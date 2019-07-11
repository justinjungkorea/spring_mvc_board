<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-06-04
  Time: 12:35
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
            <li role="presentation"><a href="home">메인</a></li>
            <li role="presentation"><a href="list">목록보기 </a></li>
            <li role="presentation" class="active"><a href="#">게시물 쓰기 </a></li>
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
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">게시글 작성</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">게시글 작성</div>
            <!-- /.panel-heading -->
            <div class="panel-body">

                <form role="form" method="post">
                    <div class="form-group">
                        <label>제목</label> <input class="form-control" name='title'>
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="3" name='content'></textarea>
                    </div>
                    <div class="form-group">
                        <label>작성자</label> <input class="form-control" name='writer'
                                                  value="${user.nickname}" readonly="readonly">
                    </div>
                    <button type="submit" class="btn btn-primary">작성완료</button>
                    <button type="reset" class="btn btn-default">다시작성</button>
                    <input type="button" value="메인으로" class="btn btn-success"
                           onclick="javascript:window.location='..'">
                </form>
            </div>
            <!-- end panel-body -->
        </div>
        <!-- end panel-body -->
    </div>
    <!-- end panel -->
</div>
<%@include file="footer.jsp"%>