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
		
		int whatToShow = 4;
		String showtype = request.getParameter("whatToShow");
		if (showtype != null)
		{
			whatToShow = Integer.parseInt(showtype);
		}

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
			<div class="functionButton" id="payButton">支付</div>
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
		
		String prepayId = "wx20151231213205f4b66e72470696597124";
		String wxPackage = "prepay_id="+prepayId;
		String signType = "MD5";
		
		List<String> strs = new ArrayList<String>();
		
		strs.add("appId=" + appId);
		strs.add("timeStamp=" + timestamp);
		strs.add("nonceStr=" + noncestr);
		strs.add("package=" + wxPackage);
		strs.add("signType=" + signType);
		
		String paySign = WechatService.MD5Signature(strs);
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
					 WeixinJSBridge.invoke(
						       'getBrandWCPayRequest', {
						           "appId" : "<%=appId%>",     //公众号名称，由商户传入     
						           "timeStamp":"<%=timestamp%>",         //时间戳，自1970年以来的秒数     
						           "nonceStr" : "<%=noncestr%>", //随机串     
						           "package" : "<%=wxPackage%>",     
						           "signType" : "<%=signType%>",         //微信签名方式：     
						           "paySign" : "<%=paySign%>" //微信签名 
						       },
						       function(res){     
						           if(res.err_msg == "get_brand_wcpay_request：ok" ) {
						        	   alert("a");
						           }     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
						       }
						   ); 
				});
			}
			
		});	  
		
		
	</script>
</body>
</html>
