<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-06-04
  Time: 15:40
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
    <section class="content">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">상세보기</h3>
            </div>
            <div class="box-body">
                <div class="form-group">
                    <label>제목</label>
                    <input type="text" name="title" class="form-control" value="${vo.title}" readonly="readonly" />
                </div>
                <div class="form-group">
                    <label>내용</label>
                    <textarea name="content" rows="5" readonly="readonly" class="form-control">${vo.content}</textarea>
                </div>
                <div class="form-group">
                    <label>작성자</label>
                    <input type="text" class="form-control" value="${vo.nickname}" readonly="readonly" />
                </div>
            </div>

            <div class="box-footer">
                <button class="btn btn-success" id="mainbtn">메인</button>
                <c:if test = "${user.email == vo.email}">
                    <button class="btn btn-warning" id="updatebtn">수정</button>
                    <button class="btn btn-danger" id="deletebtn">삭제</button>
                </c:if>
                <button class="btn btn-primary" id="listbtn">목록</button>
                <button class="btn btn-info" id="replyadd">댓글작성</button>
                <div class="box-body" style="display: none;" id="replyform" title="댓글작성">
                    <label for="nickname">작성자</label>
                    <input class="form-control" type="text" id="nickname" value="${user.nickname}" readonly="readonly">
                    <label for="replytext">댓글 내용</label>
                    <input class="form-control" type="text" placeholder="댓글을 입력하세요" id="replytext">
                </div>
                <c:if test="${vo.replycnt > 0 }">
                    <button class="btn btn-default" id="replylist">댓글읽기</button>
                </c:if>
                <div id="replydisp" style="padding-left: 20px; padding-top: 20px">

                </div>
            </div>
        </div>
    </section>
    <c:if test = "${user.email == vo.email}">

    <div id="dialog-confirm" title="삭제?" style="display: none;">
        <p>정말로 삭제하시겠습니까?</p>
    </div>
    </c:if>
<%@include file="footer.jsp"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    document.getElementById("mainbtn").addEventListener('click',function () {
        location.href="../home";
    });
    document.getElementById("listbtn").addEventListener('click',function () {
        location.href="../list?page=${criteria.page}&perPageNum=${criteria.perPageNum}&searchType=${criteria.searchType}&keyword=${criteria.keyword}";
    });
    <c:if test = "${user.email == vo.email}">
        document.getElementById('deletebtn').addEventListener('click',function () {
            $("#dialog-confirm").dialog({
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "삭제": function() {
                        $(this).dialog("close");
                        location.href="delete/${vo.bno}";
                    },
                    "취소": function() {
                        $(this).dialog("close");
                    }
                }
            });
        });
        document.getElementById('updatebtn').addEventListener('click',function () {
            location.href = "update/${bno}";
        });
    </c:if>

    document.getElementById("replyadd").addEventListener('click',function () {
        $('#replyform').dialog({
            resizable: false,
            height: 'auto',
            width: 400,
            modal: true,
            buttons:{
                "저장":function () {
                    $(this).dialog("close");
                    var replyText = document.getElementById("replytext").value;
                    $.ajax({
                        url:"replyregister",
                        data:{
                            "bno":'${vo.bno}',
                            "email":'${user.email}',
                            "nickname":'${user.nickname}',
                            "replytext": replyText
                        },
                        dataType:"json",
                        success:function (data) {
                            if(data.result){
                                alert("댓글이 입력되었습니다.");
                                getReply();
                            } else{
                                alert("댓글 입력이 실패 하였습니다.")
                            }
                        }
                    });
                },
                "취소":function () {
                    $(this).dialog("close");
                }
            }
        });
    });

    email = '${user.email}';
    <c:if test="${vo.replycnt > 0 }">
        document.getElementById("replylist").addEventListener("click", function(){
            getReply();
        });
    </c:if>
    function getReply() {
        $.ajax({
            url : 'replylist',
            data : {
                bno : '${vo.bno}'
            },
            dataType : 'json',
            success : function(data) {
                display(data);
            }
        });
    }

    function display(data) {
        var disp = '';
        $(data).each(function(idx, item) {
            disp += "<div style='width:80%; height:50px;'><label>";
            disp += item.nickname + ":" + item.replytext;
            disp += "</label>";
            if(email == item.email){
                disp += "<button type='submit' class='btn btn-danger' id='del";
                disp += item.rno + "' style='float:right; margin-right:5px;margin-left:5px;' onclick='del(this)'>댓글삭제</button>";
                disp += "<button type='submit' class='btn btn-warning' id='mod";
                disp += item.rno + "' style='float:right; margin-right:5px;margin-left:5px;' onclick='mod(this)'>댓글수정</button>";
            }
            disp += "</div>";
        });
        document.getElementById('replydisp').innerHTML = disp;
    }

    function del(btn) {
        var id = btn.id;
        var rno = id.substr(3);
        $("#dialog-confirm").dialog({
            resizable : false,
            height : "auto",
            width : 400,
            modal : true,
            buttons : {
                "삭제" : function() {
                    $(this).dialog("close");
                    $.ajax({
                        url : "replydelete",
                        data : {
                            'rno' : rno
                        },
                        success : function () {
                            getReply();
                        }
                    });

                },
                "취소" : function() {
                    $(this).dialog("close");
                }
            }
        });
    }

    function mod(btn){
        var id = btn.id;
        rno = id.substr(3);
        $("#replyform").dialog({
            resizable : false,
            height : "auto",
            width : 400,
            modal : true,
            buttons : {
                "수정" : function() {
                    replytext =
                        document.getElementById('replytext').value;
                    $.ajax({
                        url:'../reply/update',
                        data:{'rno': rno,
                            'replytext': replytext},
                    });
                    $(this).dialog("close");
                    getReply();
                },
                "취소" : function() {
                    $(this).dialog("close");
                }
            }
        });
    }


</script>
