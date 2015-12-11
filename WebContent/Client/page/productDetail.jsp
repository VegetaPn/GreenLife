<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="com.greenlife.dao.*" import="com.greenlife.model.*" import="java.util.*"
    import="com.greenlife.util.PropertiesUtil"
%>

<!DOCTYPE html>

<%
	String wechatId = (String)session.getAttribute("wechatId");
	wechatId = "huangjianqiang";//测试
	int goodsId = 1;//Integer.parseInt(request.getParameter("goosId"));
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
	String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"normal.jpg";
	String detailPath = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"detail.jpg";
%>


<html>
    <head>
        <title>产品详情</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/productDetail.css" type="text/css">
		<link rel="stylesheet" href="../css/header.css" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>
    </head>
    <body>
	
		 <div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">产品详情</div>
		</div>
		
		<div id="content">
		
		
			<div id="product">
			<div id="productImgDiv"><img id="productImg" src="<%=productImg%>"/></div>
						
			<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
			</div>
		
			<img id="detailImg" src="<%=detailPath%>"/>
			<!--  
			<div class="details">
			    <span>产品标准:</span>
				<p>介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字</p>
				<div class="dPic"><img src="../images/product.jpg"/></div>
				</div>
				<br/>
			
			<div class="details">
			    <span>商家介绍:</span>
				<p>介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字</p>
				<div class="dPic"><img src="../images/product.jpg"/></div>
				</div>
				<br/>
				
			<div class="details">
			    <span>产品调查:</span>
				<p>介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字</p>
				<div class="dPic"><img src="../images/product.jpg"/></div>
				</div>
				<br/>
			</div>
			-->
			
			
		
		</div>
       
    </body>
</html>
