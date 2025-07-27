package edu.sm.repository;

import edu.sm.dto.Cust;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
// Cust의 PK는 cust_id(INT)이므로, 제네릭 타입을 Integer로 수정합니다.
public interface CustRepository extends ProjectRepository<Cust, Integer> {

    // ProjectRepository에 없는, email로 조회하는 특별한 기능
    public Cust selectByEmail(String custEmail) throws Exception;

    /**
     * Admin 테이블에서 이메일 중복 체크 (단순 카운트)
     */
    int checkAdminEmailExists(String email) throws Exception;
}