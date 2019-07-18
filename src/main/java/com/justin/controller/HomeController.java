package com.justin.controller;

import com.justin.domain.*;
import com.justin.service.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import javax.servlet.http.*;
import java.lang.*;
import java.lang.String;
import java.util.*;

@Controller
public class HomeController {
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired
    private SpringUserService userService;

    @Autowired
    private SpringBoardService boardService;

    @RequestMapping(value = {"/","home"})
    public String home(){
        return "home";
    }

    @RequestMapping(value = "join",method = RequestMethod.GET)
    public String join(Model model){
        return "join";
    }

    @RequestMapping(value = "join",method = RequestMethod.POST)
    public String joinPost(MultipartHttpServletRequest request, RedirectAttributes redirectAttributes){
        int result = userService.join(request);
        if(result>0){
            redirectAttributes.addFlashAttribute("insert","success");
            return "redirect:/";
        } else {
            return "redirect:join";
        }
    }

    @RequestMapping(value = "login",method = RequestMethod.GET)
    public void login(Model model){}

    @RequestMapping(value = "login",method = RequestMethod.POST)
    public String login(HttpServletRequest request, HttpSession session, Model model, RedirectAttributes attributes){
        SpringUser userVO = userService.login(request);
        if(userVO == null){
            attributes.addFlashAttribute("msg","잘못된 회원정보 입니다.");
            return "redirect:login";
        }
        session.setAttribute("user",userVO);
        Object dest = session.getAttribute("dest");
        if(dest == null){
            return "redirect:/";
        } else {
            return "redirect:/"+dest.toString();
        }
    }

    @RequestMapping(value = "logout",method = RequestMethod.GET)
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping(value = "register",method = RequestMethod.GET)
    public void registerGET(SpringBoard board,  Model model){

    }

    @RequestMapping(value = "register",method = RequestMethod.POST)
    public String registerPOST(HttpServletRequest request, RedirectAttributes attributes){
        boardService.register(request);
        attributes.addFlashAttribute("msg","게시글 작성에 성공하였습니다.");
        return "redirect:list";
    }

    @RequestMapping(value = "detail/{bno}", method = RequestMethod.GET)
    public String detail(@PathVariable("bno") int bno, @ModelAttribute("criteria") SearchCriteria criteria,Model model){
        model.addAttribute("vo",boardService.detail(bno));
        return "detail";
    }

    @RequestMapping(value = "detail/update/{bno}", method = RequestMethod.GET)
    public String update(@PathVariable("bno") int bno, Model model){
        model.addAttribute("vo",boardService.updateView(bno));
        return "update";
    }

    @RequestMapping(value = "detail/update",method = RequestMethod.POST)
    public String update(HttpServletRequest request, RedirectAttributes attributes){
        boardService.update(request);
        attributes.addFlashAttribute("msg","게시글 수정에 성공하였습니다.");
        return "redirect:../list";
    }

    @RequestMapping(value = "detail/delete/{bno}",method = RequestMethod.GET)
    public String delete(@PathVariable("bno") int bno, RedirectAttributes attributes){
        boardService.delete(bno);
        attributes.addFlashAttribute("msg","게시글 삭제에 성공하였습니다.");
        return "redirect:../../list";
    }

    @RequestMapping(value = "user/update", method = RequestMethod.GET)
    public String userUpdate(Model model, HttpSession session){
        if(session.getAttribute("user") == null){
            System.out.println("not logged in");
            return "redirect:../login";
        } else {
            System.out.println("logged in!");
            return "pwcheck";
        }
    }

    @RequestMapping(value = "user/pwcheck", method = RequestMethod.POST)
    public String pwcheck(SpringUser user, HttpSession session, HttpServletRequest request, Model model, RedirectAttributes attributes){
        SpringUser loginuser = (SpringUser)session.getAttribute("user");
        user.setEmail(loginuser.getEmail());
        SpringUser userXO = userService.login(request);
        if(userXO == null){
            attributes.addFlashAttribute("msg", "비밀번호가 잘못되었습니다.");
            return "redirect:update";
        }
        session.setAttribute("user",userXO);
        return "redirect:updateform";
    }

    @RequestMapping(value = "user/updateform", method = RequestMethod.GET)
    public String updateform(){
        return "updateform";
    }

    @RequestMapping(value = "user/updateform", method = RequestMethod.POST)
    public String updatePost(MultipartHttpServletRequest request, RedirectAttributes attributes){
        int result = userService.update(request);
        if(result>0){
            request.getSession().removeAttribute("user");
            attributes.addFlashAttribute("update", "success");
            return "redirect:/";
        } else {
            return "redirect:updateform";
        }
    }

    @RequestMapping(value = "user/leave",method = RequestMethod.GET)
    public String leave(Model model,HttpSession session){
        if(session.getAttribute("user") == null){
            return "redirect:../login";
        } else {
            return "leave";
        }
    }

    @RequestMapping(value = "user/leave", method = RequestMethod.POST)
    public String leave(HttpServletRequest request, Model model, RedirectAttributes attributes){
        int r = userService.leave(request);
        if(r>=0){
            request.getSession().removeAttribute("user");
            attributes.addFlashAttribute("leave","success");
            return "redirect:/";
        } else {
            attributes.addFlashAttribute("msg","비밀번호가 잘못되었습니다.");
            return "redirect:leave";
        }
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(@ModelAttribute("criteria") SearchCriteria criteria, Model model) throws Exception{
        Map<String, Object> map = boardService.list(criteria);
        model.addAttribute("map",map);
        return "list";
    }
}
