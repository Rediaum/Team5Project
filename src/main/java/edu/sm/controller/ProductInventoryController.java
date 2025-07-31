package edu.sm.controller;

import edu.sm.dto.Product;
import edu.sm.service.ProductService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/inventory")
@RequiredArgsConstructor
public class ProductInventoryController {

    private final ProductService productService;

    // 재고 목록 페이지
    @GetMapping
    public String inventoryPage(HttpSession session, Model model) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            List<Product> productList = productService.get();
            model.addAttribute("productList", productList);
            model.addAttribute("activePage", "inventory");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admin/inventory";
    }

    // 페이지 추가 양식
    @GetMapping("/add")
    public String addPage(HttpSession session, Model model) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        model.addAttribute("activePage", "add");
        return "admin/add";
    }

    // 제품 추가 (폼 제출 처리)
    @PostMapping("/addimpl")
    public String addProductImpl(@ModelAttribute Product product,
                                 @RequestParam("imgfile") MultipartFile imgfile,
                                 HttpSession session) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            // 이미지 파일을 저장
            String uploadPath = session.getServletContext().getRealPath("/views/images/");
            String filename = UUID.randomUUID().toString() + "_" + imgfile.getOriginalFilename();
            File dest = Paths.get(uploadPath, filename).toFile();
            imgfile.transferTo(dest);

            // 데이터 제품 설정
            product.setProductImg(filename);
            product.setProductRegdate(new Timestamp(System.currentTimeMillis()));
            productService.register(product);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/admin/inventory";
    }

    // 세부 사항 + 업데이트 양식 페이지
    @GetMapping("/update/{id}")
    public String updatePage(@PathVariable("id") int id, HttpSession session, Model model) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            Product product = productService.get(id);
            model.addAttribute("product", product);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "admin/update";
    }

    // 제품 데이터 업데이트
    @PostMapping("/update")
    public String updateProduct(@ModelAttribute Product product,
                                @RequestParam(value = "imgfile", required = false) MultipartFile imgfile,
                                HttpSession session) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            // 이미지가 업로드되면 해당 이미지를 교체
            if (imgfile != null && !imgfile.isEmpty()) {
                String uploadPath = session.getServletContext().getRealPath("/views/images/");
                String filename = imgfile.getOriginalFilename();
                File dest = Paths.get(uploadPath, filename).toFile();
                imgfile.transferTo(dest);
                product.setProductImg(filename);
            } else {
                Product oldProduct = productService.get(product.getProductId());
                product.setProductImg(oldProduct.getProductImg());
            }

            product.setProductUpdate(new Timestamp(System.currentTimeMillis()));
            productService.modify(product);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/admin/inventory";
    }

    // 제품 삭제
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") int id, HttpSession session) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            productService.remove(id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/admin/inventory";
    }
}
