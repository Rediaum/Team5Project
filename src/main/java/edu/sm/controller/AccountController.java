package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class AccountController {

    private final CustService custService;

    @RequestMapping("/register")
    public String register(Model model) {
        model.addAttribute("pageTitle","Register New Account");
        return "register";
    }

    @RequestMapping("/registerimpl")
    public String registerimpl(Model model, Cust cust, HttpSession session) throws Exception {

        log.info("Registering user: password={}, name={}, email={}, phone={}",
                cust.getCustPwd(), cust.getCustName(), cust.getCustEmail(), cust.getCustPhone());
        try {
            // Save user data into the database
            custService.register(cust);
            // Store the registered user in the session
            session.setAttribute("logincust", cust);
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed. Please try again.");
            return "register";
        }
        // Redirect to the home page after successful registration
        return "redirect:/";
    }
}
