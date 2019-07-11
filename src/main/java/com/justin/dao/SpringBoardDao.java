package com.justin.dao;

import com.justin.domain.*;
import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import java.util.*;

@Repository
public class SpringBoardDao {
    @Autowired
    private SqlSession sqlSession;

    public void register(SpringBoard vo){
        sqlSession.insert("board.register",vo);
    }

    public List<SpringBoard> list(){
        return sqlSession.selectList("board.list");
    }

    public SpringBoard detail(int bno){
        return sqlSession.selectOne("board.detail", bno);
    }

    public void updateReadcnt(int bno){
        sqlSession.update("board.updateReadcnt",bno);
    }

    public void update(SpringBoard vo){
        sqlSession.update("board.update",vo);
    }

    public void delete(int bno){
        sqlSession.delete("board.delete",bno);
    }

    public int totalCount(SearchCriteria criteria){
        return sqlSession.selectOne("board.totalCount",criteria);
    }

    public List<SpringBoard> list(SearchCriteria criteria){
        return sqlSession.selectList("board.list",criteria);
    }

    public Integer replycnt(int bno){
        return sqlSession.selectOne("board.replycnt", bno);
    }

}
