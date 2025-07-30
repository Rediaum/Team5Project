package edu.sm.repository;

import edu.sm.dto.OrderItem;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface OrderItemRepository extends ProjectRepository<OrderItem, Integer> {
    // 기본 CRUD 기능:
    // insert(OrderItem) - 주문상품 등록
    // delete(Integer) - 주문상품 삭제
    // select(Integer) - 특정 주문상품 조회

    // 사용하지 않는 메서드:
    // update(OrderItem) - 주문상품은 수정하지 않음
    // selectAll() - 보안상 모든 주문상품 조회 금지

    /**
     * 특정 주문의 주문상품 목록 조회
     * @param orderId 주문 ID
     * @return 해당 주문의 주문상품 목록
     */
    List<OrderItem> findByOrderId(Integer orderId) throws Exception;
}