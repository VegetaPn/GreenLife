<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
<title>源来生活后台管理系统</title>
<link rel="stylesheet" href="../CSS/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="../CSS/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="../CSS/global.css" />
<script src="../Scripts/jquery-2.1.3.min.js" type="text/jscript"></script>
<script src="../Scripts/bootstrap.js" type="text/jscript"></script>
<script src="../Scripts/bootstrap.min.js" type="text/jscript"></script>
<!-- 在这里写下你的自定义头部信息 -->
<style  tyle="text/css">
li a{
font-size:20px;
}
</style>
</head>
<body style="background-color: #E1E1E1">
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		}
	%>
	<div class="container-fluid">
		<div class="container-fluid block">
			<div class="navbar navbar-default" style="margin: 0px;">
				<div class="row bg-primary">
					<div class="navbar-header">
						<button class="navbar-toggle" type="button">
							<span class="sr-only">导航菜单</span> <span class="icon-bar"></span>
						</button>
						<a class="navbar-brand navbar-left" style="color: White">源来生活后台管理系统</a>
					</div>
				</div>
			</div>
			<div>
				<nav class="navbar nav-pills" role="navigation">
					<div class="navbar-header">
						<a class="navbar-brand" href="#">导航</a>
					</div>
					<div>
						<ul class="nav nav-pills">

							<li class="list-group-item" style="border: 0px"><a
							font-size="20"
								href="product.jsp">商品管理</a></li>
							<li class="list-group-item" style="border: 0px"><a
								href="togroup.jsp">订单管理</a></li>
							<li class="list-group-item" style="border: 0px"><a
								href="user.jsp">用户管理</a></li>
							<li class="list-group-item" style="border: 0px"><a
								href="knowUs.jsp">关于我们</a></li>

						</ul>
					</div>
				</nav>

				<div class="col-lg-12" id="content">