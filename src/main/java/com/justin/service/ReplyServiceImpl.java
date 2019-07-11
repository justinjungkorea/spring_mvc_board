package com.justin.service;

import com.justin.dao.*;
import com.justin.domain.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import javax.servlet.http.*;
import java.util.*;

@Service
public class ReplyServiceImpl implements ReplyService{
    @Autowired
    private ReplyDao replyDao;

    @Override
    public int register(HttpServletRequest request) {
        //1.파라미터 읽기
        String bno = request.getParameter("bno");
        String email = request.getParameter("email");
        String nickname = request.getParameter("nickname");
        String replytext = request.getParameter("replytext");

        //2.Dao의 파라미터를 만들기
        Reply reply = new Reply();
        reply.setBno(Integer.parseInt(bno));
        reply.setEmail(email);
        reply.setNickname(nickname);
        reply.setReplytext(replytext);

        //3.Dao의 메소드 호출
        int result = replyDao.register(reply);

        return result;
    }

    @Override
    public List<Reply> list(HttpServletRequest request) {
        String bno = request.getParameter("bno");
        List<Reply> list = replyDao.list(Integer.parseInt(bno));
        Calendar cal = Calendar.getInstance();
        Date today = new Date(cal.getTimeInMillis());
        for (Reply vo : list) {
            if (today.toString().equals(vo.getRegdate().substring(0, 10))) {
                vo.setDateDisp(vo.getRegdate().substring(11));
            } else {
                vo.setDateDisp(vo.getRegdate().substring(0, 10));
            }
        }
        return list;
    }

    @Override
    public void delete(HttpServletRequest request) {
        String rno = request.getParameter("rno");
        replyDao.delete(Integer.parseInt(rno));
    }

    @Override
    public void update(HttpServletRequest request) {
        String rno = request.getParameter("rno");
        String replytext = request.getParameter("replytext");
        Reply reply = new Reply();
        reply.setRno(Integer.parseInt(rno));
        reply.setReplytext(replytext);
        replyDao.update(reply);
    }
}
