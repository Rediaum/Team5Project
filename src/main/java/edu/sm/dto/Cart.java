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
    // 기본 Cart 테이블 필드
    private int cartId;
    private int custId;
    private int productId;
    private int productQt;
    private Timestamp cartRegdate;

    //  JOIN으로 가져오는 Product 정보 필드들 추가
    private String productName;      // 상품명
    private int productPrice;        // 상품 가격 (이것이 누락되어 있었음!)
    private String productImg;       // 상품 이미지
}