<%@page
	import="java.util.List,com.greenlife.model.*,com.greenlife.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>待成团</title>
</head>

<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		}
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
		<button type="button" onClick="location.href='refund.jsp'"
			class="btn btn-primary">已退款</button>
	</div>

	<div class="row">
		<!-- Main -->
		<div class="panel panel-default">
			<div class="panel-heading">
				订单 <span>&gt;</span> <big><strong>待成团</strong></big>
			</div>
			<!-- Content -->
			<div class="panel-body">

				<!-- Table -->
				<table aria-describedby="dataTables-example_info" role="grid"
					class="table table-striped table-bordered table-hover datatable"
					id="group">
					<thead>
						<tr>
							<th style="display: none">序号</th>
							<th>下单时间</th>
							<th>交易号</th>
							<th>微信昵称</th>
							<th>产品名</th>
							<th>数量</th>
							<th>收货人</th>
							<th>收货地址</th>
							<th>电话</th>
						</tr>
					</thead>
					<tbody>

						<%
								List<GoodsOrder> allGoodsOrder = GoodsOrderDao.getGoodsOrderListByState(2);//获得所有商品列表
								for (int i = 0; i < allGoodsOrder.size(); i++) {
									GoodsOrder oneGoodsOrder = allGoodsOrder.get(i);//被遍历到的商品	
							%>
						<tr class="goods">


							<% //订单对应的用户信息和商品信息
							   UserInfo user=UserInfoDao.getUserInfo(oneGoodsOrder.getWechatId());
							   GoodsInfo g=GoodsInfoDao.getGoodsInfo(oneGoodsOrder.getGoodsId());
							   
							%>
							<td style="display: none"><%=allGoodsOrder.size() - i%></td>
							<td><%=oneGoodsOrder.getTradeTime() %></td>
							<td><%=oneGoodsOrder.getPrepayId()%></td>
							<td><%=user.getWechatName()%></td>
							<td><%=g.getGoodsName() %></td>
							<td><%=oneGoodsOrder.getGoodsNum() %></td>
							<td><%=oneGoodsOrder.getReceiverName() %></td>
							<td><%=oneGoodsOrder.getAddrDetail() %></td>
							<td><%=oneGoodsOrder.getPhoneNumber() %></td>
						</tr>
						<%
								}
							%>
					</tbody>
				</table>

			</div>
			<!-- Table -->
		</div>
	</div>
	<jsp:include page="footer.html"></jsp:include>

</html>
