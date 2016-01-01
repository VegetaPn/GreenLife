<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
import="com.greenlife.dao.*" 
import="com.greenlife.model.*"
import="com.greenlife.services.*" 
import="java.util.*" 
import="com.greenlife.util.*"
import="java.text.ParseException" 
import="java.text.SimpleDateFormat" 
import="java.util.Calendar" 
import="java.util.Date"
%>

<!DOCTYPE html>
<%	
	List<GoodsInfo> goodsList = new ArrayList<GoodsInfo>();
	goodsList = GoodsInfoDao.getGoodsList();
	
	String wechatId = (String)session.getAttribute("wechatId");
	String nickname = (String)session.getAttribute("nickname");
	String headimgurl = (String)session.getAttribute("headimgurl");
%>
<html>
    <head>
        <title>田园生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/home.css" type="text/css">
		<link rel="stylesheet" href="../css/guide.css" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>

		  
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton" onclick="slide()"><img src="../images/menuBar.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">田园生活</div>
		</div>
		
		<div id="content">
		<div id="sildeAd">
			<% 
				for(int i=0;i<goodsList.size();i++){
				//if(goodsList.get(i).getIsAdv() == 0 || goodsList.get(i).getIsAdv() == 1){
					GoodsInfo giIsAdv = goodsList.get(i);
					int idIsAdv = giIsAdv.getGoodsId();
					String ImgIsAdv = PropertiesUtil.getPath()+giIsAdv.getPackagePath()+"normal.jpg";	
					//<%=ImgIsAdv
			%>
			<div class="product" >
			<img id="productImg<%=idIsAdv%>" src=<%=ImgIsAdv%> onclick="javascript:location.href='productHome.jsp?goodsId=<%=idIsAdv%>'"/>
			<div class="productName"><%=giIsAdv.getGoodsName()%></div>
			</div>
		
		<%} %>
		</div>
		<%
		for(int i=0;i<goodsList.size();i++){		
		
			GoodsInfo gi = goodsList.get(i);
			if(GoodsInfoService.getGoodsStatus(gi) != 4){
			int id = gi.getGoodsId();
			String productImg = PropertiesUtil.getPath()+gi.getPackagePath()+"small.jpg";

	
		%>
			<div class="normalProduct" onclick="javascript:location.href='productHome.jsp?goodsId=<%=id%>'">
				<div class="nPic"><img src="<%=productImg%>"/></div>
				<div class="nSellInfo">
					<div class="nName"><%=gi.getGoodsName()%></div>
					<div class="nIntro"><%=gi.getSubTitle()%></div>
					<div class="nCheapprice">￥<%=gi.getGoodsPrice()%><span>/<%=gi.getGoods_unit()%></span>
						</div>
					
					<% 	
						int state = GoodsInfoService.getGoodsStatus(gi);
						String gState = "";
						String gTime = "";
						long time1 = 0;
						long time2 = 0;
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");	
						Calendar cal = Calendar.getInstance();  
						//System.out.println(state);
						switch (state){
						case 0: {
							gState = "未开始";	
							gTime = "距开始";
							cal.setTime(sdf.parse(sdf.format(new Date())));
							time1 = cal.getTimeInMillis();        
							cal.setTime(sdf.parse(gi.getEndTime()));    
							time2 = cal.getTimeInMillis();
							break;
						}
						case 1: {
							gState = "预定中";
							gTime = "剩余时间";
							cal.setTime(sdf.parse(gi.getStartTime()));  
							time1 = cal.getTimeInMillis();    
							cal.setTime(sdf.parse(gi.getEndTime()));
							time2 = cal.getTimeInMillis();    
							break;
						}
						case 2: {
							gState = "已售完";
							break;
							}
					}
				      	       
				        long between_days=(time2-time1)/(1000*3600*24);  

					%>
					<div class="nOrderTime"><%=gState %></div>
					<div class="nOrderTime"><%=gTime%>：<%=between_days%>天</div>
					
				</div>
			</div>
			
			<%
			}}
			%>
			
			
		</div>
	
		
		<div id="guide">
			<div id="visitingCard">
				<div id="bgImage"><img src="../images/bg.jpg"/></div>
				<div id="icon"><img src="<%=headimgurl%>"/></div>
				<div id="userName"><%=nickname %></div>
			</div>
		
			
			<div class="service">
				<div class="func" onclick="javascript:location.href='home.jsp'">
					<div class="icon"><img src="../images/home.png"/></div>
					<div class="myFunc">首页</div>
				
				</div>
				
				<div class="func" onclick="javascript:location.href='personalCenter.jsp'">
					<div class="icon"><img src="../images/person.png"/></div>
					<div class="myFunc">个人中心</div>
				
				</div>
				
				<div class="func" onclick="javascript:location.href='orderList.jsp?whatToShow=4'">
					<div class="icon"><img src="../images/order.png"/></div>
					<div class="myFunc">订单</div>
				
				</div>
				
				<div class="undetermined" onclick="javascript:location.href='orderList.jsp?whatToShow=0'">
	
					<div class="um">待成团</div>
				
				</div>
				
				<div class="undetermined" onclick="javascript:location.href='orderList.jsp?whatToShow=1'">
				
					<div class="um">待付款</div>
				
				</div>
				
				<div class="undetermined" onclick="javascript:location.href='orderList.jsp?whatToShow=2'">
				
					<div class="um">待发货</div>
				
				</div>
				
				<div class="undetermined" onclick="javascript:location.href='orderList.jsp?whatToShow=3'">
	
					<div class="um">待评论</div>
				
				</div>
			
			</div>
			
		</div>
		<div id="gray" onclick="slideOut()"></div>
		
		<script>
	
		$(document).ready(function()
				  {
					var y = document.body.clientWidth;
					var ads = $("#sildeAd").children("div.product");
					//alert(ads.length);
					$.each(ads,function(n,value){
						$(value).width("100%");
						$(value).css("left",y*n + "px");
					
					});
					
					setInterval(function(){
						$.each(ads,function(n,value){
							if(n == (ads.length - 1) && $(value).position().left == 0){								
								$.each(ads,function(n,value){								
									$(value).css("left", n*y + "px");
								});
								//alert(n*y);				
							}
							else{	
								$.each(ads,function(n,value){								
									//$(value).css("display","block");
									var l = $(value).position().left;
									$(value).css("left", l-y + "px");
		
								});
						
							}
						});	
					},5000);
				  });		
					/*
					$("slideAd").on("swipe",function(){
							  //$("span").text("Swipe detected!");
						 $.each(ads,function(n,value){
						$(value).css("display","block");
						var right = $(value).css("right");
						$(value).css("right", right + "px");
						alert(n);
						});
						*/
					
					
		
	
		function slide(){
			var x = document.body.clientHeight ;
			document.getElementById("guide").style.left="0";
			document.getElementById("gray").style.display="block";
			document.getElementById("guide").style.height=x+"px";
			document.getElementById("gray").style.height=x+"px";
			}

       
		function slideOut(){
			document.getElementById("gray").style.display="none";
			document.getElementById("guide").style.left="-70%";
			}
		
		function adjust(){ 
		
			//if(window.orientation==90||window.orientation==-90){ 
			var x = document.body.clientHeight;
			
			document.getElementById("guide").style.height=x+"px";
			document.getElementById("gray").style.height=x+"px";
			
			//} 
			} 
 
		window.addEventListener("onorientationchange" in window ? "orientationchange" : "resize", adjust, false);
		</script>
    </body>
</html>
