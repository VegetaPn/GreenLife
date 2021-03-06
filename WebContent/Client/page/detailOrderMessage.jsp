<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.*"
	import="java.util.Properties" import="com.greenlife.util.*"
	import="java.text.SimpleDateFormat"%>
	<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>源来生活</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link rel="stylesheet" type="text/css" href="../css/header.css" />
<link rel="stylesheet" type="text/css"
	href="../css/detailOrderMessage.css" />
<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>


</head>
<body>
	<%
		int orderId = Integer.parseInt(request.getParameter("orderId"));

		GoodsOrder orderToShow = GoodsOrderDao.getGoodsOrderById(orderId);

		GoodsInfo goodsinfo = GoodsInfoDao.getGoodsInfo(orderToShow.getGoodsId());
		int goodsId = goodsinfo.getGoodsId();
		int orderstate = orderToShow.getOrderState();

		String productImg = PropertiesUtil.getPath() + goodsinfo.getPackagePath() + "normal.jpg";

		String time = orderToShow.getSendTime();
		
		
		int targetGoodsId = goodsId;

		if(goodsinfo.getParentId()!=0){
			targetGoodsId = goodsinfo.getParentId();
		}
	%>

	<jsp:include page="header.jsp" />

	<div id="content">



		<div id="product"
			onclick="location.href='productHome.jsp?goodsId=<%=targetGoodsId%>'">


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
							if (orderstate > 10)
							{
								out.write(goodsinfo.getGoodsPrice() + "元/"+goodsinfo.getGoods_unit());
							}
							else
							{
								out.write("(成团价)" + goodsinfo.getGoodsDiscontPrice() + "元/"+goodsinfo.getGoods_unit());

							}
						%>
					</div>
				</div>
				
				<div class="middleTag">
					<div class="tagLeft">购买数量：</div>
					<div class="blackNormal" id="purchaseNum"><%=orderToShow.getGoodsNum()%>份</div>
				</div>

				<%
					if(orderToShow.getMailPrice() == 0){
				%>
				
				
				<div class="middleTag">
					<div class="tagLeft">运费：</div>
					<div class="blackNormal" id="freight">免运费
					</div>
				</div>

				<%
					}else{
						
					
				%>
				<div class="middleTag">
					<div class="tagLeft">运费：</div>
					<div class="blackNormal" id="freight"><%=orderToShow.getMailPrice()%>元
					</div>
				</div>
				
				<%
				
					}
				%>

				<div class="middleTag">
					<div class="tagLeft">实付款：</div>
					<div class="orangeText" id="paid"><%=orderToShow.getTotalPrice()%>元</div>
				</div>

				<div class="middleTag">
					<div class="tagLeft">预计发货时间：</div>
					<div class="blackNormal" id="timeToDeliver"><%=time%></div>
				</div>
			</div>


			

			<%
				if (orderstate == 1 || orderstate == 11)
				{
					//待付款
			%>
			
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">待付款</div>
				</div>
			<%
				}
				else if (orderstate == 2)
				{
					//待成团
			%>
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">待成团</div>
				</div>
			<%
				}
				else if (orderstate == 3)
				{
					//待发货
			%>
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">参团成功,待发货</div>
				</div>
				
			
			<%
				}else if(orderstate == 12){
					
				
			
			%>
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">待发货</div>
				</div>
				
			<% 
				}else if(orderstate == 4 || orderstate == 13){
			
			%>
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">待收货</div>
				</div>
			<%
				}
				else if (orderstate == 5 || orderstate == 14)
				{
			%>
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">交易成功</div>
				</div>
			<%
				}else if(orderstate == 8 || orderstate == 18){
					
				
			%>
			
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">已退款</div>
				</div>
			
			<%
				}else if(orderstate == 9 || orderstate == 19){
			%>
			
				<div class="middleTag">
					<div class="tagLeft">订单状态：</div>
					<div class="blackNormal" id="orderState">已取消</div>
				</div>
			<%	
				}
			%>
		</div>

		<%
			if(orderstate != 9 && orderstate != 19 && orderstate != 12){
		
		%>

		<div class="moreMessage">
			

			<%
				if (orderstate == 1 || orderstate == 11)
				{
					//待付款
			%>
			<div class="functionButton"
				onclick="javascript:location.href='payForOrder.jsp?orderId=<%=orderToShow.getOrderId()%>'">去付款</div>
			<div id="cancelOrder" class="functionButton">取消订单</div>
			<script>
				$(function(){
					$("#cancelOrder").one("click",function(){
						$.ajax({
							type: "post",
							url: "/cancelOrder",
							data: {
								orderId:<%=orderId%>
							},
							dataType : "json",
							success : function(data) {
								if(data){
									window.location.reload();
								}else{
									alert("取消订单失败，服务器异常");
									window.location.reload();
								}
								
							},
							error : function() {
								alert("网络异常");
								window.location.reload();
							}
						});
					});
				});
			</script>
			<%
				}
				else if (orderstate == 2)
				{
					//待成团
			%>
				<div class="functionButton"
				onclick="location.href='group.jsp?groupId=<%=orderToShow.getGroupId()%>'">约好友成团</div>

			<%
				}
				else if (orderstate == 3)
				{
					//待发货
			%>
				<div class="functionButton"
				onclick="location.href='group.jsp?groupId=<%=orderToShow.getGroupId()%>'">邀请好友参团</div>
			<%
				}else if(orderstate == 4 || orderstate == 13){
			
			%>
			
				<div class="functionButton" id="confirmReceive">确认收货</div>
				<script>
				$(function(){
					$("#confirmReceive").one("click",function(){
						$.ajax({
							type: "post",
							url: "/confirmReceive",
							data: {
								orderId:<%=orderId%>
							},
							dataType : "json",
							success : function(data) {
								if(data){
									window.location.reload();
								}else{
									alert("确认收货失败，服务器异常");
									window.location.reload();
								}
								
							},
							error : function(jqXHR, textStatus, errorThrown) {
								alert("网络异常");
							    
					   
								window.location.reload();
							}
						});
					});
				});
			</script>
			<% 
				}
				else if (orderstate == 5 || orderstate == 14)
				{
			%>
				<div class="functionButton" onclick="location.href='comment.jsp?goodsId=<%=targetGoodsId%>'">我来说两句</div>
	
			<%
				}
			%>
		
		</div>

		<%
			}
		
		%>

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
	<jsp:include page="footer.jsp" />
</body>
</html>
