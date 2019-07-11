<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-05-31
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!-- 에러 페이지를 만들기 위한 설정 -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="dummy" content="의미없는 메시지" />
        <meta name="dummy" content="의미없는 메시지" />
        <meta name="dummy" content="의미없는 메시지" />
        <meta name="dummy" content="의미없는 메시지" />
        <title>예외 발생</title>
    </head>
    <body>
        <h3>${exception.getMessage()}</h3>
    </body>
</html>