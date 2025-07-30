package edu.sm.repository;

import edu.sm.dto.CustOrder;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface OrderRepository extends ProjectRepository<CustOrder, Integer> {
    /**
     * 특정 고객의 주문 내역 조회
     * @param custId 고객 ID
     * @return 해당 고객의 주문 목록 (최신순)
     */
    List<CustOrder> findByCustId(Integer custId) throws Exception;
}