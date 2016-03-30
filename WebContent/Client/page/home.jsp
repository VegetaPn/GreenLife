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
import="com.greenlife.wechatservice.*"
%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<%	
	List<GoodsInfo> goodsList = new ArrayList<GoodsInfo>();
	goodsList = GoodsInfoDao.getGoodsListByOrderIndex();
	
	String wechatId = (String)session.getAttribute("wechatId");
	String nickname = (String)session.getAttribute("nickname");
	String headimgurl = (String)session.getAttribute("headimgurl");
	
	
%>
<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
       
		<link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/home.css" type="text/css">
		<link rel="stylesheet" href="../css/guide.css" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>
		<script src="../js/unslider.min.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

		  
    </head>
    <% 
		String jsapi_ticket = (String) session.getAttribute("ticket");
		String noncestr = "abcdefg";
		String timestamp = Long.toString((new Date()).getTime());
		String url = request.getScheme()+"://"+ request.getServerName()+request.getRequestURI();
	 	
	 	if(request.getQueryString() != null){
	 		url = url + "?" + request.getQueryString();
	 	}

		String signature = WechatService.buildSignature(noncestr, jsapi_ticket, timestamp, url);

		String appId = PropertiesUtil.getAppId();
		
		String shareImg = request.getScheme()+"://"+ request.getServerName()+"/Client/images/yuanlai.jpg";
		String shareDesc = "我们拥有绿色农场（北京平谷）和牧场（内蒙古草原腹地），可为中国家庭提供来自源头的自然生态食品。";

    %>
    <script>
		
			
			wx.config({
			    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			    appId: '<%=appId%>', 
			    timestamp: '<%=timestamp%>',
			    nonceStr: '<%=noncestr%>', 
			    signature: '<%=signature%>',
			    jsApiList: [
			                'onMenuShareTimeline',
			                'onMenuShareAppMessage',
			                'chooseImage',
			                'previewImage',
			                'uploadImage',
			                'downloadImage',
			                'chooseWXPay'
			                ]
			});
			
			
			wx.ready(function(){
				
				wx.onMenuShareTimeline({
				    title: '源来生活-<%=shareDesc%>', // 分享标题
				    link: '<%=url%>', // 分享链接
				    imgUrl: '<%=shareImg%>', // 分享图标
				    success: function () { 
				        // 用户确认分享后执行的回调函数
				    },
				    cancel: function () { 
				        // 用户取消分享后执行的回调函数
				    }
				});
				
			
				wx.onMenuShareAppMessage({
				    title: '源来生活', // 分享标题
				    desc: '<%=shareDesc%>', // 分享描述
				    link: '<%=url%>', // 分享链接
				    imgUrl: '<%=shareImg%>', // 分享图标
				    success: function () { 
				        // 用户确认分享后执行的回调函数
				    },
				    cancel: function () { 
				        // 用户取消分享后执行的回调函数
				    }
				});
			});
		
		
	
		</script>
    <body>
		
		<div id="header">
			<div id="leftButton" onclick="slide()"><img src="../images/menuBar.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">源来生活</div>
		</div>
		
		<div id="content" >
		
		<div id="sildeAd" >
			<ul class="product" >
			<% 
				for(int i=0;i<goodsList.size();i++){
				if(goodsList.get(i).getIsAdv() == 1){
					GoodsInfo giIsAdv = goodsList.get(i);
					int idIsAdv = giIsAdv.getGoodsId();
					String ImgIsAdv = PropertiesUtil.getPath()+giIsAdv.getPackagePath()+"normal.jpg";	
					
			%>

			<li><img id="productImg<%=idIsAdv%>" src=<%=ImgIsAdv%> onclick="javascript:location.href='productHome.jsp?goodsId=<%=idIsAdv%>'" ></li>
		
			<!--<div class="productName"> //giIsAdv.getGoodsName()</div>   --> 
	
		  
		<%}} %>
		 </ul>
		</div>  
			
		
		<%
		for(int i=goodsList.size()-1;i>=0;i--){		
		
			GoodsInfo gi = goodsList.get(i);
			if(GoodsInfoService.getGoodsStatus(gi) != 3){
			int id = gi.getGoodsId();
			String productImg = PropertiesUtil.getPath()+gi.getPackagePath()+"small.jpg";
          
	
		%>  
		 <div id="productList">
			<div class="normalProduct" onclick="javascript:location.href='productHome.jsp?goodsId=<%=id%>'">
				<div class="nPic"><img src="<%=productImg%>"/></div>
				<div class="nSellInfo">
					<div class="nName"><%=gi.getGoodsName()%></div>
					<div class="nIntro"><%=gi.getSubTitle()%></div>
					<div class="nCheapprice"><span><%=gi.getGoods_unit()%></span>&nbsp￥<%=gi.getGoodsPrice()%>
						</div>
					
					<% 	
						int state = GoodsInfoService.getGoodsStatus(gi);
						String gState = "";
						String gTime = "";
						long time1 = 0;
						long time2 = 0;
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");	
						Calendar cal = Calendar.getInstance();  
						switch (state){
						case 0: {
							gState = "未开始";	
							gTime = "距开始";
							cal.setTime(sdf.parse(sdf.format(new Date())));
							time1 = cal.getTimeInMillis();        
							cal.setTime(sdf.parse(gi.getStartTime()));    
							time2 = cal.getTimeInMillis();
							break;
						}
						case 1: {
							gState = "预定中";
							gTime = "剩余时间";
							cal.setTime(sdf.parse(sdf.format(new Date())));
							time1 = cal.getTimeInMillis();        
							cal.setTime(sdf.parse(gi.getEndTime()));    
							time2 = cal.getTimeInMillis();
							/*
							cal.setTime(sdf.parse(gi.getStartTime()));  
							time1 = cal.getTimeInMillis();    
							cal.setTime(sdf.parse(gi.getEndTime()));
							time2 = cal.getTimeInMillis();  
							*/
							break;
						}
						case 2: {
							gState = "已售完";
							break;
							}
					}
				      	       
				        long between_days=(time2-time1)/(1000*3600*24);  

					%>
					<!-- <div class="nOrderTime"><%=gState %></div> -->
					<%if(!gState.equals("已售完")){ %>
					<div class="nOrderTime"><%=gTime%>：<%=between_days%>天</div>
					<%} %>
				</div>
			</div>
			
					<%
						if(gState.equals("未开始")){
					%>
						<span class="arcLabel" id="salesState">未开始</span>
						
					<%
						}else if(gState.equals("预定中")){
					%>
						<span class="arcLabel">预定中</span>
					
					<%
						}else if(gState.equals("已售完")){
							
						
					%>
						<span class="sellOutLabel">已售完</span>
					
					<% 
						}
							
					%>
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
					<div class="icon"><img src="../images/blackHome.png"/></div>
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
	
					<div class="um">待收货</div>
				
				</div>
			
			</div>
			
		</div>
		<div id="gray" onclick="slideOut()"></div>
		
		<script>
	
			$(document).ready(function(e) {
			    $('#sildeAd').unslider();
			});
			
			        
			       /*
					var y = document.documentElement.clientWidth;
					var ads = $("#sildeAd").children("div.product");
					//alert(ads.length);
					$.each(ads,function(n,value){
						$(value).width("100%");
						$(value).css("left",y*n + "px");
					
					});
					
					$.each(ads,function(n,value){
						if(n == 0) base = $(value).position().left;
					});

					setInterval(function(){
						
						$.each(ads,function(n, value){
							if(n == (ads.length - 1) && $(value).position().left == 0){								
								$.each(ads, function(n,value){								
									$(value).css("left", base + n*y + "px");
									alert("n" + n + " " + value);
								});
								//alert(n*y);				
							}
							else{
								if(n != (ads.length - 1)){
								$.each(ads, function(n,value){								
									//$(value).css("display","block");
									var l = $(value).position().left;
									$(value).css("left", base + l-y + "px");
								});}
						
							}
						});	
					},5000);
				  });		
		          */
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
		<jsp:include page="footer.jsp" />
    </body>
    <script type="text/Javascript" src="js/example_1.js"></script>

</html>
