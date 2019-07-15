<%--
  Created by IntelliJ IDEA.
  User: dongwookjung
  Date: 2019-06-04
  Time: 12:55
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
            <li role="presentation" class="active"><a href="list">목록보기 </a></li>
            <li role="presentation"><a href="register">게시물 쓰기 </a></li>
            <c:if test="${user == null}">
                <li role="presentation" ><a href="join">회원가입</a></li>
            </c:if>
            <c:if test="${user != null}">
                <li role="presentation" >
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
    <div class="box">
        <div class="box-header with-border">
            <c:if test="${msg != null}">
                <h3 class="box-title" style="text-align: center">게시판 목록보기</h3>
            </c:if>
            <c:if test="${msg == null}">
                <h3 class="box-title">${msg}</h3>
            </c:if>
            <form class="form-inline" style="float:right; vertical-align: middle; margin-bottom: 10px">
                <select id="count" class="form-control" style="width:150px;height:30px;">
                    <option value="5" <c:out value="${map.pageMaker.criteria.perPageNum==5?'selected':'' }"/> >
                        5개씩 보기
                    </option>
                    <option value="10" <c:out value="${map.pageMaker.criteria.perPageNum==10?'selected':'' }"/>>
                        10개씩 보기
                    </option>
                    <option value="15" <c:out value="${map.pageMaker.criteria.perPageNum==15?'selected':'' }"/>>
                        15개씩 보기
                    </option>
                    <option value="20" <c:out value="${map.pageMaker.criteria.perPageNum==20?'selected':'' }"/>>
                        20개씩 보기
                    </option>
                </select>
            </form>
        </div>
        <div class="box-body">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th width="11%">글번호</th>
                        <th width="46%">제목</th>
                        <th width="16%">작성자</th>
                        <th width="16%">작성일</th>
                        <th width="11%">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="vo" items="${map.list}">
                        <tr>
                            <td align="right">${vo.bno}</td>
                            <td>&nbsp;
                                <a href="detail/${vo.bno}">
                                    ${vo.title}
                                    <c:if test="${vo.replycnt>0}">
                                        <span class="badge bg-blue">${vo.replycnt}</span>
                                    </c:if>
                                    <c:if test="${vo.replycnt>=3 || vo.readcnt>=10}">
                                        <span class="glyphicon glyphicon-thumbs-up" style="color:red"></span>
                                    </c:if>
                                </a >
                            </td>
                            <td>&nbsp;${vo.nickname}</td>
                            <td>&nbsp; ${vo.dispdate}</td>
                            <td align="right">
                                <span class="badge bg-blue">${vo.readcnt}</span>&nbsp;
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="box-footer">
            <div class="text-center">
                <ul class="pagination">
                    <c:if test="${map.pageMaker.totalCount != 0 }">
                        <c:if test="${map.pageMaker.prev}">
                            <li>
                                <a href="list?page=${map.pageMaker.startPage-1}&perPageNum=${map.pageMaker.criteria.perPageNum}&searchType=${map.pageMaker.criteria.searchType}&keyword=${map.pageMaker.criteria.keyword}">이전</a>
                            </li>
                        </c:if>
                        <c:forEach var="idx" begin="${map.pageMaker.startPage}" end="${map.pageMaker.endPage}">
                            <li <c:out value="${map.pageMaker.criteria.page==idx?'class=active':''}"/> >
                                <a href="list?page=${idx}&perPageNum=${map.pageMaker.criteria.perPageNum}&searchType=${map.pageMaker.criteria.searchType}&keyword=${map.pageMaker.criteria.keyword}">${idx}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${map.pageMaker.next}">
                            <li>
                                <a href="list?page=${map.pageMaker.endPage+1}&perPageNum=${map.pageMaker.criteria.perPageNum}&searchType=${map.pageMaker.criteria.searchType}&keyword=${map.pageMaker.criteria.keyword}">다음</a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>
            </div>
            <div class='box-body text-center'>
                <select name="searchType" id="searchType">
                    <option value="t"
                            <c:out value="${criteria.searchType == 't'?'selected':''}"/>>
                        제목만
                    </option>
                    <option value="c"
                            <c:out value="${criteria.searchType == 'c'?'selected':''}"/>>
                        내용만
                    </option>
                    <option value="w"<c:out value="${criteria.searchType == 'w'?'selected':''}"/>>
                        작성자
                    </option>
                    <option value="tc"<c:out value="${criteria.searchType == 'tc'?'selected':''}"/>>
                        제목 또는 내용
                    </option>
                    <option value="cw"<c:out value="${criteria.searchType == 'cw'?'selected':''}"/>>
                        내용 또는 작성자
                    </option>
                </select>
                <input type="text" name='keyword' id="keyword" value='${criteria.keyword}'>
                <button id='searchBtn' class="btn btn-success">검색</button>
            </div>
            <div class="text-center">
                <button id='mainBtn' class="btn-primary">메인으로</button>
            </div>
            <script>
                document.getElementById('mainBtn').addEventListener("click", function(event) {
                    location.href = "home";
                });
                document.getElementById("count").addEventListener("change",function() {
                    var searchType = document.getElementById("searchType").value;
                    var keyword = document.getElementById("keyword").value;
                    location.href = 'list?' + 'page=1&perPageNum=' + this.value + '&searchType='+ searchType + '&keyword=' + keyword;
                });
                document.getElementById("searchBtn").addEventListener("click",function (event) {
                   var x = document.getElementById("searchType").selectedIndex;
                   var y = document.getElementById("searchType").options;
                   var z = document.getElementById("keyword").value;
                   location.href = 'list?' + 'page=1&perPageNum=' + ${map.pageMaker.criteria.perPageNum} + '&searchType='+ y[x].value + '&keyword=' + z;
                });
                
                document.getElementById("keyword").addEventListener("keyup",function (event) {
                    if (event.keyCode === 13){
                        event.preventDefault();
                        document.getElementById("searchBtn").click();
                    }
                })
            </script>
        </div>
    </div>
<%@include file="footer.jsp"%>
