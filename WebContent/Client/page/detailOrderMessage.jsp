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


	<div id="header">
		<div id="leftButton">
			<img src="../images/leftArrowBlack.png"
				onclick="javascript:location.href='orderList.jsp'" />
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
			int orderIndex = Integer.parseInt(request.getParameter("orderIndex"));
			System.out.println("detailmessage orderIndex:" + orderIndex);

			List<GoodsOrder> orderList = new ArrayList<GoodsOrder>();
			orderList = GoodsOrderDao.getGoodsOrderList("huangjianqiang");

			GoodsOrder orderToShow = orderList.get(orderIndex);
			GoodsInfo goodsinfo = GoodsInfoDao.getGoodsInfo(orderToShow.getGoodsId());
			int orderstate = orderToShow.getOrderState();
			boolean isgroup = false;
			if (orderToShow.getGroupId() != 0)
			{
				isgroup = true;
			}

			String productImg = PropertiesUtil.getPath() + goodsinfo.getPackagePath() + "normal.jpg";
		%>

		<div id="product">
			<div id="productImgDiv">

				<img id="productImg" src=<%=productImg%> />
			</div>

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
							if (isgroup)
							{
								out.write("(成团价)" + goodsinfo.getGoodsDiscontPrice()+"元");
							}
							else
							{
								out.write(goodsinfo.getGoodsPrice()+"元");
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
				if (orderstate == 1 || orderstate == 5)
				{
			%>
			<div class="functionButton"
				onclick="javascript:location.href='payForOrder.jsp?orderIndex=<%=orderIndex%>'">去付款</div>

			<div class="functionButton" onclick="">取消订单</div>
			<%
				}
				else if (orderstate == 2)
				{
			%>
			<div class="functionButton" onclick="">约好友成团</div>
			<div class="functionButton" onclick="">取消订单</div>
			<%
				}
				else if (orderstate == 3 || orderstate == 6)
				{
			%>
			<div class="functionButton" onclick="">取消订单</div>
			<%
				}
				else if (orderstate == 4 || orderstate == 7 || orderstate == 8)
				{
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
