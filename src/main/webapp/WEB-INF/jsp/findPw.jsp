<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="com.hmportfolio.demo.enums.UserFindResult" %>
<%
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
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="css/findId.css">
    <script defer src="/js/findPw.js"></script>
</head>
<body>

<div id="top" class="width868 login_wrap">
    <!-- 헤더 -->
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
                            <h4>회원가입 시 입력한 이메일, 아이디, 이름을 입력해 주시기 바랍니다.</h4>
                            <div class="bg_box">
                                <div class="form_box">
                                    <form id="findPw-form" method="post">
                                        <input type="text" class="int" id="id" name="id" title="아이디 입력" placeholder="아이디">
                                        <input type="text" class="int" id="name" name="name" title="이름 입력" placeholder="이름">
                                        <input type="email" class="int" id="email" name="email" title="이메일 입력" placeholder="이메일">
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
    if (userFindResult != null) {
        if(userFindResult == UserFindResult.NO_MATCHING_USER){
            response.getWriter().print("<script>alert(\"일치하는 유저를 찾을수 없습니다.\");</script>");
        }
    }
%>>
</body>
</html>