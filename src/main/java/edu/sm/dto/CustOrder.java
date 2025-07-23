package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class CustOrder {
    private int orderId;
    private int custId;
    private Timestamp orderDate;
    private int totalAmount;
    private String shippingAddress;
    private String shippingName;
    private String shippingPhone;
}
