<%@page
	import="java.util.List,com.greenlife.model.*,com.greenlife.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>待收货</title>
<script src="../js/datatable-zn-sort.js"></script>
</head>
<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		}
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="navbaroforder.jsp"></jsp:include>

	<div class="row">
		<!-- Main -->
		<div class="panel panel-default">
			<div class="panel-heading">
				订单 <span>&gt;</span> <big><strong>待收货</strong></big>
			</div>
			<!-- Content -->
			<div class="panel-body">

				<!-- Table -->
				<table aria-describedby="dataTables-example_info" role="grid"
					class="table table-striped table-bordered table-hover datatable"
					id="group">
					<thead>
						<tr>

							<th>交易时间</th>
							<td>交易号</td>
							<th>微信昵称</th>
							<th>产品名</th>
							<th>数量</th>
							<th>收货人</th>
							<th>收货地址</th>
							<th>电话</th>
							<th>购买类型</th>

						</tr>
					</thead>
					<tbody>
						<%
							List<GoodsOrder> GoodsOrderByPerson = GoodsOrderDao.getGoodsOrderListByState(4);//团购订单待收货
							List<GoodsOrder> GoodsOrderByGroup = GoodsOrderDao.getGoodsOrderListByState(13);//个人订单待收货
							String type = "";
							GoodsOrderByGroup.addAll(GoodsOrderByPerson);
							for (int i = 0; i < GoodsOrderByGroup.size(); i++) {
								GoodsOrder oneGoodsOrder = GoodsOrderByGroup.get(i);//被遍历到的商品
								if (oneGoodsOrder.getOrderState() == 4) {
									type = "团购("+oneGoodsOrder.getGoodsId()+")";
								} else
									type = "个人";
						%>
						<tr class="goods">

							<%
								//订单对应的用户信息和商品信息
									UserInfo user = UserInfoDao.getUserInfo(oneGoodsOrder.getWechatId());
									GoodsInfo g = GoodsInfoDao.getGoodsInfo(oneGoodsOrder.getGoodsId());
							%>

							<td><%=oneGoodsOrder.getTradeTime() %></td>
							<td><%=oneGoodsOrder.getOutTradeNo() %></td>
							<td><%=user.getWechatName()%></td>
							<td><%=g.getGoodsName()%></td>
							<td><%=oneGoodsOrder.getGoodsNum()%></td>
							<td><%=oneGoodsOrder.getReceiverName()%></td>
							<td><%=oneGoodsOrder.getAddrDetail()%></td>
							<td><%=oneGoodsOrder.getPhoneNumber()%></td>
							<td><%=type%></td>
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
	<script type="text/javascript" src="../js/datatable-zn-sort.js"></script>
</body>


</html>
