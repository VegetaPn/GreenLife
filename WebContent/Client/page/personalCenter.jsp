<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>

<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/personalCenter.css" type="text/css">
		
    </head>
    <body>
	
		<jsp:include page="header.jsp" />
		
		<div id="content">
		<%
		//session.getAttribute("nickname");
		
		%>
			<div id="visitingCard">
				<div id="bgImage"><img src="../images/bg.jpg"/></div>
				<div id="icon"><img src=<%=session.getAttribute("headimgurl")%>/></div>
				<div id="userName"><%=session.getAttribute("nickname")%></div>
			</div>
			
			<div class="service">
				<div class="func" onclick="javascript:location.href='orderList.jsp?whatToShow=4'">
					<div class="icon"><img src="../images/shoppingCart.png"/></div>
					<div class="myFunc">我的订单</div>
					<div class="arrowHead"><img src="../images/rightArrowOrange.png"/></div>
				</div>
				
				<div class="func" onclick="javascript:location.href='collection.jsp'">
					<div class="icon"><img src="../images/heartFull.png"/></div>
					<div class="myFunc">我的收藏</div>
					<div class="arrowHead"><img src="../images/rightArrowOrange.png"/></div>
				</div>
				
				<div class="undetermined">
					<div class="um" onclick="javascript:location.href='orderList.jsp?whatToShow=0'"><img src="../images/profileGroup.png"/><span>待成团</span></div>
					<div class="um" onclick="javascript:location.href='orderList.jsp?whatToShow=1'"><img src="../images/bankCards.png"/><span>待付款</span></div>
					<div class="um" onclick="javascript:location.href='orderList.jsp?whatToShow=2'"><img src="../images/truck.png"/><span>待发货</span></div>
					<div class="um" onclick="javascript:location.href='orderList.jsp?whatToShow=3'"><img src="../images/receive.png"/><span>待收货</span></div>
				</div>
				
				
				<div class="func" onclick="javascript:location.href='myAddress.jsp'">
					<div class="icon"><img src="../images/mapMarkerOrange.png"/></div>
					<div class="myFunc">收货地址</div>
					<div class="arrowHead"><img src="../images/rightArrowOrange.png"/></div>
				</div>
				<!-- 
				<div id="quit" onclick="javascript:location.href='login.jsp'">
					<div id="logout">退出登录</div>
				</div>
			    -->
			</div>
		</div>
       <jsp:include page="footer.jsp" />
    </body>
</html>
