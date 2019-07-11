package com.justin.service;

import com.justin.domain.*;

import javax.servlet.http.*;
import java.util.*;

public interface ReplyService {
    public int register(HttpServletRequest request);
    public List<Reply> list(HttpServletRequest request);
    public void delete(HttpServletRequest request);
    public void update(HttpServletRequest request);
}
