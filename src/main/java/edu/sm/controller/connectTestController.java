package edu.sm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class connectTestController {
    // About 페이지 (about.jsp)
    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("pageTitle", "About Us");
        return "about"; // about.jsp로 이동
    }

    // Testimonial 페이지
    @GetMapping("/testimonial")
    public String testimonial(Model model) {
        model.addAttribute("pageTitle", "Testimonial");
        return "testimonial"; // testimonial.jsp로 이동
    }




    // Contact 페이지

    @GetMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("pageTitle", "Contact Us");
        return "contact"; // contact.jsp로 이동
    }


}
