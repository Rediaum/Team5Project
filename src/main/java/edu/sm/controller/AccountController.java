package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


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
    public String registerimpl(Model model, Cust cust, HttpSession session, @RequestParam("confirmCustPwd") String confirmCustPwd) throws Exception {

        log.info("Registering user: password={}, name={}, email={}, phone={}", cust.getCustPwd(), cust.getCustName(), cust.getCustEmail(), cust.getCustPhone());

        // Check if password and confirm password match
        if (!cust.getCustPwd().equals(confirmCustPwd)) {
            model.addAttribute("error", "Password and confirmation do not match.");
            return "register"; // Return to register page if mismatch
        }

        try {
            // Register user data into the database
            custService.register(cust);

            // Save the registered user in session
            session.setAttribute("logincust", cust);
        } catch (Exception e) {
            // If an error occurs (e.g., duplicate email), return to register page
            model.addAttribute("error", "Registration failed. Please try again.");
            return "register";
        }

        // Redirect to the main page after successful registration
        return "redirect:/";
    }


}
