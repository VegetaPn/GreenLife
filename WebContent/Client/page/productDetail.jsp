<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="com.greenlife.dao.*" import="com.greenlife.model.*" import="java.util.*"
    import="com.greenlife.util.PropertiesUtil"
    import="com.greenlife.wechatservice.*"
%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>

<%
	String wechatId = (String)session.getAttribute("wechatId");
	int goodsId = Integer.parseInt(request.getParameter("goodsId"));
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
	String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"normal.jpg";
	String detailPath = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"detail.jpg";
%>


<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/productDetail.css" type="text/css">
		<link rel="stylesheet" href="../css/header.css" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>

	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    </head>
    <body>
    
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
	
		<jsp:include page="header.jsp" />
		
		<div id="content">
		
		
			<div id="product" onclick="location.href='productHome.jsp?goodsId=<%=goodsId%>'">
			<div id="productImgDiv"><img id="productImg" src="<%=productImg%>"/></div>
						
			<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
			</div>
		
			<img id="detailImg" src="<%=detailPath%>"/>
			<!--  
			<div class="details">
			    <span>产品标准:</span>
				<p>介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字</p>
				<div class="dPic"><img src="../images/product.jpg"/></div>
				</div>
				<br/>
			
			<div class="details">
			    <span>商家介绍:</span>
				<p>介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字</p>
				<div class="dPic"><img src="../images/product.jpg"/></div>
				</div>
				<br/>
				
			<div class="details">
			    <span>产品调查:</span>
				<p>介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字</p>
				<div class="dPic"><img src="../images/product.jpg"/></div>
				</div>
				<br/>
			</div>
			-->
			
			
		
		</div>
       <jsp:include page="footer.jsp" />
    </body>
</html>
