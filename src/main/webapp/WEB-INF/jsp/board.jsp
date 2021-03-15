<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="com.hmportfolio.demo.enums.UserLoginResult" %>
<%@ page import="com.hmportfolio.demo.vos.*" %>
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


    Object boardResponseVoObject = request.getAttribute("BoardResponseVo");
    BoardResponseVo boardResponseVo = null;
    if (boardResponseVoObject instanceof BoardResponseVo)
    {
        boardResponseVo = (BoardResponseVo) boardResponseVoObject;
    }

    Object boardLevelVoObject = session.getAttribute("BoardLevelVo");
    BoardLevelVo boardLevelVo = null;
    if (boardLevelVoObject instanceof BoardLevelVo) {
        boardLevelVo = (BoardLevelVo) boardLevelVoObject;
    }

    Object searchVoObject = request.getAttribute("SearchVo");
    SearchVo searchVo = null;
    if(searchVoObject instanceof SearchVo) {
        searchVo = (SearchVo) searchVoObject;
    }
%>



<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
    <link rel="stylesheet" type="text/css" href="css/board.css">
    <script defer src="/js/board.js"></script>
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
                        <a href="/board?boardId=fre&boardPage=1">게시판</a>
                    </li>
                    <li>
                        <a href="/board?boardId=ntc&boardPage=1">공지사항</a>
                    </li>
                </ul>
            </div>
        </div>
    </header>

    <!-- nav -->
    <div class="gnb_bar">
        <nav class="gnb">
            <ul class="gnb_list">
                <li><a href="/board?boardId=ntc&boardPage=1">공지사항</a></li>
                <li><a href="/board?boardId=fre&boardPage=1">자유게시판</a></li>
            </ul>
        </nav>
    </div>

    <!-- content -->
    <div class="wrap_inner">
        <main id="container" class="listwrap clear">
            <!-- 왼쪽 컨텐츠 (게시판) -->
            <section class="left_content">
                <!-- 게시판 명 -->
                <div class="page_head clear">
                    <div class="f1 clear">
                        <% if (request.getParameter("boardId").equals("fre")) { %>
                        <h2><a href="/board?boardId=fre">자유게시판</a></h2>
                        <% } else { %>
                        <h2><a href="/board?boardId=ntc">공지사항</a></h2>
                        <% } %>
                    </div>
                </div>
                <!-- 게시판 -->
                <div class="gall_listwrap list">
                    <table class="gall_list">
                        <thead>
                            <th style="width: 7%">번호</th>
                            <th>제목</th>
                            <th style="width: 20%">글쓴이</th>
                            <th style="width: 15%">작성일</th>
                        </thead>
                        <tbody>
                            <!-- 게시판 글들 목록 -->
                            <% for(ArticleVo article : boardResponseVo.getArticles()) {
                                if (boardResponseVo.isSearchResult()) {
                            %>
                            <tr>
                                <td class="gall-num"><% out.print(article.getArticleId()); %></td>
                                <td class="gall-title"><a href="/board-read?articleId=<%=article.getArticleId()%>&boardId=<%=searchVo.getBoardid()%>&boardPage=<%=searchVo.getBoardpage()%>&what=<%=searchVo.getWhat()%>&keyword=<%=searchVo.getKeyword()%>"><% out.print(article.getTitle()); %><a/></td>
                                <td class="gall-writer"><% out.print(article.getWriter()); %></td>
                                <td class="gall-date"><% out.print(article.getWrittenAt()); %></td>
                            </tr>
                            <% } else {%>
                            <tr>
                                <td class="gall-num"><% out.print(article.getArticleId()); %></td>
                                <td class="gall-title"><a href="/board-read?articleId=<%=article.getArticleId()%>&boardId=<%=request.getParameter("boardId")%>&boardPage=<%=request.getParameter("boardPage")%>"><% out.print(article.getTitle()); %><a/></td>
                                <td class="gall-writer"><% out.print(article.getWriter()); %></td>
                                <td class="gall-date"><% out.print(article.getWrittenAt()); %></td>
                            </tr>
                            <%      }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <!-- 글쓰기 버튼 -->
                <div class="list_bottom_btnbox">
                    <div class="fr">
                        <% if(userVo == null){ %>
                        <button type="button" class="btn_blue write"  onclick="alert('로그인 하세요');">글쓰기</button>
                        <% } else if(userVo.getUserlevel() > boardLevelVo.getWriteLevel() ) { %>
                        <button type="button" class="btn_blue write"  onclick="alert('해당 게시판에 글쓰기 권한이 없습니다.');">글쓰기</button>
                        <% } else { %>
                        <button type="button" class="btn_blue write"  onclick="location.href='/board-write?boardId=<%= request.getParameter("boardId")%>'">글쓰기</button>
                        <% } %>
                    </div>
                </div>
                <!-- 게시판 페이징 -->
                <div class="list-paging-box">
                    <%
                       String boardId = request.getParameter("boardId");
                       String boardPage = request.getParameter("boardPage") == null ? "1" : request.getParameter("boardPage");

                       if (boardResponseVo.getRequestPage() > 1) {
                           if(boardResponseVo.isSearchResult()) {
                               out.println("<span><a href=\"search?boardId=" + boardId  + "&boardPage=1&what=" + searchVo.getWhat() + "&keyword=" + searchVo.getKeyword() + "\">처음</a></span>");
                           } else {
                               out.println("<span><a href=\"board?boardId=" + boardId + "&boardPage=1\">처음</a></span>");
                           }

                       }

                       for (int i = boardResponseVo.getStartPage(); i <= boardResponseVo.getEndPage(); i++) {
                           if (i == boardResponseVo.getRequestPage()){
                               out.println("<em><strong>" + i + "</strong></em>");
                           } else {

                              if(boardResponseVo.isSearchResult()) {
                                  out.println("<span><a href=\"search?boardId=" + boardId + "&boardPage=" + i + "&what=" + searchVo.getWhat() + "&keyword=" + searchVo.getKeyword() + "\">" + i + "</a></span>");
                              } else {
                                  out.println("<span><a href=\"board?boardId=" + boardId + "&boardPage=" + i + "\">" + i + "</a></span>");
                              }
                           }
                       }

                       if (boardResponseVo.getMaxPage() > boardResponseVo.getRequestPage()) {
                           if(boardResponseVo.isSearchResult()) {
                               out.println("<span><a href=\"board?boardId=" + boardId + "&boardPage=" + boardResponseVo.getMaxPage() + "&what=" + searchVo.getWhat() + "&keyword=" + searchVo.getKeyword() +"\">끝</a></span>");
                           } else {
                               out.println("<span><a href=\"board?boardId=" + boardId + "&boardPage=" + boardResponseVo.getMaxPage() + "\">끝</a></span>");
                           }
                       }
                    %>
                </div>

                <!-- 게시판 검색 -->
                <form id="bottom-search-form" action="/search" method="get">
                    <fieldset>
                        <input type="hidden" name="boardId" value="<%= request.getParameter("boardId")%>">
                        <div class="bottom-search-wrap clear">
                            <div class="select-box bottom-array fl">
                                <select class="select-wrap" name="what">
                                    <option value="title">제목</option>
                                    <option value="title-content">제목+내용</option>
                                    <option value="nickname">작성자</option>
                                </select>
                            </div>
                            <div class="bottom-search fl clear">
                                <div class="inner_search">
                                    <input class="in_keyword" type="text" name="keyword" maxlength="50" placeholder="검색" autofocus>
                                </div>
                                <input class="btn_search" type="submit" value="검색">
                            </div>
                        </div>
                    </fieldset>
                </form>

            </section>
            <!-- 오른쪽 컨텐츠 (로그인 유무확인) -->
            <section class="right_content ">
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
</div>
</body>
</html>