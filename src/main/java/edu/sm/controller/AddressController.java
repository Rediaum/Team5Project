package edu.sm.controller;

import edu.sm.dto.Address;
import edu.sm.dto.Cust;
import edu.sm.service.AddressService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/address")
@RequiredArgsConstructor
public class AddressController {

    private final AddressService addressService;

    /**
     * 배송지 관리 페이지 - 사용자의 모든 배송지 조회
     */
    @GetMapping("")
    public String address(Model model, HttpSession session) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        // 해당 사용자의 배송지 목록 조회
        List<Address> addressList = addressService.getAddressByCustomerId(loginUser.getCustId());

        model.addAttribute("addressList", addressList);
        log.info("사용자 {}의 배송지 {}개 조회", loginUser.getCustName(), addressList.size());

        return "address";
    }

    /**
     * 새 배송지 추가
     */
    @PostMapping("/add")
    public String addAddress(@ModelAttribute Address address,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        try {
            // 현재 사용자의 배송지 개수 확인 (최대 10개 제한)
            List<Address> currentAddresses = addressService.getAddressByCustomerId(loginUser.getCustId());
            if (currentAddresses.size() >= 10) {
                redirectAttributes.addFlashAttribute("errorMsg", "최대 10개까지만 배송지를 등록할 수 있습니다.");
                return "redirect:/address";
            }

            // 고객 ID 설정
            address.setCustId(loginUser.getCustId());

            // 기본 배송지로 설정하는 경우, 기존 기본 배송지를 해제
            if (address.isDefault()) {
                addressService.resetDefaultAddress(loginUser.getCustId());
            } else if (currentAddresses.isEmpty()) {
                // 첫 번째 배송지는 자동으로 기본 배송지로 설정
                address.setDefault(true);
            }

            // 배송지 저장
            addressService.register(address);

            redirectAttributes.addFlashAttribute("successMsg", "새 배송지가 추가되었습니다.");
            log.info("사용자 {}가 새 배송지 '{}' 추가", loginUser.getCustName(), address.getAddressName());

        } catch (Exception e) {
            log.error("배송지 추가 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("errorMsg", "배송지 추가에 실패했습니다.");
        }

        return "redirect:/address";
    }

    /**
     * 배송지 수정
     */
    @PostMapping("/update")
    public String updateAddress(@ModelAttribute Address address,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        try {
            // 기존 배송지 정보 조회 (권한 체크)
            Address existingAddress = addressService.get(address.getAddressId());
            if (existingAddress == null || existingAddress.getCustId() != loginUser.getCustId()) {
                redirectAttributes.addFlashAttribute("errorMsg", "수정 권한이 없습니다.");
                return "redirect:/address";
            }

            // 기본 배송지로 설정하는 경우, 기존 기본 배송지를 해제
            if (address.isDefault()) {
                addressService.resetDefaultAddress(loginUser.getCustId());
            }

            // 고객 ID 설정 (보안상 다시 설정)
            address.setCustId(loginUser.getCustId());

            // 배송지 수정
            addressService.modify(address);

            redirectAttributes.addFlashAttribute("successMsg", "배송지가 수정되었습니다.");
            log.info("사용자 {}가 배송지 '{}' 수정", loginUser.getCustName(), address.getAddressName());

        } catch (Exception e) {
            log.error("배송지 수정 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("errorMsg", "배송지 수정에 실패했습니다.");
        }

        return "redirect:/address";
    }

    /**
     * 배송지 삭제
     */
    @GetMapping("/delete/{addressId}")
    public String deleteAddress(@PathVariable Integer addressId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        try {
            // 기존 배송지 정보 조회 (권한 체크)
            Address existingAddress = addressService.get(addressId);
            if (existingAddress == null || existingAddress.getCustId() != loginUser.getCustId()) {
                redirectAttributes.addFlashAttribute("errorMsg", "삭제 권한이 없습니다.");
                return "redirect:/address";
            }

            // 배송지 삭제
            addressService.remove(addressId);

            // 삭제된 배송지가 기본 배송지였다면, 다른 배송지를 기본으로 설정
            if (existingAddress.isDefault()) {
                List<Address> remainingAddresses = addressService.getAddressByCustomerId(loginUser.getCustId());
                if (!remainingAddresses.isEmpty()) {
                    Address firstAddress = remainingAddresses.get(0);
                    firstAddress.setDefault(true);
                    addressService.modify(firstAddress);
                }
            }

            redirectAttributes.addFlashAttribute("successMsg", "배송지가 삭제되었습니다.");
            log.info("사용자 {}가 배송지 '{}' 삭제", loginUser.getCustName(), existingAddress.getAddressName());

        } catch (Exception e) {
            log.error("배송지 삭제 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("errorMsg", "배송지 삭제에 실패했습니다.");
        }

        return "redirect:/address";
    }

    /**
     * 기본 배송지 설정 (AJAX)
     */
    @PostMapping("/setDefault")
    @ResponseBody
    public Map<String, Object> setDefaultAddress(@RequestParam Integer addressId,
                                                 HttpSession session) throws Exception {
        Map<String, Object> result = new HashMap<>();

        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        try {
            // 기존 배송지 정보 조회 (권한 체크)
            Address existingAddress = addressService.get(addressId);
            if (existingAddress == null || existingAddress.getCustId() != loginUser.getCustId()) {
                result.put("success", false);
                result.put("message", "권한이 없습니다.");
                return result;
            }

            // 기존 기본 배송지 해제
            addressService.resetDefaultAddress(loginUser.getCustId());

            // 새로운 기본 배송지 설정
            existingAddress.setDefault(true);
            addressService.modify(existingAddress);

            result.put("success", true);
            result.put("message", "기본 배송지로 설정되었습니다.");
            log.info("사용자 {}가 '{}' 를 기본 배송지로 설정", loginUser.getCustName(), existingAddress.getAddressName());

        } catch (Exception e) {
            log.error("기본 배송지 설정 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", "기본 배송지 설정에 실패했습니다.");
        }

        return result;
    }
}