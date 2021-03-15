<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="com.hmportfolio.demo.enums.UserFindResult" %>
<%
    Object codeCheckResultObject = session.getAttribute("CodeCheckResult");
    UserFindResult codeCheckResult = null;
    if (codeCheckResultObject instanceof UserFindResult) {
        codeCheckResult = (UserFindResult) codeCheckResultObject;
    }
    session.setAttribute("CodeCheckResult", null);
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>인증번호 입력</title>
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
                            <h4>인증번호를 입력해 주시기 바랍니다.</h4>
                            <div class="bg_box">
                                <div class="form_box">
                                    <form id="code-form" method="post">
                                        <input type="text" class="int" id="code" name="code" title="인증번호 입력" placeholder="인증번호">
                                        <div>인증번호 : <%= session.getAttribute("resetCode").toString() %></div>
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
    if (codeCheckResult != null) {
        if(codeCheckResult == UserFindResult.CODE_FAIL){
            response.getWriter().print("<script>alert(\"코드가 일치하지 않습니다. 다시입력해주세요.\");</script>");
        }
    }
%>>
</body>
</html>