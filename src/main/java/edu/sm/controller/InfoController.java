package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.dto.Address;
import edu.sm.service.AddressService;
import edu.sm.service.CustService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@Slf4j
public class InfoController {

    private final CustService custService;
    private final AddressService addressService;

    /**
     * 프로필 페이지 - 기본 배송지 정보도 함께 조회
     */
    @GetMapping("/info")
    public String profile(Model model, HttpSession session) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        // 사용자 정보 설정
        model.addAttribute("cust", loginUser);

        // 기본 배송지 정보 조회
        try {
            Address defaultAddress = addressService.getDefaultAddress(loginUser.getCustId());
            model.addAttribute("defaultAddress", defaultAddress);
            log.info("사용자 {}의 기본 배송지 조회: {}",
                    loginUser.getCustName(),
                    defaultAddress != null ? defaultAddress.getAddressName() : "없음");
        } catch (Exception e) {
            log.error("기본 배송지 조회 실패: {}", e.getMessage());
            // 기본 배송지 조회 실패해도 프로필 페이지는 정상 표시
            model.addAttribute("defaultAddress", null);
        }

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
            redirectAttributes.addFlashAttribute("error", "현비밀번호가 잘못되었습니다!");
            return "redirect:/info";
        }

        // 변경 여부 체크
        boolean isPhoneChanged = cust.getCustPhone() != null && !cust.getCustPhone().equals(loginUser.getCustPhone());
        boolean isPwdChanged = cust.getCustPwd() != null && !cust.getCustPwd().isEmpty();

        // 새 비밀번호가 현재와 동일한지 확인
        if (isPwdChanged && cust.getCustPwd().equals(currentPwd)) {
            redirectAttributes.addFlashAttribute("error", "새 비밀번호는 기존 비밀번호와 같을 수 없습니다.");
            return "redirect:/info";
        }

        // 데이터 변경 없으면 리턴
        if (!isPhoneChanged && !isPwdChanged) {
            redirectAttributes.addFlashAttribute("error", "수정된 데이터가 없습니다.");
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

        // 업데이트 로그 출력
        log.info("프로필 수정 완료: {}", cust.getCustEmail());

        // 세션 업데이트
        session.setAttribute("logincust", cust);

        redirectAttributes.addFlashAttribute("success", "프로필 수정되었습니다..");
        return "redirect:/info";
    }

}
