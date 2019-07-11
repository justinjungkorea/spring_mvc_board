package com.justin.service;

import com.justin.domain.*;

import javax.servlet.http.*;
import java.util.*;

public interface SpringBoardService {
    public void register(HttpServletRequest request);
    public List<SpringBoard> list();
    public SpringBoard detail(int bno);
    public SpringBoard updateView(int bno);
    public void update(HttpServletRequest request);
    public void delete(int bno);
    public Map<String, Object> list(SearchCriteria criteria);
}
