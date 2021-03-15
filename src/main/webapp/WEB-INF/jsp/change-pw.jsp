<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="com.hmportfolio.demo.enums.UserFindResult" %>
<%
    Object newPasswordResultObject = session.getAttribute("NewPasswordResult");
    UserFindResult newPasswordResult = null;
    if (newPasswordResultObject instanceof UserFindResult) {
        newPasswordResult = (UserFindResult) newPasswordResultObject;
    }
    session.setAttribute("NewPasswordResult", null);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 비밀번호 입력</title>
    <link rel="stylesheet" href="css/findId.css">
</head>
<body>

<div id="top" class="width868 login_wrap">
    <!-- 헤더 -->
    <header class="r_header bg">
        <div class="r_head">
            <h1 class="r_logo">
                <a href="/main">로고</a>
            </h1>
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

    <main id="container">
        <div class="content">
            <article>
                <!-- 상단 메뉴 -->
                <section>
                    <ul class="page_menu clear">
                        <li>
                            <a href="/findId" class="p_menu ">아이디 찾기</a>
                        </li>
                        <li>
                            <a href="/findPw" class="p_menu on">비밀번호 재설정</a>
                        </li>
                    </ul>
                </section>
                <!-- 하단 메뉴 -->
                <section>
                    <div class="content_box brd">
                        <div class="con inner_box">
                            <h4>새 비밀번호를 입력해 주시기 바랍니다.</h4>
                            <div class="bg_box">
                                <div class="form_box">
                                    <form id="password-reset-form" method="post">
                                        <input type="password" class="int" id="npw" name="npw" title="새 비밀번호 입력" placeholder="새 비밀번호">
                                        <button type="submit" id="id_find" class="btn_find">확인</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </article>
        </div>
    </main>

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

<%
    if (newPasswordResult != null) {
        switch (newPasswordResult) {
            case CHANGE_SUCCESS:
                response.getWriter().print("<script>alert(\"비밀번호를 변경하였습니다. 다시 로그인 해주세요.\");</script>");
                response.getWriter().print("<script>window.location.href=\"main\";</script>");
                break;
            case CHANGE_FAIL:
                response.getWriter().print("<script>alert(\"비밀번호 변경에 실패하였습니다.\");</script>");
                break;
        }
    }
%>
</body>
</html>