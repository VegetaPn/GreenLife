<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*"%>
<!DOCTYPE html>
<html>
<head>
<title>田园生活</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link rel="stylesheet" type="text/css" href="../css/header.css" />
<link rel="stylesheet" type="text/css"
	href="../css/detailOrderMessage.css" />



</head>
<body>


	<div id="header">
		<div id="leftButton">
			<img src="../images/leftArrowBlack.png" onclick="javascript:location.href='orderList.jsp'"/>
		</div>
		<!-- 左上角功能键：返回、或是菜单按键-->

		<div id="homeButton">
			<img src="../images/home.png">
		</div>
		<!-- 右上角功能键，其实就是主页按钮-->
		<div id="title">订单详情</div>
	</div>

	<div id="content">

		<%
			
			
		    int orderType = 0;
		    int orderId;
		    //int goodsId;
		    //String wechatId;
		    //int addrId;
		    //int goodsNum;
		    //String tradeTime;
		    //String comment;
		    double mailPrice = Double.parseDouble(request.getParameter("mailPrice"));
		    double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
		    int groupId;
		    String sendTime = request.getParameter("sendTime");
		    //int groupMinnum = Integer.parseInt(request.getParameter("groupMinnum"));

		    String goodsName = request.getParameter("goodsName");
		    String goodsPrice = request.getParameter("goodsPrice");
		    String recieverName = request.getParameter("recieverName");
		    String recieverPhone = request.getParameter("recieverPhone");
		    
		    String address = request.getParameter("address");
		%>

		<div id="product">
			<div id="productImgDiv">

				<img id="productImg" src="../images/product.jpg" />
			</div>

		</div>

		<div class="orderMainMessage">


			<div class="orderMessage">
				<div class="productName">
					<span class="blackBold"><%=goodsName%></span>
				</div>

				<div class="middleTag">
					<div class="tagLeft">商品价格：</div>
					<div class="blackNormal" id="productPrice"><%=goodsPrice%></div>
				</div>

				<div class="middleTag">
					<div class="tagLeft">运费：</div>
					<div class="orangeText" id="freight"><%=mailPrice%>元
					</div>
				</div>

				<div class="middleTag">
					<div class="tagLeft">实付款：</div>
					<div class="orangeText" id="paid"><%=totalPrice%></div>
				</div>

				<div class="middleTag">
					<div class="tagLeft">预计发货时间：</div>
					<div class="blackNormal" id="timeToDeliver"><%=sendTime%></div>
				</div>
			</div>

			<div class="functionButton" id="button1"
				onclick="javascript:location.href='payForOrder.jsp'">去付款</div>



			<div class="functionButton" id="button2">取消订单</div>

		</div>

		<div class="moreMessage">

			<div class="middleTag">
				<div class="tagLeft">收货地址：</div>
				<div class="blackNormal" id="aimLocation"><%=address%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">收货人：</div>
				<div class="blackNormal" id="recieverName"><%=recieverName%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">手机号码：</div>
				<div class="blackNormal" id="telephoneNumber"><%=recieverPhone %></div>
			</div>

		</div>

	</div>
</body>
</html>
