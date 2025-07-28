package edu.sm.controller;

import edu.sm.dto.Product;
import edu.sm.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    final ProductService productService;

    @GetMapping("/")
    public String main(Model model) {
        log.info("Start Main...");

        // 홈페이지 기본 데이터
        model.addAttribute("pageTitle", "Shop - Project team - 5");

        // 상품 목록 추가 (메인 페이지에는 8개만)
        try {
            List<Product> allProducts = productService.get();
            List<Product> productList = new ArrayList<>();
            int limit = Math.min(8, allProducts.size());
            for (int i = 0; i < limit; i++) {
                productList.add(allProducts.get(i));
            }
            model.addAttribute("productList", productList);
            log.info("메인 페이지에 {} 개의 상품을 표시합니다.", productList.size());
        } catch (Exception e) {
            log.error("메인 페이지 상품 로딩 오류", e);
            model.addAttribute("productList", new ArrayList<>());
        }

        return "index";
    }
}