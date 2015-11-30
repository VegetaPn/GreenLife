<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>个人中心</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/personalCenter.css" type="text/css">
		
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
			</div>
			
			<div class="service">
				<div class="func">
					<div class="icon"><img src="../images/shoppingCart.png"/></div>
					<div class="myFunc">我的订单</div>
					<div class="arrowHead"><img src="../images/rightArrowOrange.png"/></div>
				</div>
				
				<div class="func">
					<div class="icon"><img src="../images/heartfull.png"/></div>
					<div class="myFunc">我的收藏</div>
					<div class="arrowHead"><img src="../images/rightArrowOrange.png"/></div>
				</div>
				
				<div class="undetermined">
					<div class="um"><img src="../images/profileGroup.png"/><span>待成团</span></div>
					<div class="um"><img src="../images/bankCards.png"/><span>待付款</span></div>
					<div class="um"><img src="../images/truck.png"/><span>待发货</span></div>
					<div class="um"><img src="../images/comment.png"/><span>待评论</span></div>
				</div>
				
				
				<div class="func">
					<div class="icon"><img src="../images/mapMarkerOrange.png"/></div>
					<div class="myFunc">收货地址</div>
					<div class="arrowHead"><img src="../images/rightArrowOrange.png"/></div>
				</div>
				
				<div id="quit">
					<div id="logout">退出登录</div>
				</div>
			
			</div>
		</div>
       
    </body>
</html>
