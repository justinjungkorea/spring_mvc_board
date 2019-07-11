<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-05-23
  Time: 14:22
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
<section class="content" style="padding-left: 20px; padding-right: 20px">
    <div class="box">
        <div class="box-header with-border">
            <h4 id="addr"></h4>
        </div>
        <c:if test="${user==null}">
            <div class="box-header with-border">
                <a href="login"><h3 class="box-title">로그인</h3></a>
            </div>
        </c:if>
        <c:if test="${user!=null }">
            <div class="box-header with-border">
                <a href="logout"><h3 class="box-title">로그아웃</h3></a>
            </div>
            <div class="box-header with-border">
                <a href="user/update"><h3 class="box-title">회원정보수정</h3></a>
            </div>
            <div class="box-header with-border">
                <a href="user/leave"><h3 class="box-title">회원탈퇴</h3></a>
            </div>
        </c:if>
    </div>

</section>

<%@include file="footer.jsp"%>

<c:if test="${insert != null }">
    <script>
        $(function() {
            $("#dialog-confirm" ).dialog({
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "닫기": function() {
                        $( this ).dialog( "close" );
                    },
                }
            });
        } );
    </script>
</c:if>
<div id="dialog-confirm" title="회원가입" style="display:none">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>
        회원가입에 성공하셨습니다.이제 로그인하고 사용하시면 됩니다.</p>
</div>

<script>
    setInterval(function () {
        navigator.geolocation.getCurrentPosition(function (position) {
            var loc = position.coords.latitude + ":" + position.coords.longitude;
            $.ajax({
                url:"address",
                data:{"loc":loc},
                dataType:"json",
                success:function (data) {
                    document.getElementById('addr').innerHTML = "현재위치 : " + data.address;
                }
            })
        })
    })
</script>

<c:if test="${update != null }">
    <script>
        $(function() {
            $("#dialog-update").dialog({
                resizable : false,
                height : "auto",
                width : 400,
                modal : true,
                buttons : {
                    "닫기" : function() {
                        $(this).dialog("close");
                    },
                }
            });
        });
    </script>
</c:if>
<div id="dialog-update" title="회원정보 수정" style="display: none">
    <p>
        <span class="ui-icon ui-icon-alert"style="float: left; margin: 12px 12px 20px 0;"></span>
        회원정보 수정에 성공하셨습니다.이제 로그인하고 사용하시면 됩니다.
    </p>
</div>

<c:if test="${secession != null }">
    <script>
        $(function() {
            $("#dialog-update").dialog({
                resizable : false,
                height : "auto",
                width : 400,
                modal : true,
                buttons : {
                    "닫기" : function() {
                        $(this).dialog("close");
                    },
                }
            });
        });
    </script>
</c:if>
<div id="dialog-update" title="회원탈퇴" style="display: none">
    <p>
        <span class="ui-icon ui-icon-alert" style="float: left; margin: 12px 12px 20px 0;"></span>
        회원 탈퇴에 성공하셨습니다.
    </p>
</div>