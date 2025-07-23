package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Product {
    private int productId;
    private int categoryId;
    private String productName;
    private String description;
    private int productPrice;
    private double discountRate;
    private String productImg;
    private Timestamp productRegdate;
    private Timestamp productUpdate;
}
