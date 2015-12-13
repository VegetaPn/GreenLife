<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.ArrayList"
	import="java.util.List" import="com.greenlife.util.*"%>
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

	<%
	    //获取订单列表
		List<GoodsOrder> orderList = new ArrayList<GoodsOrder>();
		orderList = GoodsOrderDao.getGoodsOrderList("huangjianqiang");
		int orderAmount = orderList.size();
		System.out.println(orderAmount);
		//用于填充的变量
		int whatToShow = 4;
		String showtype = request.getParameter("whatToShow");
		if (showtype != null)
		{
			whatToShow = Integer.parseInt(showtype);
		}
		GoodsOrder orderToShow = new GoodsOrder();
		GoodsInfo goodsinfo = new GoodsInfo();
		int orderstate = 0;
	%>
	<div id="header">
		<div id="leftButton">
			<img src="../images/leftArrowBlack.png" />
		</div>
		<!-- 左上角功能键：返回、或是菜单按键-->

		<div id="homeButton">
			<img src="../images/home.png">
		</div>
		<!-- 右上角功能键，其实就是主页按钮-->
		<div id="title">
			<%
			    if (whatToShow == 4)
				{
					out.write("订单列表");
				}
				else if (whatToShow == 0)
				{
					out.write("订单列表-待成团");
				}
				else if (whatToShow == 1)
				{
					out.write("订单列表-待付款");
				}
				else if (whatToShow == 2)
				{
					out.write("订单列表-待发货");
				}
				else if (whatToShow == 3)
				{
					out.write("订单列表-待评论");
				}
			%>
		</div>
	</div>
	<div id="content">
		<%
		    for (int orderIndex = 0; orderIndex < orderAmount; orderIndex++)
			{
				orderToShow = orderList.get(orderIndex);
				goodsinfo = GoodsInfoDao.getGoodsInfo(orderToShow.getGoodsId());
				orderstate = orderToShow.getOrderState();
				String productImg = PropertiesUtil.getPath() + goodsinfo.getPackagePath() + "small.jpg";
				if (whatToShow != 4)
				{
					if (whatToShow == 0 && orderstate != 2)
					{
						//跳过不是待成团的条目
						continue;
					}
					if (whatToShow == 1 && orderstate != 1 && orderstate != 5)
					{
						//跳过不是待付款的条目
						continue;
					}
					if (whatToShow == 2 && orderstate != 3 && orderstate != 6)
					{
						//跳过不是待发货的条目
						continue;
					}
					if (whatToShow == 3 && orderstate != 4 && orderstate != 7)
					{
						//跳过不是待评论的条目
						continue;
					}
				}
		%>

		<!--一个订单条目-->
		<div class="tag">

			<div class="labelHeader" id="productSalesPrice">

				<div class="whiteDiv"></div>
				<span class="label"> 
				<%
	     			if (orderstate == 1)
	 				{
	 					out.write("待付款");
	 				}
	 				else if (orderstate == 2)
	 				{
	 					out.write("待成团");
	 				}
	 				else if (orderstate == 3)
	 				{
	 					out.write("待发货");
	 				}
	 				else if (orderstate == 4)
	 				{
	 					out.write("待评价");
	 				}
	 				else if (orderstate == 5)
	 				{
	 					out.write("待付款");
	 				}
	 				else if (orderstate == 6)
	 				{
	 					out.write("待成团");
	 				}
	 				else if (orderstate == 7)
	 				{
	 					out.write("待发货");
	 				}
	 				else if (orderstate == 8)
	 				{
	 					out.write("已完成");
	 				}
	 				else
	 				{
	 					out.write("未知类型订单");
	 				}
				 %>
				</span>

			</div>

			<div class="listTag">


				<!--订单的图片和详情-->
				<div class="orderMessage">
					<!--订单产品图片-->
					<div class="productView">
						<img class="productImg" src=<%=productImg%> />
					</div>
					<!--订单详情-->
					<div class="detailMessage"
						onclick="javascript:location.href='detailOrderMessage.jsp?orderIndex=<%=orderIndex%>'">

						<div class="productName">
							<span class="blackBold"><%=goodsinfo.getGoodsName()%></span>
						</div>

						<div class="seeMore">
							<hr class="line" />
							<!--<div class="morePNGalign"><img class="morePNG" src="../images/rightArrowCircle.png"/></div>-->
						</div>


						<div class="cargoReciever">
							<span class="blackNormal">收货人：</span><span class="orangeText"
								id="recieverName"><%=orderToShow.getReceiverName()%></span>
						</div>

						<div class="shouldPay">
							<span class="blackNormal">应付款：</span><span class="orangeText"
								id="groupPrice"><%=orderToShow.getTotalPrice()%></span><span
								class="blackNormal" id="originPrice">元 共</span><span
								class="orangeText" id="groupPrice"><%=orderToShow.getGoodsNum()%></span><span
								class="blackNormal" id="originPrice">件</span>
						</div>

						<div class="orderTime">
							<span class="blackNormal">预订时间：</span><span class="blackNormal"
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
				    if (orderstate == 1 || orderstate == 5)
					{
				%>
				<div class="functionButton" id="goToPay"
					onclick="javascript:location.href='detailOrderMessage.jsp?orderIndex=<%=orderIndex%>'">去付款</div>
				<%
				    }
					else if (orderstate == 2)
					{
				%>
				<div class="functionButton" id="makeGroup" onclick="">约好友成团</div>
				<%
				    }
					else if (orderstate == 4 || orderstate == 7)
					{
				%>
				<div class="functionButton" id="giveComment" onclick="">我来说两句</div>
				<%
				    }
					else if (orderstate == 8)
					{
				%>
				<div class="functionButton" id="showToFriends" onclick="">分享给好友</div>
				<%
				    }
				%>
			</div>
		</div>
		<%
		    }
		%>
	</div>
</body>
</html>
