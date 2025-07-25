package edu.sm.controller;

import edu.sm.dto.Product;
import edu.sm.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {

    final ProductService productService;

    // String dir = "product/";  <-- 이 줄을 삭제하거나 주석 처리하세요.

    @RequestMapping("")
    public String product(Model model) throws Exception{
        log.info("Product 페이지 요청이 들어왔습니다.");
        List<Product> productList = null;
        productList  = productService.get();

        // 이 model.addAttribute가 가장 중요합니다.
        model.addAttribute("productList", productList);


        // ▼▼▼ 아래 두 줄을 삭제하거나 주석 처리하세요. ▼▼▼
        // model.addAttribute("left", dir + "left");
        // model.addAttribute("center", dir + "center");

        // ViewResolver가 "product"라는 이름으로 바로 product.jsp를 찾아갑니다.
        return "product";
    }
}