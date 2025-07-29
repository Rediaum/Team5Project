package edu.sm.repository;

import edu.sm.dto.Address;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AddressRepository extends ProjectRepository<Address, Integer> {

    /**
     * 특정 고객의 모든 배송지 조회
     * @param custId 고객 ID
     * @return 해당 고객의 배송지 목록 (기본 배송지가 먼저 오도록 정렬)
     */
    List<Address> selectByCustomerId(Integer custId) throws Exception;

    /**
     * 특정 고객의 기본 배송지 조회
     * @param custId 고객 ID
     * @return 기본 배송지 (없으면 null)
     */
    Address selectDefaultByCustomerId(Integer custId) throws Exception;

    /**
     * 특정 고객의 모든 배송지를 기본 배송지가 아닌 상태로 변경
     * @param custId 고객 ID
     */
    void resetDefaultByCustomerId(Integer custId) throws Exception;

    /**
     * 특정 고객의 배송지 개수 조회
     * @param custId 고객 ID
     * @return 배송지 개수
     */
    int countByCustomerId(Integer custId) throws Exception;
}
