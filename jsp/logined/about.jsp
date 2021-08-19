<%-- 
    Document   : register.jsp
    Created on : 2021. 8. 4, 오후 5:21:34
    Author     : JuwonPark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
    <head>
        <!-- Basic Settings -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        
        <!-- CSS Connection -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/about.css"/>
    
        <!-- Title -->
        <title>BosuMap Project About</title>
        
        <!-- External Resources -->
        <script src="https://kit.fontawesome.com/69b73ca6e6.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">
        
        <!-- JQuery Code -->
        <script type="text/javascript">
            // Top Bars
            var topbarFlag = false;
            $(function(){
                $(window).resize(function(){
                    var windowWidth = window.outerWidth;
                    if(windowWidth >= 1000) {
                        $('.topbar_menu').css("display", "flex");
                    }
                })
                $('.topbar_toggle').click(function(){
                    if(topbarFlag == true) {
                        $('.topbar_menu').css("display", "none");
                        topbarFlag = false;
                    }else {
                        $('.topbar_menu').css("display", "flex");
                        topbarFlag = true;
                    }
                });
            })
            // Logout Function.
            function Logout(){
                alert("로그아웃 되었습니다.");
            }
            // Received Id.
            <%
                request.setCharacterEncoding("UTF-8");
                String name = request.getParameter("name");
            %>
        </script>
    </head>
    <body>
        <!-- Top Bars -->
        <nav class="topbar">
            <div class="topbar_logo">
                <a href="${pageContext.request.contextPath}/jsp/logined/index.jsp?name=<%=name%>">BosuMap</a>
            </div>
            <ul class="topbar_menu">
                <li><a href="${pageContext.request.contextPath}/jsp/logined/about.jsp?name=<%=name%>">About</li>
                <li><a href="${pageContext.request.contextPath}/jsp/logined/board.jsp?name=<%=name%>">Board</li>
                <li><a href="${pageContext.request.contextPath}/jsp/logined/program.jsp?name=<%=name%>">Program</li>
                <li onclick="Logout()"><a href="${pageContext.request.contextPath}/jsp/login.jsp">LogOut</li>
                <li onclick="Logout()"><a href="${pageContext.request.contextPath}/jsp/register.jsp">Register</li>
            </ul>
            <div>
                <%=name%>님이 로그인 중입니다
            </div>
            <a href="#" class="topbar_toggle">
                <i class="fas fa-bars"></i>
            </a>
        </nav>
        <div class="container">
            <div class="container">
                <div class="div_about_purpose">
                    <h1>프로젝트에 대하여</h1>
                    <p>이 프로젝트는 언제 어디서나 식당을 쉽고 빠르게 검색할 수 있도록 도와주는<br>
                        웹 서비스를 구축하는 것을 목표로 설계되었습니다.<br> 원하는 식당을 검색하는 게 아닌,
                        현재 사용할 수 있는 금액을 입력하여,<br> 해당 금액 내의 이용가능한 식당을 보여주는 
                        기능을 제공합니다.<br> 추가적으로 제공하는 게시판을 통해 정보를 교환하고싶은 사용자
                        들을 위한,<br> 로그인 서비스 및 커뮤니티를 통한 정보교환 기능을 제공합니다.
                    </p>
                    <h1>구현된 기능</h1>
                    <p>1) 카테고리와 금액을 통한 식당 검색.<br>
                        2) 결과 리스트로 출력.<br>
                        3) 카카오 맵 API를 이용한 위치 표시.<br>
                        4) 회원가입 및 로그인 서비스.<br>
                        5) 게시판 서비스.</p>
                    <h1>사용 기술 및 역할</h1>
                    <p>웹(박주원) : HTML5, CSS, JQuery, JS, JSP.<br>
                        데이터베이스 및 아이디어(최승헌) : MariaDB.<br>
                        클라우드 서버(송영준) : AWS EC2. APACHE TOMCAT, NGINX
                    </p>
                    <h1>팀 보수 일동. 감사드립니다.</h1>
                </div>
            </div>
        </div>
    </body>
</html>
