<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
   import="com.greenlife.model.*"  import="com.greenlife.dao.*" import ="java.util.*"
   import="java.text.*"%>
<!DOCTYPE html>

<%
//String wechatId = (String)session.getAttribute("wechatId");
String wechatId = "huangjianqiang";
//int goodsId = Integer.parseInt(request.getParameter("goodsId"));
int goodsId =1;
GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
Date endTime = sdf.parse(goodsInfo.getEndTime());
Calendar calendar = new GregorianCalendar(); 
calendar.setTime(endTime); 
calendar.add(calendar.DATE,1); 
endTime=calendar.getTime(); 

UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
int addressId = userInfo.getAddrId();
List<AdressInfo> addressInfos = AdressInfoDao.getAdressList(wechatId);
AdressInfo defaultAddressInfo = null;
int index = -1;
String defaultAddr = new String();

for(int i =0; i<addressInfos.size();i++){
	   if(addressInfos.get(i).getAddrId() == addressId){
		   defaultAddressInfo = addressInfos.get(i);
		   index = i;
		   
    	   StringBuffer temp = new StringBuffer();
    	   String[] temps = addressInfos.get(i).getAddrDetail().split(";");
    	   for(int j = 0;j<temps.length; j++){
    		   if(!temps[j].equals("null")){
    			   temp.append(temps[j]+" ");
    		   }
    	   }
    	   defaultAddr = temp.toString();
	   }
}


%>
<html>
    <head>
        <title>确认预定</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/purchase.css" type="text/css">
		<script type="text/javascript" src="../js/purchase.js"></script>
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
						<span id="sCusName"><%=defaultAddressInfo.getReceiverName()%></span>
						<img src="../images/phoneOrange.png"/>
						<span id="sPhoneNum"><%=defaultAddressInfo.getReceiverPhone()%></span>
					</div>
					<div class="bottom">
						<img src="../images/mapMarkerOrange.png"/>
						<span id="sAddress"><%=defaultAddr%></span>
					</div>
				</div>
				<div id="dToAddress">
					<a href="myAddress.jsp"><img id="iToAddress" src="../images/rightArrowCircle3.png" ></a>
				</div>
			</div>
			
			<!--第二层产品信息-->
			<div id="dProductMess">
			    <div id="dProductImg">
				    <img id="iProductImg" src="../images/product.jpg"/>
				</div>
				<div id="dProductInfor">
				    <p id="pProductName"><%=goodsInfo.getGoodsName()%></P>
					<p id="pPrice">单价:<span id="sProductPrice">
					      <%=goodsInfo.getGoodsPrice()%></span>元/<%=goodsInfo.getGoods_unit()%></p>
				</div>
			</div>
			
			<!--第四层购买数量及增减-->
			<div id="dSell">
			    <div class="left"><span>数量:</span></div>
				<div class="middle">
				    <img id="iDecrease" src="../images/minusCommodity.png" onclick="decrease()"/>
					<input type="number" id="iNumber" value="1" onchange ="calculate()"/>
					<img id="iIncrease" src="../images/addCommodity.png" onclick="increase()"/>
				</div>
				<div class="right">
				    <p>x<span id="sNumber">1</span>份</p>
					<p>合计：<span id="stPrice"><%=goodsInfo.getGoodsPrice()%></span></p>
				</div>
			</div>
			
			<!--第六层发货时间信息-->
			<div id="dPostTime">
			    <span>现在订购，发货时间：<span id="sPostTime"><%=sdf.format(endTime)%></span></span>
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
			<div class="left">实付款：<span><span id="sTotalPrice"><%=goodsInfo.getGoodsPrice()%></span>元</span></div>
		</div>
       
    </body>
</html>
