<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.greenlife.dao.*" import="com.greenlife.model.*"
    import="com.greenlife.util.*"
    import="com.greenlife.wechatservice.*"
    import="java.util.*"
%>
    <%@ page errorPage="error.jsp"%>
    
<%
	int goodsId = Integer.parseInt(request.getParameter("goodsId"));
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
	
	String reportPath = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"report.jpg";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/report.css" type="text/css">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
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
	
		<img id="reportImg" src="<%=reportPath%>"/>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>