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
        log.info("Start Product...");
        try {
            List<Product> productList = productService.get();
            model.addAttribute("productList", productList);
            model.addAttribute("selectedCategory", 0); // 0 = 전체
            log.info("상품 목록 페이지에 {} 개의 상품을 표시합니다.", productList.size());
        } catch (Exception e) {
            log.error("상품 목록 로딩 오류", e);
            model.addAttribute("productList", new ArrayList<>());
        }
        return "product";
    }

    /**
     * 상품 상세 페이지
     */
    @RequestMapping("/product/detail/{productId}")
    public String productDetail(@PathVariable int productId, Model model) {
        log.info("Start Product Detail... productId: {}", productId);
        try {
            Product product = productService.get(productId);
            model.addAttribute("product", product);
            return "product-detail";
        } catch (Exception e) {
            log.error("상품 상세 정보 로딩 오류: {}", productId, e);
            return "redirect:/product";
        }
    }
    /**
     * 카테고리별 상품 필터링
     */
    @RequestMapping("/product/category/{categoryId}")
    public String productByCategory(@PathVariable int categoryId, Model model) {
        log.info("Start Product by Category... categoryId: {}", categoryId);
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
            log.info("카테고리 {} : {} 개의 상품을 찾았습니다.", categoryId, filteredProducts.size());

        } catch (Exception e) {
            log.error("카테고리별 상품 로딩 오류", e);
            model.addAttribute("productList", new ArrayList<>());
        }
        return "product";
    }



    /**
     * About 페이지
     */
    @RequestMapping("/about")
    public String about(Model model) {
        log.info("Start About...");
        return "about";
    }

    /**
     * Testimonial 페이지
     */
    @RequestMapping("/testimonial")
    public String testimonial(Model model) {
        log.info("Start Testimonial...");
        return "testimonial";
    }

    /**
     * Blog 페이지
     */
    @RequestMapping("/blog_list")
    public String blog(Model model) {
        log.info("Start Blog...");
        return "blog_list";
    }

    /**
     * Contact 페이지
     */
    @RequestMapping("/contact")
    public String contact(Model model) {
        log.info("Start Contact...");
        return "contact";
    }

//    //Search 기능
//
//    @RequestMapping("/search")
//    public String search(@RequestParam(required = false) String keyword, Model model) {
//        log.info("Start Search... keyword: {}", keyword);
//        try {
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                List<Product> allProducts = productService.get();
//                List<Product> searchResults = new ArrayList<>();
//
//                for (Product product : allProducts) {
//                    if (product.getProductName().toLowerCase().contains(keyword.toLowerCase())) {
//                        searchResults.add(product);
//                    }
//                }
//
//                model.addAttribute("productList", searchResults);
//                model.addAttribute("keyword", keyword);
//                log.info("검색 키워드 '{}': {} 개의 상품을 찾았습니다.", keyword, searchResults.size());
//            } else {
//                model.addAttribute("productList", new ArrayList<>());
//            }
//        } catch (Exception e) {
//            log.error("검색 중 오류 발생", e);
//            model.addAttribute("productList", new ArrayList<>());
//        }
//        return "product"; // product.jsp 재사용
//    }
}