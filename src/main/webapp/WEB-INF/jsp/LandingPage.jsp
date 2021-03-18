<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Minifolio</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/default.css">
    <link rel="stylesheet" href="css/Landing.css">
</head>
<body>

<div class="container">
    <!-- nav -->
    <nav class="top-nav">
        <div class="top-nav-link">
            <a href="#scroll-section-0" class="top-nav-item home-title">Minifolio</a>
            <a href="#scroll-section-0" class="top-nav-item a">Top</a>
            <a href="#scroll-section-1" class="top-nav-item b">About Me</a>
            <a href="#scroll-section-2" class="top-nav-item c">Skills</a>
            <a href="#scroll-section-3" class="top-nav-item d">Project</a>
            <a href="#contact" class="top-nav-item e">Contact</a>
        </div>
    </nav>

    <section class="scroll-section" id="scroll-section-0">
        <div class="video-container">
            <video src="/videos/backgroundvideo.mp4" autoplay loop muted></video>
        </div>
        <h1 id="title-text">개발하고 싶습니다.</h1>
    </section>

    <section class="scroll-section" id="scroll-section-1">
        <div class="about-me">
            About Me
        </div>
        <div class="about-me-form">
            <!-- 왼쪽 -->
            <div class="about-me-text">
                <p class="about-me-text-item">
                    안녕하십니까,
                    <br>
                    저는 웹 개발자가 되고싶은 박현민입니다.
                </p>
                <p class="about-me-text-item">
                    컴퓨터공학과를 다니면서 진로를 고민하던 시기에,
                    <br>
                    점점 발전하는 SNS 와 커뮤니티, 자신의 삶을 공유하는 플랫폼들을 보며
                    <br>
                    웹 기술에 대한 궁금즘과 호기심을 가지고
                    <br>
                    개발자에 대한 꿈을 키웠습니다.
                </p>
                <p class="about-me-text-item">
                    저는 활발한 의사소통을 통해 더 좋은 결과물을 만들어내기 위해 노력합니다.
                    <br>
                    이 과정에서 발생하는 목표를 향한 열정과 의지가 저를 이끌어가는 원동력입니다.
                </p>
                <p class="about-me-text-item">
                    아직 배울 것이 많다고 생각합니다.
                    <br>
                    배움을 게을리 하지 않고 계속해서 발전하는 개발자가 되도록 하겠습니다.
                </p>
            </div>
            <!-- 오른쪽 -->
            <div class="about-me-image">
                <div class="about-me-image-source">
                    <img src="/images/myimage.jpg">
                </div>
                <div class="about-me-image-text">
                    <p>
                        2014.3 영남대학교 컴퓨터공학과 입학
                        <br>
                        2020.11 정보처리기사 취득
                        <br>
                        2021.2 영남대학교 컴퓨터공학과 졸업
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="scroll-section" id="scroll-section-2">
        <div class="skills">
            Skills
        </div>
        <div class="skills-item">
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/html5.png">
                </div>
                <div class="skill-name">
                    HTML5
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/css3.png">
                </div>
                <div class="skill-name">
                    CSS3
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/javascript.png">
                </div>
                <div class="skill-name">
                    JavaScript
                </div>
            </div>
        </div>

        <div class="skills-item">
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/java.png">
                </div>
                <div class="skill-name">
                    Java
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/jsp.png">
                </div>
                <div class="skill-name">
                    JSP
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/spring.png">
                </div>
                <div class="skill-name">
                    Spring
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/springboot.png">
                </div>
                <div class="skill-name">
                    SpringBoot
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/maven.png">
                </div>
                <div class="skill-name">
                    Maven
                </div>
            </div>
        </div>

        <div class="skills-item">
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/mysql.png">
                </div>
                <div class="skill-name">
                    MySQL
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/oracle.png">
                </div>
                <div class="skill-name">
                    Oracle
                </div>
            </div>
        </div>

        <div class="skills-item">
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/ubuntu.png">
                </div>
                <div class="skill-name">
                    Ubuntu
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/centos.png">
                </div>
                <div class="skill-name">
                    CentOS
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/gcp.png">
                </div>
                <div class="skill-name">
                    GCP
                </div>
            </div>
            <div class="skills-item-container skill">
                <div class="icon">
                    <img src="/images/aws.png">
                </div>
                <div class="skill-name">
                    AWS
                </div>
            </div>
        </div>
    </section>

    <section class="scroll-section" id="scroll-section-3">
        <div class="Projects">
            Projects
        </div>
        <div class="project-item">
            <div class="project-item-container">
                <div class="project-item-image">
                    <img src="/images/ccinside.PNG">
                </div>
                <div class="project-item-title">
                    <h1>CCinside</h1>
                </div>
                <div class="project-item-intro">
                    <p>
                        'DCinside' 커뮤니티를 클론 코딩한 사이트입니다. 회원가입과 로그인, 게시판 기능을 구현하였습니다.
                    </p>
                </div>
                <div class="project-item-date">
                    <p>
                        2020.12
                    </p>
                </div>
                <div class="project-item-button">
                    <div class="github">
                        <a href="https://github.com/ascd135/demo">GitHub</a>
                    </div>
                    <div class="visit">
                        <a href="/main">이동</a>
                    </div>
                </div>
            </div>

            <div class="project-item-container">
                <div class="project-item-image">
                    <img src="/images/나만따라yu.png">
                </div>
                <div class="project-item-title">
                    <h1>나만따라YU</h1>
                </div>
                <div class="project-item-intro">
                    <p>
                        영남대학교 대학생들만 사용할 수 있는 웹 커뮤니티 입니다.
                        <br>
                        6명이 모여 개발을 하였고, 저는 front-end 를 맡았습니다.
                    </p>
                </div>
                <div class="project-item-date">
                    <p>
                        2020.12
                    </p>
                </div>
                <div class="project-item-button">
                    <div class="github">
                        <a href="https://github.com/leeys507/WebProject">GitHub</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div class="contact" id="contact">
    <div class="contact-title">
        Contact
    </div>
    <div class="contact-email">
        E-mail : ascd135@naver.com
    </div>
    <div class="contact-phone">
        Phone : 010-8521-8665
    </div>
</div>
<footer class="footer">
    Made by Hyun min.
</footer>


<script src="/js/Landing.js"></script>
</body>
</html>