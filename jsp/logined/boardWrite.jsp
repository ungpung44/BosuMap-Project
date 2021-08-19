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
            %>
            // Going Back.
            function GoingBack(){
                alert("글쓰기를 취소하고 목록으로 이동합니다");
                location.href = "${pageContext.request.contextPath}/jsp/logined/board.jsp?name=<%=name%>";
            }
            // Going Next.
            function GoingNext(){
                var title = $("#write_title").val();
                var pw = $("#write_pw").val();
                var write_content = $("#write_content").val();
                if(!title){
                    alert("글 제목 입력은 필수입니다.");
                    $("#write_title").focus();
                }else if(!pw){
                    alert("글 암호 입력은 필수입니다.");
                    $("#write_pw").focus();
                }else if(!write_content){
                    alert("글 내용 입력은 필수입니다.");
                    $("#write_title").focus();
                }else{
                    Success();
                }
                // Success.
                function Success() {
                    $(".form_write").submit();
                }
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
            <form class="form_write" action="${pageContext.request.contextPath}/jsp/logined/boardWriteSuccess.jsp?name=<%=name%>" method="post">
                <h1>글쓰기</h1>
                <p>제목</p><input id="write_title" type="text" name="title" />
                <p>글암호</p><input id="write_pw" type="password" name="password"/>
                <p>글내용</p><textarea id="write_content" name="content"></textarea>
                <div class="div_buttons">
                    <button type="button" id="button_back" onclick="GoingBack()">취소하기</button>
                    <button type="button" id="button_done" onclick="GoingNext()">등록하기</button>
                </div>
            </form>
        </div>
    </body>
</html>
