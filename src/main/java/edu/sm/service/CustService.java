package edu.sm.project.service;

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
     이메일로 회원 정보를 조회합니다. (로그인, 이메일 중복 체크 시 사용)
     @param custEmail 고객 이메일
     @return 고객 정보 객체 (없으면 null)
     */
    public Cust getByEmail(String custEmail) throws Exception {
        return custRepository.selectByEmail(custEmail);
    }
}