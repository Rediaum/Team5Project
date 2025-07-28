package edu.sm.repository;

import edu.sm.dto.Cart;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CartRepository extends ProjectRepository<Cart, Integer> {
    // 특정 고객의 장바구니 전체 목록을 조회하는 기능
    public List<Cart> findByCustId(String custId) throws Exception;

}