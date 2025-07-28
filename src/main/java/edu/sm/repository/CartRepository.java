package edu.sm.repository;

import edu.sm.dto.Cart;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CartRepository extends ProjectRepository<Cart, Integer> {

    /**
     * ✅ 특정 고객의 장바구니 전체 목록 조회 (Integer 타입으로 수정)
     * @param custId 고객 ID (Integer 타입)
     * @return 장바구니 목록
     */
    List<Cart> findByCustId(Integer custId) throws Exception;

    /**
     * 중복 상품 체크 (같은 고객의 같은 상품)
     * @param custId 고객 ID
     * @param productId 상품 ID
     * @return 기존 장바구니 항목 (없으면 null)
     */
    Cart findByCustomerAndProduct(@Param("custId") Integer custId,
                                  @Param("productId") Integer productId) throws Exception;

    /**
     * 기존 상품의 수량만 증가
     * @param custId 고객 ID
     * @param productId 상품 ID
     * @param quantity 추가할 수량
     */
    void updateQuantity(@Param("custId") Integer custId,
                        @Param("productId") Integer productId,
                        @Param("quantity") Integer quantity) throws Exception;
}