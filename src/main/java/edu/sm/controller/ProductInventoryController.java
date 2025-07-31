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

    // INVENTORY LIST PAGE
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

    // ADD PAGE FORM
    @GetMapping("/add")
    public String addPage(HttpSession session, Model model) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        model.addAttribute("activePage", "add");
        return "admin/add";
    }

    // ADD PRODUCT (HANDLE FORM SUBMISSION)
    @PostMapping("/addimpl")
    public String addProductImpl(@ModelAttribute Product product,
                                 @RequestParam("imgfile") MultipartFile imgfile,
                                 HttpSession session) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            // Simpan file image
            String uploadPath = session.getServletContext().getRealPath("/views/images/");
            String filename = UUID.randomUUID().toString() + "_" + imgfile.getOriginalFilename();
            File dest = Paths.get(uploadPath, filename).toFile();
            imgfile.transferTo(dest);

            // Set data product
            product.setProductImg(filename);
            product.setProductRegdate(new Timestamp(System.currentTimeMillis()));
            productService.register(product);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/admin/inventory";
    }

    // DETAIL + UPDATE FORM PAGE
    @GetMapping("/update/{id}")
    public String updatePage(@PathVariable("id") int id, HttpSession session, Model model) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            Product product = productService.get(id);
            model.addAttribute("product", product);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "admin/update"; // JSP form for editing
    }

    // UPDATE PRODUCT DATA
    @PostMapping("/update")
    public String updateProduct(@ModelAttribute Product product,
                                @RequestParam(value = "imgfile", required = false) MultipartFile imgfile,
                                HttpSession session) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            // Optional: if image is uploaded, replace it
            if (imgfile != null && !imgfile.isEmpty()) {
                String uploadPath = session.getServletContext().getRealPath("/views/images/");
                String filename = imgfile.getOriginalFilename();
                File dest = Paths.get(uploadPath, filename).toFile();
                imgfile.transferTo(dest);
                product.setProductImg(filename);
            } else {
                // Ambil produk lama dulu agar productImg lama tidak hilang
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

    // DELETE PRODUCT
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
