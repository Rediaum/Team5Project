package edu.sm.controller;

import edu.sm.dto.Product;
import edu.sm.service.ProductService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin/inventory")
@RequiredArgsConstructor
public class ProductInventoryController {

    private final ProductService productService;

    @GetMapping
    public String inventoryPage(HttpSession session, Model model) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/";
        }
        try {
            List<Product> productList = productService.get();
            model.addAttribute("productList", productList);
            model.addAttribute("newProduct", new Product());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admin/inventory";
    }

    // 제품 축아
    @PostMapping("/add")
    public String addProduct(@ModelAttribute("newProduct") Product product) {
        try {
            productService.register(product);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/inventory";
    }

    // 제품 정보 수정
    @PostMapping("/update")
    public String updateProduct(@ModelAttribute Product product) {
        try {
            productService.modify(product);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/inventory";
    }
}
