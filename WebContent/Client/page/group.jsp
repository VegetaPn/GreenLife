<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.greenlife.model.*" import="java.util.*"
    import="com.greenlife.dao.*"
	import="java.text.SimpleDateFormat" import="com.greenlife.util.*"
	import="com.greenlife.wechatservice.*"%>
	
	
<%
	String wechatId = (String)session.getAttribute("wechatId");
	int groupId = Integer.parseInt(request.getParameter("groupId"));

	TodayGroup group = TodayGroupDao.getTodayGroup(groupId);

	String time = group.getStartTime();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
	Date date = sdf.parse(time);
	
	
	
	Calendar calendar =new GregorianCalendar(); 
    calendar.setTime(date); 
    calendar.add(Calendar.DATE,1);
	
    Date endDate = calendar.getTime();
    
    SimpleDateFormat showSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    String endTime = showSdf.format(endDate);
    
	int goodsId = group.getGoodsId();
	String organiserWechatId = group.getWechatId();
	
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
	String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"normal.jpg";
	
	UserInfo organiser = UserInfoDao.getUserInfo(wechatId);
	
	List<GoodsOrder> orderList = GoodsOrderDao.getGoodsOrderListByGroupId(groupId);
	int listSize = orderList.size();
%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UFT-8">
<title>田园生活</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<link rel="stylesheet" href="../css/header.css" type="text/css">
	<link rel="stylesheet" href="../css/group.css" type="text/css">
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

		String appId = (String) session.getAttribute("appid");
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
		                'onMenuShareQQ',
		                'onMenuShareQZone',
		                'chooseImage',
		                'previewImage',
		                'uploadImage',
		                'downloadImage',
		                'chooseWXPay'
		                ]
		});
		
	</script>
	
	
	
		<div id="header">
		<div id="leftButton">
			<img src="../images/leftArrowBlack.png"  onclick="history.back(-1);" />
		</div>
	

		<div id="homeButton">
			<img src="../images/home.png" onclick="location.href='home.jsp'">
		</div>
		
		<div id="title">田园生活</div>
	</div>

	<div id="content">
		<div id="product" onclick="location.href='productHome.jsp?goodsId=<%=goodsId%>'">
			<img id="productImg" src="<%=productImg%>"/>
						
			<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
			</div>
	
	
		<div id="organiser">
			
			<img class="avatar" src="<%=organiser.getPhotoPath()%>"/>
			<span id="desc">发起人：</span>	
			<span id="organiserName"><%=organiser.getWechatName()%></span>
			<span id="priceDesc">成团价：<span id="price"><%=goodsInfo.getGoodsDiscontPrice()%></span>元</span> 
			
				
		</div >	
		
		<div class="interval"></div>	
		
			
		<div id="groupState">
			<div>成团最少人数:<span>2</span></div>
			<div>已参团<span><%=listSize %></span>人</div>
			<div>报名截止：<%=endTime%></div><br/>
			<div>如果报名截止时未成团，将自动退款</div>
			
		</div>
		
		<div id="joinGroupDiv">
			<span id="joinGroup">我要参团</span>
		</div>
		
		
		<div class="interval"></div>	
		
		<div id="label">已参团<hr/></div>
			
		<%
			for(int i=0;i<listSize;i++){
				GoodsOrder order = orderList.get(i);
				UserInfo user = UserInfoDao.getUserInfo(order.getWechatId());
				
				Date tradeDate = sdf.parse(order.getTradeTime());
				String tradeTime = showSdf.format(tradeDate);
			
		%>
			
			<div class="inGroup">
				
			<img class="avatar" src="<%=user.getPhotoPath()%>"/>
			<span class="name"><%=user.getWechatName()%></span>
			<span class="time"><%=tradeTime%></span>  
			<hr/>
				
			</div>
				
		<%
			}
		%>
		
		
		
	
		
	</div>
	
	
	
</body>
</html>