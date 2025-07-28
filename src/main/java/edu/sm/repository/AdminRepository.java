package edu.sm.repository;

import edu.sm.dto.Admin;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AdminRepository extends ProjectRepository<Admin, Integer> {

    /**
     * 이메일로 Admin 조회 (로그인용)
     * - 이메일은 UNIQUE 제약조건으로 중복 불가
     * - Admin과 Cust 이메일 중복 없음
     */
    Admin selectByEmail(String adminEmail) throws Exception;
}