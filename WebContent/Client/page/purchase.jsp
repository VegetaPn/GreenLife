<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.greenlife.model.*"  import="com.greenlife.dao.*" %>
<!DOCTYPE html>

<html>
    <head>
        <title>确认预定</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/purchase.css" type="text/css">
    </head>
    <body>
	
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">确认预定</div>
		</div>
		
		
		<div id="content">
		    <div class="blank"></div>
		    
			<!--第一层用户信息-->
		    <div id="dCusMess">
				<div id="dCusInfor">
				    <div class="top">
						<img src="../images/maleOrange.png"/>
						<span id="sCusName">唐先生</span>
						<img src="../images/phoneOrange.png"/>
						<span id="sPhoneNum">18813090000</span>
					</div>
					<div class="bottom">
						<img src="../images/mapMarkerOrange.png"/>
						<span id="sAddress">北京市海淀区上园村3号</span>
					</div>
				</div>
				<div id="dToAddress">
					<div>></div>
				</div>
			</div>
			
			<!--第二层产品信息-->
			<div id="dProductMess">
			    <div id="dProductImg">
				    <img id="iProductImg" src="../images/product.jpg"/>
				</div>
				<div id="dProductInfor">
				    <p id="pProductName">2015现磨五常稻花香大米</P>
					<p id="pPrice">单价:<span id="sProductPrice">￥99.00</span></p>
				</div>
			</div>
			
			<!--第三层质量检测-->	
			<div id="dQuality">    
				<img id="iQuaLogo" src="../images/quaLogo.png"/>
				<div id="dQualityInfor">
				    <span>已通过<span id="sTestTimes">2333</span>项田园检测</span>
				</div>
				<div id="toQualityInfor">></div>
			</div>
			
			
			<!--第四层购买数量及增减-->
			<div id="dSell">
			    <div class="left"><span>数量:</span></div>
				<div class="middle">
				    <div id="iDecrease">-</div>
					<input type="text" id="iNumber"/>
					<div id="iIncrease">+</div>
				</div>
				<div class="right">
				    <p>x<span id="sNumber">1</span>份</p>
					<p>合计：<span>￥99.00</span></p>
				</div>
			</div>
			
			<!--第五层发货地信息-->
			<div id="dOriAddress">
			    <span class="left">发货地：</span>
				<span id="sOriAddress">北京市东花市北里</span>
				<span id="sPostage">免邮费</span>
			</div>
			
			<!--第六层发货时间信息-->
			<div id="dPostTime">
			    <span>现在订购，预计发货时间：<span id="sPostTime">2015.11.12~04.12</span></span>
			</div>
			
			<div class="blank"></div>
			
			<!--第七层留言-->
			<div id="dMessage">
			    <input type="text" id="iMessage" value="给田园生活留个言"/>
				<span>请在24小时内付款否则订单将取消</span>
			</div>
		</div>
		<!--最底层-->
		<div id="dSubmit">
			<div class="right">
				<input id="iSubmit" type="button" value="确认支付"/>
			</div>
			<div class="left">实付款：<span id="sTotalPrice">￥99.00</span></div>
		</div>
       
    </body>
</html>
