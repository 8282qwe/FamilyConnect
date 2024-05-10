package model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class calendarDto {
    private int scheduledid;
    private String title;
    private String description;
    private String startdt;
    private String enddt;
    private int userid;
    private int groupid;
}
