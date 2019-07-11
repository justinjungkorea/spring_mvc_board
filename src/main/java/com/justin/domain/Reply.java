package com.justin.domain;

import lombok.*;

@Data
public class Reply {
    private int rno;
    private int bno;
    private String replytext;
    private String email;
    private String nickname;
    private String regdate;
    private String dateDisp;
}
