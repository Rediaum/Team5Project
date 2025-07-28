package edu.sm.service;

import edu.sm.dto.Admin;
import edu.sm.dto.Cust;
import edu.sm.dto.Product;
import edu.sm.frame.ProjectService;
import edu.sm.repository.AdminRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminService implements ProjectService<Admin, Integer> {

    private final AdminRepository adminRepository;
    private final CustService custService;
    private final ProductService productService;

    @Override
    public void register(Admin admin) throws Exception {
        // Admin 등록은 DB에서만 수행하므로 실제로는 사용하지 않음
        adminRepository.insert(admin);
    }

    @Override
    public void modify(Admin admin) throws Exception {
        adminRepository.update(admin);
    }

    @Override
    public void remove(Integer adminId) throws Exception {
        adminRepository.delete(adminId);
    }

    @Override
    public Admin get(Integer adminId) throws Exception {
        return adminRepository.select(adminId);
    }

    @Override
    public List<Admin> get() throws Exception {
        return adminRepository.selectAll();
    }

    // ===== 로그인 전용 메소드 =====

    /*
      이메일로 Admin 조회 (로그인용)
      - UNIQUE 제약조건으로 중복 없음 보장
     */
    public Admin getByEmail(String adminEmail) throws Exception {
        return adminRepository.selectByEmail(adminEmail);
    }

    // 고객 관리 기능 (Admin 권한으로 수행)


     //모든 고객 조회 (관리자용)
    public List<Cust> getAllCustomers() throws Exception {
        log.info("관리자 - 모든 고객 조회");
        return custService.get();
    }

    //고객 삭제 (관리자용)
    public void deleteCustomer(Integer custId) throws Exception {
        log.info("관리자 - 고객 삭제: {}", custId);
        custService.remove(custId);
    }

    // 고객 정보 수정 (관리자용)
    public void modifyCustomer(Cust cust) throws Exception {
        log.info("관리자 - 고객 정보 수정: {}", cust.getCustEmail());
        custService.modify(cust);
    }

    // 특정 고객 조회 (관리자용)

    public Cust getCustomer(Integer custId) throws Exception {
        return custService.get(custId);
    }

    // Admin 권한으로 수행


    // 모든 제품 조회 (관리자용)
    public List<Product> getAllProducts() throws Exception {
        log.info("관리자 - 모든 제품 조회");
        return productService.get();
    }

    //제품 삭제 (관리자용)
    public void deleteProduct(Integer productId) throws Exception {
        log.info("관리자 - 제품 삭제: {}", productId);
        productService.remove(productId);
    }


    // 제품 정보 수정 (관리자용)

    public void modifyProduct(Product product) throws Exception {
        log.info("관리자 - 제품 정보 수정: {}", product.getProductName());
        productService.modify(product);
    }

    //제품 등록 (관리자용)

    public void registerProduct(Product product) throws Exception {
        log.info("관리자 - 제품 등록: {}", product.getProductName());
        productService.register(product);
    }

    //특정 제품 조회 (관리자용)

    public Product getProduct(Integer productId) throws Exception {
        return productService.get(productId);
    }
}