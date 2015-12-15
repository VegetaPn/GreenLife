<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>田园生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/friendDetail.css" type="text/css">
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png" onclick="history.back(-1);" /></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png" onclick="location.href='home.jsp'"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">田园生活</div>
		</div>
		
		<div id="content">
		
			<div id="product">
				<img id="productImg" src="../images/product.jpg"/>
				<div id="productName">
					2015现磨五常稻花香大米
				</div>
			</div>
		
			<div id="totalPurchase">您的好友购买了<span class="purchaseNum">55</span>份<hr/></div>
			
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/1.png"/>
				<span class="name">张二狗</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">10</span>份</span>  
				<hr/>
				
			</div>
			
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/2.png"/>
				<span class="name">张一狗</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">9</span>份</span>  
				<hr/>
				
			</div>
			
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/1.png"/>
				<span class="name">Mary</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">5</span>份</span>  
				<hr/>
				
			</div>
			
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/3.png"/>
				<span class="name">Lily</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">5</span>份</span>  
				<hr/>
				
			</div>
			
			
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/4.png"/>
				<span class="name">张二狗</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">10</span>份</span>  
				<hr/>
				
			</div>
			
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/5.png"/>
				<span class="name">张二狗</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">10</span>份</span>  
				<hr/>
				
			</div>
			
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/2.png"/>
				<span class="name">张二狗</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">10</span>份</span>  
				<hr/>
				
			</div>
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="../images/1.png"/>
				<span class="name">张二狗</span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum">10</span>份</span>  
				<hr/>
				
			</div>
			
			<div id="purchase">
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
		</div>
       
    </body>
</html>
