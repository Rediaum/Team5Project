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

            Integer orderId;
            if ("cart".equals(orderType)) {
                orderId = processCartOrder(loginCust, address);
            } else {
                orderId = processDirectOrder(loginCust, productId, quantity, address);
            }

            redirectAttributes.addFlashAttribute("success", "주문이 성공적으로 완료되었습니다.");
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

            model.addAttribute("order", order);
            model.addAttribute("orderItems", orderItems);

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
}