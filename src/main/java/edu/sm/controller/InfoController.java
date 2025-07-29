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
                                @RequestParam("pwdConfirm") String pwdConfirm,
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

        // 변경 여부 체크
        boolean isPhoneChanged = cust.getCustPhone() != null && !cust.getCustPhone().equals(loginUser.getCustPhone());
        boolean isPwdChanged = cust.getCustPwd() != null && !cust.getCustPwd().isEmpty();

        // 비밀번호 확인 필드와 일치 여부 체크
        if (isPwdChanged && (pwdConfirm == null || !cust.getCustPwd().equals(pwdConfirm))) {
            redirectAttributes.addFlashAttribute("errorMsg", "새 비밀번호와 확인이 일치하지 않습니다.");
            return "redirect:/info";
        }

        // 새 비밀번호가 현재와 동일한지 확인
        if (isPwdChanged && cust.getCustPwd().equals(currentPwd)) {
            redirectAttributes.addFlashAttribute("errorMsg", "새 비밀번호는 기존 비밀번호와 같을 수 없습니다.");
            return "redirect:/info";
        }

        // 데이터 변경 없으면 리턴
        if (!isPhoneChanged && !isPwdChanged) {
            redirectAttributes.addFlashAttribute("errorMsg", "수정된 데이터가 없습니다.");
            return "redirect:/info";
        }

        // 비밀번호를 변경하지 않는다면 기존 것을 유지
        if (!isPwdChanged) {
            cust.setCustPwd(loginUser.getCustPwd());
        }

        // 폼에서 누락된 필드를 덮어쓰기 방지
        cust.setCustName(loginUser.getCustName());
        cust.setCustEmail(loginUser.getCustEmail());
        cust.setCustRegdate(loginUser.getCustRegdate());

        // 저장
        custService.modify(cust);

        // 세션 업데이트
        session.setAttribute("logincust", cust);

        redirectAttributes.addFlashAttribute("successMsg", "프로필 수정되었읍니다..");
        return "redirect:/info";
    }

}
