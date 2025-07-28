package edu.sm.repository;

import edu.sm.dto.Product;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ProductRepository extends ProjectRepository<Product, Integer> {
    // @Param 어노테이션으로 파라미터 명시
    List<Product> getRecentProducts(@Param("limit") int limit) throws Exception;

    // 카테고리명 포함 조회가 필요하다면
    List<Product> getRecentProductsWithCategory(@Param("limit") int limit) throws Exception;
}
