<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.*"
	import="java.util.Properties"%>
<!DOCTYPE html>
<html>
<head>
<title>田园生活</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="../css/header.css" />
<link rel="stylesheet" type="text/css" href="../css/payForOrder.css" />
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
		<div id="title">订单支付</div>
	</div>

	<div id="content">




		<%
			int orderIndex = Integer.parseInt(request.getParameter("orderIndex"));
			System.out.println("orderIndex:" + orderIndex);

			List<GoodsOrder> orderList = new ArrayList<GoodsOrder>();
			orderList = GoodsOrderDao.getGoodsOrderList("huangjianqiang");

			GoodsOrder orderToShow = orderList.get(orderIndex);
			GoodsInfo goodsinfo = GoodsInfoDao.getGoodsInfo(orderToShow.getGoodsId());

			boolean isgroup = false;
			if (orderToShow.getOrderState() == 1)
			{
				isgroup = true;
			}
		%>


		<div class="topTag" id="orderMessage">

			<div class="bigTag">
				<span class="blackBold">订单详情</span>
			</div>

			<hr class="line" />

			<div class="middleTag">
				<div class="tagLeft">订单号：</div>
				<div class="blackNormalRight" id="orderNumber"><%=orderToShow.getOrderId()%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">名称：</div>
				<div class="blackNormalRight" id="productName"><%=goodsinfo.getGoodsName()%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">单价：</div>
				<div class="blackNormalRight" id="productPrice">
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
				<div class="tagLeft">数量：</div>
				<div class="blackNormalRight" id="goodsAmount"><%=orderToShow.getGoodsNum()%></div>
			</div>

			<hr class="line" />

			<div class="middleTag">
				<div class="tagLeft">快递费：</div>
				<div class="blackNormalRight" id="freight"><%=orderToShow.getMailPrice()%>
					元
				</div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">留言：</div>
				<div class="blackNormalRight" id="leftMessage"><%=orderToShow.getComment()%></div>
			</div>

		</div>


		<div class="topTag">

			<div class="bigTag">
				<span class=blackBold><%=orderToShow.getReceiverName() + "  " + orderToShow.getPhoneNumber()%></span>
			</div>

			<div class="detailLocation">
				<div class="locationIMGAlign">
					<img src="../images/mapMarkerBlack.png" class="locationIMG" />
				</div>
				<div class="blackNormal" id="detailLocationInfo"><%=orderToShow.getAddrDetail()%></div>
			</div>


		</div>

		<div class="topTag" id="payBlock">


			<div id="totalPrice">
				<span class="blackBold" id="totalSym">合计：￥</span><span
					class="orangeText"><%=orderToShow.getTotalPrice()%></span>
			</div>
			<div class="functionButton" id="payButton" onclick="">支付</div>





		</div>


	</div>

</body>
</html>
