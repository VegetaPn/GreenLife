<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*" import="java.util.*"
	import="com.greenlife.model.*" import="java.text.SimpleDateFormat"%>
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
	

		goodsID = 1;
		String str_goodsID = request.getParameter("goodsID");
		if (str_goodsID != null)
		{
			goodsID = Integer.parseInt(str_goodsID);
		}

		GoodsInfo goodsinfo = GoodsInfoDao.getGoodsInfo(goodsID);
		
		String time = goodsinfo.getEndTime();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
		Date date = sdf.parse(time);			
		Calendar calendar =new GregorianCalendar(); 
	    calendar.setTime(date); 
	    calendar.add(Calendar.DATE,1);

	    Date endDate = calendar.getTime();
	    
	    SimpleDateFormat showSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    String endTime = showSdf.format(endDate);
	    
		
		
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
		<div id="title">田园生活</div>
	</div>

	<div id="content">


		<div id="product" onclick="location.href='productHome.jsp?goodsId=<%=goodsID%>'">
			
			<img id="productImg" src="../images/product.jpg" />
			

			<div id="productName"><%=goodsinfo.getGoodsName()%></div>
		</div>


		<div class="mainMessage">
			<h2 class="middleTag">
				<span class="blackBold">成团价格：</span><span class="orangeText"
					id="groupPrice"><%=goodsinfo.getGoodsDiscontPrice()%>元</span><span
					class="blackNormal" id="originPrice">（原价：<%=goodsinfo.getGoodsPrice()%>元）
				</span>
			</h2>
			<hr class="line" />

			<h2 class="middleTag">
				<span class="blackBold">发货时间：</span><span class="blackNormal"
					id="deliverTime"><%=endTime%></span>
			</h2>
			<hr class="line" />

			<h2 class="middleTag">
				<span class="blackBold">成团人数：</span><span class="orangeText"
					id="groupPeopleAmount">2</span><span class="blackNormal">（一账户购买多份视为一人）</span>
			</h2>
			<hr class="line" />

			<h2 class="smallTag">*支付开团120小时内，未满2人自动退款</h2>
		</div>


		<div class="functionButton"
			onclick="javascript:location.href='purchase.jsp?group=true&goodsId=<%=goodsID%>'">我要开团</div>


		<img src="../images/howToStartGroup.png" class="startGroupIMG" />


		<div class="detail">
			<h2>详细说明：</h2>
			<p id="detailInfo">
				<%
					out.println(goodsinfo.getGoodsText1() + "<br/>" + goodsinfo.getGoodsText2());
				%>
			</p>

		</div>

	</div>

</body>
</html>
