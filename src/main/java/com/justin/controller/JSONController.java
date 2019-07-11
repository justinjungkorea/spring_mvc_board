package com.justin.controller;

import com.justin.domain.*;
import com.justin.service.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.*;
import java.util.*;

@RestController
public class JSONController {

    @Autowired
    private SpringUserService userService;

    @Autowired
    private ReplyService replyService;

    @RequestMapping(value = "detail/replyregister", method = RequestMethod.GET)
    public Map<String, Object> register(HttpServletRequest request){
        int result = replyService.register(request);
        Map<String, Object>map = new HashMap<>();

        if(result>0){
            map.put("result", true);
        } else {
            map.put("result", false);
        }

        return map;
    }

    @RequestMapping(value = "detail/replylist", method = RequestMethod.GET)
    public List<Reply> replyList(HttpServletRequest request){
        return replyService.list(request);
    }

    @RequestMapping(value = "detail/replydelete", method = RequestMethod.GET)
    public void delete(HttpServletRequest request){
        replyService.delete(request);
    }

    @RequestMapping(value = "detail/replyupdate", method = RequestMethod.GET)
    public void update(HttpServletRequest request){
        replyService.update(request);
    }

    @RequestMapping(value = "emailcheck", method = RequestMethod.GET)
    public Map<String, Object> emailcheck(String email){
        Map<String, Object> map = new HashMap<>();
        String result = userService.emailcheck(email);
        map.put("result",result == null);
        return map;
    }

    @RequestMapping(value = "nicknamecheck", method = RequestMethod.GET)
    public Map<String,Object> nicknamecheck(String nickname){
        Map<String,Object> map = new HashMap<>();
        String result = userService.nicknamecheck(nickname);
        map.put("result",result == null);
        return map;
    }

    @RequestMapping(value = "address")
    public Map<String, Object> address(@RequestParam("loc") String loc){
        Map<String, Object> map = new HashMap<>();
        map.put("address", userService.address(loc));
        return map;
    }

}
