package edu.sm.controller;

import edu.sm.dto.Cart;
import edu.sm.dto.CustOrder;
import edu.sm.dto.Cust;
import edu.sm.dto.OrderItem;
import edu.sm.service.CartService;
import edu.sm.service.OrderItemService;
import edu.sm.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

    /**
     * 장바구니에서 주문 페이지로 이동
     */
    @RequestMapping("/from-cart")
    public String orderFromCart(HttpSession session, Model model) {
        // 로그인 체크
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        log.info("장바구니 주문 요청 - 고객: {}", loginCust.getCustName());

        try {
            // 장바구니 데이터 조회
            List<Cart> cartItems = cartService.findByCustId(loginCust.getCustId());

            if (cartItems.isEmpty()) {
                log.warn("빈 장바구니로 주문 시도 - 고객: {}", loginCust.getCustName());
                model.addAttribute("error", "장바구니가 비어있습니다.");
                return "redirect:/cart";
            }

            // 총 주문 금액 계산
            int totalAmount = cartService.calculateTotalPrice(loginCust.getCustId());

            // 주문 페이지에 필요한 데이터 전달
            model.addAttribute("cartItems", cartItems);
            model.addAttribute("totalAmount", totalAmount);
            model.addAttribute("orderType", "cart"); // 장바구니 주문임을 표시

            log.info("장바구니 주문 데이터 전달 완료 - 상품 {}개, 총액 {}원", cartItems.size(), totalAmount);

        } catch (Exception e) {
            log.error("장바구니 주문 처리 오류: ", e);
            model.addAttribute("error", "주문 처리 중 오류가 발생했습니다.");
            return "redirect:/cart";
        }

        return "order";
    }

    /**
     * 상품페이지에서 바로 주문
     */
    @RequestMapping({"/direct", "/buy"})
    public String directOrder(@RequestParam("productId") Integer productId,
                              @RequestParam(value = "quantity", defaultValue = "1") Integer quantity,
                              HttpSession session, Model model) {
        // 로그인 체크
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        log.info("직접 주문 요청 - 고객: {}, 상품ID: {}, 수량: {}", loginCust.getCustName(), productId, quantity);

        try {
            // TODO: ProductService를 통해 상품 정보 조회
            // Product product = productService.get(productId);
            // 임시로 직접 주문 데이터 구성 (실제로는 Product 정보가 필요)

            model.addAttribute("productId", productId);
            model.addAttribute("quantity", quantity);
            model.addAttribute("orderType", "direct"); // 직접 주문임을 표시

            log.info("직접 주문 데이터 전달 완료");

        } catch (Exception e) {
            log.error("직접 주문 처리 오류: ", e);
            model.addAttribute("error", "주문 처리 중 오류가 발생했습니다.");
            return "redirect:/product";
        }

        return "order";
    }

    /**
     * 주문 내역 조회 (고객의 모든 주문)
     */
    @RequestMapping("/history")
    public String orderHistory(HttpSession session, Model model) {
        // 로그인 체크
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        log.info("주문 내역 요청 - 고객: {}", loginCust.getCustName());

        try {
            // 고객의 모든 주문 조회
            List<CustOrder> orderHistory = orderService.getOrdersByCustId(loginCust.getCustId());

            model.addAttribute("orderHistory", orderHistory);
            log.info("주문 내역 조회 완료 - {}건", orderHistory.size());

        } catch (Exception e) {
            log.error("주문 내역 조회 오류: ", e);
            model.addAttribute("error", "주문 내역을 불러오는 중 오류가 발생했습니다.");
        }

        return "order-history"; // 주문 내역 전용 JSP
    }

    /**
     * 특정 주문 상세 조회
     */
    @RequestMapping("/detail/{orderId}")
    public String orderDetail(@PathVariable Integer orderId, HttpSession session, Model model) {
        // 로그인 체크
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        log.info("주문 상세 요청 - 고객: {}, 주문ID: {}", loginCust.getCustName(), orderId);

        try {
            // 주문 기본 정보 조회
            CustOrder order = orderService.get(orderId);

            // 보안 체크: 본인의 주문인지 확인
            if (order == null || !Objects.equals(order.getCustId(), loginCust.getCustId())) {
                log.warn("타인의 주문 조회 시도 - 고객: {}, 주문ID: {}", loginCust.getCustName(), orderId);
                return "redirect:/order/history";
            }

            // 주문 상품 목록 조회
            List<OrderItem> orderItems = orderItemService.getItemsByOrderId(orderId);

            model.addAttribute("order", order);
            model.addAttribute("orderItems", orderItems);

            log.info("주문 상세 조회 완료 - 주문ID: {}, 상품 {}개", orderId, orderItems.size());

        } catch (Exception e) {
            log.error("주문 상세 조회 오류: ", e);
            model.addAttribute("error", "주문 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/order/history";
        }

        return "order-detail"; // 주문 상세 전용 JSP
    }

    /**
     * 주문 취소
     */
    @RequestMapping("/cancel/{orderId}")
    public String cancelOrder(@PathVariable Integer orderId, HttpSession session) {
        // 로그인 체크
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        log.info("주문 취소 요청 - 고객: {}, 주문ID: {}", loginCust.getCustName(), orderId);

        try {
            // 주문 정보 조회 및 본인 확인
            CustOrder order = orderService.get(orderId);
            if (order == null || !Objects.equals(order.getCustId(), loginCust.getCustId())) {
                log.warn("타인의 주문 취소 시도 - 고객: {}, 주문ID: {}", loginCust.getCustName(), orderId);
                return "redirect:/order/history";
            }

            // 주문 취소 (삭제)
            orderService.remove(orderId);
            log.info("주문 취소 완료 - 주문ID: {}", orderId);

        } catch (Exception e) {
            log.error("주문 취소 오류: ", e);
        }

        return "redirect:/order/history";
    }
}