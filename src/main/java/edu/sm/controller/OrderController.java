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
            private final ProductService productService; // 추가 필요
            private final AddressService addressService; // 🔥 기존 서비스 활용!

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

                    // 총 주문 금액 계산 (할인 적용)
                    int totalAmount = cartService.calculateTotalPrice(loginCust.getCustId());

                    // 주문 페이지에 필요한 데이터 전달
                    model.addAttribute("cartItems", cartItems);
                    model.addAttribute("totalAmount", totalAmount);
                    model.addAttribute("orderType", "cart");
                    model.addAttribute("customer", loginCust); // 고객 정보 추가

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
                    // 상품 정보 조회
                    Product product = productService.get(productId);
                    if (product == null) {
                        model.addAttribute("error", "상품을 찾을 수 없습니다.");
                        return "redirect:/product";
                    }

                    // 할인 적용된 가격 계산
                    double actualDiscountRate = product.getDiscountRate() > 1 ?
                            product.getDiscountRate() / 100 : product.getDiscountRate();
                    int discountedPrice = (int) (product.getProductPrice() * (1 - actualDiscountRate));
                    int totalAmount = discountedPrice * quantity;

                    // 🔥 직접 주문에서도 배송지 정보 추가
                    Address defaultAddress = null;
                    List<Address> addresses = null;
                    try {
                        defaultAddress = addressService.getDefaultAddress(loginCust.getCustId());
                        addresses = addressService.getAddressByCustomerId(loginCust.getCustId());
                    } catch (Exception e) {
                        log.warn("배송지 조회 실패: {}", e.getMessage());
                    }

                    // 주문 페이지에 필요한 데이터 전달
                    model.addAttribute("product", product);
                    model.addAttribute("quantity", quantity);
                    model.addAttribute("totalAmount", totalAmount);
                    model.addAttribute("orderType", "direct");
                    model.addAttribute("customer", loginCust);
                    model.addAttribute("defaultAddress", defaultAddress); // 🔥 추가
                    model.addAttribute("addresses", addresses); // 🔥 추가

                    log.info("직접 주문 데이터 전달 완료 - 상품: {}, 총액: {}원", product.getProductName(), totalAmount);

                } catch (Exception e) {
                    log.error("직접 주문 처리 오류: ", e);
                    model.addAttribute("error", "주문 처리 중 오류가 발생했습니다.");
                    return "redirect:/product";
                }

                return "order";
            }

            /**
             * 주문 완료 처리 (POST) - 핵심 기능!
             */
            @PostMapping("/submit")
            @Transactional
            public String submitOrder(@RequestParam("orderType") String orderType,
                                      @RequestParam("shippingName") String shippingName,
                                      @RequestParam("shippingPhone") String shippingPhone,
                                      @RequestParam("shippingAddress") String shippingAddress,
                                      @RequestParam(value = "productId", required = false) Integer productId,
                                      @RequestParam(value = "quantity", required = false, defaultValue = "1") Integer quantity,
                                      HttpSession session,
                                      RedirectAttributes redirectAttributes) {

                // 로그인 체크
                Cust loginCust = (Cust) session.getAttribute("logincust");
                if (loginCust == null) {
                    return "redirect:/login";
                }

                log.info("주문 완료 처리 시작 - 고객: {}, 주문타입: {}", loginCust.getCustName(), orderType);

                try {
                    Integer orderId;

                    if ("cart".equals(orderType)) {
                        // 장바구니 주문 처리
                        orderId = processCartOrder(loginCust, shippingName, shippingPhone, shippingAddress);
                    } else if ("direct".equals(orderType)) {
                        // 직접 주문 처리
                        orderId = processDirectOrder(loginCust, productId, quantity, shippingName, shippingPhone, shippingAddress);
                    } else {
                        throw new IllegalArgumentException("잘못된 주문 타입: " + orderType);
                    }

                    log.info("주문 완료 - 주문ID: {}", orderId);
                    redirectAttributes.addFlashAttribute("success", "주문이 성공적으로 완료되었습니다!");
                    redirectAttributes.addFlashAttribute("orderId", orderId);

                    return "redirect:/order/complete/" + orderId;

                } catch (Exception e) {
                    log.error("주문 처리 중 오류: ", e);
                    redirectAttributes.addFlashAttribute("error", "주문 처리 중 오류가 발생했습니다: " + e.getMessage());
                    return "redirect:/cart";
                }
            }

            /**
             * 장바구니 주문 처리 (private 메서드)
             */
            private Integer processCartOrder(Cust customer, String shippingName, String shippingPhone, String shippingAddress) throws Exception {
                // 1. 장바구니 조회
                List<Cart> cartItems = cartService.findByCustId(customer.getCustId());
                if (cartItems.isEmpty()) {
                    throw new RuntimeException("장바구니가 비어있습니다.");
                }

                // 2. 총 금액 계산 (할인 적용)
                int totalAmount = cartService.calculateTotalPrice(customer.getCustId());

                // 3. 주문 생성
                CustOrder order = CustOrder.builder()
                        .custId(customer.getCustId())
                        .totalAmount(totalAmount)
                        .shippingName(shippingName)
                        .shippingPhone(shippingPhone)
                        .shippingAddress(shippingAddress)
                        .build();

                Integer orderId = orderService.registerAndGetId(order); // 수정 필요 - ID 반환 메서드

                // 4. 주문 상품 생성
                for (Cart cartItem : cartItems) {
                    // 할인 적용된 단가 계산
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
                }

                // 5. 장바구니 비우기
                for (Cart cartItem : cartItems) {
                    cartService.remove(cartItem.getCartId());
                }

                return orderId;
            }

            /**
             * 직접 주문 처리 (private 메서드)
             */
            private Integer processDirectOrder(Cust customer, Integer productId, Integer quantity,
                                               String shippingName, String shippingPhone, String shippingAddress) throws Exception {
                // 1. 상품 조회
                Product product = productService.get(productId);
                if (product == null) {
                    throw new RuntimeException("상품을 찾을 수 없습니다.");
                }

                // 2. 할인 적용된 가격 계산
                double actualDiscountRate = product.getDiscountRate() > 1 ?
                        product.getDiscountRate() / 100 : product.getDiscountRate();
                int unitPrice = (int) (product.getProductPrice() * (1 - actualDiscountRate));
                int totalAmount = unitPrice * quantity;

                // 3. 주문 생성
                CustOrder order = CustOrder.builder()
                        .custId(customer.getCustId())
                        .totalAmount(totalAmount)
                        .shippingName(shippingName)
                        .shippingPhone(shippingPhone)
                        .shippingAddress(shippingAddress)
                        .build();

                Integer orderId = orderService.registerAndGetId(order);

                // 4. 주문 상품 생성
                OrderItem orderItem = OrderItem.builder()
                        .orderId(orderId)
                        .productId(productId)
                        .quantity(quantity)
                        .unitPrice(unitPrice)
                        .build();

                orderItemService.register(orderItem);

                return orderId;
            }

            /**
             * 주문 완료 페이지
             */
            @RequestMapping("/complete/{orderId}")
            public String orderComplete(@PathVariable Integer orderId, HttpSession session, Model model) {
                // 로그인 체크
                Cust loginCust = (Cust) session.getAttribute("logincust");
                if (loginCust == null) {
                    return "redirect:/login";
                }

                try {
                    // 주문 정보 조회 및 권한 체크
                    CustOrder order = orderService.get(orderId);
                    if (order == null || !Objects.equals(order.getCustId(), loginCust.getCustId())) {
                        return "redirect:/order/history";
                    }

                    // 주문 상품 목록 조회
                    List<OrderItem> orderItems = orderItemService.getItemsByOrderId(orderId);

                    model.addAttribute("order", order);
                    model.addAttribute("orderItems", orderItems);

                } catch (Exception e) {
                    log.error("주문 완료 페이지 조회 오류: ", e);
                    model.addAttribute("error", "주문 정보를 불러오는 중 오류가 발생했습니다.");
                }

                return "order-complete";
            }

            /**
             * 주문 내역 조회
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

                return "order-history";
            }

            /**
             * 주문 상세 조회
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

                return "order-detail";
            }

            /**
             * 주문 취소
             */
            @RequestMapping("/cancel/{orderId}")
            public String cancelOrder(@PathVariable Integer orderId, HttpSession session, RedirectAttributes redirectAttributes) {
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

                    redirectAttributes.addFlashAttribute("success", "주문이 취소되었습니다.");

                } catch (Exception e) {
                    log.error("주문 취소 오류: ", e);
                    redirectAttributes.addFlashAttribute("error", "주문 취소 중 오류가 발생했습니다.");
                }

                return "redirect:/order/history";
            }
        }