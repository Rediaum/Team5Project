package edu.sm.controller;

import edu.sm.dto.Cart;
import edu.sm.dto.Cust;
import edu.sm.service.CartService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cart")
@Slf4j
public class CartController {

    final CartService cartService;
    String dir = ""; // cart/ 제거 - views 바로 아래에 cart.jsp가 있음

    /**
     * 장바구니 목록 페이지 - 로그인 필수
     */
    @RequestMapping("")
    public String cartList(Model model, HttpSession session) {
        log.info("=== 장바구니 페이지 요청 시작 ===");

        // 세션에서 로그인 고객 정보 확인
        Cust loginCust = (Cust) session.getAttribute("logincust");
        log.info("세션에서 가져온 로그인 고객: {}", loginCust != null ? loginCust.getCustName() : "null");

        if (loginCust == null) {
            log.warn("비로그인 사용자의 장바구니 접근 시도");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        try {
            List<Cart> list = cartService.findByCustId(loginCust.getCustId());
            log.info("고객 {}의 장바구니 조회 - {}개 상품", loginCust.getCustName(), list.size());

            // 총 가격과 개수 계산
            int totalPrice = cartService.calculateTotalPrice(loginCust.getCustId());
            int itemCount = cartService.getCartItemCount(loginCust.getCustId());

            model.addAttribute("cartItems", list); // JSP 변수명 통일
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("itemCount", itemCount);
            // model.addAttribute("center", dir + "cart"); ← 제거

            log.info("장바구니 모델 데이터 설정 완료 - center: {}", dir + "cart");
            log.info("=== 장바구니 페이지 요청 완료 - return cart.jsp 직접 ===");
        } catch (Exception e) {
            log.error("장바구니 조회 오류: ", e);
            model.addAttribute("error", "장바구니를 불러오는 중 오류가 발생했습니다.");
        }
        return "order/cart"; // cart.jsp 직접 반환
    }

    /**
     * 장바구니에 상품 추가 - 로그인 필수
     */
    @RequestMapping("/add")
    public String addCart(@RequestParam("productId") Integer productId,
                          @RequestParam(value = "quantity", defaultValue = "1") Integer quantity,
                          HttpSession session) {
        // 세션에서 로그인 고객 정보 확인
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            log.warn("비로그인 사용자의 장바구니 추가 시도 - 상품ID: {}", productId);
            return "redirect:/login";
        }

        try {
            // 🆕 중복 상품 체크
            Cart existingCart = cartService.findByCustomerAndProduct(loginCust.getCustId(), productId);

            if (existingCart != null) {
                // 기존 상품이 있으면 수량만 증가
                existingCart.setProductQt(existingCart.getProductQt() + quantity);
                cartService.modify(existingCart);
                log.info("장바구니 수량 증가 - 고객: {}, 상품ID: {}, 기존수량: {}, 추가수량: {}, 총수량: {}",
                        loginCust.getCustName(), productId,
                        existingCart.getProductQt() - quantity, quantity, existingCart.getProductQt());
            } else {
                // 새로운 상품이면 새로 추가
                Cart cart = Cart.builder()
                        .custId(loginCust.getCustId())
                        .productId(productId)
                        .productQt(quantity)
                        .build();

                cartService.register(cart);
                log.info("장바구니 새 상품 추가 - 고객: {}, 상품ID: {}, 수량: {}",
                        loginCust.getCustName(), productId, quantity);
            }

        } catch (Exception e) {
            log.error("장바구니 추가 실패: ", e);
        }

        return "redirect:/cart";
    }

    /**
     * 장바구니 상품 삭제 - 본인 장바구니만 삭제 가능
     */
    @RequestMapping("/delete")
    public String deleteCart(@RequestParam("cartId") int cartId, HttpSession session) {
        // 세션에서 로그인 고객 정보 확인
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            // 보안: 본인의 장바구니 아이템인지 확인
            Cart cartItem = cartService.get(cartId);
            if (cartItem != null && Objects.equals(cartItem.getCustId(), loginCust.getCustId())) {
                cartService.remove(cartId);
                log.info("장바구니 삭제 성공 - 고객: {}, 장바구니ID: {}", loginCust.getCustName(), cartId);
            } else {
                log.warn("타인의 장바구니 삭제 시도 - 고객: {}, 장바구니ID: {}", loginCust.getCustName(), cartId);
            }
        } catch (Exception e) {
            log.error("장바구니 삭제 오류: ", e);
        }

        return "redirect:/cart";
    }

    /**
     * 장바구니 상품 수량 변경 - 본인 장바구니만 수정 가능
     */
    @RequestMapping(value = "/update", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCart(@RequestParam("cartId") int cartId,
                                                          @RequestParam("quantity") int quantity,
                                                          HttpSession session,
                                                          @RequestHeader(value = "X-Requested-With", required = false) String requestedWith) {
        Map<String, Object> response = new HashMap<>();

        // 세션에서 로그인 고객 정보 확인
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");

            if ("XMLHttpRequest".equals(requestedWith)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            } else {
                return ResponseEntity.status(HttpStatus.FOUND)
                        .header("Location", "/login")
                        .build();
            }
        }

        try {
            // 수량 유효성 검사
            if (quantity < 1 || quantity > 99) {
                response.put("success", false);
                response.put("message", "수량은 1~99개까지 선택 가능합니다.");

                if ("XMLHttpRequest".equals(requestedWith)) {
                    return ResponseEntity.badRequest().body(response);
                } else {
                    // 기존 방식 (페이지 리다이렉트)
                    return ResponseEntity.status(HttpStatus.FOUND)
                            .header("Location", "/cart")
                            .build();
                }
            }

            // 보안: 본인의 장바구니 아이템인지 확인
            Cart cartItem = cartService.get(cartId);
            if (cartItem != null && Objects.equals(cartItem.getCustId(), loginCust.getCustId())) {
                cartItem.setProductQt(quantity);
                cartService.modify(cartItem);

                log.info("장바구니 수량 수정 성공 - 고객: {}, 장바구니ID: {}, 수량: {}",
                        loginCust.getCustName(), cartId, quantity);

                response.put("success", true);
                response.put("message", "수량이 변경되었습니다.");
                response.put("cartId", cartId);
                response.put("quantity", quantity);

            } else {
                log.warn("타인의 장바구니 수정 시도 - 고객: {}, 장바구니ID: {}",
                        loginCust.getCustName(), cartId);
                response.put("success", false);
                response.put("message", "접근 권한이 없습니다.");

                if ("XMLHttpRequest".equals(requestedWith)) {
                    return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
                }
            }

        } catch (Exception e) {
            log.error("장바구니 수량 수정 오류: ", e);
            response.put("success", false);
            response.put("message", "수량 변경 중 오류가 발생했습니다.");

            if ("XMLHttpRequest".equals(requestedWith)) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
            }
        }

        // AJAX 요청인 경우 JSON 응답
        if ("XMLHttpRequest".equals(requestedWith)) {
            return ResponseEntity.ok(response);
        } else {
            // 기존 방식 (페이지 리다이렉트)
            return ResponseEntity.status(HttpStatus.FOUND)
                    .header("Location", "/cart")
                    .build();
        }
    }

    /**
     * 장바구니 전체 비우기
     */
    @PostMapping("/clear")
    public String clearCart(HttpSession session) {
        Cust loginCust = (Cust) session.getAttribute("logincust");
        if (loginCust == null) {
            return "redirect:/login";
        }

        try {
            List<Cart> cartItems = cartService.findByCustId(loginCust.getCustId());
            for (Cart item : cartItems) {
                cartService.remove(item.getCartId());
            }
            log.info("장바구니 전체 비우기 성공 - 고객: {}", loginCust.getCustName());
        } catch (Exception e) {
            log.error("장바구니 비우기 오류: ", e);
        }

        return "redirect:/cart";
    }
}