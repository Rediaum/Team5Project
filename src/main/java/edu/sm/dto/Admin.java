package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Admin {
    private int adminId;
    private String adminEmail;
    private String adminPwd;
    private String adminName;
    private String adminPhone;
    private Timestamp adminRegdate;
    private Timestamp adminUpdate;
}
