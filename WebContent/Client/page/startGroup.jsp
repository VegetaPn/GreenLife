<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*"%>
<!DOCTYPE html>
<html>
<head>
<title>田园生活</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="../css/startGroup.css" />
<link rel="stylesheet" type="text/css" href="../css/header.css" />
</head>



<body>

	<%
		//获取产品ID，然后显示信息
		int goodsID=Integer.parseInt(request.getParameter("goodsId"));
	
		GoodsInfo goodsinfo = GoodsInfoDao.getGoodsInfo(goodsID);
	
	
	
	
	
	%>




	<div id="header">
		<div id="leftButton">
			<img src="../images/leftArrowBlack.png" />
		</div>
		<!-- 左上角功能键：返回、或是菜单按键-->

		<div id="homeButton">
			<img src="../images/home.png">
		</div>
		<!-- 右上角功能键，其实就是主页按钮-->
		<div id="title">我要开团</div>
	</div>

	<div id="content">


		<div id="product">
			<div id="productImgDiv">
				<img id="productImg" src="../images/product.jpg" />
			</div>

			<div id="productName"><%=goodsinfo.getGoodsName()%></div>
		</div>


		<div class="mainMessage">
			<h2 class="middleTag">
				<span class="blackBold">成团价格：</span><span class="orangeText"
					id="groupPrice"><%=goodsinfo.getGoodsDiscontPrice()%>元</span><span class="blackNormal"
					id="originPrice">（原价：<%=goodsinfo.getGoodsPrice()%>元）</span>
			</h2>
			<hr class="line" />

			<h2 class="middleTag">
				<span class="blackBold">发货时间：</span><span class="blackNormal"
					id="deliverTime">2015.11.12-2016.04.12</span>
			</h2>
			<hr class="line" />

			<h2 class="middleTag">
				<span class="blackBold">成团人数：</span><span class="orangeText"
					id="groupPeopleAmount">2</span><span class="blackNormal">（一账户购买多份视为一人）</span>
			</h2>
			<hr class="line" />

			<h2 class="smallTag">*支付开团120小时内，未满2人自动退款</h2>
		</div>


		<div class="functionButton" >我要开团</div>


		<img src="../images/howToStartGroup.bmp" class="startGroupIMG" />


		<div class="detail">
			<h2>详细说明：</h2>
			<p id="detailInfo">如此这般，这里那里，就是这样，以上以上，好的好的,233,how are
				you,我是谁，我在哪里</p>

		</div>

	</div>

</body>
</html>
