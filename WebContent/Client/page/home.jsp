<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>田园生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/home.css" type="text/css">
		<link rel="stylesheet" href="../css/guide.css" type="text/css">
		
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton" onclick="slide()"><img src="../images/menuBar.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">田园生活</div>
		</div>
		
		<div id="content">
		
		<div id="pushDiv">
			<div id="product">
				<div id="productImgDiv">
					<img id="productImg" src="../images/product.jpg"/>
					<div id="productName">17.8度甜新疆阿克苏苹果</div>
					
				</div>
				<div id="price">
					<div class="cheapPrice">￥7.90<span>/2个</span></div>
					<div class="marketPrice">&#12288;&#12288;超市：￥9.90</div>
				</div>
			</div>
		</div>
			
			
			<div class="normalProduct">
				<div class="nPic"><img src="../images/product.jpg"/></div>
				<div class="nSellInfo">
					<div class="nName">一级香梨</div>
					<div class="nIntro">单果100克1级香梨</div>
					<div class="nCheapprice">￥7.90<span>/5个</span></div>
					<div class="nMarketprice">超市：￥11.90</div>	
					<div class="nFriendorder">你有100位好友订购此产品120份</div>
				</div>
			</div>
			
			<div class="normalProduct">
				<div class="nPic"><img src="../images/product.jpg"/></div>
				<div class="nSellInfo">
					<div class="nName">来自孔雀河的库尔勒一级香梨</div>
					<div class="nIntro">单果100克以上才叫1级香梨</div>
					<div class="nCheapprice">￥7.90<span>/5个</span></div>
					<div class="nMarketprice">超市：￥11.90</div>	
					<div class="nFriendorder">你有100位好友订购此产品100份</div>
				</div>
			</div>
			
			<div class="normalProduct">
				<div class="nPic"><img src="../images/product.jpg"/></div>
				<div class="nSellInfo">
					<div class="nName">来自孔雀河的库尔勒一级香梨</div>
					<div class="nIntro">单果100克以上才叫1级香梨</div>
					<div class="nCheapprice">￥7.90<span>/5个</span></div>
					<div class="nMarketprice">超市：￥11.90</div>	
					<div class="nFriendorder">你有100位好友订购此产品100份</div>
				</div>
			</div>
			
			<div class="normalProduct">
				<div class="nPic"><img src="../images/product.jpg"/></div>
				<div class="nSellInfo">
					<div class="nName">来自孔雀河的库尔勒一级香梨</div>
					<div class="nIntro">单果100克以上才叫1级香梨</div>
					<div class="nCheapprice">￥7.90<span>/5个</span></div>
					<div class="nMarketprice">超市：￥11.90</div>	
					<div class="nFriendorder">你有100位好友订购此产品120份</div>
				</div>
			</div>
		
		</div>
	
		
		<div id="guide">
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
		<div id="gray" onclick="slideOut()"></div>
		
		<script>
		function slide(){
			var x = document.body.clientHeight ;
			document.getElementById("guide").style.left="0";
			document.getElementById("gray").style.display="block";
			document.getElementById("guide").style.height=x+"px";
			document.getElementById("gray").style.height=x+"px";
			}

       
		function slideOut(){
			document.getElementById("gray").style.display="none";
			document.getElementById("guide").style.left="-70vw";
			}
		
		function adjust(){ 
		
			//if(window.orientation==90||window.orientation==-90){ 
			var x = document.body.clientHeight ;
			document.getElementById("guide").style.height=x+"px";
			document.getElementById("gray").style.height=x+"px";
			//alert("aaaaaaaaaaaaaa");
			//} 
			} 
 
		window.addEventListener("onorientationchange" in window ? "orientationchange" : "resize", adjust, false);
		</script>
    </body>
</html>