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
        cust.setCustName(loginUser.getCustName());
        cust.setCustEmail(loginUser.getCustEmail());
        cust.setCustRegdate(loginUser.getCustRegdate());

        // Cek password dulu, jika salah set error dan kembali
        if (!loginUser.getCustPwd().equals(currentPwd)) {
            redirectAttributes.addFlashAttribute("error", "Password lama salah!");
            return "redirect:/info";
        }

        // Update field yang valid, contohnya: jika password kosong, pakai password lama
        if (cust.getCustPwd() == null || cust.getCustPwd().trim().isEmpty()) {
            cust.setCustPwd(loginUser.getCustPwd());
        }

        custService.modify(cust);

        // Update session user
        session.setAttribute("logincust", cust);

        redirectAttributes.addFlashAttribute("success", "Profil berhasil diperbarui.");
        return "redirect:/info";
    }

}
