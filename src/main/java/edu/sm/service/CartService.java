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

    // 총 가격 계산 - 할인 적용 버전

    public int calculateTotalPrice(Integer custId) throws Exception {
        List<Cart> cartItems = cartRepository.findByCustId(custId);
        int totalPrice = 0;

        for (Cart item : cartItems) {
            // 할인율 적용 계산
            int originalPrice = item.getProductPrice();
            double discountRate = item.getDiscountRate();

            // 할인율이 1보다 크면 퍼센트 형태(예: 70), 작으면 소수 형태(예: 0.7)
            double actualDiscountRate = discountRate > 1 ? discountRate / 100 : discountRate;

            // 할인된 가격 계산
            int discountedPrice = (int) (originalPrice * (1 - actualDiscountRate));

            // 총 가격에 수량 곱해서 누적
            totalPrice += discountedPrice * item.getProductQt();
        }

        return totalPrice;
    }

    // 장바구니 상품 개수 계산
    public int getCartItemCount(Integer custId) throws Exception {
        List<Cart> cartItems = cartRepository.findByCustId(custId);
        int totalCount = 0;
        for (Cart item : cartItems) {
            totalCount += item.getProductQt();
        }
        return totalCount;
    }
}