<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.*"
	import="com.greenlife.util.PropertiesUtil"
	import="com.greenlife.wechatservice.*"%>
<!DOCTYPE html>
<html>
<head>
<title>源来生活</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="../css/header.css" />
<link rel="stylesheet" type="text/css" href="../css/payForOrder.css" />
<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<body>
	<%
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		
		GoodsOrder orderToShow = GoodsOrderDao.getGoodsOrderById(orderId);		

		
		GoodsInfo goodsinfo = GoodsInfoDao.getGoodsInfo(orderToShow.getGoodsId());
		

		int orderstate = orderToShow.getOrderState();
	%>

	<jsp:include page="header.jsp" />

	<div id="content">

		<div class="topTag" id="orderMessage">

			<div class="bigTag">
				<span class="blackBold">订单详情</span>
			</div>

			<hr class="line" />

			<div class="middleTag">
				<div class="tagLeft">订单号：</div>
				<div class="blackNormalRight" id="orderNumber"><%=orderToShow.getOrderId()%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">名称：</div>
				<div class="blackNormalRight" id="productName"><%=goodsinfo.getGoodsName()%></div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">单价：</div>
				<div class="blackNormalRight" id="productPrice">
					<%
						if (orderstate>10)
						{
							out.write(goodsinfo.getGoodsPrice()+"元");
						}
						else
						{
							out.write("(成团价)" + goodsinfo.getGoodsDiscontPrice()+"元");
							
						}
					%>
				</div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">数量：</div>
				<div class="blackNormalRight" id="goodsAmount"><%=orderToShow.getGoodsNum()%></div>
			</div>

			<hr class="line" />

			<div class="middleTag">
				<div class="tagLeft">快递费：</div>
				<div class="blackNormalRight" id="freight"><%=orderToShow.getMailPrice()%>
					元
				</div>
			</div>

			<div class="middleTag">
				<div class="tagLeft">留言：</div>
				<div class="blackNormalRight" id="leftMessage"><%=orderToShow.getComment()%></div>
			</div>

		</div>


		<div class="topTag">

			<div class="bigTag">
				<span class=blackBold><%=orderToShow.getReceiverName() + "  " + orderToShow.getPhoneNumber()%></span>
			</div>

			<div class="detailLocation">
				<div class="locationIMGAlign">
					<img src="../images/mapMarkerBlack.png" class="locationIMG" />
				</div>
				<div class="blackNormal" id="detailLocationInfo"><%=orderToShow.getAddrDetail()%></div>
			</div>


		</div>

		<div class="topTag" id="payBlock">


			<div id="totalPrice">
				<span class="blackBold" id="totalSym">合计：￥</span><span
					class="orangeText"><%=orderToShow.getTotalPrice()%></span>
			</div>
			<%if(orderstate==1 || orderstate==11){ %>
			<div class="functionButton" id="payButton">支付</div>
			<%} %>
		</div>

	
	</div>
	
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
		
		$(function(){
			if (typeof WeixinJSBridge == "undefined"){
				   if( document.addEventListener ){
				       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
				   }else if (document.attachEvent){
				       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
				       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
				   }
				}else{
				   onBridgeReady();
				}
			
			
			function onBridgeReady(){
				
				
				$("#payButton").click(function(){
					$("#payButton").attr("disabled","disabled");
					$.ajax({
						type: "post",
						url: "/pay",
						data: {
							orderId:<%=orderId%>
						},
						dataType : "json",
						success : function(data) {
							if(data == null){
								alert("服务器异常");
								window.location.reload();
							}else{
								 WeixinJSBridge.invoke(
								       'getBrandWCPayRequest', {
								           "appId":data.appId,     
								           "timeStamp":data.timeStamp,         
								           "nonceStr":data.nonceStr,
								           "package":data.myPackage,     
								           "signType":data.signType,            
								           "paySign":data.paySign 
								       },
								       function(res){   
								    	
								           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
								        	  
								        	   $.ajax({
								        			type: "post",
													url: "/payFinish",
													data: {
														orderId:<%=orderId%>
													},
													dataType : "json",
													success : function(data) {
													
														if(data){
															
															window.location.href="detailOrderMessage.jsp?orderId=<%=orderId%>";
														}else{
															alert("付款失败，请重新付款");
															window.location.reload();
														}
													},
													error : function() {
														alert("网络异常");
														window.location.href="detailOrderMessage.jsp?orderId=<%=orderId%>";
													}
								        	   });
								           }else{
								        	   $('#areaSelect').removeAttr("disabled");
								           }
								       }
								); 
							}
							
						},
						error : function() {
							alert("网络异常");
							$('#areaSelect').removeAttr("disabled");
						}
						
					});
					
				
				});
			}
			
		});	  
		
		
	</script>
</body>
</html>
