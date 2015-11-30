<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>产品主页</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/productHome.css">
		
    </head>
    <body>
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">产品主页</div>
		</div>
		
		<div id="content">
	
	
		<div id="product">
			<div id="productImgDiv"><img id="productImg" src="../images/product.jpg"/></div>
			<span class="arcLabel" id="salesState">进行中</span>
			<span class="arcLabel" id="orderNum">订单数：387</span>
			<img id="heart" src="../images/collect.png"/>
			<div id="productName">
				2015现磨五常稻花香大米
			</div>
		</div>
		<div id="productInfo">
			<div id="infoDesc">
			
			<hr/>
			
			<span class="descFont">田园生活黏度最畅销产品</span><br/><br/>
			<span class="descFont">通过ISO9001国际认证</span><br/><br/>
			<span class="descFont">在《舌尖上的中国中播出》的产品</span><br/><br/>
			<span class="descFont">中国羽毛球队指定唯一产品</span><br/><br/>
			<div href="#" class="link">项目详情 ></div>
			
			</div>
		</div>
		
		<div class="grayDiv">
			<div  id="friendPurchase">
				<div class="labelHeader">
					<div class="whiteDiv"></div>
					<span class="label">我的朋友订购了<span id="purchaseNum">21</span>份</span>
				</div>
				
				
				<div id="purchaseDetail" onclick="window.location.href='#'">
					<div class="personalPurchaseDiv"><img class="avatar" src="../images/1.png"><br/>10</div>
					<div class="personalPurchaseDiv"><img class="avatar" src="../images/2.png"><br/>4</div>
					<div class="personalPurchaseDiv"><img class="avatar" src="../images/3.png"><br/>3</div>
					<div class="personalPurchaseDiv"><img class="avatar" src="../images/4.png"><br/>2</div>
					<div class="personalPurchaseDiv"><img class="avatar" src="../images/5.png"><br/>2</div>
					<a  class="link" id="friendLink">></a>
				</div>
				
			</div>
			
			<div class="labelHeader" id="productSalesPrice">
				
				<div class="whiteDiv"></div>
				<span class="label">99元10斤</span>
				
			</div>
		
			
			
		
		</div>
		
		<div class="grayDiv" id="salesProductImgDiv">
			<img id="salesProductImg" src="../images/product.jpg"/>
		</div>
		
		<div class="grayDiv" id="LastGrayDiv">
			<div id="productSalesInfo">
				<div id="salesInfo">
				<span class="titleFont">产品品种：</span><span class="descFont">稻花香2号</span><br/>
				<span class="titleFont">产品产地：</span><span class="descFont">黑龙江五常</span><br/>
				<span class="titleFont">产品特征：</span><span class="descFont">不惨假；现磨不抛光</span><br/>
				<span class="titleFont">产品规格：</span><span class="descFont">10斤</span><br/>
				<span class="titleFont">包装说明：</span><span class="descFont">10斤/袋，真空包装</span><br/>
				<span class="titleFont">生产日期：</span><span class="descFont">2015年10月</span><br/>
				<span class="titleFont">发货地点：</span><span class="descFont">五常</span><br/>
				</div>
			
			
				<div id="teamPurchase" onclick="window.location.href='#'">
					<div class="salesPrice" id="teamPrice">
						89.00元/份
					</div>
					<div class="purchaseLink">
						2人团>
					</div >
				</div>
				
				<div id="personalPurchase" onclick="window.location.href='#'">
					<div  class="salesPrice"  id="personalPrice">
						99.00元/份
					</div>
					<div class="purchaseLink">
						单独预定
					</div >
				</div>
			
			</div>
			
			
			
			
			<div id="productQuality">
				<div id="qualityContent">
					<div id="qualityLogo">
						<img id="qualityLogoImg" src="../images/quaLogo.png"/>
						
					</div>
					<div id="qualityInfo">
						<span id="qualityFont">已通过2333项田园检测</span><br/><br/>
						<span id="qualityLink">查看检测详情></span>
					</div>
				</div>
			</div>
			
			
			
			<div id="productComment">
				<div class="labelHeader">
					<div class="whiteDiv"></div>
					<span class="label" id="commentLabel">产品评价（35条）</span>
				</div>
				<div id="commentContent">
					<div id="commentInfo">
						<div>
							<div class="avatarDiv"><img class="avatar" src="../images/1.png"/></div>
	
							<div class="name">秦始皇</div>
							<div class="time">一天前</div>
						</div>
						
						
						<div class="comment">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet.</div>
						<hr/>	
						
						<div>
							<div class="avatarDiv"><img class="avatar" src="../Images/2.png"/></div>
	
							<div class="name">姚晨</div>
							<div class="time">两天前</div>
						</div>
						
						
						<div class="comment">
						Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar
						tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
						Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus sapien 
						nunc eget odio.
						<br/>
						<img class="commentImg" src="../images/product.jpg"/>
						</div>
						<hr/>	
						
						
					</div>
					
					
					<div id="commentLinkDiv">
					
					<a id="commentLink">我来说两句</a>
					
					</div>
				</div>
			</div>
		</div>
		</div>
    </body>
</html>
