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
            <%
                // Received Id.
                request.setCharacterEncoding("UTF-8");
                String name = request.getParameter("name");
                String urd = request.getParameter("uid");
                int uid = Integer.parseInt(urd);
                int count = 0;
                // Database.
                Connection connection = null;
                ResultSet resultSet = null;
                PreparedStatement pstmt = null;
                Class.forName("org.mariadb.jdbc.Driver");
                String url = "jdbc:mariadb://database-1.cirkk0nam9wr.ap-northeast-2.rds.amazonaws.com:3306/Bosu";
                String user = "admin";
                String pass = "20073011";
                String sqlBoard = "SELECT * FROM board WHERE board_idx = ?";
                String sqlCount = "UPDATE board SET hit_cnt = hit_cnt +1 WHERE board_idx = ?";
                String sqlShowReply = "SELECT * FROM Reply WHERE con_num = ? ORDER BY idx DESC";
            %>
                
            <%
                Class.forName("org.mariadb.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, pass);
                connection.setAutoCommit(false);
                pstmt = connection.prepareStatement(sqlCount);
                pstmt.setInt(1, uid);
                count = pstmt.executeUpdate();
                pstmt.close();
                pstmt = connection.prepareStatement(sqlBoard);
                pstmt.setInt(1, uid);
                resultSet = pstmt.executeQuery();
                
                String creator = "", title = "", content = "", date = "";
                int CountView = 0;
                if(resultSet.next()){
                    creator = resultSet.getString("creator_id");
                    title = resultSet.getString("title");
                    content = resultSet.getString("contents");
                    java.util.Date preDate = resultSet.getDate("created_datetime");
                    date = new SimpleDateFormat("yyyy-MM-dd").format(preDate);
                    CountView = resultSet.getInt("hit_cnt");
                }
                resultSet.close();
                pstmt.close();
                pstmt = connection.prepareStatement(sqlShowReply);
                pstmt.setInt(1, uid);
                resultSet = pstmt.executeQuery();
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
            <div class="div_board">
                <div id="div_content">
                    <h1><%=title%></h1>
                    <p>번호 : <%=uid%></p>
                    <p>작성자 : <%=creator%></p>
                    <p>내용</p>
                    <textarea id="result"cols="50" rows="8"><%=content%></textarea>
                </div>
                <div id="reply">
                    <table>
                        <thead>
                            <tr>
                                <th>댓글쓴이</th>
                                <th>내용</th>
                                <th>날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                while(resultSet.next()){
                                    String replyId = resultSet.getString("id");
                                    String replyContent = resultSet.getString("content");
                                    java.util.Date replyPreDate = resultSet.getDate("date");
                                    String replyDate = new SimpleDateFormat("yyyy-MM-dd").format(replyPreDate);
                                    if(replyId != null){
                                        out.println("<tr>");
                                        out.println("<td>" + replyId + "</td>");
                                        out.println("<td>" + replyContent + "</td>");
                                        out.println("<td>" + replyDate + "</td>");
                                        out.println("</tr>");
                                    }
                                }
                                resultSet.close();
                                pstmt.close();
                                connection.close();
                            %>
                        </tbody>
                    </table>
                </div>
                <form class="form_reply" action="${pageContext.request.contextPath}/jsp/logined/boardReplySuccess.jsp?name=<%=name%>&&uid=<%=uid%>" method="post">
                    <span>내용</span><input id="reply_content" type="text" name="reply_content"/>
                    <span>암호</span><input id="reply_password" type="password" name="reply_password"/>
                    <button type="submit" id="button_done">댓글등록</button>
                </form>
            </div>
        </div>
    </body>
</html>
