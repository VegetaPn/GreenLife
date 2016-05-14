<%@page
	import="java.util.List,com.greenlife.model.*,com.greenlife.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>待发货</title>
</head>

<body id="body">


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
				订单 <span>&gt;</span> <big><strong>待发货</strong></big>
			</div>
			<!-- Content -->
			<div class="panel-body" >

				<!-- Table -->
				<table aria-describedby="dataTables-example_info" role="grid"
					id="datatable"
					class="table table-striped table-bordered table-hover datatable">
					<thead>
						<tr>
							<th>交易时间</th>
							<th>交易号</th>
							<th>微信昵称</th>
							<th>产品名</th>
							<th>数量</th>
							<th>收货人</th>
							<th>收货地址</th>
							<th>电话</th>
							<th>购买类型</th>
							<th>发货</th>
							<th>取消订单</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="footer.html"></jsp:include>
	<script src="../js/refund.js"></script>
	<script src="../js/send.js"></script>
	<script type="text/javascript" src="../js/list/tosend.js"></script>
</body>



</html>