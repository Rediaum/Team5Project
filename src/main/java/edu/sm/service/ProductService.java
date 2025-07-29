package edu.sm.service;

import edu.sm.dto.Product;
import edu.sm.frame.ProjectService;
import edu.sm.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ProductService implements ProjectService<Product, Integer> {

    final ProductRepository productRepository;

    @Override
    public void register(Product product) throws Exception {
        productRepository.insert(product);
    }

    @Override
    public void modify(Product product) throws Exception {
        productRepository.update(product);
    }

    @Override
    public void remove(Integer i) throws Exception{
        productRepository.delete(i);
    }

    @Override
    public List<Product> get() throws Exception {
        return productRepository.selectAll();
    }

    @Override
    public Product get(Integer i) throws Exception {
        return productRepository.select(i);
    }

    // ProductService에만 있는 추가 메소드
    public List<Product> getRecentProducts(int limit) throws Exception {
        return productRepository.getRecentProducts(limit);
    }

    // 검색을 위한 추가 메소드들
    // 키워드 검색 (상품명 + 설명에서 검색)

    public List<Product> searchProducts(String keyword) throws Exception {
        if (keyword == null || keyword.trim().isEmpty()) {
            return new ArrayList<>();
        }
        return productRepository.searchByKeyword(keyword.trim());
    }

    // 가격 범위 검색
    public List<Product> searchByPriceRange(Integer minPrice, Integer maxPrice) throws Exception {
        return productRepository.searchByPriceRange(minPrice, maxPrice);
    }

    // 고급 검색
    public List<Product> advancedSearch(String keyword, Integer categoryId,
                                        Integer minPrice, Integer maxPrice,
                                        String sortBy, String sortOrder) throws Exception {

        // 기본값 설정
        if (sortBy == null || sortBy.isEmpty()) sortBy = "product_regdate";
        if (sortOrder == null || sortOrder.isEmpty()) sortOrder = "DESC";

        return productRepository.advancedSearch(keyword, categoryId, minPrice, maxPrice, sortBy, sortOrder);
    }

    // 인기 상품 조회

    public List<Product> getPopularProducts(int limit) throws Exception {
        return productRepository.getPopularProducts(limit);
    }

    // 할인 상품 조회

    public List<Product> getDiscountedProducts() throws Exception {
        return productRepository.getDiscountedProducts();
    }

    // 검색 자동완성 제안

    public List<String> getSearchSuggestions(String keyword) throws Exception {
        if (keyword == null || keyword.trim().length() < 2) {
            return new ArrayList<>();
        }
        return productRepository.getProductNameSuggestions(keyword.trim(), 10);
    }

    // 검색 결과 통계

    public Map<String, Object> getSearchStatistics(List<Product> products) {
        Map<String, Object> stats = new HashMap<>();

        if (products.isEmpty()) {
            stats.put("totalCount", 0);
            stats.put("avgPrice", 0);
            stats.put("minPrice", 0);
            stats.put("maxPrice", 0);
            return stats;
        }

        int totalCount = products.size();
        int minPrice = products.stream().mapToInt(Product::getProductPrice).min().orElse(0);
        int maxPrice = products.stream().mapToInt(Product::getProductPrice).max().orElse(0);
        double avgPrice = products.stream().mapToInt(Product::getProductPrice).average().orElse(0);

        stats.put("totalCount", totalCount);
        stats.put("avgPrice", Math.round(avgPrice));
        stats.put("minPrice", minPrice);
        stats.put("maxPrice", maxPrice);

        return stats;
    }
}