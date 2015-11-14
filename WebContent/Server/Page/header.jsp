<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
    <title>田园生活后台管理系统</title>
    <link rel="stylesheet" href="../CSS/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="../CSS/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="../CSS/global.css" />
    <script src="../Scripts/jquery-2.1.3.min.js" type="text/jscript"></script>
    <script src="../Scripts/bootstrap.js" type="text/jscript"></script>
    <script src="../Scripts/bootstrap.min.js" type="text/jscript"></script>
	<!-- 在这里写下你的自定义头部信息 -->
</head>
<body style="background-color: #E1E1E1">
    <div class="container-fluid">
		<div class="container-fluid block">
        <div class="navbar navbar-default" style="margin:0px;">
            <div class="row bg-primary">
                <div class="navbar-header">
                    <button class="navbar-toggle" type="button">
                        <span class="sr-only">导航菜单</span> <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand navbar-left" style="color:White">田园生活后台管理系统</a>
                </div>
                <div class="collapse navbar-collapse">
                    <div class="nav navbar-text navbar-right" id="userinfo" runat="server">
                        <!-- 该区域为用户登录区 -->
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid" style="margin:0px; margin-top:25px">
            <div class="col-lg-2">
                <div>
                    <h4><strong>快捷导航</strong></h4>
                    <div class="breaker-10"></div>
                    <div class="breaker-1 bg-color2"></div>
                    <div class="breaker-10"></div>
                    <ol class="list-group list-unstyled" style="border:0px">
                    	<li class="list-group-item" style="border:0px">
                            <a href="product.jsp">商品管理</a>
                        </li>
                        <li class="list-group-item" style="border:0px">
                            <a href="order.jsp">订单管理</a>
                        </li>
                        <li class="list-group-item" style="border:0px">
                            <a href="groupbuy.jsp">团购管理</a>
                        </li>
                        <li class="list-group-item" style="border:0px">
                            <a href="label.jsp">标签管理</a>
                        </li>
                        <li class="list-group-item" style="border:0px">
                            <a href="user.jsp">用户管理</a>
                        </li>
                        <!-- <li class="list-group-item" style="border:0px">
                            <a href="#ADD" class="nav-header collapsed" data-toggle="collapse">
                            	添加 <span class="pull-right glyphicon glyphicon-chevron-toggle"></span></a>
                            <ul id="ADD" class="nav nav-list collapse secondmenu" style="height: 0px;">
                                <li><a href="../PAGES/Unit.jsp"><i class="glyphicon glyphicon-edit"></i>添加单位</a></li>
                                <li><a href="../Master/addUnit.jsp"><i class="glyphicon glyphicon-user"></i>添加测评项</a></li>
                            </ul>
                        </li> -->
                        <!-- <li class="list-group-item" style="border:0px">
                            <a href="../PAGES/voting.jsp">投票进程</a>
                        </li>
                        <li class="list-group-item" style="border:0px">
                            <a href="#VIEW" class="nav-header collapsed" data-toggle="collapse">
                            	查看测评结果<span class="pull-right glyphicon glyphicon-chevron-toggle"></span></a>
                            <ul id="VIEW" class="nav nav-list collapse secondmenu" style="height: 0px;">
                                <li><a href="../Master/CMResult.jsp"><i class="glyphicon glyphicon-family"></i>竞争上岗测评</a></li>
                                <li><a href="../Master/RMResult.jsp"><i class="glyphicon glyphicon-server"></i>等额选举测评</a></li>
                            </ul>
                        </li> -->
                    </ol>
                </div>
            </div>