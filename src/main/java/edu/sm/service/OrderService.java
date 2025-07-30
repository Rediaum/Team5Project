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

    /**
     * 주문 등록 후 생성된 ID 반환 (핵심 추가 기능)
     */
    public Integer registerAndGetId(CustOrder order) throws Exception {
        orderRepository.insertAndGetId(order);
        return order.getOrderId(); // MyBatis가 자동으로 설정해준 ID 반환
    }

    @Override
    public void modify(CustOrder order) throws Exception {
        // 주문은 수정하지 않음 - 필요시 예외 처리
        throw new UnsupportedOperationException("주문 정보는 수정할 수 없습니다.");
    }

    @Override
    public void remove(Integer orderId) throws Exception {
        // 주문 삭제 (주문 취소)
        orderRepository.delete(orderId);
    }

    @Override
    public List<CustOrder> get() throws Exception {
        // 보안상 모든 주문 조회 금지
        throw new UnsupportedOperationException("전체 주문 조회는 지원하지 않습니다.");
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

    /**
     * 주문 상태별 조회 (확장 가능)
     */
    public List<CustOrder> getOrdersByStatus(Integer custId, String status) throws Exception {
        // 향후 주문 상태 관리가 필요할 때 구현
        return orderRepository.findByCustId(custId);
    }
}