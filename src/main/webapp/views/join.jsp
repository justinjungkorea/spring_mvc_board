<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-05-31
  Time: 11:51
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
            <li role="presentation"><a href="register">게시물 쓰기 </a></li>
            <c:if test="${user == null}">
                <li role="presentation" class="active"><a href="join">회원가입</a></li>
            </c:if>
            <c:if test="${user != null}">
                <li role="presentation" class="active">
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
<section class="content">
    <!-- 회원가입 -->
    <form id="registerform" enctype="multipart/form-data" method="post" action="#">
        <p align="center">
            <table border="1" width="50%" height="80%" align='center'>
                <tr>
                    <td colspan="3" align="center"><h2>회원 가입</h2></td>
                </tr>
                <tr>
                    <td rowspan="5" align="center" style="padding-top: 5px; padding-bottom: 5px">
                    <img id="img" width="200px" height="200px" border="1" />
                        <br /><br />
                        <input type='file' id="image" name="image" accept=".jpg,.jpeg,.gif,.png" />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#f5f5f5"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;이메일</font></td>
                    <td>&nbsp;&nbsp;&nbsp;
                        <input type="email" name="email" id="email" size="30" maxlength=50 required="required"/>
                        <div id="emailDiv"></div>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#f5f5f5"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;비밀번호</font></td>
                    <td>&nbsp;&nbsp;&nbsp;
                        <input type="password" name="pw" id="pw" size="20" required="required" />
                        <div id="pwDiv"></div>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#f5f5f5"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;비밀번호확인</font></td>
                    <td>&nbsp;&nbsp;&nbsp; <input type="password" id="pwconfirm" size="20" required="required" />
                    </td>
                </tr>
                <tr>
                    <td width="17%" bgcolor="#f5f5f5"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;닉네임</font></td>
                    <td>&nbsp;&nbsp;&nbsp;
                        <input type="text" name="nickname" id="nickname" size="20"
                               pattern="([a-z, A-Z, 가-힣]){2,}" required="required" title="닉네임은 문자 2자 이상입니다." />
                        <div id="nicknameDiv"></div>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3" style="padding-top: 5px; padding-bottom: 5px">
                        <input type="submit" value="회원가입" class="btn btn-warning"/>
                        <input type="button" value="메인으로" class="btn btn-success" onclick="window.location='/'">
                    </td>
                </tr>
            </table>
    </form>
    <br /> <br />
</section>
<script>
    var filename = '';
    document.getElementById("image").addEventListener('change', function(e) {
        if (this.files && this.files[0]) {
            filename = this.files[0].name;
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('img').src = e.target.result;
            };
            reader.readAsDataURL(this.files[0]);
        }
    });

    let emailcheck = false;
    document.getElementById("email").addEventListener("focusout",function(){
        var email = document.getElementById("email").value;
        $.ajax({
            url : "emailcheck",
            data : {
                'email' : email
            },
            dataType : "json",
            success : function(data) {
                if (data.result === true) {
                    document.getElementById("emailDiv").innerHTML = "사용 가능한 아이디입니다.";
                    document.getElementById("emailDiv").style.color='blue';
                    emailcheck = true;
                } else {
                    document.getElementById("emailDiv").innerHTML = "사용 불가능한 아이디입니다.";
                    document.getElementById("emailDiv").style.color='red';
                    emailcheck=false
                }
            }
        });
    });


    let nicknamecheck = false;
    document.getElementById("nickname").addEventListener("focusout",function () {
        var nickname = document.getElementById("nickname").value;
        $.ajax({
            url : "nicknamecheck",
            data : {
                'nickname' : nickname
            },
            dataType : "json",
            success : function (data) {
                if(data.result === true){
                    document.getElementById("nicknameDiv").innerHTML = "사용 가능한 nickname 입니다.";
                    document.getElementById("nicknameDiv").style.color='blue';
                    nicknamecheck = true;
                } else {
                    document.getElementById("nicknameDiv").innerHTML = "사용 불가능한 nickname입니다.";
                    document.getElementById("nicknameDiv").style.color='red';
                    nicknamecheck = false;
                }
            }
        });
    });

    document.getElementById("registerform").addEventListener("submit",function(e){
        console.log("submit check");
        if(!emailcheck){
            document.getElementById("emailDiv").innerHTML = "이메일 중복검사를 수행하세요!!";
            document.getElementById("emailDiv").style.color='red';
            document.getElementById("email").focus();
            e.preventDefault();
            return;
        }
        if(!nicknamecheck){
            document.getElementById("nicknameDiv").innerHTML = "닉네임 중복검사를 수행하세요!!";
            document.getElementById("nicknameDiv").style.color='red';
            document.getElementById("nickname").focus();
            e.preventDefault();
            return;
        }
        var pw = document.getElementById("pw").value;
        var pwconfirm = document.getElementById("pwconfirm").value;
        if(pw != pwconfirm){
            document.getElementById("pwDiv").innerHTML = "2개의 비밀번호가 다릅니다!!";
            document.getElementById("pwDiv").style.color='red';
            document.getElementById("pw").focus();
            e.preventDefault();
            return;
        }
        var pattern1 = /[0-9]/; // 숫자 var
        pattern2 = /[a-zA-Z]/; // 문자 var
        pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;// 특수문자
        if(!pattern1.test(pw) || !pattern2.test(pw) || !pattern3.test(pw) || pw.length < 8) {
            document.getElementById("pwDiv").innerHTML = "비밀번호는 8자리 이상 문자, 숫자, 특수문자로 구성하여야 합니다.";
            document.getElementById("pw").focus();
            e.preventDefault();
        }
    })
</script>
<%@include file="footer.jsp"%>