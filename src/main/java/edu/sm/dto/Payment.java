package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Payment {
    private int paymentId;
    private int orderId;
    private String paymentMethod;
    private int paymentAmount;
    private Timestamp paymentDate;
    private String transactionId;
}
