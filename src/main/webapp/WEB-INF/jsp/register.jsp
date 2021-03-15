<%@ page import="com.hmportfolio.demo.enums.UserRegisterResult" %>
<%@ page import="com.hmportfolio.demo.vos.UserRegisterVo" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%
    Object userRegisterResultObject = session.getAttribute("UserRegisterResult");
    UserRegisterResult userRegisterResult = null;

    if (userRegisterResultObject instanceof UserRegisterResult) {
        userRegisterResult = (UserRegisterResult) userRegisterResultObject;
    }
    session.setAttribute("UserRegisterResult" , null);

    Object userRegisterVoObject = session.getAttribute("UserRegisterVo");
    UserRegisterVo userRegisterVo = null;
    if (userRegisterVoObject instanceof UserRegisterVo) {
        userRegisterVo = (UserRegisterVo) userRegisterVoObject;
    }
    session.setAttribute("UserRegisterVo" , null);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="css/register.css">
</head>
<body>
<header class="r_header bg">
    <div class="r_head">
        <h1 class="r_logo">
            <a href="/main">CCinside</a>
            <a href="/register" >회원가입</a>
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
    <form id="register-form" name="register-form" method="post">
        <div class="content">
            <article>
                <section>
                    <div class="path">
                        <h1>회원정보 입력</h1>
                    </div>
                </section>
                <section>
                    <div class="content_box brd">
                        <div class="con register_box">
                            <fieldset>
                                <!-- 아이디 입력 -->
                                <div class="form_group id">
                                    <div class="form_tit">아이디 입력</div>
                                    <div class="form_txt">
                                        <input type="text" class="int" id="id" name="id" maxlength="12" title="아이디 입력" placeholder="아이디를 입력해 주세요.">
                                    </div>
                                </div>
                                <!-- 비밀번호 입력 -->
                                <div class="form_group pw">
                                    <div class="form_tit">비밀번호 입력</div>
                                    <div class="form_txt">
                                        <input type="password" class="int" id="password" name="password" maxlength="50" title="비밀번호 입력" placeholder="비밀번호를 입력해 주세요.">
                                        <input type="password" class="int" id="password-check" name="password-check" maxlength="50" title="비밀번호 확인 입력" placeholder="비밀번호를 재확인해 주세요.">
                                    </div>
                                </div>
                                <!-- 이름 입력 -->
                                <div class="form_group name">
                                    <div class="form_tit">이름</div>
                                    <div class="form_txt">
                                        <input type="text" class="int" id="name" name="name" maxlength="20" title="이름 입력" placeholder="이름을 입력해 주세요.">
                                    </div>
                                </div>
                                <!-- 닉네임 입력 -->
                                <div class="form_group nickname">
                                    <div class="form_tit">닉네임</div>
                                    <div class="form_txt">
                                        <input type="text" class="int" id="nickname" name="nickname" maxlength="20" title="닉네임 입력" placeholder="닉네임을 입력해 주세요.">
                                    </div>
                                </div>
                                <!-- 전화번호 입력 -->
                                <div class="form_group phone">
                                    <div class="form_tit">휴대폰 번호</div>
                                    <div class="form_txt">
                                        <input type="text" class="int" id="phone" name="phone" maxlength="11" title="휴대폰 번호 입력" placeholder="전화번호를 입력해 주세요.">
                                    </div>
                                </div>
                                <!-- 이메일 입력 -->
                                <div class="form_group email">
                                    <div class="form_tit">이메일 입력</div>
                                    <div class="form_txt">
                                        <input type="email" class="int" id="email" name="email" maxlength="50" title="이메일 입력" placeholder="이메일을 입력해 주세요.">
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    <div class="btn_box clear">
                        <div class="fr">
                            <button type="submit" class="btn_grey small btn_next">가입</button>
                        </div>
                    </div>
                </section>
            </article>
        </div>
    </form>
</main>
<%
    if (userRegisterResult != null) {
        switch (userRegisterResult) {
            case SUCCESS :
                response.getWriter().print("<script>alert(\"회원가입이 완료되었습니다.\");</script>");
                response.getWriter().print("<script>window.location.href=\"main\";</script>");
                break;
            case EMAIL_DUPLICATE:
                response.getWriter().print("<script>alert(\"이미 사용중인 이메일입니다.\");</script>");
                break;
            case NICKNAME_DUPLICATE:
                response.getWriter().print("<script>alert(\"이미 사용중인 닉네임입니다.\");</script>");
                break;
            case PHONE_DUPLICATE:
                response.getWriter().print("<script>alert(\"이미 등록되어있는 번호입니다.\");</script>");
                break;
            case ID_DUPLICATE:
                response.getWriter().print("<script>alert(\"이미 등록되어있는 아이디입니다.\");</script>");
                break;
            case FAILURE:
                response.getWriter().print("<script>alert(\"알 수 없는 이유로 회원가입에 실패하였습니다. 잠시후 다시 시도해주세요.\");</script>");
                break;
        }
    }
%>

<footer class="foot">
    <div class="info">
        <a href="#">회사소개</a>
        <a href="#">이용약관</a>
        <a href="#">개인정보처리방침</a>
        <a href="#">청소년보호정책</a>
        <a href="#">광고안내</a>
    </div>
</footer>

</body>
</html>