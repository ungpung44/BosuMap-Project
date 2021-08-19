<%-- 
    Document   : registerSuccess
    Created on : 2021. 8. 10, 오후 8:17:53
    Author     : JuwonPark
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="KO">
    <head>
        <!-- Basic Settings -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        
        <!-- CSS Connection -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css"/>
    
        <!-- Title -->
        <title>BosuMap Project Register</title>
        
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
            // You cant use Login Page.
            function Error(){
                alert("게시판을 이용하려면 로그인하세요");
            }
        </script>
    </head>
    <body>
        <!-- Top Bars -->
        <nav class="topbar">
            <div class="topbar_logo">
                <a href="${pageContext.request.contextPath}/index.jsp">BosuMap</a>
            </div>
            <ul class="topbar_menu">
                <li><a href="${pageContext.request.contextPath}/jsp/about.jsp">About</li>
                <li onclick="Error()"><a href="${pageContext.request.contextPath}/jsp/login.jsp">Board</li>
                <li><a href="${pageContext.request.contextPath}/jsp/program.jsp">Program</li>
                <li><a href="${pageContext.request.contextPath}/jsp/login.jsp">Login</li>
                <li><a href="${pageContext.request.contextPath}/jsp/register.jsp">Register</li>
            </ul>
            <a href="#" class="topbar_toggle">
                <i class="fas fa-bars"></i>
            </a>
        </nav>
            <%
                request.setCharacterEncoding("UTF-8");
                String userId = request.getParameter("user_id");
                String userPassword = request.getParameter("user_pw");
                String userName = request.getParameter("user_name");
                int userGender = Integer.parseInt(request.getParameter("radio_gender"));
                String userEmail = request.getParameter("user_email");
                String userNick = request.getParameter("user_nick");

                Connection connection = null;
                PreparedStatement pstmt = null;
                Class.forName("org.mariadb.jdbc.Driver");
                String url = "jdbc:mariadb://database-1.cirkk0nam9wr.ap-northeast-2.rds.amazonaws.com:3306/Bosu";
                String user = "admin";
                String pass = "20073011";
                
                String sql = "INSERT INTO Member(mem_nickname_idx, mem_userid, mem_email, mem_password, mem_username, mem_gender) values(?, ?, ?, ?, ?, ?)";
                connection = DriverManager.getConnection(url, user, pass);
                pstmt = connection.prepareStatement(sql);
                pstmt.setString(1, userNick);
                pstmt.setString(2, userId);
                pstmt.setString(3, userEmail);
                pstmt.setString(4, userPassword);
                pstmt.setString(5, userName);
                pstmt.setInt(6, userGender);
                pstmt.executeUpdate();

                pstmt.close();
                connection.close();
            %>
            <script>
                alert("회원가입을 완료하였습니다! 로그인으로 이동합니다!");
                location.href="${pageContext.request.contextPath}/jsp/login.jsp";
            </script>
    </body>
</html>
