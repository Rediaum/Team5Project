package edu.sm.service;

import edu.sm.dto.Cart;
import edu.sm.frame.ProjectService;
import edu.sm.repository.CartRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class CartService implements ProjectService<Cart, Integer> {

    private final CartRepository cartRepository;

    @Override
    public void register(Cart cart) throws Exception {
        cartRepository.insert(cart);
    }

    @Override
    public void modify(Cart cart) throws Exception {
        cartRepository.update(cart);
    }

    @Override
    public void remove(Integer cartId) throws Exception {
        cartRepository.delete(cartId);
    }

    @Override
    public Cart get(Integer cartId) throws Exception {
        return cartRepository.select(cartId);
    }

    @Override
    public List<Cart> get() throws Exception {
        return cartRepository.selectAll();
    }

    /**
     * ✅ 특정 고객의 장바구니 목록 조회 (Integer 타입으로 수정)
     */
    public List<Cart> findByCustId(Integer custId) throws Exception {
        log.info("고객 {}의 장바구니 조회", custId);
        return cartRepository.findByCustId(custId);
    }

    /**
     * ✅ 장바구니 총 가격 계산
     */
    public int calculateTotalPrice(Integer custId) throws Exception {
        List<Cart> cartItems = cartRepository.findByCustId(custId);
        int totalPrice = 0;

        for (Cart item : cartItems) {
            totalPrice += item.getProductPrice() * item.getProductQt();
        }

        log.info("고객 {}의 장바구니 총 가격: {}원", custId, totalPrice);
        return totalPrice;
    }

    /**
     * ✅ 장바구니 총 상품 개수
     */
    public int getCartItemCount(Integer custId) throws Exception {
        List<Cart> cartItems = cartRepository.findByCustId(custId);
        int totalCount = 0;

        for (Cart item : cartItems) {
            totalCount += item.getProductQt();
        }

        log.info("고객 {}의 장바구니 총 상품 개수: {}개", custId, totalCount);
        return totalCount;
    }
}