package model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class userDto {
    private int userid;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String birthday;
    private String groupid;
    private String profile;
}
