package edu.sm.service;

import edu.sm.dto.Payment;
import edu.sm.frame.ProjectService;
import edu.sm.repository.PaymentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Service
@RequiredArgsConstructor
@Slf4j
public class PaymentService implements ProjectService<Payment, Integer> {

    private final PaymentRepository paymentRepository;

    @Override
    public void register(Payment payment) throws Exception {
        paymentRepository.insert(payment);
    }

    @Override
    public void modify(Payment payment) throws Exception {
        paymentRepository.update(payment);
    }

    @Override
    public void remove(Integer paymentId) throws Exception {
        paymentRepository.delete(paymentId);
    }

    @Override
    public Payment get(Integer paymentId) throws Exception {
        return paymentRepository.select(paymentId);
    }

    @Override
    public List<Payment> get() throws Exception {
        return paymentRepository.selectAll();
    }

    /**
     * 🎯 결제 처리 - 항상 성공!
     */
    public Payment processPayment(Integer orderId, String paymentMethod, Integer paymentAmount) throws Exception {
        log.info("💳 결제 처리 - 주문ID: {}, 방법: {}, 금액: {}원", orderId, paymentMethod, paymentAmount);

        // 🎭 간단한 처리 시뮬레이션 (1초)
        Thread.sleep(1000);

        // ✅ Payment 객체 생성 (항상 성공)
        Payment payment = Payment.builder()
                .orderId(orderId)
                .paymentMethod(paymentMethod)
                .paymentAmount(paymentAmount)
                .paymentDate(new Timestamp(System.currentTimeMillis()))
                .transactionId(generateTransactionId(paymentMethod))
                .build();

        // DB 저장
        register(payment);
        log.info("🎉 결제 완료 - 결제ID: {}, 거래ID: {}", payment.getPaymentId(), payment.getTransactionId());

        return payment;
    }

    /**
     * 주문의 결제 정보 조회
     */
    public Payment getPaymentByOrderId(Integer orderId) throws Exception {
        return paymentRepository.findByOrderId(orderId);
    }

    /**
     * 고객의 결제 내역 조회
     */
    public List<Payment> getPaymentsByCustId(Integer custId) throws Exception {
        return paymentRepository.findByCustId(custId);
    }

    /**
     * 결제 취소 - 항상 성공!
     */
    public void cancelPayment(Integer paymentId) throws Exception {
        log.info("🔄 결제 취소 - 결제ID: {}", paymentId);
        remove(paymentId);
        log.info("✅ 취소 완료");
    }

    /**
     * 거래 ID 생성
     */
    private String generateTransactionId(String paymentMethod) {
        String dateString = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String randomNumber = String.format("%08d", ThreadLocalRandom.current().nextInt(99999999));

        // 결제 방법별 접두사
        String prefix = getPaymentPrefix(paymentMethod);

        return String.format("%s_%s_%s", prefix, dateString, randomNumber);
    }

    /**
     * 결제 방법별 접두사
     */
    private String getPaymentPrefix(String paymentMethod) {
        switch (paymentMethod) {
            case "creditCard": return "CC";
            case "bankTransfer": return "BT";
            case "kakaoPay": return "KP";
            case "naverPay": return "NP";
            default: return "PAY";
        }
    }
}