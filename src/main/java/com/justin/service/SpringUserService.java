package com.justin.service;

import com.justin.domain.*;
import org.springframework.web.multipart.*;

import javax.servlet.http.*;

public interface SpringUserService {
    public String emailcheck(String email);
    public String nicknamecheck(String nickname);
    public int join(MultipartHttpServletRequest request);
    public SpringUser login(HttpServletRequest request);
    public String address(String loc);
    public int update(MultipartHttpServletRequest request);
    public int leave(HttpServletRequest request);
}
