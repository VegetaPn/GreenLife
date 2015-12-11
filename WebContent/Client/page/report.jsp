<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.greenlife.dao.*" import="com.greenlife.model.*"
%>
    
    
<%
	int goodsId = 1;//Integer.parseInt(request.getParameter("goosId"));
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
	String reportPath = goodsInfo.getPackagePath()+"goods/"+goodsInfo.getGoodsId()+ "/report.jpg";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>产品报告</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/report.css" type="text/css">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    </head>
<body>
	<div id="header">
		<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
		<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
		<div id="title">田园生活</div>
	</div>
	<div id="content">
	
		<img id="reportImg" src="<%=reportPath%>"/>
	</div>
</body>
</html>