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

    // 기본 검색 페이지
    @RequestMapping("")
    public String search(@RequestParam(required = false) String keyword,
                         @RequestParam(required = false) Integer category,
                         @RequestParam(required = false) Integer minPrice,
                         @RequestParam(required = false) Integer maxPrice,
                         @RequestParam(required = false) String sortBy,
                         @RequestParam(required = false) String sortOrder,
                         Model model) {

//        log.info("검색 요청 - 키워드: {}, 카테고리: {}, 가격: {}-{}",
//                keyword, category, minPrice, maxPrice);

        try {
            List<Product> searchResults;
            List<Category> mainCategories = categoryService.getMainCategories();

            // 고급 검색 실행
            if (hasAdvancedFilters(keyword, category, minPrice, maxPrice)) {
                searchResults = productService.advancedSearch(
                        keyword, category, minPrice, maxPrice, sortBy, sortOrder);
            } else {
                searchResults = new ArrayList<>();
            }

            // 검색 결과 통계
            Map<String, Object> searchStats = productService.getSearchStatistics(searchResults);

            // 모델에 데이터 추가
            model.addAttribute("searchResults", searchResults);
            model.addAttribute("searchStats", searchStats);
            model.addAttribute("mainCategories", mainCategories);
            model.addAttribute("keyword", keyword);
            model.addAttribute("selectedCategory", category != null ? category : 0);
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);
            model.addAttribute("sortBy", sortBy != null ? sortBy : "regdate");
            model.addAttribute("sortOrder", sortOrder != null ? sortOrder : "DESC");

//            log.info("검색 완료 - {}개 결과", searchResults.size());

        } catch (Exception e) {
//            log.error("검색 중 오류 발생: ", e);
            model.addAttribute("searchResults", new ArrayList<>());
            model.addAttribute("error", "검색 중 오류가 발생했습니다.");
        }

        return "product/search"; // search.jsp
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