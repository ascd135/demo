<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="com.hmportfolio.demo.enums.UserFindResult" %>
<%@ page import="com.hmportfolio.demo.vos.UserFindIdVo" %>

<%
    Object userFindIdVoObject = session.getAttribute("UserFindIdVo");
    UserFindIdVo userFindIdVo = null;
    if (userFindIdVoObject instanceof UserFindIdVo) {
        userFindIdVo = (UserFindIdVo) userFindIdVoObject;
    }
    session.setAttribute("UserFindIdVo", null);

    Object userFindResultObject = session.getAttribute("UserFindResult");
    UserFindResult userFindResult = null;
    if (userFindResultObject instanceof UserFindResult) {
        userFindResult = (UserFindResult) userFindResultObject;
    }
    session.setAttribute("UserFindResult", null);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="css/findId.css">
    <script defer src="/js/findId.js"></script>
</head>
<body>
<!-- 헤더 -->
<div id="top" class="width868 login_wrap">
    <header class="r_header bg">
        <div class="r_head">
            <h1 class="r_logo">
                <a href="/main">CCinside</a>
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
                            <a href="/findId" class="p_menu on">아이디 찾기</a>
                        </li>
                        <li>
                            <a href="/findPw" class="p_menu">비밀번호 재설정</a>
                        </li>
                    </ul>
                </section>
                <!-- 하단 메뉴 -->
                <section>
                    <div class="content_box brd">
                        <div class="con inner_box">
<% if (userFindResult != null && userFindResult == UserFindResult.FIND_SUCCESS && userFindIdVo != null) {
%>
                            <h4>입력하신 정보와 일치하는 아이디를 안내해 드립니다.</h4>
                            <div class="bg_box">
                                <div class="form_box">
                                   <p class="userid"><%=userFindIdVo.getSession().getAttribute("userId")%></p>
                                   <button type="button" class="btn_find">
                                       <a href="/main">메인으로</a>
                                   </button>
                                </div>
                            </div>
<% } else {
%>
                            <h4>회원가입 시 입력한 이름과 이메일 정보를 입력해 주시기 바랍니다.</h4>
                            <div class="bg_box">
                                <div class="form_box">
                                    <form id="findId-form" method="post">
                                        <input type="text" class="int" id="name" name="name" title="이름 입력" placeholder="이름">
                                        <input type="email" class="int" id="email" name="email" title="이메일 입력" placeholder="이메일">
                                        <button type="submit" id="id_find" class="btn_find">확인</button>
                                    </form>
                                </div>
                            </div>
 <% }
 %>
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
    if (userFindResult != null) {
        switch (userFindResult) {
            case EMAIL_NOT_FOUND:
                response.getWriter().print("<script>alert(\"일치하는 이메일이 없습니다.\");</script>");
                break;
            case NAME_NOT_FOUND:
                response.getWriter().print("<script>alert(\"일치하는 이름이 없습니다.\");</script>");
                break;
            case FIND_FAIL:
                response.getWriter().print("<script>alert(\"아이디를 찾을수 없습니다.\");</script>");
                break;
        }
    }
%>>
</html>