package edu.sm.controller;

import edu.sm.dto.*;
import edu.sm.service.*;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Objects;

@Controller
@RequiredArgsConstructor
@RequestMapping("/order")
@Slf4j
public class OrderController {

    private final OrderService orderService;
    private final OrderItemService orderItemService;
    private final CartService cartService;
    private final AddressService addressService;
    private final ProductService productService;
    private final PaymentService paymentService;

    @RequestMapping("/from-cart")
    public String orderFromCart(HttpSession session, Model model) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            List<Cart> cartItems = cartService.findByCustId(loginCust.getCustId());
            if (cartItems.isEmpty()) {
                model.addAttribute("error", "장바구니가 비어있습니다.");
                return "redirect:/cart";
            }

            List<Address> addresses = addressService.getAddressByCustomerId(loginCust.getCustId());
            Address defaultAddress = addressService.getDefaultAddress(loginCust.getCustId());

            model.addAttribute("cartItems", cartItems);
            model.addAttribute("addresses", addresses);
            model.addAttribute("defaultAddress", defaultAddress);
            model.addAttribute("orderType", "cart");

        } catch (Exception e) {
            log.error("장바구니 주문 페이지 로딩 실패: {}", e.getMessage(), e);
            model.addAttribute("error", "주문 처리 중 오류가 발생했습니다.");
            return "redirect:/cart";
        }

        return "order";
    }

    @RequestMapping("/direct")
    public String orderDirect(@RequestParam("productId") Integer productId,
                              @RequestParam(value = "quantity", defaultValue = "1") Integer quantity,
                              HttpSession session, Model model) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            // 상품 정보 조회
            Product product = productService.get(productId);
            if (product == null) {
                model.addAttribute("error", "존재하지 않는 상품입니다.");
                return "redirect:/product";
            }

            List<Address> addresses = addressService.getAddressByCustomerId(loginCust.getCustId());
            Address defaultAddress = addressService.getDefaultAddress(loginCust.getCustId());

            model.addAttribute("product", product);
            model.addAttribute("quantity", quantity);
            model.addAttribute("addresses", addresses);
            model.addAttribute("defaultAddress", defaultAddress);
            model.addAttribute("orderType", "direct");

        } catch (Exception e) {
            log.error("직접 주문 페이지 로딩 실패: {}", e.getMessage(), e);
            model.addAttribute("error", "상품 정보를 불러올 수 없습니다.");
            return "redirect:/product";
        }

        return "order";
    }

    @PostMapping("/submit")
    public String submitOrder(@RequestParam("orderType") String orderType,
                              @RequestParam("selectedAddress") String selectedAddress,
                              @RequestParam(value = "paymentMethod", required = false, defaultValue = "creditCard") String paymentMethod,
                              @RequestParam(value = "productId", required = false) Integer productId,
                              @RequestParam(value = "quantity", required = false, defaultValue = "1") Integer quantity,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            // 배송지 검증
            Address address = addressService.get(Integer.parseInt(selectedAddress));
            if (address == null || !Objects.equals(address.getCustId(), loginCust.getCustId())) {
                redirectAttributes.addFlashAttribute("error", "유효하지 않은 배송지입니다.");
                return "redirect:/order/from-cart";
            }

            // 결제 방법 검증
            if (!isValidPaymentMethod(paymentMethod)) {
                redirectAttributes.addFlashAttribute("error", "유효하지 않은 결제 방법입니다.");
                return "redirect:/order/from-cart";
            }

            Integer orderId;
            Integer totalAmount;

            if ("cart".equals(orderType)) {
                // 장바구니 비우기 전에 미리 금액 계산!
                totalAmount = cartService.calculateTotalPrice(loginCust.getCustId());
                log.info("🛒 장바구니 총 금액 계산: {}원", totalAmount);

                // 주문 처리 (이때 장바구니가 비워짐)
                orderId = processCartOrder(loginCust, address);
                log.info("🛒 장바구니 주문 처리 완료 - orderId: {}", orderId);
            } else {
                // 직접 주문은 기존과 동일
                totalAmount = calculateDirectOrderAmount(productId, quantity);
                orderId = processDirectOrder(loginCust, productId, quantity, address);
                log.info("🛍️ 직접 주문 - orderId: {}, totalAmount: {}", orderId, totalAmount);
            }

            // 금액이 0인 경우 오류 처리
            if (totalAmount == null || totalAmount <= 0) {
                log.error("❌ 주문 금액이 0원 - orderType: {}, totalAmount: {}", orderType, totalAmount);
                redirectAttributes.addFlashAttribute("error", "주문 금액이 올바르지 않습니다.");
                return "redirect:/cart";
            }

            // 결제 처리
            try {
                Payment payment = paymentService.processPayment(orderId, paymentMethod, totalAmount);
                log.info("✅ 결제 완료 - 주문ID: {}, 결제ID: {}, 거래ID: {}, 금액: {}원",
                        orderId, payment.getPaymentId(), payment.getTransactionId(), payment.getPaymentAmount());
            } catch (Exception paymentException) {
                log.error("❌ 결제 처리 실패 - 주문ID: {}, 에러: {}", orderId, paymentException.getMessage(), paymentException);
                redirectAttributes.addFlashAttribute("error", "결제 처리 중 오류가 발생했습니다: " + paymentException.getMessage());
                return "redirect:/cart";
            }

            redirectAttributes.addFlashAttribute("success", "주문 및 결제가 성공적으로 완료되었습니다.");
            return "redirect:/order/complete/" + orderId;

        } catch (Exception e) {
            log.error("주문 처리 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "주문 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/cart";
        }
    }


    @Transactional
    protected Integer processCartOrder(Cust customer, Address address) throws Exception {
        log.info("장바구니 주문 처리 시작 - 고객ID: {}", customer.getCustId());

        // 장바구니 아이템 조회
        List<Cart> cartItems = cartService.findByCustId(customer.getCustId());
        if (cartItems.isEmpty()) {
            throw new IllegalStateException("장바구니가 비어있습니다.");
        }
        log.info("장바구니 아이템 수: {}", cartItems.size());

        // 총 금액 계산
        int totalAmount = cartService.calculateTotalPrice(customer.getCustId());
        log.info("총 금액: {}", totalAmount);

        // 주문 생성
        CustOrder order = CustOrder.builder()
                .custId(customer.getCustId())
                .totalAmount(totalAmount)
                .shippingName(address.getAddressName())
                .shippingPhone(customer.getCustPhone())
                .shippingAddress(address.getAddress() + " " + (address.getDetailAddress() != null ? address.getDetailAddress() : ""))
                .orderDate(new java.sql.Timestamp(System.currentTimeMillis()))
                .build();

        log.info("주문 객체 생성 완료");

        // ⭐ 개선된 부분: registerAndGetId 사용으로 한 번에 등록하고 ID 반환
        Integer orderId = orderService.registerAndGetId(order);
        log.info("주문 등록 완료 - 생성된 주문ID: {}", orderId);

        // 주문 아이템 생성
        for (Cart cartItem : cartItems) {
            double actualDiscountRate = cartItem.getDiscountRate() > 1 ?
                    cartItem.getDiscountRate() / 100 : cartItem.getDiscountRate();
            int unitPrice = (int) (cartItem.getProductPrice() * (1 - actualDiscountRate));

            OrderItem orderItem = OrderItem.builder()
                    .orderId(orderId)
                    .productId(cartItem.getProductId())
                    .quantity(cartItem.getProductQt())
                    .unitPrice(unitPrice)
                    .build();

            orderItemService.register(orderItem);
            log.info("주문 아이템 등록 완료 - 상품ID: {}", cartItem.getProductId());
        }

        // 장바구니 비우기
        for (Cart cartItem : cartItems) {
            cartService.remove(cartItem.getCartId());
            log.info("장바구니 아이템 삭제 완료 - ID: {}", cartItem.getCartId());
        }

        log.info("장바구니 주문 처리 완료 - 주문ID: {}", orderId);
        return orderId;
    }

    @Transactional
    protected Integer processDirectOrder(Cust customer, Integer productId, Integer quantity, Address address) throws Exception {
        log.info("직접 주문 처리 시작 - 고객ID: {}, 상품ID: {}", customer.getCustId(), productId);

        // 상품 정보 조회 및 검증
        Product product = productService.get(productId);
        if (product == null) {
            throw new IllegalArgumentException("존재하지 않는 상품입니다.");
        }

        // 수량 검증
        if (quantity <= 0) {
            throw new IllegalArgumentException("주문 수량은 1개 이상이어야 합니다.");
        }

        // 실제 상품 가격으로 계산
        double actualDiscountRate = product.getDiscountRate() > 1 ?
                product.getDiscountRate() / 100 : product.getDiscountRate();
        int unitPrice = (int)(product.getProductPrice() * (1 - actualDiscountRate));
        int totalAmount = unitPrice * quantity;

        // 주문 생성
        CustOrder order = CustOrder.builder()
                .custId(customer.getCustId())
                .totalAmount(totalAmount)
                .shippingName(address.getAddressName())
                .shippingPhone(customer.getCustPhone())
                .shippingAddress(address.getAddress() + " " + (address.getDetailAddress() != null ? address.getDetailAddress() : ""))
                .orderDate(new java.sql.Timestamp(System.currentTimeMillis()))
                .build();

        // ⭐ 개선된 부분: registerAndGetId 사용으로 한 번에 등록하고 ID 반환
        Integer orderId = orderService.registerAndGetId(order);
        log.info("주문 등록 완료 - 생성된 주문ID: {}", orderId);

        // 주문 아이템 생성
        OrderItem orderItem = OrderItem.builder()
                .orderId(orderId)
                .productId(productId)
                .quantity(quantity)
                .unitPrice(unitPrice)
                .build();

        orderItemService.register(orderItem);
        log.info("주문 아이템 등록 완료 - 상품ID: {}", productId);

        log.info("직접 주문 처리 완료 - 주문ID: {}", orderId);
        return orderId;
    }

    @RequestMapping("/complete/{orderId}")
    public String orderComplete(@PathVariable Integer orderId, HttpSession session, Model model) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            CustOrder order = orderService.get(orderId);
            if (order == null) {
                model.addAttribute("error", "주문 정보를 찾을 수 없습니다.");
                return "redirect:/order/history";
            }

            // 주문 소유자 검증
            if (!Objects.equals(order.getCustId(), loginCust.getCustId())) {
                model.addAttribute("error", "접근 권한이 없습니다.");
                return "redirect:/order/history";
            }

            List<OrderItem> orderItems = orderItemService.getItemsByOrderId(orderId);

            // 🆕 결제 정보 조회
            Payment payment = null;
            try {
                payment = paymentService.getPaymentByOrderId(orderId);
            } catch (Exception e) {
                log.warn("결제 정보 조회 실패 (주문ID: {}): {}", orderId, e.getMessage());
                // 결제 정보가 없어도 페이지는 표시하도록 함
            }

            model.addAttribute("order", order);
            model.addAttribute("orderItems", orderItems);
            model.addAttribute("payment", payment); // 🆕 결제 정보 추가

        } catch (Exception e) {
            log.error("주문 완료 페이지 로딩 실패: {}", e.getMessage(), e);
            model.addAttribute("error", "주문 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/order/history";
        }

        return "order-complete";
    }

    @RequestMapping("/history")
    public String orderHistory(HttpSession session, Model model) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            List<CustOrder> orderHistory = orderService.getOrdersByCustId(loginCust.getCustId());
            model.addAttribute("orderHistory", orderHistory);

        } catch (Exception e) {
            log.error("주문 내역 조회 실패: {}", e.getMessage(), e);
            model.addAttribute("error", "주문 내역을 불러오는 중 오류가 발생했습니다.");
        }

        return "order-history";
    }

    @RequestMapping("/cancel/{orderId}")
    public String cancelOrder(@PathVariable Integer orderId, HttpSession session, RedirectAttributes redirectAttributes) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            CustOrder order = orderService.get(orderId);
            if (order != null && Objects.equals(order.getCustId(), loginCust.getCustId())) {
                // TODO: 주문 상태 확인 로직 추가 (배송 전에만 취소 가능)
                // TODO: 주문 아이템도 함께 삭제하는 로직 추가
                orderService.remove(orderId);
                redirectAttributes.addFlashAttribute("success", "주문이 취소되었습니다.");
                log.info("주문 취소 완료 - 주문ID: {}, 고객ID: {}", orderId, loginCust.getCustId());
            } else {
                redirectAttributes.addFlashAttribute("error", "취소할 수 없는 주문입니다.");
            }
        } catch (Exception e) {
            log.error("주문 취소 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "주문 취소 중 오류가 발생했습니다.");
        }

        return "redirect:/order/history";
    }

    // 결제 방법 유효성 검증
    private boolean isValidPaymentMethod(String paymentMethod) {
        return paymentMethod != null && (
                "creditCard".equals(paymentMethod) ||
                        "bankTransfer".equals(paymentMethod) ||
                        "kakaoPay".equals(paymentMethod) ||
                        "naverPay".equals(paymentMethod)
        );
    }

    // 직접 주문 금액 계산
    private Integer calculateDirectOrderAmount(Integer productId, Integer quantity) throws Exception {
        Product product = productService.get(productId);
        if (product == null) {
            throw new IllegalArgumentException("존재하지 않는 상품입니다.");
        }

        double actualDiscountRate = product.getDiscountRate() > 1 ?
                product.getDiscountRate() / 100 : product.getDiscountRate();
        int unitPrice = (int)(product.getProductPrice() * (1 - actualDiscountRate));

        return unitPrice * quantity;
    }
}