package edu.sm.service;

import edu.sm.dto.Cart;
import edu.sm.frame.ProjectService;
import edu.sm.repository.CartRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CartService implements ProjectService<Cart, Integer> { // <-- ProjectService를 구현

    final CartRepository cartRepository;

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
        // return cartRepository.select(cartId); // Mapper에 select 쿼리가 있다면 구현
        return null;
    }

    @Override
    public List<Cart> get() throws Exception {
        // return cartRepository.selectAll(); // Mapper에 selectAll 쿼리가 있다면 구현
        return null;
    }

    // CartService에만 필요한 별도의 메서드
    public List<Cart> findByCustId(String custId) throws Exception {
        return cartRepository.findByCustId(custId);
    }
}