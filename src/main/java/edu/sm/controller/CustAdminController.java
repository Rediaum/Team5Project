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
@RequestMapping("/admin/customer")
@RequiredArgsConstructor
public class CustAdminController {

    private final CustService custService;

    // Tampilkan semua customer
    @GetMapping("/customers")
    public String custList(HttpSession session, Model model) {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        try {
            List<Cust> custList = custService.get();  // Ubah getAll() → get()
            model.addAttribute("custList", custList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "admin/customerList";
    }

    // Halaman detail & update customer
    @GetMapping("/{custId}")
    public String customerDetail(@PathVariable int custId, HttpSession session, Model model) throws Exception {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        Cust cust = custService.get(custId);
        model.addAttribute("cust", cust);
        return "admin/customerUpdate";
    }

    // Update data customer
    @PostMapping("/update")
    public String updateCustomer(@ModelAttribute Cust cust, HttpSession session) throws Exception {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        custService.modify(cust);
        return "redirect:/admin/customer";
    }

    // Hapus customer
    @GetMapping("/delete/{custId}")
    public String deleteCustomer(@PathVariable int custId, HttpSession session) throws Exception {
        if (!"admin".equals(session.getAttribute("role"))) return "redirect:/";

        custService.remove(custId);
        return "redirect:/admin/customer";
    }
}
