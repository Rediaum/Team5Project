package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
public class LoginController {
//1
    private final CustService custService;

    /**
     * 로그인 페이지 표시
     */
    @RequestMapping("/login")
    public String login(Model model) {
        model.addAttribute("center", "login");
        return "index";
    }

    /**
     * 로그인 처리
     */
    @PostMapping("/loginimpl")
    public String loginImpl(Model model,
                            @RequestParam("email") String email,
                            @RequestParam("pwd") String pwd,
                            HttpSession session) throws Exception {
        log.info("로그인 시도 - Email: {}", email);

        Cust dbCust = custService.getByEmail(email);

        if (dbCust == null) {
            model.addAttribute("loginstate", "fail");
            model.addAttribute("center", "login");
            return "index";
        }

        if (dbCust.getCustPwd().equals(pwd)) {
            session.setAttribute("logincust", dbCust);
            return "redirect:/";
        } else {
            model.addAttribute("loginstate", "fail");
            model.addAttribute("center", "login");
            return "index";
        }
    }

    /**
     * 로그아웃 처리
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }
}