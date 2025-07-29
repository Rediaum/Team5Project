package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class InfoController {

    private final CustService custService;

    // GET: Profil
    @GetMapping("/info")
    public String profile(Model model, HttpSession session) throws Exception {
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("cust", loginUser);
        return "info";
    }

    // POST: Update profil
    @PostMapping("/info/update")
    public String updateProfile(@ModelAttribute Cust cust,
                                @RequestParam("currentPwd") String currentPwd,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) throws Exception {
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        cust.setCustId(loginUser.getCustId());

        // 기존 비밀번호 확인
        if (!loginUser.getCustPwd().equals(currentPwd)) {
            redirectAttributes.addFlashAttribute("errorMsg", "현비밀번호가 잘못되었습니다!");
            return "redirect:/info";
        }

        // 데이터 변경 사항 확인
        boolean isPhoneChanged = cust.getCustPhone() != null && !cust.getCustPhone().equals(loginUser.getCustPhone());
        boolean isPwdChanged = cust.getCustPwd() != null && !cust.getCustPwd().isEmpty() && !cust.getCustPwd().equals(loginUser.getCustPwd());

        if (!isPhoneChanged && !isPwdChanged) {
            redirectAttributes.addFlashAttribute("errorMsg", "수정된 데이터가 없습니다.");
            return "redirect:/info";
        }

        // 비밀번호를 변경하지 않았다면 기존 비밀번호를 사용하세요.
        if (!isPwdChanged) {
            cust.setCustPwd(loginUser.getCustPwd());
        }

        // 폼에서 전송되지 않은 다른 데이터를 추가하여 업데이트 시 null이 되지 않도록 합니다.
        cust.setCustName(loginUser.getCustName());
        cust.setCustEmail(loginUser.getCustEmail());
        cust.setCustRegdate(loginUser.getCustRegdate());

        // Update database
        custService.modify(cust);

        // Update session
        session.setAttribute("logincust", cust);

        redirectAttributes.addFlashAttribute("successMsg", "프로필 수정되었읍니다..");
        return "redirect:/info";
    }

}
