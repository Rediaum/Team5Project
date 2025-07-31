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
import java.util.Objects;

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
    public String address(Model model,
                          HttpSession session,
                          @RequestParam(value = "returnUrl", required = false) String returnUrl) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        // 해당 사용자의 배송지 목록 조회
        List<Address> addressList = addressService.getAddressByCustomerId(loginUser.getCustId());

        model.addAttribute("addressList", addressList);
        model.addAttribute("returnUrl", returnUrl); // JSP에서 사용할 수 있도록 추가
        log.info("사용자 {}의 배송지 {}개 조회, returnUrl: {}", loginUser.getCustName(), addressList.size(), returnUrl);

        return "address";
    }

    /**
     * 새 배송지 추가
     */
    @PostMapping("/add")
    public String addAddress(@ModelAttribute Address address,
                             @RequestParam(value = "returnUrl", required = false) String returnUrl,
                             @RequestParam(value = "isDefault", required = false) String isDefaultParam,
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
                return getRedirectUrl(returnUrl);
            }

            // 고객 ID 설정
            address.setCustId(loginUser.getCustId());

            // 체크박스 값 명시적으로 설정
            boolean isDefaultChecked = "true".equals(isDefaultParam);
            address.setDefault(isDefaultChecked);

            // 디버그 로그 추가
            log.info("새 배송지 추가 요청 - 사용자: {}, isDefaultParam: {}, 최종 기본 배송지 설정: {}",
                    loginUser.getCustName(), isDefaultParam, address.isDefault());

            // 기본 배송지 설정 처리
            if (address.isDefault()) {
                // 기존 기본 배송지를 모두 해제
                log.info("기존 기본 배송지 해제 중...");
                addressService.resetDefaultAddress(loginUser.getCustId());
                log.info("기존 기본 배송지 해제 완료");
            } else if (currentAddresses.isEmpty()) {
                // 첫 번째 배송지는 자동으로 기본 배송지로 설정
                log.info("첫 번째 배송지이므로 자동으로 기본 배송지로 설정");
                address.setDefault(true);
            }

            // 배송지 저장
            log.info("배송지 저장 중... 기본 배송지: {}", address.isDefault());
            addressService.register(address);
            log.info("배송지 저장 완료");

            redirectAttributes.addFlashAttribute("successMsg", "새 배송지가 추가되었습니다.");
            log.info("사용자 {}가 새 배송지 '{}' 추가 (기본: {})",
                    loginUser.getCustName(), address.getAddressName(), address.isDefault());

            // returnUrl에 따라 적절한 페이지로 리다이렉트
            return getRedirectUrl(returnUrl);

        } catch (Exception e) {
            log.error("배송지 추가 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMsg", "배송지 추가에 실패했습니다: " + e.getMessage());
            return getRedirectUrl(returnUrl);
        }
    }

    /**
     * 배송지 수정
     */
    @PostMapping("/update")
    public String updateAddress(@ModelAttribute Address address,
                                @RequestParam(value = "returnUrl", required = false) String returnUrl,
                                @RequestParam(value = "isDefault", required = false) String isDefaultParam,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        try {
            // 배송지 소유자 검증
            Address existingAddress = addressService.get(address.getAddressId());
            if (existingAddress == null || !Objects.equals(existingAddress.getCustId(), loginUser.getCustId())) {
                redirectAttributes.addFlashAttribute("errorMsg", "수정 권한이 없습니다.");
                return getRedirectUrl(returnUrl);
            }

            // 고객 ID 설정
            address.setCustId(loginUser.getCustId());

            // 체크박스 값 명시적으로 설정
            boolean isDefaultChecked = "true".equals(isDefaultParam);
            address.setDefault(isDefaultChecked);

            log.info("배송지 수정 요청 - 사용자: {}, isDefaultParam: {}, 최종 기본 배송지 설정: {}",
                    loginUser.getCustName(), isDefaultParam, address.isDefault());

            // 기본 배송지로 설정하는 경우, 기존 기본 배송지를 해제
            if (address.isDefault()) {
                addressService.resetDefaultAddress(loginUser.getCustId());
            }

            // 배송지 수정
            addressService.modify(address);

            redirectAttributes.addFlashAttribute("successMsg", "배송지가 수정되었습니다.");
            log.info("사용자 {}가 배송지 '{}' 수정 (기본: {})",
                    loginUser.getCustName(), address.getAddressName(), address.isDefault());

            return getRedirectUrl(returnUrl);

        } catch (Exception e) {
            log.error("배송지 수정 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMsg", "배송지 수정에 실패했습니다: " + e.getMessage());
            return getRedirectUrl(returnUrl);
        }
    }

    /**
     * 배송지 삭제 - POST 방식
     */
    @PostMapping("/delete")
    public String deleteAddress(@RequestParam Integer addressId,
                                @RequestParam(value = "returnUrl", required = false) String returnUrl,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) throws Exception {
        // 로그인 체크
        Cust loginUser = (Cust) session.getAttribute("logincust");
        if (loginUser == null) {
            return "redirect:/login";
        }

        try {
            // 배송지 소유자 검증
            Address address = addressService.get(addressId);
            if (address == null || !Objects.equals(address.getCustId(), loginUser.getCustId())) {
                redirectAttributes.addFlashAttribute("errorMsg", "삭제 권한이 없습니다.");
                return getRedirectUrl(returnUrl);
            }

            // 배송지 삭제
            addressService.remove(addressId);

            redirectAttributes.addFlashAttribute("successMsg", "배송지가 삭제되었습니다.");
            log.info("사용자 {}가 배송지 '{}' 삭제", loginUser.getCustName(), address.getAddressName());

            return getRedirectUrl(returnUrl);

        } catch (Exception e) {
            log.error("배송지 삭제 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("errorMsg", "배송지 삭제에 실패했습니다.");
            return getRedirectUrl(returnUrl);
        }
    }

    /**
     * 기존 GET 방식 삭제를 위한 호환성 메서드
     */
    @GetMapping("/delete/{addressId}")
    public String deleteAddressGet(@PathVariable Integer addressId,
                                   @RequestParam(value = "returnUrl", required = false) String returnUrl,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) throws Exception {
        // POST 방식 삭제 메서드를 호출
        return deleteAddress(addressId, returnUrl, session, redirectAttributes);
    }

    /**
     * 기본 배송지 설정 - AJAX 호출용
     */
    @PostMapping("/setDefault")
    @ResponseBody
    public Map<String, Object> setDefaultAddress(@RequestParam Integer addressId,
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 로그인 체크
            Cust loginUser = (Cust) session.getAttribute("logincust");
            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            // 배송지 소유자 검증
            Address address = addressService.get(addressId);
            if (address == null || !Objects.equals(address.getCustId(), loginUser.getCustId())) {
                result.put("success", false);
                result.put("message", "권한이 없습니다.");
                return result;
            }

            // 기존 기본 배송지 해제 후 새로 설정
            addressService.resetDefaultAddress(loginUser.getCustId());
            address.setDefault(true);
            addressService.modify(address);

            result.put("success", true);
            result.put("message", "기본 배송지로 설정되었습니다.");
            log.info("사용자 {}가 배송지 '{}'을 기본으로 설정", loginUser.getCustName(), address.getAddressName());

        } catch (Exception e) {
            log.error("기본 배송지 설정 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", "설정에 실패했습니다.");
        }

        return result;
    }

    /**
     * returnUrl에 따라 적절한 리다이렉트 URL 반환
     */
    private String getRedirectUrl(String returnUrl) {
        if ("order".equals(returnUrl)) {
            return "redirect:/order/from-cart";
        }
        return "redirect:/address"; // 기본값은 배송지 관리 페이지
    }
}