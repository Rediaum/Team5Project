package edu.sm.service;

import edu.sm.dto.Cart;
import edu.sm.frame.ProjectService;
import edu.sm.repository.CartRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
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

    // ===== 장바구니 전용 메소드 =====

    public List<Cart> findByCustId(Integer custId) throws Exception {
        return cartRepository.findByCustId(custId);
    }

    public int calculateTotalPrice(Integer custId) throws Exception {
        List<Cart> cartItems = cartRepository.findByCustId(custId);
        int totalPrice = 0;
        for (Cart item : cartItems) {
            totalPrice += item.getProductPrice() * item.getProductQt();
        }
        return totalPrice;
    }

    public int getCartItemCount(Integer custId) throws Exception {
        List<Cart> cartItems = cartRepository.findByCustId(custId);
        int totalCount = 0;
        for (Cart item : cartItems) {
            totalCount += item.getProductQt();
        }
        return totalCount;
    }
}