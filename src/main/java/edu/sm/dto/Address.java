package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Address {
    private int addressId;
    private int custId;
    private String addressName;
    private String postalCode;
    private String address;
    private String detailAddress;
    private boolean isDefault;
    private Timestamp addressUpdate;
}
