package com.justin.service;

import com.justin.dao.*;
import com.justin.domain.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import javax.servlet.http.*;
import java.util.*;

@Service
public class SpringBoardServiceImpl implements SpringBoardService {

    @Autowired
    private SpringBoardDao boardDao;

    @Override
    public void register(HttpServletRequest request) {

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        SpringUser user = (SpringUser)request.getSession().getAttribute("user");
        String email = user.getEmail();
        if(title.trim().length() == 0){
            title = "제목없음";
        }
        if(content.trim().length() == 0){
            content = "내용없음";
        }

        String ip = request.getRemoteAddr();
        SpringBoard vo = new SpringBoard();
        vo.setTitle(title);
        vo.setContent(content);
        vo.setEmail(email);
        vo.setIp(ip);
        boardDao.register(vo);
    }

    @Override
    public List<SpringBoard> list() {
        List<SpringBoard> list = boardDao.list();
        Calendar calendar = Calendar.getInstance();
        Date today = new Date(calendar.getTimeInMillis());
        for(SpringBoard vo : list){
            System.out.println("in service list : "+vo);
            if(today.toString().equals(vo.getRegdate().substring(0,10))){
                vo.setDispdate(vo.getRegdate().substring(11));
            } else {
                vo.setDispdate(vo.getRegdate().substring(0,10));
            }
        }

        return list;
    }

    @Override
    public SpringBoard detail(int bno) {
        boardDao.updateReadcnt(bno);
        SpringBoard board = boardDao.detail(bno);
        board.setReplycnt(boardDao.replycnt(board.getBno()));
        return board;
    }

    @Override
    public SpringBoard updateView(int bno) {
        return boardDao.detail(bno);
    }

    @Override
    public void update(HttpServletRequest request) {

        int bno = Integer.parseInt(request.getParameter("bno"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        if (title.trim().length() == 0) {
            title = "제목없음";
        }
        if (content.trim().length() == 0) {
            content = "내용없음";
        }
// 필요한 데이터를 생성
        String ip = request.getRemoteAddr();
        SpringBoard vo = new SpringBoard();
        vo.setBno(bno);
        vo.setTitle(title);
        vo.setContent(content);
        vo.setIp(ip);
        boardDao.update(vo);
    }

    @Override
    public void delete(int bno) {
        boardDao.delete(bno);
    }

    @Override
    public Map<String, Object> list(SearchCriteria criteria) {
        Map<String, Object> map = new HashMap<>();
        List<SpringBoard> list = boardDao.list(criteria);
        if(list.size() == 0){
            criteria.setPage(criteria.getPage()-1);
            list = boardDao.list(criteria);
        }
        Calendar calendar = Calendar.getInstance();
        Date today = new Date(calendar.getTimeInMillis());
        for(SpringBoard vo:list){
            if(today.toString().equals(vo.getRegdate().substring(0,10))){
                vo.setDispdate(vo.getRegdate().substring(11));
            } else {
                vo.setDispdate(vo.getRegdate().substring(0,10));
            }
            vo.setReplycnt(boardDao.replycnt(vo.getBno()));
        }

        map.put("list",list);
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(boardDao.totalCount(criteria));
        map.put("pageMaker", pageMaker);

        return map;
    }
}

