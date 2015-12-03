<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>收货地址</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/reAddress.css" type="text/css">
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">收货地址</div>
		</div>
		
		<div id="content">
		
			<!-- 在此加入各自的内容物-->
			<div class="blank"></div>
			
			<div class="dPanel">
				<div class="cell">
				   <span>收货人</span><br/>
				   <input type="text" id="iConsignee" class="input" value="张二狗"/>
				</div>
				<div class="cell">
				   <span>手机号码</span><br/>
				   <input type="text" id="iPhnoe" class="input" value="138383838383"/>
				</div>
				<div class="cell">
				   <span>地区信息</span><br/>
				   <input type="text" id="iRegione" class="input" value="北京 北京 海淀区"/>
				</div>
				<div class="cell">
				   <span>详细地址</span><br/>
				   <input type="text" id="iAddress" class="input" value="北京交通大学巴拉巴拉"/>
				</div>
				<div class="cell">
				   <input type="checkbox" id="iCheck">
				   <span>默认地址</span><br/>
				   <input type="button" id="iSure" class="input" value="确认"/>
				</div>						
			</div>
			
		</div>
       
    </body>
</html>
