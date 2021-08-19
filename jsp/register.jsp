<%-- 
    Document   : register.jsp
    Created on : 2021. 8. 4, 오후 5:21:34
    Author     : JuwonPark
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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
            // Top Bars.
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
            // Main Flag.
            var idFlag = false;
            var nickFlag = false;
            var pwFlag = false;
            // DB Load.
            <%
                Class.forName("org.mariadb.jdbc.Driver");
                Connection connection = null;
                Statement statementId = null;
                Statement statementNick = null;
                ResultSet resultSetId = null;
                ResultSet resultSetNick = null;
                
                String url = "jdbc:mariadb://database-1.cirkk0nam9wr.ap-northeast-2.rds.amazonaws.com:3306/Bosu";
                String user = "admin";
                String pass = "20073011";
                
                String sqlId = "SELECT mem_userid FROM Member";
                String sqlNick = "SELECT mem_nickname_idx FROM Member";
                connection = DriverManager.getConnection(url, user, pass);
                statementId = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                statementNick = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSetId = statementId.executeQuery(sqlId);
                resultSetNick = statementNick.executeQuery(sqlNick);
                resultSetId.last();
                resultSetNick.last();
                int rowId = resultSetId.getRow();
                int rowNick = resultSetNick.getRow();
                resultSetId.beforeFirst();
                resultSetNick.beforeFirst();
                String[] idSet = new String[rowId];
                String[] nickSet = new String[rowNick];
                int i = 0;
                while(resultSetId.next()) {
                    idSet[i] = resultSetId.getString("mem_userid");
                    i++;
                }
                i = 0;
                while(resultSetNick.next()) {
                    nickSet[i] = resultSetNick.getString("mem_nickname_idx");
                    i++;
                }
                resultSetId.close();
                resultSetNick.close();
                statementId.close();
                statementNick.close();
                connection.close();
                String resultValId = Arrays.toString(idSet);
                String resultValNick = Arrays.toString(nickSet);
            %>
            var idArray = "<%=resultValId%>";
            var nickArray = "<%=resultValNick%>";
            
            // ID Checking.
            function IDValidation() {
                var userId = $("#user_id").val().toString();
                
                if(idArray.indexOf(userId) != -1) {
                    alert("중복된 아이디입니다.");
                    idFlag = false;
                }else {
                    alert("사용가능한 아이디입니다.");
                    idFlag = true;
                }
            }
            
            // PW Checking.
            function PWValidation() {
                var userPw1 = $("#user_pw1").val();
                var userPw2 = $("#user_pw2").val();
                if(userPw1 == userPw2) {
                    alert("비밀번호가 일치합니다.");
                    pwFlag = true;
                }else {
                    alert("비밀번호가 일치하지 않습니다.");
                    pwFlag = false;
                }
            }
            
            // Nick Checking.
            function NickValidation() {
                var userNick = $("#user_nick").val().toString();
                
                if(nickArray.indexOf(userNick) != -1) {
                    alert("중복된 닉네임입니다.");
                    nickFlag = false;
                }else {
                    alert("사용가능한 닉네임입니다.");
                    nickFlag = true;
                }
            }
            
            // SignUp Checking.           
            function SignUpValidation() {
                var userId = $("#user_id").val();
                var userPw = $("#user_pw1").val();
                var userPwChk = $("#user_pw2").val();
                var userName = $("#user_name").val();
                var userGender = $('input[name="radio_gender"]:checked');
                var userEmail = $("#user_email").val();
                var userNick = $("#user_nick").val();
                
                if(idFlag == true && nickFlag == true && pwFlag == true){
                    if(!userId) {
                        alert("아이디 입력은 필수입니다.");
                        $("#user_id").focus();
                        //$("#result_id_check").text("아이디를 입력하세요.");
                    }else if(!userPw) {
                        alert("비밀번호 입력은 필수입니다.");
                        $("#user_pw1").focus();
                        //$("#result_pw_check").text("비밀번호를 입력하세요.");
                    }else if(!userPwChk) {
                        alert("비밀번호 확인 입력은 필수입니다.");
                        $("#user_pw2").focus();
                        //$("#result_pw_check").text("비밀번호를 알맞게 입력하세요.");
                    }else if(!userName) {
                        alert("성명 입력은 필수입니다.");
                        $("#userName").focus();
                        //$("#result_name_check").text("성명을 입력하세요.");
                    }else if(!userNick){
                        alert("닉네임 입력은 필수입니다.");
                        $("#userNick").focus();
                    }else {
                        Success();
                    }
                }else if(idFlag == false) {
                    alert("아이디 중복을 확인하세요.");
                    $("#user_id").focus();
                }else if(nickFlag == false) {
                    alert("닉네임 중복을 확인하세요.");
                    $("#userNick").focus();
                }else if(pwFlag == false) {
                    alert("비밀번호 중복을 확인하세요.");
                    $("#user_pw1").focus();
                }
                
            }
            
            // SignUp Success.
            function Success() {
                $(".form_register").submit();
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
        <!-- Container -->
        <div class="container">
            <form action="${pageContext.request.contextPath}/jsp/registerSuccess.jsp" method="post" class="form_register">
                <div class="title">
                    <h1>회원가입</h1>
                </div>
                <div class="div_left">
                    <div class="div_id">
                        <h1>아이디</h1>
                        <input type="text" id="user_id" name="user_id" placeholder="아이디"><br>
                        <p id="result_id_check"> </p>
                        <button type="button" id="button_id_check" onclick="IDValidation()">중복확인</button>
                    </div>
                    <div class="div_pw">
                        <h1>패스워드</h1>
                        <input type="password" id="user_pw1" name="user_pw" placeholder="비밀번호">
                        <h1>패스워드 확인</h1>
                        <input type="password" id="user_pw2" placeholder="비밀번호 확인">
                        <p id="result_pw_check"> </p>
                        <button type="button" id="button_pw_check" onclick="PWValidation()">일치확인</button>
                    </div>
                    <div class="div_name">
                        <h1>성명</h1>
                        <input type="text" id="user_name" name="user_name" placeholder="홍길동">
                        <p id="result_name_check"> </p>
                    </div>
                    <div class="div_nickname">
                        <h1>닉네임</h1>
                        <input type="text" id="user_nick" name="user_nick" placeholder="닉네임">
                        <p id="result_nickname_check"> </p>
                        <button type="button" id="button_nick_check" onclick="NickValidation()">중복확인</button>
                    </div>
                    <div class="div_gender">
                        <h1>성별</h1>
                        <span class="male">남성</span>
                        <input type="radio" class="radio_gender" name="radio_gender" value="1" checked>
                        <span class="female">여성</span>
                        <input type="radio" class="radio_gender" name="radio_gender" value="2">
                    </div>
                    <div class="div_email">
                        <h1>이메일</h1>
                        <input type="email" id="user_email" name="user_email" placeholder="address@gmail.com">
                        <p id="result_email_check"> </p>
                    </div>
                    <div class="div_done">
                        <button type="button" id="button_done" onclick="SignUpValidation()">가입하기</button>
                    </div>
                </div>
            </form>    
        </div>
                
        
    </body>
</html>
