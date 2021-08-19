<%-- 
    Document   : programMapPage
    Created on : 2021. 8. 13, 오후 11:21:22
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/programMapPage.css"/>
    
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
            // DB Connection.
            <%
                request.setCharacterEncoding("UTF-8");
                String address = request.getParameter("adress");
                Class.forName("org.mariadb.jdbc.Driver");
                Connection connection = null;
                ResultSet resultName = null;
                ResultSet resultMenu = null;
                ResultSet resultPrice = null;
                PreparedStatement pstmtName = null;
                PreparedStatement pstmtMenu = null;
                PreparedStatement pstmtPrice = null;
                String url = "jdbc:mariadb://database-1.cirkk0nam9wr.ap-northeast-2.rds.amazonaws.com:3306/Bosu";
                String user = "admin";
                String pass = "20073011";
                String sqlName = "SELECT DISTINCT Sikdang_Name FROM Sikdang WHERE adress = ? ORDER BY Sikdang_idx ASC";
                String sqlMenu = "SELECT Food_Name FROM Sikdang WHERE adress = ? ORDER BY Sikdang_idx ASC";
                String sqlPrice = "SELECT price FROM Sikdang WHERE adress = ? ORDER BY Sikdang_idx ASC";
                
                connection = DriverManager.getConnection(url, user, pass);
                pstmtName = connection.prepareStatement(sqlName, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                pstmtMenu = connection.prepareStatement(sqlMenu, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                pstmtPrice = connection.prepareStatement(sqlPrice, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                pstmtName.setString(1, address);
                pstmtMenu.setString(1, address);
                pstmtPrice.setString(1, address);
                resultName = pstmtName.executeQuery();
                resultMenu = pstmtMenu.executeQuery();
                resultPrice = pstmtPrice.executeQuery();
                resultName.last();
                resultMenu.last();
                resultPrice.last();
                int rowName = resultName.getRow();
                int rowMenu = resultMenu.getRow();
                int rowPrice = resultPrice.getRow();
                String[] nameSet = new String[rowName];
                String[] menuSet = new String[rowMenu];
                String[] priceSet = new String[rowPrice];
                resultName.beforeFirst();
                resultMenu.beforeFirst();
                resultPrice.beforeFirst();
                int i = 0;
                while(resultName.next()){
                    nameSet[i] = resultName.getString("Sikdang_Name");
                    i++;
                }
                i = 0;
                while(resultMenu.next()){
                    menuSet[i] = resultMenu.getString("Food_Name");
                    i++;
                }
                i = 0;
                while(resultPrice.next()){
                    priceSet[i] = resultPrice.getString("price");
                    i++;
                }
                resultName.close();
                resultMenu.close();
                resultPrice.close();
                pstmtName.close();
                pstmtMenu.close();
                pstmtPrice.close();
                connection.close();
                String resultValName = "", resultValMenu = "", resultValPrice = "";
                for(i = 0; i < nameSet.length; i++) {
                    if(i == 0) {
                        resultValName += "'" + nameSet[i] + "'";
                    }else {
                        resultValName += ",'" + nameSet[i] + "'";
                    } 
                }
                for(i = 0; i < menuSet.length; i++) {
                    if(i == 0) {
                        resultValMenu += "'" + menuSet[i] + "'";
                    }else {
                        resultValMenu += ",'" + menuSet[i] + "'";
                    } 
                }
                for(i = 0; i < priceSet.length; i++) {
                    if(i == 0) {
                        resultValPrice += "'" + priceSet[i] + "'";
                    }else {
                        resultValPrice += ",'" + priceSet[i] + "'";
                    } 
                }
            %>
            var address = '<%=address%>'
            var name = [<%=resultValName%>];
            var menu = [<%=resultValMenu%>];
            var price = [<%=resultValPrice%>];
            
            var markersDiv = '<div class="markers">';
            for(var i = 0; i < menu.length; i++){
                if(i == 0){
                    markersDiv += name;
                    markersDiv += '<br>' + menu[i] + ': ' + price[i];
                }  
                else
                    markersDiv += '<br>' + menu[i] + ': ' + price[i];
            }
            markersDiv += '</div>';
            var userMarkersDiv = '<div class="markers">내위치</div>'; 
            console.log(markersDiv);
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
            <div id="div_map">
                
            </div>
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=739041fe352001faaf2c01054bdb2e41&libraries=services"></script>
            <script>
                var container = document.getElementById('div_map');
                var options = {
                    center: new kakao.maps.LatLng(37.47422586122199, 127.03148464046687),
                    level: 3
                };
                var map = new kakao.maps.Map(container, options);
                var geocoder = new kakao.maps.services.Geocoder();
                geocoder.addressSearch(address, function(result, status){
                      if(status == kakao.maps.services.Status.OK){
                         if(navigator.geolocation){
                             navigator.geolocation.getCurrentPosition(function(position){
                                 var userLat = position.coords.latitude;
                                 var userLng = position.coords.longitude;
                                 var userCoords = new kakao.maps.LatLng(userLat, userLng);
                                 var userMarker = new kakao.maps.Marker({
                                    map: map,
                                    position: userCoords
                                 });
                                 var userInfoWindow = new kakao.maps.InfoWindow({
                                    content: userMarkersDiv
                                 });
                                 userInfoWindow.open(map, userMarker);
                             });
                         }else{
                             alert("현재 브라우저는 사용자 위치를 제공하지 않습니다.");
                         }
                          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                          
                          var marker = new kakao.maps.Marker({
                              map: map,
                              position: coords
                          });
                          
                          var infowindow = new kakao.maps.InfoWindow({
                              content: markersDiv         
                          });
                          
                          infowindow.open(map, marker);
                          map.setCenter(coords);
                      }      
                });
            </script>
        </div>
    </body>
</html>