package edu.sm.controller;

import edu.sm.dto.Product;
import edu.sm.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ProductController {

    final ProductService productService;
    /**
     * 상품 목록 페이지
     */
    @RequestMapping("/product")
    public String product(Model model) {
//        log.info("Start Product...");
        try {
            List<Product> productList = productService.get();
            model.addAttribute("productList", productList);
            model.addAttribute("selectedCategory", 0); // 0 = 전체
//            log.info("상품 목록 페이지에 {} 개의 상품을 표시합니다.", productList.size());
        } catch (Exception e) {
//            log.error("상품 목록 로딩 오류", e);
            model.addAttribute("productList", new ArrayList<>());
        }
        return "product/center";
    }

    //상품 상세 페이지
    @RequestMapping("/product/detail/{productId}")
    public String productDetail(@PathVariable int productId, Model model) {
//        log.info("Start Product Detail... productId: {}", productId);
        try {
            Product product = productService.get(productId);
            model.addAttribute("product", product);
            return "product/detail";
        } catch (Exception e) {
//            log.error("상품 상세 정보 로딩 오류: {}", productId, e);
            return "redirect:/product/center";
        }
    }
    // 카테고리별 상품 필터링
    @RequestMapping("/product/category/{categoryId}")
    public String productByCategory(@PathVariable int categoryId, Model model) {
//        log.info("Start Product by Category... categoryId: {}", categoryId);
        try {
            List<Product> allProducts = productService.get();
            List<Product> filteredProducts = new ArrayList<>();

            // 카테고리별 필터링
            for (Product product : allProducts) {
                if (product.getCategoryId() == categoryId) {
                    filteredProducts.add(product);
                }
            }

            model.addAttribute("productList", filteredProducts);
            model.addAttribute("selectedCategory", categoryId);
//            log.info("카테고리 {} : {} 개의 상품을 찾았습니다.", categoryId, filteredProducts.size());

        } catch (Exception e) {
//            log.error("카테고리별 상품 로딩 오류", e);
            model.addAttribute("productList", new ArrayList<>());
        }
        return "product/center";
    }





}