package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("/register")
@Slf4j
public class RegisterController {

    private final CustService custService;

    /**
     * 회원가입 페이지 표시
     */
    @GetMapping("")
    public String registerForm(Model model) {
        log.info("회원가입 페이지 요청");
        model.addAttribute("pageTitle", "회원가입");
        model.addAttribute("cust", new Cust());
        return "register";
    }

    /**
     * 회원가입 처리
     */
    @PostMapping("")
    public String register(@ModelAttribute Cust cust,
                           @RequestParam String pwdConfirm,
                           RedirectAttributes redirectAttributes,
                           Model model) {
        try {
            log.info("회원가입 처리 시작: {}", cust.getCustEmail());

            // 비밀번호 확인 검사
            if (!cust.getCustPwd().equals(pwdConfirm)) {
                model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
                model.addAttribute("cust", cust);
                return "register";
            }

            // 유효성 검사
            if (!custService.validateCust(cust)) {
                model.addAttribute("error", "입력 정보를 다시 확인해주세요. 이미 사용중인 이메일일 수 있습니다.");
                model.addAttribute("cust", cust);
                return "register";
            }

            // 회원가입 처리
            custService.register(cust);
            log.info("회원가입 완료: {}", cust.getCustEmail());

            redirectAttributes.addFlashAttribute("success", "회원가입이 완료되었습니다!");
            return "redirect:/"; // 메인 페이지로 이동

        } catch (Exception e) {
            log.error("회원가입 처리 중 오류: ", e);
            model.addAttribute("error", "회원가입 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("cust", cust);
            return "register";
        }
    }

    /**
     * 이메일 중복 체크 (AJAX)
     * ✅ 수정: 명확한 응답 구조로 변경
     */
    @PostMapping("/check-email")
    @ResponseBody
    public ResponseEntity<Boolean> checkEmailDuplicate(@RequestParam String email) {
        try {
            log.info("이메일 중복 체크: {}", email);
            boolean isDuplicate = custService.checkEmailDuplicate(email);

            // ✅ 명확한 로직: 중복이면 false(사용불가), 중복 아니면 true(사용가능)
            boolean isAvailable = !isDuplicate;

            log.info("이메일 {} - 중복: {}, 사용가능: {}", email, isDuplicate, isAvailable);
            return ResponseEntity.ok(isAvailable);

        } catch (Exception e) {
            log.error("이메일 중복 체크 오류: ", e);
            return ResponseEntity.ok(false); // 오류 시 사용 불가로 처리
        }
    }
}