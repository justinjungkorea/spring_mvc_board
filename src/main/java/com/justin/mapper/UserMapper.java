package com.justin.mapper;

import com.justin.domain.*;
import org.springframework.stereotype.*;

@Repository
public interface UserMapper {
    public String emailcheck(String email);
    public String nicknamecheck(String nickname);
    public int join(SpringUser user);
    public SpringUser login(String email);
    public int update(SpringUser user);
    public int leave(String email);
}
