<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-06-04
  Time: 16:12
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
                <li role="presentation"><a href="../">메인</a></li>
                <li role="presentation" class="active"><a href="../list">목록보기 </a></li>
                <li role="presentation"><a href="../register">게시물 쓰기 </a></li>
                <c:if test="${user == null}">
                    <li role="presentation"><a href="../join">회원가입</a></li>
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

    <section class="center">
        <div class="box box-primary">
            <div class="box-header">
                <h3 class="box-title">게시물 수정</h3>
            </div>
            <form role="form" id="updateForm" action="../../detail/update" method="post">
                <input type="hidden" name="bno" value="${vo.bno}" />
                <div class="box-body">
                    <div class="form-group">
                        <label>제목</label> <input type="text" name="title" class="form-control" value="${vo.title}" />
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea name="content" class="form-control" placeholder="내용 입력" rows="5">${vo.content}</textarea>
                    </div>
                    <div class="form-group">
                        <label>작성자</label> <input type="text" class="form-control" value="${vo.nickname}" readonly="readonly" />
                    </div>
                </div>
            </form>
            <div class="box-footer">
                <button class="btn btn-success" id="updatebtn">수정완료</button>
                <button class="btn btn-warning" id="mainbtn"></button>
                <button class="btn btn-primary" id="listbtn">목록보기</button>
            </div>
        </div>
    </section>
<%@include file="footer.jsp"%>
    <script>
        //메인 버튼을 눌렀을 때 처리
        document.getElementById("mainbtn").addEventListener("click", function() {
                location.href = "../../";
            });
        //목록 버튼을 눌렀을 때 처리
        document.getElementById("listbtn").addEventListener("click", function() {
                location.href = "../../list";
            });
        //수정 완료 버튼을 눌렀을 때 처리
        document.getElementById("updatebtn").addEventListener("click", function() {
                document.getElementById("updateForm").submit();
            });
    </script>
