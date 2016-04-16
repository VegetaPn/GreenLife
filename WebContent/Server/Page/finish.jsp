<%@page
	import="java.util.List,com.greenlife.model.*,com.greenlife.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
<title>已完成订单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.min1.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/bootstrap-responsiv.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/jquery.dataTables.min.css">



<link rel="stylesheet" type="text/css" href="../CSS/jquery-confirm.css">


<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/refund.js"></script>
</head>

<body>

	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		} else {
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="row">
		<button type="button" onClick="location.href='togroup.jsp'"
			class="btn btn-primary">待成团</button>
		<button type="button" onClick="location.href='topay.jsp'"
			class="btn btn-info">待付款</button>
		<button type="button" onClick="location.href='tosend.jsp'"
			class="btn btn-success">待发货</button>

		<button type="button" onClick="location.href='toreceive.jsp'"
			class="btn btn-warning">待收货</button>
		<button type="button" onClick="location.href='finish.jsp'"
			class="btn btn-danger">已完成</button>
	</div>

	<div class="row">
		<!-- Main -->
		<div class="panel panel-default">
			<div class="panel-heading">
				订单 <span>&gt;</span> <big><strong>已完成</strong></big>
			</div>
			<!-- Content -->
			<div class="panel-body">

				<!-- Table -->
				<table aria-describedby="dataTables-example_info" role="grid"
					class="table table-striped table-bordered table-hover datatable"
					id="group">
					<thead>
						<tr>
						<th style="display:none">序号</th>
							<th>时间</th>
							<th>交易号</th>
							<th>微信昵称</th>
							<th>产品名称</th>
							<th>数量</th>
							<th>收货人</th>
							<th>收货地址</th>
							<th>电话</th>
							<th>取消并退款</th>

						</tr>
					</thead>
					<tbody>
						<%
							List<GoodsOrder> GoodsOrderByPerson = GoodsOrderDao.getGoodsOrderListByState(5);//团购订单待收货
								List<GoodsOrder> GoodsOrderByGroup = GoodsOrderDao.getGoodsOrderListByState(14);//个人订单待收货
								String type = "";
								GoodsOrderByGroup.addAll(GoodsOrderByPerson);
								for (int i = 0; i < GoodsOrderByGroup.size(); i++) {
									GoodsOrder oneGoodsOrder = GoodsOrderByGroup.get(i);//被遍历到的商品
									if (oneGoodsOrder.getOrderState() == 5) {
										type = "团购";
									} else {
										type = "个人";
									}
						%>
						<tr class="goods">

							<%
								GoodsInfo g = GoodsInfoDao.getGoodsInfo(oneGoodsOrder.getGoodsId());
										UserInfo user = UserInfoDao.getUserInfo(oneGoodsOrder.getWechatId());
							%>
							<td style="display: none"><%=GoodsOrderByGroup.size() - i%></td>
							<td><%=oneGoodsOrder.getTradeTime()%>
							<td><%=oneGoodsOrder.getPrepayId() %>
							<td><%=user.getWechatName()%></td>
							<td><%=g.getGoodsName()%></td>
							<td><%=oneGoodsOrder.getGoodsNum()%></td>
							<td><%=oneGoodsOrder.getReceiverName()%>
							<td><%=oneGoodsOrder.getAddrDetail()%></td>
							<td><%=oneGoodsOrder.getPhoneNumber()%></td>
							<td><button class="btn btn-danger refund"
									id="<%=oneGoodsOrder.getOrderId()%>">取消并退款</button></td>

						</tr>
						<%
							}
							}
						%>
					
				</table>

			</div>
			<!-- Table -->
		</div>
	</div>

	<jsp:include page="footer.html"></jsp:include>

	<script src="../js/head.js"></script>

	<script type="text/javascript" src="../js/jquery-confirm.js"></script>

	<script type="text/javascript" src="../js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="../js/datatable-zn-sort.js"></script>
</html>
