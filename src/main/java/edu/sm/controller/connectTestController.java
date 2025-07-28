package edu.sm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class connectTestController {
    /**
     * About 페이지 (about.jsp)
     */
    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("pageTitle", "About Us");
        return "about"; // about.jsp로 이동
    }

    /**
     * Testimonial 페이지
     */
    @GetMapping("/testimonial")
    public String testimonial(Model model) {
        model.addAttribute("pageTitle", "Testimonial");
        return "testimonial"; // testimonial.jsp로 이동
    }

    /**
     * Blog 페이지
     */
    @GetMapping("/blog_list")
    public String blog(Model model) {
        System.out.println("Blog 페이지 요청이 들어왔습니다.");
        model.addAttribute("pageTitle", "Blog");
        return "blog_list"; // blog_list.jsp로 이동
    }

    /**
     * Contact 페이지
     */
    @GetMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("pageTitle", "Contact Us");
        return "contact"; // contact.jsp로 이동
    }

//    /**
//     * Search 기능
//     */
//    @GetMapping("/search")
//    public String search(@RequestParam(required = false) String keyword, Model model) {
//        model.addAttribute("pageTitle", "Search Results");
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            model.addAttribute("keyword", keyword);
//            // 검색 로직 추가
//            // List<Product> searchResults = productService.searchProducts(keyword);
//            // model.addAttribute("searchResults", searchResults);
//        }
//        return "search"; // search.jsp로 이동 또는 검색 결과 페이지
//    }
}
