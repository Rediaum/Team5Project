package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Cart {
    private int cartId;
    private int custId;
    private int productId;
    private int productQt;
    private Timestamp cartRegdate;
}
