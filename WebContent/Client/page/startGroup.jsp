<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*" import="java.util.*"
	import="com.greenlife.model.*" import="java.text.SimpleDateFormat"
	import="com.greenlife.util.PropertiesUtil"%>
	<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>源来生活</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="../css/startGroup.css" />
<link rel="stylesheet" type="text/css" href="../css/header.css" />
</head>



<body>

	<%
		//获取产品ID，然后显示信息

		int goodsID=Integer.parseInt(request.getParameter("goodsId"));
	

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
	    
	    SimpleDateFormat showSdf = new SimpleDateFormat("yyyy/MM/dd");
	    String endTime = showSdf.format(endDate);
	    
	    String productImg = PropertiesUtil.getPath()+goodsinfo.getPackagePath()+"normal.jpg";
		
	    
	    int targetGoodsId = goodsID;

		if(goodsinfo.getParentId()!=0){
			targetGoodsId = goodsinfo.getParentId();
		}
	%>

	<jsp:include page="header.jsp" />

	<div id="content">


		
		<div id="product" onclick="location.href='productHome.jsp?goodsId=<%=targetGoodsId%>'">
			<div id="productImgDiv"><img id="productImg" src="<%=productImg%>"/></div>
						
			
			</div>
			<div id="productName">
				<%=goodsinfo.getGoodsName()%>
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

			<h2 class="smallTag">*支付开团24小时内，未满2人自动退款</h2>
		</div>


		<div class="functionButton"
			onclick="javascript:location.href='purchase.jsp?group=true&goodsId=<%=goodsID%>'">我要开团</div>


		<img src="../images/howToStartGroup.png" class="startGroupIMG" />


		<div class="detail">
			<h2>详细说明：</h2>
			<p id="detailInfo">
				<%=goodsinfo.getGoodsText2().replace("\n", "<br/>")%>
				
			</p>

		</div>

	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
