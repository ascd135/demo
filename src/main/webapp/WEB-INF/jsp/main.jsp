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
<!-- ?????? -->
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
                    <button type="submit"  class="btn_search">??????</button>
                </div>
            </form>
        </div>
    </div>
</header>
<div class="gnb_bar">
    <nav class="gnb">
        <ul class="gnb_list">
            <li><a href="/board?boardId=ntc&boardPage=1">????????????</a></li>
            <li><a href="/board?boardId=fre&boardPage=1">???????????????</a></li>
        </ul>
    </nav>
</div>

<!-- ?????? -->
<div content="wrap_inner">
<main id="container" class="listwrap clear">
    <div class="main_content">
        <!-- ?????? ????????? -->
        <section class="left_content">
            <article>
                <div class="content-ntc hit-ntc">
                    <!-- ???????????? ?????? -->
                    <header class="ntc-head">
                        <h3 class="ntc-head-tit">
                            ????????????
                        </h3>
                    </header>
                </div>
                <!-- ???????????? ????????? -->
                <table class="gall_list">
                    <thead>
                        <th style="width: 7%">??????</th>
                        <th>??????</th>
                        <th style="width: 20%">?????????</th>
                        <th style="width: 15%">?????????</th>
                        <th style="width: 8%">??????</th>
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
                    <!-- ??????????????? ?????? -->
                    <header class="ntc-head">
                        <h3 class="ntc-head-tit">
                            ??????????????? ?????????
                        </h3>
                    </header>
                </div>
                <!-- ??????????????? ????????? -->
                <table class="gall_list">
                    <thead>
                        <th style="width: 7%">??????</th>
                        <th>??????</th>
                        <th style="width: 20%">?????????</th>
                        <th style="width: 15%">?????????</th>
                        <th style="width: 8%">??????</th>
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
        <!-- ????????? ????????? -->
        <section class="right_content">
            <div id="login" class="login_wrap">

<%  if (userVo == null) {
%>
                <div class="login_inner">
                    <form id="login-form" method="post">
                        <filedset>
                            <div class="login_input">
                                <!-- ????????? -->
                                <div class="input_box">
                                    <label for="userId" id="idLabel" class="lab_login"></label>
                                    <input type="text" id="userId" name="userId" class="input_text" placeholder="?????????" maxlength="12" autofocus value="<%=predefinedEmail%>">
                                </div>
                                <!-- ???????????? -->
                                <div class="input_box">
                                    <label for="userPw" id="pwLabel" class="lab_login"></label>
                                    <input type="password" id="userPw" name="userPw" class="input_text" placeholder="????????????" maxlength="32" value="<%=predefinedPassword%>">
                                </div>
                            </div>
                            <!-- ????????? ?????? -->
                            <div class="login_set">
                                <button type="submit" class="btn_login login">?????????</button>
                            </div>
                        </filedset>
                    </form>

                    <!-- ???????????? , ???????????? ?????? -->
                    <div class="options">
                        <a href="/register" target="_self"><strong>????????????</strong></a>
                        <a href="/findId">?????????</a>
                        <a href="/findPw">???????????? ??????</a>
                    </div>
                </div>
<% } else {
%>
                <div class="user_info">
                    <div class="user_inner">
                        <div class="user_name otp_width">
                            <strong><%=userVo.getNickname()%> ???</strong>
                        </div>
                        <button type="button" class="btn_inout logout" onclick="location.href='/logout'">????????????</button>
                    </div>

                    <div class="user_details">
                        <a href="#">?????? ??? ???</a>
                        <a href="#"><strong>????????????</strong></a>
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
        <a href="#">????????????</a>
        <a href="#">????????????</a>
        <a href="#">????????????????????????</a>
        <a href="#">?????????????????????</a>
        <a href="#">????????????</a>
    </div>
</footer>
<%
    if (userLoginResult != null) {
        if (userLoginResult != UserLoginResult.SUCCESS) {
%>
<script>alert("???????????? ?????? ????????? ?????? ?????????????????????. ?????? ??????????????????.");</script>
<%
        }
    }
%>
</body>
</html>