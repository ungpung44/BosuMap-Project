<%-- 
    Document   : register.jsp
    Created on : 2021. 8. 4, 오후 5:21:34
    Author     : JuwonPark
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="KO">
    <head>
        <!-- Basic Settings -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        
        <!-- CSS Connection -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/board.css"/>
    
        <!-- Title -->
        <title>BosuMap Project Board</title>
        
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
                // Database.
                Connection connection = null;
                ResultSet resultSet = null;
                PreparedStatement pstmt = null;
                Class.forName("org.mariadb.jdbc.Driver");
                String url = "jdbc:mariadb://database-1.cirkk0nam9wr.ap-northeast-2.rds.amazonaws.com:3306/Bosu";
                String user = "admin";
                String pass = "20073011";
                String sql = "SELECT * FROM board ORDER BY board_idx DESC";
            %>
            function Write(){
                location.href = "${pageContext.request.contextPath}/jsp/logined/boardWrite.jsp?name=<%=name%>";
            }
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
            <%
                Class.forName("org.mariadb.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, pass);
                pstmt = connection.prepareStatement(sql);
                resultSet = pstmt.executeQuery();
            %>
            <div class="row">
                <table>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>글쓴이</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while(resultSet.next()){
                                int boardIndex = resultSet.getInt("board_idx");
                                String boardTitle = resultSet.getString("title");
                                String boardId = resultSet.getString("creator_id");
                                int boardCount = resultSet.getInt("hit_cnt");
                                java.util.Date boardPreDate = resultSet.getDate("created_datetime");
                                String boardDate = new SimpleDateFormat("yyyy-MM-dd").format(boardPreDate);
                                out.println("<tr>");
                                out.println("<td>" + boardIndex + "</td>");
                                out.println("<td><a href='boardView.jsp?name=" + name + "&&uid=" + boardIndex + "'/>" + boardTitle + "</td>");
                                out.println("<td>" + boardId + "</td>");
                                out.println("<td>" + boardDate + "</td>");
                                out.println("</tr>");
                            }
                            resultSet.close();
                            pstmt.close();
                            connection.close();
                        %>
                    </tbody>
                </table>
                <button type="button" id="button_done" onclick="Write()">글쓰기</button>
            </div>
        </div>
    </body>
</html>
