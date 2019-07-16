package com.justin.dao;

import com.justin.domain.*;
import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.test.context.*;

@Repository
public class SpringUserDao {
    @Autowired
    private SqlSession sqlSession;

    public String emailcheck(String email){
        return sqlSession.selectOne("user.emailcheck",email);
    }

    public String nicknamecheck(String nickname){
        System.out.println("slrdkd");
        try {
            System.out.println(sqlSession.selectOne("user.nicknamecheck", nickname).toString());
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return sqlSession.selectOne("user.nicknamecheck",nickname);
    }

    public int join(SpringUser springUser){
        return sqlSession.insert("user.join", springUser);
    }

    public SpringUser login(String email){
        return sqlSession.selectOne("user.login",email);
    }

    public int update(SpringUser user){
        return sqlSession.update("user.update",user);
    }

    public int leave(String email){
        return sqlSession.delete("user.leave", email);
    }
}
