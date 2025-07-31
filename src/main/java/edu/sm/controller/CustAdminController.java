package edu.sm.controller;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/customerList")
@RequiredArgsConstructor
public class CustAdminController {

    private final CustService custService;

    // 모든 고객 표시
    @GetMapping("")
    public String custList(HttpSession session, Model model) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            List<Cust> custList = custService.get();
            model.addAttribute("custList", custList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "admin/customerList";
    }

    // 고객 상세 정보 및 업데이트 페이지
    @GetMapping("/{custId}")
    public String customerDetail(@PathVariable int custId, HttpSession session, Model model) throws Exception {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        Cust cust = custService.get(custId);
        model.addAttribute("cust", cust);
        return "admin/customer";
    }

    // 고객 데이터 업데이트
    @PostMapping("/update")
    public String updateCustomer(@ModelAttribute Cust cust, HttpSession session) throws Exception {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        custService.modify(cust);
        return "redirect:/admin/customerList";
    }

    // Hapus customer
    @GetMapping("/delete/{custId}")
    public String deleteCustomer(@PathVariable int custId, HttpSession session) throws Exception {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        custService.remove(custId);
        return "redirect:/admin/customerList";
    }

}
