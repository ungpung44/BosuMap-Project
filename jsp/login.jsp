<%-- 
    Document   : register.jsp
    Created on : 2021. 8. 4, 오후 5:21:34
    Author     : JuwonPark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="KO">
    <head>
        <!-- Basic Settings -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        
        <!-- CSS Connection -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css"/>
    
        <!-- Title -->
        <title>BosuMap Project Login</title>
        
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
            // DB Load.
            <%
                Class.forName("org.mariadb.jdbc.Driver");
                Connection connection = null;
                Statement statementId = null;
                Statement statementPw = null;
                ResultSet resultSetId = null;
                ResultSet resultSetPw = null;

                String url = "jdbc:mariadb://database-1.cirkk0nam9wr.ap-northeast-2.rds.amazonaws.com:3306/Bosu";
                String user = "admin";
                String pass = "20073011";

                String sqlId = "SELECT mem_userid FROM Member";
                String sqlPw = "SELECT mem_password FROM Member";
                connection = DriverManager.getConnection(url, user, pass);
                statementId = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                statementPw = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSetId = statementId.executeQuery(sqlId);
                resultSetPw = statementPw.executeQuery(sqlPw);

                resultSetId.last();
                resultSetPw.last();
                int rowId = resultSetId.getRow();
                int rowPw = resultSetPw.getRow();
                resultSetId.beforeFirst();
                resultSetPw.beforeFirst();
                String[] idSet = new String[rowId+2];
                String[] pwSet = new String[rowPw+2];
                int i = 0;
                while(resultSetId.next()) {
                    idSet[i] = resultSetId.getString("mem_userid");
                    i++;
                }
                i = 0;
                while(resultSetPw.next()) {
                    pwSet[i] = resultSetPw.getString("mem_password");
                    i++;
                }
                resultSetId.close();
                resultSetPw.close();
                statementId.close();
                statementPw.close();
                connection.close();
                String resultValId = Arrays.toString(idSet);
                String resultValPw = Arrays.toString(pwSet);
            %>
            var idArray = "<%=resultValId%>";
            var pwArray = "<%=resultValPw%>";
            
            // Login Function.
            function LoginValidation() {
                var userId = $("#user_id").val().toString();
                var userPw = $("#user_pw").val().toString();
                if((idArray.indexOf(userId) != -1) && ((pwArray.indexOf(userPw) != -1))){
                    alert("로그인을 성공했습니다!");
                    //location.href="${pageContext.request.contextPath}/jsp/logined/index.jsp"
                    $('.form_login').submit();
                }else {
                    alert("아이디나 비밀번호가 틀립니다.");
                }
            }
            
            // Register Function.
            function GoingRegister() {
                alert("회원가입 페이지로 이동합니다.");
                location.href="${pageContext.request.contextPath}/jsp/register.jsp"
            }
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
        <div class="container">
            <form action="${pageContext.request.contextPath}/jsp/logined/index.jsp" method="post" class="form_login">
                <div class="title">
                    <h1>로그인</h1>
                </div>
                <div class="div_id">
                    <input type="text" id="user_id" name="name" placeholder="아이디">
                </div>
                <div class="div_pw">
                    <input type="password" id="user_pw" placeholder="비밀번호">
                </div>
                <div class="div_buttons">
                    <button type="button" id="button_login" onclick="LoginValidation()">
                        로그인
                    </button>
                    <button type="button" id="button_register" onclick="GoingRegister()">
                        회원가입
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>
