package edu.sm.service;

import edu.sm.dto.Cust;
import edu.sm.frame.ProjectService;
import edu.sm.repository.CustRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
// import org.springframework.security.crypto.password.PasswordEncoder; // 나중에 비밀번호 암호화를 위해 추가

import java.util.List;

@Service
@RequiredArgsConstructor
public class CustService implements ProjectService<Cust, Integer> { // PK 타입을 Integer로 수정

    final CustRepository custRepository;
    // final PasswordEncoder passwordEncoder; // 나중에 비밀번호 암호화를 위해 추가

    @Override
    public void register(Cust cust) throws Exception {
        // ⚠️ 중요: 실제로는 비밀번호를 암호화해서 저장해야 합니다.
        // String encodedPassword = passwordEncoder.encode(cust.getCustPwd());
        // cust.setCustPwd(encodedPassword);
        custRepository.insert(cust);
    }

    @Override
    public void modify(Cust cust) throws Exception {
        // 비밀번호 변경 시에도 암호화 로직이 필요합니다.
        custRepository.update(cust);
    }

    @Override
    public void remove(Integer custId) throws Exception { // PK인 custId(Integer)를 받습니다.
        custRepository.delete(custId);
    }

    @Override
    public Cust get(Integer custId) throws Exception { // PK인 custId(Integer)를 받습니다.
        return custRepository.select(custId);
    }

    @Override
    public List<Cust> get() throws Exception {
        return custRepository.selectAll();

    }
// --- CustService에만 필요한 로그인/중복체크용 특별 메서드 ---

    /**
     * 이메일로 회원 정보를 조회합니다. (로그인, 이메일 중복 체크 시 사용)
     * @param custEmail 고객 이메일
     * @return 고객 정보 객체 (없으면 null)
     */
    public Cust getByEmail(String custEmail) throws Exception {
        return custRepository.selectByEmail(custEmail);
    }

    // === 회원가입 관련 추가 메서드들 ===

    /**
     * 이메일 중복 체크 - Admin 우선, 그 다음 Cust 확인
     */
    public boolean checkEmailDuplicate(String email) throws Exception {
        // 1. Admin 테이블 확인 (우선순위)
        int adminCount = custRepository.checkAdminEmailExists(email);
        if (adminCount > 0) {
            return true; // Admin이 사용중이면 중복
        }

        // 2. Cust 테이블 확인
        Cust cust = custRepository.selectByEmail(email);
        return cust != null; // Cust가 사용중이어도 중복
    }

    /**
     * 전화번호로 회원 정보를 조회합니다. (로그인, 전화번호 중복 체크 시 사용)
     * @param custPhone 고객 전화번호
     * @return 고객 정보 객체 (없으면 null)
     */
    public Cust getByPhone(String custPhone) throws Exception {
        return custRepository.selectByPhone(custPhone);
    }
    /**
     * 전화번호 중복 체크 - Admin 우선, 그 다음 Cust 확인
     */
    public boolean checkPhoneDuplicate(String phone) throws Exception {
        // 1. Admin 테이블 확인 (우선순위)
        int adminCount = custRepository.checkAdminPhoneExists(phone);
        if (adminCount > 0) {
            return true; // Admin이 사용중이면 중복
        }

        // 2. Cust 테이블 확인
        Cust cust = custRepository.selectByPhone(phone);
        return cust != null; // Cust가 사용중이어도 중복
    }

    /**
     * 회원가입 유효성 검사
     */
    public boolean validateCust(Cust cust) throws Exception {
        // 기본 필드 검사
        if (cust.getCustEmail() == null || cust.getCustEmail().trim().isEmpty() ||
                cust.getCustPwd() == null || cust.getCustPwd().trim().isEmpty() ||
                cust.getCustName() == null || cust.getCustName().trim().isEmpty() ||
                cust.getCustPhone() == null || cust.getCustPhone().trim().isEmpty()) {
            return false;
        }

        // 이메일 중복 검사 (Admin 우선)
        if (checkEmailDuplicate(cust.getCustEmail())) {
            return false;
        }

        if (checkPhoneDuplicate(cust.getCustPhone())) {
            return false;
        }

        return true;
    }
}