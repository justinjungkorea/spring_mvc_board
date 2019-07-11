<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-06-05
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html >
<head >
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <title >Spring MVC Board</title >
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" >
</head >
<body class="skin-blue sidebar-mini">
    <div class="wrapper">
        <header class="main-header">
            <div class="page-header">
                <h1>Spring MVC 게시판</h1>
            </div>
        </header>
    </div>
    <aside class="main-sidebar">
        <section class="sidebar">
            <ul class="nav nav-tabs">
                <li role="presentation" class="active"><a href="">메인</a></li>
                <li role="presentation"><a href="list">목록보기 </a></li>
                <li role="presentation"><a href="register">게시물 쓰기 </a></li>
                <c:if test="${user == null}">
                    <li role="presentation"><a href="join">회원가입</a></li>
                </c:if>
                <c:if test="${user != null}">
                    <li role="presentation">
                        <a href="#">
                            <span class="badge badge-light">
                                <img src="${pageContext.request.contextPath}/views/${user.image}" width="20" height="20"/>
                            </span>${user.nickname}님
                        </a>
                    </li>
                </c:if>
            </ul>
        </section>
    </aside>
    <div class="container">
        <div class="row">
            <div class="col-md-4">

            </div>
            <div class="col-md-4">
                <div class="login-box well">
                    <form accept-charset="UTF-8" role="form" method="post" action="leave">
                        <legend>비밀번호 입력</legend>
                        <div style='color: red'>${msg}</div>
                        <div class="form-group">
                            <label for="pw">비밀번호</label>
                            <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요" class="formcontrol" />
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-login-submit btn-block m-t-md" value="비밀번호 확인" />
                        </div>
                        <div class="form-group">
                            <a href="../" class="btn btn-success btn-block m-tmd">메인으로</a>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>

<%@include file="footer.jsp"%>