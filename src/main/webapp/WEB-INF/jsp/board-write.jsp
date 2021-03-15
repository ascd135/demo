<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="com.hmportfolio.demo.enums.UserLoginResult" %>
<%@ page import="com.hmportfolio.demo.vos.UserVo" %>
<%@ page import="com.hmportfolio.demo.vos.UserLoginVo" %>
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

%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <link rel="stylesheet" type="text/css" href="css/board.css">
    <script defer src="https://cdn.ckeditor.com/ckeditor5/23.1.0/classic/ckeditor.js"></script>
    <script defer src="js/bbs/bbs.js"></script>
</head>
<body>
<div class="width1160 list_wrap">
    <!-- 헤더 -->
    <header class="r_header">
        <div class="r_head">
            <!-- 로고 -->
            <h1 class="r_logo">
                <a href="/main"><img src="images/ccinsidelogo.png" style="width: 25%; height: 25%;"></a>
            </h1>
            <div class="r_search">
                <form id="search-form" method="get">
                    <div class="top_search">
                        <div class="inner_search">
                            <input type="text" name="keyword" class="in_keyword">
                        </div>
                        <button type="submit"  class="btn_search">검색</button>
                    </div>
                </form>
            </div>
            <div class="area_links">
                <ul>
                    <li>
                        <a href="/board?boardId=fre">게시판</a>
                    </li>
                    <li>
                        <a href="/board?boardId=ntc">공지사항</a>
                    </li>
                </ul>
            </div>
        </div>
    </header>

    <!-- nav -->
    <div class="gnb_bar">
        <nav class="gnb">
            <ul class="gnb_list">
                <li><a href="/board?boardId=ntc">공지사항</a></li>
                <li><a href="/board?boardId=fre">자유게시판</a></li>
            </ul>
        </nav>
    </div>

    <!-- content -->
    <div class="width1160">
        <main id="container">
            <!-- (글쓰기) -->
            <section>
                <header>
                    <div class="page_head clear">
                        <% if (request.getParameter("boardId").equals("ntc")) { %>
                        <h2><a href="/board-write?boardId=<%= request.getParameter("boardId")%>">공지사항</a></h2>
                        <% } else { %>
                        <h2><a href="/board-write?boardId=<%= request.getParameter("boardId")%>">자유게시판</a></h2>
                        <% } %>
                    </div>
                </header>
                <article id="write_wrap" class="clear">
                    <form id="write-form" method="post">
                        <!-- 제목 -->
                        <div class="clear">
                            <div class="input_box input_write_tit">
                                <input type="text" id="title" name="title" maxlength="40" class="put_inquiry f_blank" placeholder="제목을 입력해 주세요.">
                            </div>
                        </div>
                        <!-- 게시판 -->
                        <div class="editor_wrap">
                            <textarea name="content" maxlength="10000" placeholder="내용을 입력해 주세요"></textarea>
                        </div>
                        <!-- 버튼 -->
                        <div class="btn_box write fr">
                            <button type="button" class="btn_grey cancle" onclick="location.href='/board?boardId=<%= request.getParameter("boardId")%>'">취소</button>
                            <button type="submit" class="btn_submit_blue btn_svc write">등록</button>
                        </div>
                    </form>
                </article>
            </section>
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
</div>

</body>
</html>