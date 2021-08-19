<%-- 
    Document   : register.jsp
    Created on : 2021. 8. 4, 오후 5:21:34
    Author     : JuwonPark
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="KO">
    <head>
        <!-- Basic Settings -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        
        <!-- CSS Connection -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/programListPage.css"/>
    
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
            // Requested & DB.
            <%
                request.setCharacterEncoding("UTF-8");
                String mainCategory = request.getParameter("radio_category_main");
                String wellbeingCategory = request.getParameter("radio_category_wellbeing");
                String menu = request.getParameter("menu");
                String menuName = '%' + menu + '%';
                int money = Integer.parseInt(request.getParameter("money"));

                Class.forName("org.mariadb.jdbc.Driver");
                Connection connection = null;
                ResultSet resultSetName = null;
                ResultSet resultSetAddress = null;
                ResultSet resultSetTel = null;
                PreparedStatement pstmtName = null;
                PreparedStatement pstmtAddress = null;
                PreparedStatement pstmtTel = null;
                
                String url = "jdbc:mariadb://database-1.cirkk0nam9wr.ap-northeast-2.rds.amazonaws.com:3306/Bosu";
                String user = "admin";
                String pass = "20073011";
                String sqlName = "";
                String sqlAddress = "";
                String sqlTel = "";
                
                connection = DriverManager.getConnection(url, user, pass);
                
                if(mainCategory.equals("All")) {
                    sqlName = "SELECT DISTINCT Sikdang_Name FROM Sikdang WHERE (Add_ones = ? AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlAddress = "SELECT DISTINCT adress FROM Sikdang WHERE (Add_ones = ? AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlTel = "SELECT DISTINCT Tel FROM Sikdang WHERE (Add_ones = ? AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                }else if(wellbeingCategory.equals("None")) {
                    sqlName = "SELECT DISTINCT Sikdang_Name FROM Sikdang WHERE (Food_Kinds = ? AND Add_ones IS NULL AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlAddress = "SELECT DISTINCT adress FROM Sikdang WHERE (Food_Kinds = ? AND Add_ones IS NULL AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlTel = "SELECT DISTINCT Tel FROM Sikdang WHERE (Food_Kinds = ? AND Add_ones IS NULL AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                }else if(mainCategory.equals("All") && wellbeingCategory.equals("None")) {
                    sqlName = "SELECT DISTINCT Sikdang_Name FROM Sikdang WHERE (Add_ones IS NULL AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlAddress = "SELECT DISTINCT adress FROM Sikdang WHERE (Add_ones IS NULL AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlTel = "SELECT DISTINCT Tel FROM Sikdang WHERE (Add_ones IS NULL AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                }else {
                    sqlName = "SELECT DISTINCT Sikdang_Name FROM Sikdang WHERE (Food_Kinds = ? AND Add_ones = ? AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlAddress = "SELECT DISTINCT adress FROM Sikdang WHERE (Food_Kinds = ? AND Add_ones = ? AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                    sqlTel = "SELECT DISTINCT Tel FROM Sikdang WHERE (Food_Kinds = ? AND Add_ones = ? AND price <= ?) AND Food_NAME LIKE ? ORDER BY Sikdang_idx ASC";
                }

                pstmtName = connection.prepareStatement(sqlName, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                pstmtAddress = connection.prepareStatement(sqlAddress, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                pstmtTel = connection.prepareStatement(sqlTel, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                
                if(mainCategory.equals("All")) {
                    pstmtName.setString(1, wellbeingCategory);
                    pstmtName.setInt(2, money);
                    pstmtName.setString(3, menuName);
                    pstmtAddress.setString(1, wellbeingCategory);
                    pstmtAddress.setInt(2, money);
                    pstmtAddress.setString(3, menuName);
                    pstmtTel.setString(1, wellbeingCategory);
                    pstmtTel.setInt(2, money);
                    pstmtTel.setString(3, menuName);
                }else if(wellbeingCategory.equals("None")) {
                    pstmtName.setString(1, mainCategory);
                    pstmtName.setInt(2, money);
                    pstmtName.setString(3, menuName);
                    pstmtAddress.setString(1, mainCategory);
                    pstmtAddress.setInt(2, money);
                    pstmtAddress.setString(3, menuName);
                    pstmtTel.setString(1, mainCategory);
                    pstmtTel.setInt(2, money);
                    pstmtTel.setString(3, menuName);
                }else if(mainCategory.equals("All") && wellbeingCategory.equals("None")) {
                    pstmtName.setInt(1, money);
                    pstmtName.setString(2, menuName);
                    pstmtAddress.setInt(1, money);
                    pstmtAddress.setString(2, menuName);
                    pstmtTel.setInt(1, money);
                    pstmtTel.setString(2, menuName);
                }else {
                    pstmtName.setString(1, mainCategory);
                    pstmtName.setString(2, wellbeingCategory);
                    pstmtName.setInt(3, money);
                    pstmtName.setString(4, menuName);
                    pstmtAddress.setString(1, mainCategory);
                    pstmtAddress.setString(2, wellbeingCategory);
                    pstmtAddress.setInt(3, money);
                    pstmtAddress.setString(4, menuName);
                    pstmtTel.setString(1, mainCategory);
                    pstmtTel.setString(2, wellbeingCategory);
                    pstmtTel.setInt(3, money);
                    pstmtTel.setString(4, menuName);
                }

                resultSetName = pstmtName.executeQuery();
                resultSetAddress = pstmtAddress.executeQuery();
                resultSetTel = pstmtTel.executeQuery();
                resultSetName.last();
                resultSetAddress.last();
                resultSetTel.last();
                int rowName = resultSetName.getRow();
                int rowAddress = resultSetAddress.getRow();
                int rowTel = resultSetTel.getRow();
                String[] nameSet = new String[rowName];
                String[] addressSet = new String[rowAddress];
                String[] telSet = new String[rowTel];
                resultSetName.beforeFirst();
                resultSetAddress.beforeFirst();
                resultSetTel.beforeFirst();
                int i = 0;
                while(resultSetName.next()) {
                    nameSet[i] = resultSetName.getString("Sikdang_Name");
                    i++;
                }
                i = 0;
                while(resultSetAddress.next()) {
                    addressSet[i] = resultSetAddress.getString("adress");
                    i++;
                }
                i = 0;
                while(resultSetTel.next()) {
                    telSet[i] = resultSetTel.getString("Tel");
                    i++;
                }
                resultSetName.close();
                resultSetAddress.close();
                resultSetTel.close();
                pstmtName.close();
                pstmtAddress.close();
                pstmtTel.close();
                connection.close();

                //String resultValName = Arrays.toString(nameSet);
                //String resultValAddress = Arrays.toString(addressSet);
                
                String resultValName = "";
                for(i = 0; i < nameSet.length; i++) {
                    if(i == 0) {
                        resultValName += "'" + nameSet[i] + "'";
                    }else {
                        resultValName += ",'" + nameSet[i] + "'";
                    } 
                }
                String resultValAddress = "";
                for(i = 0; i < addressSet.length; i++) {
                    if(i == 0) {
                        resultValAddress += "'" + addressSet[i] + "'";
                    }else {
                        resultValAddress += ",'" + addressSet[i] + "'";
                    }
                }
                String resultValTel = "";
                for(i = 0; i < telSet.length; i++) {
                    if(i == 0) {
                        resultValTel += "'" + telSet[i] + "'";
                    }else {
                        resultValTel += ",'" + telSet[i] + "'";
                    }
                }
            %>
            var resultSetName = [<%=resultValName%>];
            var resultSetAddress = [<%=resultValAddress%>];
            var resultSetTel = [<%=resultValTel%>];
            var maincategory = "<%=mainCategory%>";
            console.log(resultSetName);
            console.log(resultSetAddress);
            
            if(resultSetName.length == 0){
                alert("일치하는 결과가 없습니다.");
                location.href="${pageContext.request.contextPath}/jsp/logined/program.jsp?name=<%=name%>";
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
            <form action="${pageContext.request.contextPath}/jsp/logined/programMapPage.jsp?name=<%=name%>" method="post" class="form_list">
                <div class="div_title">
                    <h1>식당 리스트</h1>
                </div>
            </form>
        </div>
        <script type="text/javascript">
            var preImgSrc = "../img";
            if(maincategory == "전체")
                preImgSrc += "/allFood.png";
            else if(maincategory == "한식")
                preImgSrc += "/koreanFood.png";
            else if(maincategory == "일식")
                preImgSrc += "/japaneseFood.png";
            else if(maincategory == "양식")
                preImgSrc += "/westernFood.png";
            else
                preImgSrc += "/chineseFood.png";
            console.log(preImgSrc);
            for(var i = 0; i < resultSetName.length; i++){
                $(".form_list").append("<div class=\"div_list\">" 
                        + "<img class=\"restaurant_img\" src=\"" + preImgSrc + "\" height=\"100px\" width=\"100px\">"
                        + "<p class=\"restaurant_name\">" + resultSetName[i] + "</p>"
                        + "<p class=\"restaurant_menu\">" + resultSetAddress[i] + "</p>" 
                        + "<p class=\"restaurant_tel\">" + resultSetTel[i] + "</p>"
                        + "<button type=\"submit\" class=\"button_select\" name=\"adress\" value=\"" + resultSetAddress[i] + "\">식당선택</button>"
                        + "</div>");
            }
        </script>
    </body>
</html>
