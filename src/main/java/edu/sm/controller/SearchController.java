package edu.sm.controller;

import edu.sm.dto.Category;
import edu.sm.dto.Product;
import edu.sm.service.CategoryService;
import edu.sm.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/search")
@Slf4j
public class SearchController {
    private final CategoryService categoryService;
    private final ProductService productService;

    // 기본 검색 페이지 (search 메서드 수정)
    @RequestMapping("")
    public String search(@RequestParam(required = false) String keyword,
                         @RequestParam(required = false) Integer category,
                         @RequestParam(required = false) Integer minPrice,
                         @RequestParam(required = false) Integer maxPrice,
                         @RequestParam(required = false) String sortBy,
                         @RequestParam(required = false) String sortOrder,
                         Model model) {

        try {
            List<Product> searchResults;

            // 동적 카테고리 목록 조회
            List<Category> mainCategories = categoryService.getMainCategories();

            // 검색 조건이 있으면 고급 검색, 없으면 전체 상품 조회
            if (hasAdvancedFilters(keyword, category, minPrice, maxPrice)) {
                searchResults = productService.advancedSearch(
                        keyword, category, minPrice, maxPrice, sortBy, sortOrder);
            } else {
                // 검색 조건이 없으면 전체 상품을 최신순으로 조회
                searchResults = productService.get();
            }

            // 검색 결과 통계 계산 (할인 적용된 가격 기준)
            Map<String, Object> searchStats = calculateSearchStatistics(searchResults);

            // 모델에 데이터 추가
            model.addAttribute("searchResults", searchResults);
            model.addAttribute("searchStats", searchStats);
            model.addAttribute("mainCategories", mainCategories);
            model.addAttribute("keyword", keyword);
            model.addAttribute("selectedCategory", category != null ? category : 0);
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);
            model.addAttribute("sortBy", sortBy != null ? sortBy : "product_regdate");
            model.addAttribute("sortOrder", sortOrder != null ? sortOrder : "DESC");

        } catch (Exception e) {
            model.addAttribute("searchResults", new ArrayList<>());
            model.addAttribute("mainCategories", new ArrayList<>());
            model.addAttribute("error", "검색 중 오류가 발생했습니다.");
        }

        return "product/search";
    }

    // 검색 결과 통계 계산 (할인 적용된 실제 판매가격 기준)

    private Map<String, Object> calculateSearchStatistics(List<Product> searchResults) {
        Map<String, Object> stats = new HashMap<>();

        if (searchResults == null || searchResults.isEmpty()) {
            stats.put("totalCount", 0);
            stats.put("avgPrice", 0);
            stats.put("minPrice", 0);
            stats.put("maxPrice", 0);
            return stats;
        }

        // 할인 적용된 실제 판매가격 계산
        List<Double> actualPrices = new ArrayList<>();

        for (Product product : searchResults) {
            double actualPrice;

            if (product.getDiscountRate() > 0) {
                // 할인율이 0.1 형태(10%)인지 70 형태(70%)인지 확인
                double discountRate = product.getDiscountRate() > 1 ?
                        product.getDiscountRate() / 100 : product.getDiscountRate();
                actualPrice = product.getProductPrice() * (1 - discountRate);
            } else {
                // 할인이 없는 경우 원가격
                actualPrice = product.getProductPrice();
            }

            actualPrices.add(actualPrice);
        }

        int totalCount = searchResults.size();
        double totalPrice = actualPrices.stream().mapToDouble(Double::doubleValue).sum();
        double avgPrice = totalPrice / totalCount;
        double minPrice = actualPrices.stream().mapToDouble(Double::doubleValue).min().orElse(0);
        double maxPrice = actualPrices.stream().mapToDouble(Double::doubleValue).max().orElse(0);

        stats.put("totalCount", totalCount);
        stats.put("avgPrice", Math.round(avgPrice));
        stats.put("minPrice", Math.round(minPrice));
        stats.put("maxPrice", Math.round(maxPrice));

        return stats;
    }

    // AJAX 자동완성 검색

    @GetMapping("/suggestions")
    @ResponseBody
    public ResponseEntity<List<String>> getSearchSuggestions(@RequestParam String keyword) {
        try {
            List<String> suggestions = productService.getSearchSuggestions(keyword);
            return ResponseEntity.ok(suggestions);
        } catch (Exception e) {
//            log.error("자동완성 검색 오류: ", e);
            return ResponseEntity.ok(new ArrayList<>());
        }
    }

    //인기 검색어 AJAX
    @GetMapping("/popular")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getPopularProducts() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Product> popularProducts = productService.getPopularProducts(8);
            response.put("success", true);
            response.put("products", popularProducts);
        } catch (Exception e) {
//            log.error("인기 상품 조회 오류: ", e);
            response.put("success", false);
            response.put("message", "인기 상품을 불러올 수 없습니다.");
        }
        return ResponseEntity.ok(response);
    }

    // 할인 상품 AJAX

    @GetMapping("/discounted")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDiscountedProducts() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Product> discountedProducts = productService.getDiscountedProducts();
            response.put("success", true);
            response.put("products", discountedProducts);
        } catch (Exception e) {
//            log.error("할인 상품 조회 오류: ", e);
            response.put("success", false);
            response.put("message", "할인 상품을 불러올 수 없습니다.");
        }
        return ResponseEntity.ok(response);
    }

    private boolean hasAdvancedFilters(String keyword, Integer category,
                                       Integer minPrice, Integer maxPrice) {
        return (keyword != null && !keyword.trim().isEmpty()) ||
                (category != null && category > 0) ||
                (minPrice != null && minPrice > 0) ||
                (maxPrice != null && maxPrice > 0);
    }
}