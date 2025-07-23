package edu.sm.dto;

import lombok.*;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Category {
    private int categoryId;
    private Integer parentCategoryId;
    private String categoryName;
    private Timestamp categoryUpdate;
}
