package edu.sm.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class OrderItem {
    private int orderitemId;
    private int orderId;
    private int productId;
    private int quantity;
    private int unitPrice;
}
