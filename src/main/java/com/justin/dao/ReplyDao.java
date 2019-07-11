package com.justin.dao;

import com.justin.domain.*;
import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import java.util.*;

@Repository
public class ReplyDao {
    @Autowired
    private SqlSession sqlSession;

    public int register(Reply reply){
        return sqlSession.insert("reply.register",reply);
    }

    public List<Reply> list(int bno){
        return sqlSession.selectList("reply.list",bno);
    }

    public void delete(int rno){
        sqlSession.delete("reply.delete", rno);
    }

    public void update(Reply reply){
        sqlSession.update("reply.update", reply);
    }

}
