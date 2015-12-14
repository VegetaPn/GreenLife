<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.*"
	import="java.util.Properties" import="com.greenlife.util.*"%>
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
	<%
		int orderId = Integer.parseInt(request.getParameter("orderId"));

		GoodsOrder orderToShow = GoodsOrderDao.getGoodsOrderById(orderId);


		GoodsInfo goodsinfo = GoodsInfoDao.getGoodsInfo(orderToShow.getGoodsId());
		int goodsId = goodsinfo.getGoodsId();
		int orderstate = orderToShow.getOrderState();

		int whatToShow = 4;
		String showtype = request.getParameter("whatToShow");
		if (showtype != null) {
			whatToShow = Integer.parseInt(showtype);
		}

		String productImg = PropertiesUtil.getPath() + goodsinfo.getPackagePath() + "normal.jpg";
	%>

	<div id="header">
		<div id="leftButton"
			onclick="javascript:location.href='orderList.jsp?whatToShow=<%=whatToShow%>'">
			<img src="../images/leftArrowBlack.png" />
		</div>
		<!-- 左上角功能键：返回、或是菜单按键-->

		<div id="homeButton" onclick="javascript:location.href='home.jsp'">
			<img src="../images/home.png">
		</div>
		<!-- 右上角功能键，其实就是主页按钮-->
		<div id="title">田园生活</div>
	</div>

	<div id="content">



		<div id="product"
			onclick="location.href='productHome.jsp?goodsId=<%=goodsId%>'">


			<img id="productImg" src=<%=productImg%> />


		</div>

		<div class="orderMainMessage">


			<div class="orderMessage">
				<div class="productName">
					<span class="blackBold"><%=goodsinfo.getGoodsName()%></span>
				</div>

				<div class="middleTag">
					<div class="tagLeft">商品价格：</div>
					<div class="blackNormal" id="productPrice">
						<%
							if (orderstate > 10) {
								out.write("(成团价)" + goodsinfo.getGoodsDiscontPrice() + "元");
							} else {
								out.write(goodsinfo.getGoodsPrice() + "元");
							}
						%>
					</div>
				</div>

				<div class="middleTag">
					<div class="tagLeft">运费：</div>
					<div class="orangeText" id="freight"><%=orderToShow.getMailPrice()%>元
					</div>
				</div>

				<div class="middleTag">
					<div class="tagLeft">实付款：</div>
					<div class="orangeText" id="paid"><%=orderToShow.getTotalPrice()%></div>
				</div>

				<div class="middleTag">
					<div class="tagLeft">预计发货时间：</div>
					<div class="blackNormal" id="timeToDeliver"><%=orderToShow.getSendTime()%></div>
				</div>
			</div>


			<%
				if (orderstate == 1 || orderstate == 11) {
					//待付款
			%>
			<div class="functionButton"
				onclick="javascript:location.href='payForOrder.jsp?<%=orderToShow.getOrderId()%>&whatToShow=<%=whatToShow%>'">去付款</div>
			<div class="functionButton" onclick="">取消订单</div>
			<%
				} else if (orderstate == 2) {
					//待成团
			%>
			<div class="functionButton" onclick="">约好友成团</div>
			<div class="functionButton" onclick="">取消订单</div>
			<%
				} else if (orderstate == 3 || orderstate == 12) {
					//待发货
			%>
			<div class="functionButton" onclick="">取消订单</div>
			<%
				} else if (orderstate == 5 || orderstate == 14) {
			%>
			<div class="functionButton" onclick="">我来说两句</div>
			<div class="functionButton" onclick="">分享给好友</div>
			<%
				}
			%>
		</div>

		<div class="moreMessage">

			<div class="middleTag">
				<div class="tagLeft">收货地址：</div>
				<div class="blackNormal" id="aimLocation"><%=orderToShow.getAddrDetail()%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">收货人：</div>
				<div class="blackNormal" id="recieverName"><%=orderToShow.getReceiverName()%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">手机号码：</div>
				<div class="blackNormal" id="telephoneNumber"><%=orderToShow.getPhoneNumber()%></div>
			</div>

		</div>

	</div>
</body>
</html>
