<%@page import="com.greenlife.dao.GoodsOrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>源来生活后台管理系统</title>

<%
	double money = GoodsOrderDao.getGoodsOrderMoney();
	
%>

<%@ include file="common.html"%>
</head>
<body style="background-color: #E1E1E1">
	<div class="container-fluid">
		<div class="container-fluid block">
			<div class="navbar navbar-default" style="margin: 0px;">
				<div class="row bg-primary">
					<div class="navbar-header">
						<button class="navbar-toggle" type="button">
							<span class="sr-only">导航菜单</span> <span class="icon-bar"></span>
						</button>
						<a class="navbar-brand navbar-left" style="color: White">源来生活后台管理系统&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>流水量:<%=money%>元</span></a>
						
					</div>
				</div>
			</div>
			<div>
				<nav>
						<ul class="nav nav-pills navbar-right">

							<li class="list-group-item" style="border: 0px"><a
							
								href="product.jsp">商品管理</a></li>
							<li class="list-group-item" style="border: 0px"><a
								href="togroup.jsp">订单管理</a></li>
							<li class="list-group-item" style="border: 0px"><a
								href="user.jsp">用户管理</a></li>
							<li class="list-group-item" style="border: 0px"><a
								href="knowUs.jsp">关于我们</a></li>
						</ul>
					
				</nav>
				</div>
				
				<div class="col-lg-12" id="content">