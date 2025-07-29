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

    //키워드로 상품 검색 (상품명 + 설명)
    List<Product> searchByKeyword(@Param("keyword") String keyword) throws Exception;

    //가격 범위로 검색
    List<Product> searchByPriceRange(@Param("minPrice") Integer minPrice,
                                     @Param("maxPrice") Integer maxPrice) throws Exception;

    //카테고리별 검색
    List<Product> searchByCategory(@Param("categoryId") Integer categoryId) throws Exception;

    // 복합 검색 (키워드 + 가격 + 카테고리)
    List<Product> advancedSearch(@Param("keyword") String keyword,
                                 @Param("categoryId") Integer categoryId,
                                 @Param("minPrice") Integer minPrice,
                                 @Param("maxPrice") Integer maxPrice,
                                 @Param("sortBy") String sortBy,
                                 @Param("sortOrder") String sortOrder) throws Exception;

    // 인기 상품 검색 (최근 주문 많은 순)
    List<Product> getPopularProducts(@Param("limit") int limit) throws Exception;

    // 할인 상품 검색
    List<Product> getDiscountedProducts() throws Exception;

    // 검색 자동완성용 상품명 목록
    List<String> getProductNameSuggestions(@Param("keyword") String keyword,
                                           @Param("limit") int limit) throws Exception;
}
