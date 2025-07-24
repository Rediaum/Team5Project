package edu.sm.repository;

import edu.sm.dto.Cust;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CustRepository extends ProjectRepository<Cust, String> {
    // email을 Key로 사용하기 위한 String
}
