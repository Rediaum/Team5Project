package edu.sm.controller;

import edu.sm.dto.Admin;
import edu.sm.dto.Cust;
import edu.sm.service.AdminService;
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
    private final AdminService adminService;

    @RequestMapping("/login")
    public String login(Model model) {
        return "auth/login";
    }

    //Admin과 cust 통합 로그인

    @PostMapping("/loginimpl")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> loginImpl(
            @RequestParam("email") String email,
            @RequestParam("pwd") String pwd,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
//            log.info("통합 로그인 시도 - Email: {}", email);

            // 1Admin 테이블에서 먼저 확인
            Admin dbAdmin = adminService.getByEmail(email);
            if (dbAdmin != null) {
                if (dbAdmin.getAdminPwd().equals(pwd)) {
                    //  Admin을 Cust 형태로 변환해서 세션에 저장
                    Cust adminAsCust = convertAdminToCust(dbAdmin);
                    session.setAttribute("logincust", adminAsCust);

                    // Admin 플래그 추가
                    session.setAttribute("isAdmin", true);
                    session.setAttribute("adminInfo", dbAdmin); // 원본 Admin 정보도 저장
                    session.setAttribute("role", "admin"); // Admin role 추가

//                    log.info("Admin 로그인 성공: {}", email);

                    response.put("success", true);
                    response.put("message", "관리자 로그인 성공!");
                    response.put("custName", dbAdmin.getAdminName());
                    response.put("userType", "admin");
                    return ResponseEntity.ok(response);
                } else {
                    log.warn("Admin 비밀번호 불일치: {}", email);
                    response.put("success", false);
                    response.put("message", "비밀번호가 일치하지 않습니다.");
                    return ResponseEntity.ok(response);
                }
            }

            // 2️ Cust 테이블에서 확인 (후순위)
            Cust dbCust = custService.getByEmail(email);
            if (dbCust != null) {
                if (dbCust.getCustPwd().equals(pwd)) {
                    session.setAttribute("logincust", dbCust);
                    // 일반 고객은 Admin 플래그 false
                    session.setAttribute("isAdmin", false);
                    session.setAttribute("role", "cust"); // cust role 축아

//                    log.info("고객 로그인 성공: {}", email);

                    response.put("success", true);
                    response.put("message", "로그인 성공!");
                    response.put("custName", dbCust.getCustName());
                    response.put("userType", "customer");
                    return ResponseEntity.ok(response);
                } else {
//                    log.warn("고객 비밀번호 불일치: {}", email);
                    response.put("success", false);
                    response.put("message", "비밀번호가 일치하지 않습니다.");
                    return ResponseEntity.ok(response);
                }
            }

            // 3️ 둘 다 없는 경우
//            log.warn("존재하지 않는 이메일: {}", email);
            response.put("success", false);
            response.put("message", "존재하지 않는 이메일입니다.");
            return ResponseEntity.ok(response);

        } catch (Exception e) {
//            log.error("로그인 처리 중 오류: ", e);
            response.put("success", false);
            response.put("message", "로그인 처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(response);
        }
    }

    // 로그아웃 처리

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate(); // 모든 세션 정보 삭제 (isAdmin 포함)
//            log.info("로그아웃 완료");
        }
        return "redirect:/";
    }

    // Admin → Cust 변환 (JSP 호환성을 위해)

    private Cust convertAdminToCust(Admin admin) {
        Cust adminAsCust = new Cust();

        adminAsCust.setCustId(admin.getAdminId());
        adminAsCust.setCustEmail(admin.getAdminEmail());
        adminAsCust.setCustPwd(admin.getAdminPwd());
        adminAsCust.setCustName(admin.getAdminName());
        adminAsCust.setCustPhone(admin.getAdminPhone());
        adminAsCust.setCustRegdate(admin.getAdminRegdate());
        adminAsCust.setCustUpdate(admin.getAdminUpdate());

        return adminAsCust;
    }
}