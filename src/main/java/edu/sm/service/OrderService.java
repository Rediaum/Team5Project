package edu.sm.service;

import edu.sm.dto.CustOrder;
import edu.sm.frame.ProjectService;
import edu.sm.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService implements ProjectService<CustOrder, Integer> {

    private final OrderRepository orderRepository;

    @Override
    public void register(CustOrder order) throws Exception {
        orderRepository.insert(order);
    }

    @Override
    public void modify(CustOrder order) throws Exception {
        // 주문은 수정하지 않음 - 필요시 예외 처리
    }

    @Override
    public void remove(Integer orderId) throws Exception {
        // 주문 삭제 (주문 취소)
        orderRepository.delete(orderId);
    }

    @Override
    public List<CustOrder> get() throws Exception {
        // 보안상 모든 주문 조회 금지
        return null;
    }

    @Override
    public CustOrder get(Integer orderId) throws Exception {
        return orderRepository.select(orderId);
    }

    // ===== 주문 전용 메소드 =====

    /**
     * 특정 고객의 주문 내역 조회
     * @param custId 고객 ID
     * @return 해당 고객의 주문 목록 (최신순)
     */
    public List<CustOrder> getOrdersByCustId(Integer custId) throws Exception {
        return orderRepository.findByCustId(custId);
    }
}