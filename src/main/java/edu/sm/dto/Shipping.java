package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Shipping {
    private int shippingId;
    private int orderId;
    private String shippingCompany;
    private String trackingNumber;
    private Timestamp shippedDate;
    private Timestamp deliveredDate;
    private Timestamp estimatedDelivery;
    private String deliveryMemo;
    private int shippingFee;
    private Timestamp shippingUpdate;
}
