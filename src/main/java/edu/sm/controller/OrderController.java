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

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
        if (loginCust == null) return "redirect:/login";

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
        if (loginCust == null) return "redirect:/login";

        try {
            // ★ 이 부분이 중요! 상품 정보 조회
            Product product = productService.get(productId);  // ProductService 필요

            List<Address> addresses = addressService.getAddressByCustomerId(loginCust.getCustId());
            Address defaultAddress = addressService.getDefaultAddress(loginCust.getCustId());

            model.addAttribute("product", product);  // ★ 상품 정보 전달
            model.addAttribute("quantity", quantity);
            model.addAttribute("addresses", addresses);
            model.addAttribute("defaultAddress", defaultAddress);
            model.addAttribute("orderType", "direct");

        } catch (Exception e) {
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
        if (loginCust == null) return "redirect:/login";

        try {
            Address address = addressService.get(Integer.parseInt(selectedAddress));
            if (address == null || address.getCustId() != loginCust.getCustId()) {
                redirectAttributes.addFlashAttribute("error", "유효하지 않은 배송지입니다.");
                return "redirect:/order/from-cart";
            }

            Integer orderId;
            if ("cart".equals(orderType)) {
                orderId = processCartOrder(loginCust, address);
            } else {
                orderId = processDirectOrder(loginCust, productId, quantity, address);
            }

            return "redirect:/order/complete/" + orderId;

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "주문 처리 중 오류가 발생했습니다.");
            return "redirect:/cart";
        }
    }

    private Integer processCartOrder(Cust customer, Address address) throws Exception {
        log.info("장바구니 주문 처리 시작 - 고객ID: {}", customer.getCustId());

        List<Cart> cartItems = cartService.findByCustId(customer.getCustId());
        log.info("장바구니 아이템 수: {}", cartItems.size());

        int totalAmount = cartService.calculateTotalPrice(customer.getCustId());
        log.info("총 금액: {}", totalAmount);

        CustOrder order = CustOrder.builder()
                .custId(customer.getCustId())
                .totalAmount(totalAmount)
                .shippingName(address.getAddressName())
                .shippingPhone(customer.getCustPhone())
                .shippingAddress(address.getAddress() + " " + (address.getDetailAddress() != null ? address.getDetailAddress() : ""))
                .orderDate(new java.sql.Timestamp(System.currentTimeMillis())) // 현재 시간 추가
                .build();

        log.info("주문 객체 생성 완료");
        try {
            orderService.register(order);
            log.info("주문 등록 완료");
        } catch (Exception e) {
            log.error("주문 등록 실패: {}", e.getMessage(), e);
            throw e;
        }

        List<CustOrder> recentOrders = orderService.getOrdersByCustId(customer.getCustId());
        Integer orderId = recentOrders.get(0).getOrderId();
        log.info("생성된 주문ID: {}", orderId);

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

        for (Cart cartItem : cartItems) {
            cartService.remove(cartItem.getCartId());
            log.info("장바구니 아이템 삭제 완료 - ID: {}", cartItem.getCartId());
        }

        log.info("장바구니 주문 처리 완료 - 주문ID: {}", orderId);
        return orderId;
    }

    private Integer processDirectOrder(Cust customer, Integer productId, Integer quantity, Address address) throws Exception {
        log.info("직접 주문 처리 시작 - 고객ID: {}, 상품ID: {}", customer.getCustId(), productId);

        // 상품 정보 조회 (ProductService 필요)
        Product product = productService.get(productId);

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

        orderService.register(order);

        // 생성된 주문 ID 조회
        List<CustOrder> recentOrders = orderService.getOrdersByCustId(customer.getCustId());
        Integer orderId = recentOrders.get(0).getOrderId();

        // 주문 아이템 생성
        OrderItem orderItem = OrderItem.builder()
                .orderId(orderId)
                .productId(productId)
                .quantity(quantity)
                .unitPrice(unitPrice)
                .build();

        orderItemService.register(orderItem);

        return orderId;
    }

    @RequestMapping("/complete/{orderId}")
    public String orderComplete(@PathVariable Integer orderId, HttpSession session, Model model) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) return "redirect:/login";

        try {
            CustOrder order = orderService.get(orderId);
            if (order == null || !Objects.equals(order.getCustId(), loginCust.getCustId())) {
                return "redirect:/order/history";
            }

            List<OrderItem> orderItems = orderItemService.getItemsByOrderId(orderId);

            model.addAttribute("order", order);
            model.addAttribute("orderItems", orderItems);

        } catch (Exception e) {
            model.addAttribute("error", "주문 정보를 불러오는 중 오류가 발생했습니다...");
        }

        return "order-complete";
    }

    @RequestMapping("/history")
    public String orderHistory(HttpSession session, Model model) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) return "redirect:/login";

        try {
            List<CustOrder> orderHistory = orderService.getOrdersByCustId(loginCust.getCustId());
            model.addAttribute("orderHistory", orderHistory);
        } catch (Exception e) {
            model.addAttribute("error", "주문 내역을 불러오는 중 오류가 발생했습니다.");
        }

        return "order-history";
    }

    @RequestMapping("/cancel/{orderId}")
    public String cancelOrder(@PathVariable Integer orderId, HttpSession session) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) return "redirect:/login";

        try {
            CustOrder order = orderService.get(orderId);
            if (order != null && Objects.equals(order.getCustId(), loginCust.getCustId())) {
                orderService.remove(orderId);
            }
        } catch (Exception e) {
            // 무시
        }

        return "redirect:/order/history";
    }
}
