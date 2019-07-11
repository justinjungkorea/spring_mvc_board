package com.justin.util;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

@Component
@org.springframework.web.bind.annotation.ControllerAdvice("com.justin")
public class ControllerAdvice {

    //예외처리 메소드
    //Exception이 동작하면 호출되는 메소드
    @ExceptionHandler(Exception.class)
    //Controller 처리 방법과 유사
    public ModelAndView errorHandling(Exception ex) {
        ModelAndView mav = new ModelAndView();
        //에러페이지 이름을 설정 - ViewResolver를 적용
        mav.setViewName("/error/error");
        //전달할 데이터 설정
        mav.addObject("exception", ex);
        return mav;
    }
}
