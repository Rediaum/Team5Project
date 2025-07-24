package edu.sm.dto;

import lombok.*;

import java.sql.Timestamp;
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Cust {
    private int custId;
    private String custEmail;
    private String custPwd;
    private String custConfirmPwd;
    private String custName;
    private String custPhone;
    private Timestamp custRegdate;
    private Timestamp custUpdate;
}
