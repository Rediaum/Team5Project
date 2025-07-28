package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class LoginController {

    private final CustService custService;

    /**
     * 로그인 페이지 표시
     */
    @RequestMapping("/login")
    public String login(Model model) {
        return "login";  // 직접 login.jsp 반환
    }

    /**
     * ✅ AJAX 로그인 처리 - JSON 응답
     */
    @PostMapping("/loginimpl")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> loginImpl(
            @RequestParam("email") String email,
            @RequestParam("pwd") String pwd,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            log.info("로그인 시도 - Email: {}", email);

            // 이메일로 사용자 조회
            Cust dbCust = custService.getByEmail(email);

            if (dbCust == null) {
                log.warn("존재하지 않는 이메일: {}", email);
                response.put("success", false);
                response.put("message", "존재하지 않는 이메일입니다.");
                return ResponseEntity.ok(response);
            }

            // 비밀번호 확인
            if (dbCust.getCustPwd().equals(pwd)) {
                // 로그인 성공
                session.setAttribute("logincust", dbCust);
                log.info("로그인 성공: {}", email);

                response.put("success", true);
                response.put("message", "로그인 성공!");
                response.put("custName", dbCust.getCustName());
                return ResponseEntity.ok(response);
            } else {
                // 비밀번호 불일치
                log.warn("비밀번호 불일치: {}", email);
                response.put("success", false);
                response.put("message", "비밀번호가 일치하지 않습니다.");
                return ResponseEntity.ok(response);
            }

        } catch (Exception e) {
            log.error("로그인 처리 중 오류: ", e);
            response.put("success", false);
            response.put("message", "로그인 처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(response);
        }
    }

    /**
     * 로그아웃 처리
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
            log.info("로그아웃 완료");
        }
        return "redirect:/";
    }
}