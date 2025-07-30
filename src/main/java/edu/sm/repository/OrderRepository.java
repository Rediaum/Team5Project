package edu.sm.repository;

import edu.sm.dto.CustOrder;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface OrderRepository extends ProjectRepository<CustOrder, Integer> {

    /**
     * 주문 생성 후 ID 반환 (핵심 추가 기능)
     * @param order 주문 정보
     * @throws Exception
     */
    void insertAndGetId(CustOrder order) throws Exception;

    /**
     * 특정 고객의 주문 내역 조회
     * @param custId 고객 ID
     * @return 주문 목록 (최신순)
     * @throws Exception
     */
    List<CustOrder> findByCustId(Integer custId) throws Exception;
}