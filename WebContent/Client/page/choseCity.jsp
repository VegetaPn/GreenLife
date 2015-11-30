<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>选择城市</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
	    <link rel="stylesheet" href="../css/city.css" type="text/css">
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="title">选择城市</div>
		</div>
		
		<div id="content">
		
		<!-- 在此加入各自的内容物-->
		   <div class="dOutside">
		        <div class="dInside">
				    <div id="dCity">
					    <span id="sCityName">甘肃</span>
					</div>
					
				    <div class="dChildCity">
						<hr/>
					    <span class="sChildCity">兰州</span>
						<span class="toGrandChild">><span>
					</div>
				    
					<div class="dChildCity">
						<hr/>
					    <span class="sChildCity">白银</span>
						<span class="toGrandChild">><span>
						
					</div>
				    
					<div class="dChildCity">
						<hr/>
					    <span class="sChildCity">定西</span>
						<span class="toGrandChild">><span>
						
					</div>
				    
					<div class="dChildCity">
						<hr/>
					    <span class="sChildCity">甘南</span>
						<span class="toGrandChild">><span>	
					</div>
					
					<div class="dChildCity">
						<hr/>
					    <span class="sChildCity">嘉峪关</span>
						<span class="toGrandChild">><span>
					</div>
				</div>
		   </div>
		</div>
       
    </body>
</html>
