package edu.sm.service;

import edu.sm.dto.OrderItem;
import edu.sm.frame.ProjectService;
import edu.sm.repository.OrderItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderItemService implements ProjectService<OrderItem, Integer> {

    private final OrderItemRepository orderItemRepository;

    @Override
    public void register(OrderItem orderItem) throws Exception {
        orderItemRepository.insert(orderItem);
    }

    @Override
    public void modify(OrderItem orderItem) throws Exception {
        // 주문상품은 수정하지 않음
        throw new UnsupportedOperationException("주문상품 정보는 수정할 수 없습니다.");
    }

    @Override
    public void remove(Integer orderItemId) throws Exception {
        orderItemRepository.delete(orderItemId);
    }

    @Override
    public List<OrderItem> get() throws Exception {
        // 보안상 모든 주문상품 조회 금지
        throw new UnsupportedOperationException("모든 주문상품 조회는 지원하지 않습니다.");
    }

    @Override
    public OrderItem get(Integer orderItemId) throws Exception {
        return orderItemRepository.select(orderItemId);
    }

    // ===== 주문상품 전용 메소드 =====

    /**
     * 특정 주문의 주문상품 목록 조회
     * @param orderId 주문 ID
     * @return 해당 주문의 주문상품 목록
     */
    public List<OrderItem> getItemsByOrderId(Integer orderId) throws Exception {
        return orderItemRepository.findByOrderId(orderId);
    }
}