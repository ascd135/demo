<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="com.hmportfolio.demo.vos.*" %>
<%@ page import="com.hmportfolio.demo.vos.BoardReadResponseVo" %>
<%@ page import="com.hmportfolio.demo.vos.CommentItemVo" %>
<%@ page import="com.hmportfolio.demo.vos.UserVo" %>

<%
    Object userVoObject = session.getAttribute("UserVo");
    UserVo userVo = null;
    if (userVoObject instanceof UserVo) {
        userVo = (UserVo) userVoObject;
    }

    Object boardReadResponseVoObject = request.getAttribute("BoardReadResponseVo");
    BoardReadResponseVo boardReadResponseVo = null;
    if (boardReadResponseVoObject instanceof BoardReadResponseVo) {
        boardReadResponseVo = (BoardReadResponseVo) boardReadResponseVoObject;
    }

%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
    <link rel="stylesheet" type="text/css" href="css/board.css">
    <script defer src="/js/bbs/read.js"></script>
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
                        <button type="submit" class="btn_search">검색</button>
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
        <main id="container" class="clear">
            <section>
                <!-- 헤더 -->
                <header>
                    <div class="page_head clear">
                        <div class="f1 clear">
                            <% if (request.getParameter("boardId").equals("fre")) { %>
                            <h2><a href="/board?boardId=fre&boardPage=1">자유게시판</a></h2>
                            <% } else { %>
                            <h2><a href="/board?boardId=ntc&boardPage=1">공지사항</a></h2>
                            <% } %>
                        </div>
                    </div>
                </header>
                <!-- 본문 -->
                <article>
                    <div class="view-content-wrap">
                        <header>
                            <div class="content-view-head clear">
                                <!-- 제목 -->
                                <h3 class="title">
                                    <span><%= boardReadResponseVo.getTitle() %></span>
                                </h3>
                                <!-- 작성자(닉네임), 날짜, 추천수 -->
                                <div class="content-writer">
                                    <div class="fl">
                                        <span><%= boardReadResponseVo.getWriter() %></span>
                                        <span class="content-written-at"><%= boardReadResponseVo.getWrittenAt() %></span>
                                    </div>
                                </div>
                            </div>
                        </header>
                        <div class="view-contents">
                            <!-- 게시글 -->
                            <div class="inner clear">
                                <div class="writing-view-box">
                                    <%= boardReadResponseVo.getText() %>
                                </div>
                            </div>
                            <!-- 추천(hit) -->
                            <div class="btn-recommend-box clear">
                                <div class="inner fl">
                                    <div class="up-num-box">
                                        <p id="js-hit" class="up-num font-red">0
                                        </p>
                                    </div>
                                    <button id="js-up" type="button" class="btn-recommend-up">
                                        <em><img id="recommend-up" class="up-button" src="images/sp_img.jpg"></em>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 댓글 -->
                    <div class="view-comment">
                        <div class="comment-wrap show">
                            <div class="comment-title">
                                <div class="fl num-box">

                                </div>
                            </div>
                            <!-- 댓글 -->
                            <div class="comment-box">
                                <ul class="comment-list">
                                    <% for (CommentItemVo comment : boardReadResponseVo.getComments()) {%>
                                    <li class="up-content">
                                        <div class="comment-info clear">
                                            <!-- 닉네임 -->
                                            <div class="comment-nick">
                                                <span class="comment-writer">
                                                    <span class="nickname">
                                                        <em><%= comment.getWriter() %></em>
                                                    </span>
                                                </span>
                                            </div>
                                            <!-- 내용 -->
                                            <div class="clear comment-text button-reply-write-all">
                                                <p class="user-text"><%= comment.getText() %>
                                                </p>
                                            </div>
                                            <!-- 날짜 -->
                                            <div class="fr clear">
                                                <span class="date-time"><%=comment.getWrittenAt() %></span>
                                            </div>
                                        </div>
                                    </li>
                                    <% } %>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- 댓글 쓰기 폼 -->
                    <form id="comment-form" method="post">
                        <div class="comment-write-box clear">
                            <div class="comment-text-content">
                                <div class="comment-write">
                                    <textarea id="comment" name="comment" maxlength="400"
                                              placeholder="<%= userVo == null ? "로그인해주세요." : "댓글을 입력해 주세요." %>" <%= userVo == null ? "readonly" : "" %>></textarea>
                                </div>
                                <div class="comment-content-bottom clear">
                                    <div class="fr">
                                        <button type="submit"
                                                class="btn_blue" <%= userVo == null ? "onclick=\"alert('로그인해주세요.'); return false;\"" : "" %>>
                                            등록
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- 수정,삭제,글쓰기 -->
                    <%
                        // 관리자면 글 삭제 가능, 자기가 작성한 글 삭제 가능
                        boolean delete;
                        if (userVo == null) {
                            delete = false;
                        } else {
                            if (userVo.getUserlevel() == 1) {
                                delete = true;
                            } else if (userVo.getUserlevel() < 3 && userVo.getNickname().equals(boardReadResponseVo.getWriter())) {
                                delete = true;
                            } else {
                                delete = false;
                            }
                        }
                    %>
                    <div class="view-bottom-button-box clear">
                        <div class="fl">
                            <button type="button" class="btn_blue"
                                    onclick="location.href='/board?boardId=<%= request.getParameter("boardId")%>&boardPage=<%=request.getParameter("boardPage")%>'">
                                목록
                            </button>
                        </div>
                        <div class="fr">
                            <button type="button" class="btn_grey">수정</button>
                            <form id="delete-form" class="fr" method="post">
                                <input type="hidden" name="_method" value="delete">
                                <input type="submit" class="btn_grey" <%= delete == false ? "onclick=\"alert('삭제할 수 없습니다.'); return false;\"" : "onclick=\"alert('삭제하였습니다.');\"" %> value="삭제">
                            </form>
                        </div>
                    </div>
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
