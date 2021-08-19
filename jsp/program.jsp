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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/program.css"/>
    
        <!-- Title -->
        <title>BosuMap Project Program</title>
        
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
            // Sending Check.
            function Submit(){
                var money = $("#money").val();
                if(!money){
                    alert("금액을 입력해야 합니다");
                }else{
                    $(".form_program").submit();
                }
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
            <form action="${pageContext.request.contextPath}/jsp/programListPage.jsp" method="post" class="form_program">
                <div class="title">
                    <h1>식당 검색 프로그램</h1>
                </div>
                <div id="div_menuname">
                    <h1>메뉴명 검색</h1>
                    <input type="text" id="menu" name="menu">
                </div>
                <div class="div_category_main">
                    <h1>메인 카테고리</h1>
                    <div id="div_element">
                        <div id="div_category_main_korean">
                            <span>한식</span>
                            <input type="radio" name="radio_category_main" value="한식" checked>
                        </div>
                        <div id="div_category_main_chinese">
                            <span>중식</span>
                            <input type="radio" name="radio_category_main" value="중식">
                        </div>
                        <div id="div_category_main_japanese">
                            <span>일식</span>
                            <input type="radio" name="radio_category_main" value="일식">
                        </div>
                        <div id="div_category_main_western">
                            <span>양식</span>
                            <input type="radio" name="radio_category_main" value="양식">
                        </div>
                    </div>
                    
                </div>
                <div class="div_category_wellbeing">
                    <h1>건강 카테고리</h1>
                    <div id="div_category_wellbeing_none">
                        <span>선택안함</span>
                        <input type="radio" name="radio_category_wellbeing" value="None" checked>
                    </div>
                    <div id="div_category_wellbeing_healthy">
                        <span>건강식</span>
                        <input type="radio" name="radio_category_wellbeing" value="건강식">
                    </div>
                    <div id="div_category_wellbeing_vegitable">
                        <span>채식</span>
                        <input type="radio" name="radio_category_wellbeing" value="채소식">
                    </div>
                    <div id="div_category_wellbeing_lowSalt">
                        <span>저염식</span>
                        <input type="radio" name="radio_category_wellbeing" value="저염식">
                    </div>
                   
                </div>
                <div class="div_category_money">
                    <h1>금액을 입력하세요</h1>
                    <input type="number" id="money" name="money">
                </div>
                <div class="div_done">
                    <button type="button" id="button_done" onclick="Submit()">
                        검색하기
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>
