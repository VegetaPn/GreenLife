<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.ArrayList"
	import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<title>田园生活</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link rel="stylesheet" type="text/css" href="../css/header.css" />
<link rel="stylesheet" type="text/css" href="../css/orderList.css" />




</head>
<body>
	<div id="header">
		<div id="leftButton">
			<img src="../images/leftArrowBlack.png" />
		</div>
		<!-- 左上角功能键：返回、或是菜单按键-->

		<div id="homeButton">
			<img src="../images/home.png">
		</div>
		<!-- 右上角功能键，其实就是主页按钮-->
		<div id="title">订单列表</div>
	</div>



	<%
	    //获取订单列表
	    List<GoodsOrder> orderList = new ArrayList<GoodsOrder>();
	    orderList = GoodsOrderDao.getGoodsOrderList("huangjianqiang");
	    int orderAmount = orderList.size();
	    System.out.println(orderAmount);
	    orderAmount = 1;
	    GoodsOrder orderToShow = new GoodsOrder();
	%>

	<div id="content">

		<%
		    for (int goodsOrderIndex = 0; goodsOrderIndex < orderAmount; goodsOrderIndex++) {
				//orderToShow=orderList.get(goodsOrderIndex);
				//int goodsId=orderToShow.getGoodsId();
				//GoodsInfo goodsinfo=GoodsInfoDao.getGoodsInfo(goodsId);
				GoodsInfo goodsinfo = new GoodsInfo();
		%>

		<!--一个订单条目-->
		<div class="tag">

			<div class="labelHeader" id="productSalesPrice">

				<div class="whiteDiv"></div>
				<span class="label">待付款</span>

			</div>

			<div class="listTag">


				<!--订单的图片和详情-->
				<div class="orderMessage">
					<!--订单产品图片-->
					<div class="productView">
						<img class="productImg" src="../images/product.jpg" />
					</div>
					<!--订单详情-->
					<div class="detailMessage" onclick="javascript:location.href='detailOrderMessage.jsp?orderIndex=<%=goodsOrderIndex%>'">

						<div class="productName">
							<span class="blackBold"><%=goodsinfo.getGoodsName()%></span>
						</div>

						<div class="seeMore">
							<hr class="line" />
							<!--<div class="morePNGalign"><img class="morePNG" src="../images/rightArrowCircle.png"/></div>-->
						</div>


						<div class="cargoReciever">
							<span class="blackNormal">收货人：</span><span class="orangeText"
								id="recieverName"><%=orderToShow.getWechatId()%></span>
						</div>

						<div class="shouldPay">
							<span class="blackNormal">应付款：</span><span class="orangeText"
								id="groupPrice"><%=orderToShow.getTotalPrice()%></span><span
								class="blackNormal" id="originPrice">元 共</span><span
								class="orangeText" id="groupPrice"><%=orderToShow.getGoodsNum()%></span><span
								class="blackNormal" id="originPrice">件</span>
						</div>

						<div class="orderTime">
							<span class="blackNormal">预定时间：</span><span class="blackNormal"
								id="timeOrdered"><%=orderToShow.getTradeTime()%></span>
						</div>

						<div class="deliverTime">
							<span class="blackNormal">发货时间：</span><span class="blackNormal"
								id="timeToDeliver"><%=orderToShow.getSendTime()%></span>
						</div>

					</div>

				</div>

				<!-- 条目可进行的操作（按钮）-->


				<%
				    if (true) {
				%>
				<div class="functionButton" id="goToPay"
					onclick="javascript:location.href='payForOrder.jsp'">去付款</div>
				<%
				    } else if (false) {
				%>
				<div class="functionButton" id="makeGroup">约好友成团</div>
				<%
				    } else if (false) {
				%>
				<div class="functionButton" id="giveComment">我来说两句</div>
				<%
				    } else if (false) {
				%>
				<div class="functionButton" id="showToFriends">分享给好友</div>
				<%
				    }
				%>
			</div>
		</div>
		<%
		    }
		%>
	
</body>
</html>
