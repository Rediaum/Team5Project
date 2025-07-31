package edu.sm.repository;

import edu.sm.dto.Payment;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface PaymentRepository extends ProjectRepository<Payment, Integer> {

    //주문 ID로 결제 정보 조회
    Payment findByOrderId(Integer orderId) throws Exception;

    //거래 ID로 결제 정보 조회
    Payment findByTransactionId(String transactionId) throws Exception;

    //고객의 결제 내역 조회
    List<Payment> findByCustId(Integer custId) throws Exception;
}

