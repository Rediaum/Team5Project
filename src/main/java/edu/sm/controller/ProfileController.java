package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("/profile")
@Slf4j
public class ProfileController {

    private final CustService custService;

    /**
     * 프로필 수정 폼 표시
     */
    @GetMapping("")
    public String showEditForm(@SessionAttribute("loginUser") Cust loginUser, Model model) {
        try {
            Cust customer = custService.getByEmail(loginUser.getCustEmail());
            if (customer == null) {
                log.warn("사용자 정보 없음: {}", loginUser.getCustEmail());
                return "redirect:/";
            }
            model.addAttribute("pageTitle", "프로필 수정");
            model.addAttribute("cust", customer);
            return "profile";
        } catch (Exception e) {
            log.error("프로필 로딩 실패: ", e);
            return "redirect:/";
        }
    }

    /**
     * 프로필 수정 처리
     */
    @PostMapping("/update")
    public String updateProfile(@ModelAttribute Cust cust,
                                @RequestParam String pwdConfirm,
                                @SessionAttribute("loginUser") Cust loginUser,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        try {
            log.info("프로필 수정 요청: {}", loginUser.getCustEmail());

            Cust original = custService.getByEmail(loginUser.getCustEmail());
            if (original == null) {
                model.addAttribute("error", "회원 정보를 찾을 수 없습니다.");
                return "profile";
            }

            // 이름/전화번호 필수 확인
            if (cust.getCustName() == null || cust.getCustName().isBlank()) {
                model.addAttribute("error", "이름을 입력해주세요.");
                model.addAttribute("cust", cust);
                return "profile";
            }

            if (cust.getCustPhone() == null || cust.getCustPhone().isBlank()) {
                model.addAttribute("error", "전화번호를 입력해주세요.");
                model.addAttribute("cust", cust);
                return "profile";
            }

            // 비밀번호가 입력된 경우 변경
            if (cust.getCustPwd() != null && !cust.getCustPwd().isBlank()) {
                if (!cust.getCustPwd().equals(pwdConfirm)) {
                    model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
                    model.addAttribute("cust", cust);
                    return "profile";
                }
                original.setCustPwd(cust.getCustPwd()); // TODO: 암호화 필요
            }

            // 필드 업데이트
            original.setCustName(cust.getCustName());
            original.setCustPhone(cust.getCustPhone());

            custService.modify(original);

            redirectAttributes.addFlashAttribute("success", "프로필이 성공적으로 수정되었습니다.");
            return "redirect:/profile/edit";

        } catch (Exception e) {
            log.error("프로필 수정 실패: ", e);
            model.addAttribute("error", "오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("cust", cust);
            return "profile";
        }
    }
}