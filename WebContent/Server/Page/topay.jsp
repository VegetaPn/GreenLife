<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Free CSS template Collect from Cssmoban.com</title>
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.min1.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/bootstrap-responsiv.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/jquery.dataTables.min.css">
</head>

<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/GreenLife/Server/Page/login.jsp");
		}
	%>
<jsp:include page="header.jsp"></jsp:include>
	<div class="row">
		<button type="button" onClick="location.href='togroup.jsp'"
			class="btn btn-primary">待成团</button>
		<button type="button" onClick="location.href='tosend.jsp'"
			class="btn btn-success">待发货</button>
		<button type="button" onClick="location.href='topay.jsp'"
			class="btn btn-info">待付款</button>
		<button type="button" onClick="location.href='toreceive.jsp'"
			class="btn btn-warning">待收货</button>
		<button type="button" onClick="location.href='finish.jsp'"
			class="btn btn-danger">已完成</button>
	</div>

	<div class="row">
		<!-- Main -->
		<div class="panel panel-default">
			<div class="panel-heading">
				订单 <span>&gt;</span> <big><strong>待付款</strong></big>
			</div>
			<!-- Content -->
			<div class="panel-body">

				<!-- Table -->
				<table aria-describedby="dataTables-example_info" role="grid"
					class="table table-striped table-bordered table-hover datatable"
					id="group">
					<thead>
						<tr>
							<th width="13"><input type="checkbox" class="checkbox" /></th>
							<th>订单号</th>
							<th>微信号</th>
							<th>产品ID</th>
							<th>地址ID</th>
							<th>数量</th>
							<th>发货时间</th>
							<th>总价</th>

						</tr>
					</thead>
					<tbody>
						<tr role="row" class="gradeU event">
							<td><input type="checkbox" class="checkbox" /></td>
							<td>232423593</td>
							<td>MXDJ890</td>
							<td>gdsgd</td>
							<td>fiweg</td>
							<td>1</td>
							<td>15.11.30</td>
							<td>300</td>
						</tr>
						<tr role="row" class="gradeU odd">
							<td><input type="checkbox" class="checkbox" /></td>
							<td>232423593</td>
							<td>MXDJ890</td>
							<td>gdsgd</td>
							<td>fiweg</td>
							<td>1</td>
							<td>15.11.30</td>
							<td>300</td>
						</tr>
				</table>

			</div>
			<!-- Table -->
		</div>
	</div>
<jsp:include page="footer.html"></jsp:include>
	<!-- End Footer -->
	<script type="text/javascript"
		src="http://sandbox.runjs.cn/uploads/rs/238/n8vhm36h/jquery.js"></script>
	<script type="text/javascript"
		src="http://sandbox.runjs.cn/uploads/rs/238/n8vhm36h/jquery.dataTables.js"></script>
	<script type="text/javascript"
		src="http://sandbox.runjs.cn/uploads/rs/238/n8vhm36h/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="http://sandbox.runjs.cn/uploads/rs/238/n8vhm36h/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="../js/datatable-zn.js"></script>

</body>

</html>