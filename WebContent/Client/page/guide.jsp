<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>个人中心</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/guide.css" type="text/css">
		
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">个人中心</div>
		</div>
		
		<div id="content">
			<div id="visitingCard">
				<div id="bgImage"><img src="../images/bg.jpg"/></div>
				<div id="icon"><img src="../images/1.png"/></div>
				<div id="userName">张二狗</div>
				<div id="logout">退出</div>
			</div>
		
			
			<div class="service">
				<div class="func">
					<div class="icon"><img src="../images/home.png"/></div>
					<div class="myFunc">首页</div>
				
				</div>
				
				<div class="func">
					<div class="icon"><img src="../images/person.png"/></div>
					<div class="myFunc">个人中心</div>
				
				</div>
				
				<div class="func">
					<div class="icon"><img src="../images/order.png"/></div>
					<div class="myFunc">订单</div>
				
				</div>
				
				<div class="undetermined">
	
					<div class="um">待成团</div>
				
				</div>
				
				<div class="undetermined">
				
					<div class="um">待付款</div>
				
				</div>
				
				<div class="undetermined">
				
					<div class="um">待发货</div>
				
				</div>
				
				<div class="undetermined">
	
					<div class="um">待评论</div>
				
				</div>
			
			</div>
		</div>
    </body>
</html>
