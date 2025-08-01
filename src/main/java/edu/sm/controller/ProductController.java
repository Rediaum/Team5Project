package edu.sm.controller;

import edu.sm.dto.Category;
import edu.sm.dto.Product;
import edu.sm.service.CategoryService;
import edu.sm.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;

    /**
     * 상품 목록 페이지 (전체 상품 + 동적 카테고리)
     */
    @RequestMapping("/product")
    public String product(Model model) {
//        log.info("Start Product...");
        try {
            // 전체 상품 조회
            List<Product> productList = productService.get();

            // 대분류 카테고리 목록 조회 (동적 카테고리 메뉴용)
            List<Category> mainCategories = categoryService.getMainCategories();

            model.addAttribute("productList", productList);
            model.addAttribute("mainCategories", mainCategories);
            model.addAttribute("selectedCategory", 0); // 0 = 전체

//            log.info("상품 목록 페이지에 {} 개의 상품과 {} 개의 카테고리를 표시합니다.",
//                    productList.size(), mainCategories.size());
        } catch (Exception e) {
//            log.error("상품 목록 로딩 오류", e);
            model.addAttribute("productList", new ArrayList<>());
            model.addAttribute("mainCategories", new ArrayList<>());
        }
        return "product/center";
    }

    /**
     * 상품 상세 페이지
     */
    @RequestMapping("/product/detail/{productId}")
    public String productDetail(@PathVariable int productId, Model model) {
//        log.info("Start Product Detail... productId: {}", productId);
        try {
            Product product = productService.get(productId);
            model.addAttribute("product", product);
            return "product/detail";
        } catch (Exception e) {
//            log.error("상품 상세 정보 로딩 오류: {}", productId, e);
            return "redirect:/product";
        }
    }

    /**
     * 카테고리별 상품 필터링 (동적 처리)
     */
    @RequestMapping("/product/category/{categoryId}")
    public String productByCategory(@PathVariable int categoryId, Model model) {
//        log.info("Start Product by Category... categoryId: {}", categoryId);
        try {
            // 해당 카테고리의 상품들 조회
            List<Product> allProducts = productService.get();
            List<Product> filteredProducts = new ArrayList<>();

            // 선택된 카테고리 정보
            Category selectedCategoryInfo = categoryService.get(categoryId);

            // 카테고리별 필터링
            for (Product product : allProducts) {
                if (product.getCategoryId() == categoryId) {
                    filteredProducts.add(product);
                }
                // 만약 대분류를 선택했다면, 그 대분류의 모든 소분류 상품들도 포함
                else if (selectedCategoryInfo != null && selectedCategoryInfo.getParentCategoryId() == null) {
                    // 대분류인 경우, 해당 대분류의 소분류들 확인
                    List<Category> subCategories = categoryService.getSubCategories(categoryId);
                    for (Category subCategory : subCategories) {
                        if (product.getCategoryId() == subCategory.getCategoryId()) {
                            filteredProducts.add(product);
                        }
                    }
                }
            }

            // 대분류 카테고리 목록 (메뉴용)
            List<Category> mainCategories = categoryService.getMainCategories();

            model.addAttribute("productList", filteredProducts);
            model.addAttribute("mainCategories", mainCategories);
            model.addAttribute("selectedCategory", categoryId);
            model.addAttribute("selectedCategoryInfo", selectedCategoryInfo);

//            log.info("카테고리 {} ({}) : {} 개의 상품을 찾았습니다.",
//                    categoryId,
//                    selectedCategoryInfo != null ? selectedCategoryInfo.getCategoryName() : "Unknown",
//                    filteredProducts.size());

        } catch (Exception e) {
//            log.error("카테고리별 상품 로딩 오류", e);
            model.addAttribute("productList", new ArrayList<>());
            model.addAttribute("mainCategories", new ArrayList<>());
        }
        return "product/center";
    }
}