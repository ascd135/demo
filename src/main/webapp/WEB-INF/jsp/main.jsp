<%@ page import="com.hmportfolio.demo.enums.UserLoginResult" %>
<%@ page import="com.hmportfolio.demo.vos.UserVo" %>
<%@ page import="com.hmportfolio.demo.vos.UserLoginVo" %>
<%@ page import="com.hmportfolio.demo.vos.BoardMainResponseVo" %>
<%@ page import="com.hmportfolio.demo.vos.ArticleVo" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%
    Object userVoObject = session.getAttribute("UserVo");
    UserVo userVo = null;
    if (userVoObject instanceof UserVo) {
        userVo = (UserVo) userVoObject;
    }

    Object userLoginVoObject = session.getAttribute("UserLoginVo");
    UserLoginVo userLoginVo = null;
    String predefinedEmail = "";
    String predefinedPassword = "";
    if (userLoginVoObject instanceof UserLoginVo) {
        userLoginVo = (UserLoginVo) userLoginVoObject;
    }
    if (userLoginVo != null) {
        predefinedEmail = userLoginVo.getId();
        predefinedPassword = userLoginVo.getPassword();
    }
    session.setAttribute("UserLoginVo", null);

    Object userLoginResultObject = session.getAttribute("UserLoginResult");
    UserLoginResult userLoginResult = null;
    if (userLoginResultObject instanceof UserLoginResult) {
        userLoginResult = (UserLoginResult) userLoginResultObject;
    }
    session.setAttribute("UserLoginResult", null);

    Object boardMainResponseVoObject1 = request.getAttribute("BoardMainResponseVo1");
    BoardMainResponseVo boardMainResponseVo1 = null;
    if (boardMainResponseVoObject1 instanceof BoardMainResponseVo){
        boardMainResponseVo1 = (BoardMainResponseVo) boardMainResponseVoObject1;
    }

    Object boardMainResponseVoObject2 = request.getAttribute("BoardMainResponseVo2");
    BoardMainResponseVo boardMainResponseVo2 = null;
    if (boardMainResponseVoObject2 instanceof BoardMainResponseVo){
        boardMainResponseVo2 = (BoardMainResponseVo) boardMainResponseVoObject2;
    }

%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>main</title>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <script defer src="/js/login.js"></script>
</head>
<body>
<!-- 헤더 -->
<header>
    <div class="head">
        <h1 class="logo">
            <a href="/main"><img src="images/ccinsidelogo.png" style="width: 25%; height: 25%;"></a>
        </h1>
        <div class="search">
            <form id="search-form" method="get">
                <div class="top_search">
                    <div class="inner_search">
                        <input type="text" name="keyword" class="in_keyword">
                    </div>
                    <button type="submit"  class="btn_search">검색</button>
                </div>
            </form>
        </div>
    </div>
</header>
<div class="gnb_bar">
    <nav class="gnb">
        <ul class="gnb_list">
            <li><a href="/board?boardId=ntc&boardPage=1">공지사항</a></li>
            <li><a href="/board?boardId=fre&boardPage=1">자유게시판</a></li>
        </ul>
    </nav>
</div>

<!-- 메인 -->
<div content="wrap_inner">
<main id="container" class="listwrap clear">
    <div class="main_content">
        <!-- 왼쪽 컨텐츠 -->
        <section class="left_content">
            <article>
                <div class="content-ntc hit-ntc">
                    <!-- 공지사항 헤더 -->
                    <header class="ntc-head">
                        <h3 class="ntc-head-tit">
                            공지사항
                        </h3>
                    </header>
                </div>
                <!-- 공지사항 게시판 -->
                <table class="gall_list">
                    <thead>
                        <th style="width: 7%">번호</th>
                        <th>제목</th>
                        <th style="width: 20%">글쓴이</th>
                        <th style="width: 15%">작성일</th>
                        <th style="width: 8%">개념</th>
                    </thead>
                    <tbody>
                    <% for(ArticleVo article : boardMainResponseVo1.getArticles()) {
                    %>
                        <tr>
                            <td class="gall-num"><% out.print(article.getArticleId()); %></td>
                            <td class="gall-title"><a href="/board-read?articleId=<%=article.getArticleId()%>&boardId=ntc"><% out.print(article.getTitle()); %><a/></td>
                            <td class="gall-writer"><% out.print(article.getWriter()); %></td>
                            <td class="gall-date"><% out.print(article.getWrittenAt()); %></td>
                            <td class="gall-hit"><% out.print(article.getHit()); %></td>
                        </tr>
                    <% }
                    %>
                    </tbody>
                </table>


                <div class="content-ntc hit-ntc content-fre">
                    <!-- 자유게시판 헤더 -->
                    <header class="ntc-head">
                        <h3 class="ntc-head-tit">
                            자유게시판 개념글
                        </h3>
                    </header>
                </div>
                <!-- 자유게시판 게시판 -->
                <table class="gall_list">
                    <thead>
                        <th style="width: 7%">번호</th>
                        <th>제목</th>
                        <th style="width: 20%">글쓴이</th>
                        <th style="width: 15%">작성일</th>
                        <th style="width: 8%">개념</th>
                    </thead>
                    <tbody>
                    <% for(ArticleVo article : boardMainResponseVo2.getArticles()) {
                    %>
                        <tr>
                            <td class="gall-num"><% out.print(article.getArticleId()); %></td>
                            <td class="gall-title"><a href="/board-read?articleId=<%=article.getArticleId()%>&boardId=fre"><% out.print(article.getTitle()); %><a/></td>
                            <td class="gall-writer"><% out.print(article.getWriter()); %></td>
                            <td class="gall-date"><% out.print(article.getWrittenAt()); %></td>
                            <td class="gall-hit"><% out.print(article.getHit()); %></td>
                        </tr>
                    <% }
                    %>
                    </tbody>
                </table>
            </article>
        </section>
        <!-- 오른쪽 컨텐츠 -->
        <section class="right_content">
            <div id="login" class="login_wrap">

<%  if (userVo == null) {
%>
                <div class="login_inner">
                    <form id="login-form" method="post">
                        <filedset>
                            <div class="login_input">
                                <!-- 아이디 -->
                                <div class="input_box">
                                    <label for="userId" id="idLabel" class="lab_login"></label>
                                    <input type="text" id="userId" name="userId" class="input_text" placeholder="아이디" maxlength="12" autofocus value="<%=predefinedEmail%>">
                                </div>
                                <!-- 비밀번호 -->
                                <div class="input_box">
                                    <label for="userPw" id="pwLabel" class="lab_login"></label>
                                    <input type="password" id="userPw" name="userPw" class="input_text" placeholder="비밀번호" maxlength="32" value="<%=predefinedPassword%>">
                                </div>
                            </div>
                            <!-- 로그인 버튼 -->
                            <div class="login_set">
                                <button type="submit" class="btn_login login">로그인</button>
                            </div>
                        </filedset>
                    </form>

                    <!-- 회원가입 , 비밀번호 찾기 -->
                    <div class="options">
                        <a href="/register" target="_self"><strong>회원가입</strong></a>
                        <a href="/findId">아이디</a>
                        <a href="/findPw">비밀번호 찾기</a>
                    </div>
                </div>
<% } else {
%>
                <div class="user_info">
                    <div class="user_inner">
                        <div class="user_name otp_width">
                            <strong><%=userVo.getNickname()%> 님</strong>
                        </div>
                        <button type="button" class="btn_inout logout" onclick="location.href='/logout'">로그아웃</button>
                    </div>

                    <div class="user_details">
                        <a href="#">내가 쓴 글</a>
                        <a href="#"><strong>회원정보</strong></a>
                    </div>
                </div>
<% }
%>
            </div>
        </section>
    </div>
</main>
</div>

<!-- footer -->
<footer class="foot">
    <div class="info">
        <a href="#">회사소개</a>
        <a href="#">이용약관</a>
        <a href="#">개인정보처리방침</a>
        <a href="#">청소년보호정책</a>
        <a href="#">광고안내</a>
    </div>
</footer>
<%
    if (userLoginResult != null) {
        if (userLoginResult != UserLoginResult.SUCCESS) {
%>
<script>alert("올바르지 않은 아이디 혹은 비밀번호입니다. 다시 확인해주세요.");</script>
<%
        }
    }
%>
</body>
</html>