package com.justin.domain;

import lombok.*;
import java.sql.*;

@Data
public class SpringBoard {
    private int bno;
    private String title;
    private String content;
    private String regdate;
    private String updatedate;
    private int readcnt;
    private String ip;
    private String email;
    private String nickname;
    private String dispdate;
    private int replycnt;
}
