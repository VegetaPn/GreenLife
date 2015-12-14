<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>示例</title>
</head>
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.min1.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/bootstrap-responsiv.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/jquery.dataTables.min.css">
<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/GreenLife/Server/Page/login.jsp");
		}
	%>
	<jsp:include page="header.jsp"></jsp:include>


	<div class="panel">
		<div class="panel-heading ">
			信息管理 <span>&gt;</span> 用户列表
		</div>

		<div class="panel-body ">

			<table
				class="table table-striped table-bordered table-hover datatable ">
				<thead>
					<tr>
						<th>用户微信号</th>
						<th>用户微信昵称</th>
						<th>手机号</th>
						<th width="110 " class="ac ">好友</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>
					</tr>
					<tr>

						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>

					</tr>
					<tr>

						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>
					</tr>
					<tr>

						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>
					</tr>
					<tr>

						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>
					</tr>
					<tr>

						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>
					</tr>
					<tr>

						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>
					</tr>
					<tr class="odd ">

						<td><a href="# ">STRS78998</a></td>
						<td>小宝</td>
						<td><a href="# ">132239842395</a></td>
						<td>a</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="footer.html"></jsp:include>
	<script src="../js/jquery.min.js"></script>
	<script src="../js/head.js"></script>
	<script type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="../js/datatable-zn.js"></script>

</body>
</html>