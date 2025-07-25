package edu.sm.controller;

import edu.sm.dto.Cart;
import edu.sm.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cart")
public class CartController {

    final CartService cartService;

    // JSP 파일들이 위치한 폴더 경로를 변수로 관리
    String dir = "cart/";

    /**
     * 고객 ID를 받아 장바구니 목록 페이지를 보여줌
     */
    @RequestMapping("")
    public String cartList(Model model, @RequestParam("id") String custId) {
        try {
            List<Cart> list = cartService.findByCustId(custId);
            model.addAttribute("cartlist", list); // JSP에서 사용할 이름은 cartlist로 통일
            model.addAttribute("center", dir + "cart"); // ex) "cart/cart.jsp"
        } catch (Exception e) {
            // 나중에 에러 처리 페이지로 보낼 수 있음
            e.printStackTrace();
        }
        return "index";
    }

    /**
     * 장바구니에 상품을 추가함
     * (새 상품이면 INSERT, 이미 있으면 수량 UPDATE)
     */
    @RequestMapping("/add")
    public String addCart(Cart cart) {
        try {
            // product_id, cust_id, product_qt가 cart 객체에 담겨서 들어옴
            cartService.register(cart);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 작업 완료 후, 다시 해당 고객의 장바구니 목록 페이지로 이동함
        return "redirect:/cart?id=" + cart.getCustId();
    }

    /**
     * 장바구니의 특정 상품을 삭제
     * cart_id(기본키)를 기준으로 삭제
     */
    @RequestMapping("/delete")
    public String deleteCart(@RequestParam("cartId") int cartId, @RequestParam("custId") String custId) {
        try {
            cartService.remove(cartId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 작업 완료 후, 다시 해당 고객의 장바구니 목록 페이지로 이동
        return "redirect:/cart?id=" + custId;
    }

    /**
     * 장바구니의 특정 상품 수량을 변경합
     */
    @RequestMapping("/update")
    public String updateCart(Cart cart) {
        try {
            // cart_id와 변경할 product_qt가 cart 객체에 담겨서 들어
            cartService.modify(cart);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 작업 완료 후, 다시 해당 고객의 장바구니 목록 페이지로 이동
        return "redirect:/cart?id=" + cart.getCustId();
    }
}