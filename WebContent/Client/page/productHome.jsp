<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.*"
	import="java.text.SimpleDateFormat" import="com.greenlife.util.*"
	import="com.greenlife.wechatservice.*"
	import="com.greenlife.services.*"%>


<%
	String wechatId = (String) session.getAttribute("wechatId");
	
	int goodsId = Integer.parseInt(request.getParameter("goodsId"));
	
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
	Date startTime = sdf.parse(goodsInfo.getStartTime());
	Date endTime = sdf.parse(goodsInfo.getEndTime());
	Date date = new Date();
	String salesState = null;

	int status = GoodsInfoService.getGoodsStatus(goodsInfo);
	
	
	if(status == 0){
		salesState = "未开始";
	}
	if(status == 1){
		salesState = "预定中";
	}
	if(status == 2){
		salesState = "已售完";
	}
	if(status == 3){
		salesState = "已下架";
	}

	
	String productImg = PropertiesUtil.getPath() + goodsInfo.getPackagePath() + "normal.jpg";
	String smallProductImg = "http://"+PropertiesUtil.getURL()+PropertiesUtil.getPath() + goodsInfo.getPackagePath() + "small.jpg";
	
	int orderNum = GoodsOrderDao.getGoodsOrderNum(goodsId);

	int reportNum = goodsInfo.getReportNum();

	List<Comment> commentList = CommentDao.getCommentList(goodsId);

	int commentListSize = commentList.size();
%>

<!DOCTYPE html>

<html>
<head>
<title>源来生活</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link rel="stylesheet" href="../css/header.css" type="text/css">
<link rel="stylesheet" href="../css/productHome.css">
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
	%>

	<jsp:include page="header.jsp" />

	

	<div id="content">

		<div id="prompt"><span>关注成功</span></div>
		<div id="product">

			
			<img id="productImg" src="<%=productImg%>" />
			
			<span class="arcLabel" id="salesState"><%=salesState%></span> <span
				class="arcLabel" id="orderNum">订单数：<%=orderNum%></span>
			<script>var isCollected = false;</script>

			
			<%
				boolean isConcerned = false;

				List<Integer> concerdedGoodsList = ConcernedListDao.getGoodsList(wechatId);
				for (Integer concerdedGoodsId : concerdedGoodsList) {
					if (goodsId == concerdedGoodsId) {
						isConcerned = true;
					}
				}
				if (!isConcerned) {
			%>
			<img id="heart" src="../images/noCollect.png" />

			<%
				} else {
			%>
			
			<img id="heart" src="../images/collect.png" />
			<script>isCollected = true;</script>
			<%
				}
			%>

			<script>
			
			
			
			$(document).ready(function(){
 				 $("#heart").click(function(){
	   			 	 $.ajax({
	    				type: "post",//数据提交的类型（post或者get）
	       				url: "/collect",//数据提交得地址
	        			data: {goodsId: "<%=goodsId%>",isCollected : isCollected},//提交的数据(自定义的一些后台程序需要的参数)
						dataType : "text",//返回的数据类型
						success : function(
								data) {//请求成功后返执行的方法
							if (!isCollected) {
								isCollected = true;
								$("#prompt").html("<span>关注成功</span>");
								$("#prompt").show();
								setTimeout("$('#prompt').hide()",1000);
								$("#heart").attr('src',"../images/collect.png");
							} else {
								isCollected = false;
								$("#prompt").html("<span>取消关注</span>");
								$("#prompt").show();
								setTimeout("$('#prompt').hide()",1000);
								$("#heart").attr('src',"../images/noCollect.png");
							}
						},
						error : function() {
							alert("网路异常");
						}
					});
					});
				});
			</script>

			<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
		</div>
		
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
				    title: '源来生活-<%=goodsInfo.getGoodsName()%>', // 分享标题
				    link: '<%=url%>', // 分享链接
				    imgUrl: '<%=smallProductImg%>', // 分享图标
				    success: function () { 
				        // 用户确认分享后执行的回调函数
				    },
				    cancel: function () { 
				        // 用户取消分享后执行的回调函数
				    }
				});
				
			
				wx.onMenuShareAppMessage({
				    title: '源来生活-<%=goodsInfo.getGoodsName()%>', // 分享标题
				    desc: '<%=goodsInfo.getSubTitle()%>', // 分享描述
				    link: '<%=url%>', // 分享链接
				    imgUrl: '<%=smallProductImg%>', // 分享图标
				    success: function () { 
				        // 用户确认分享后执行的回调函数
				    },
				    cancel: function () { 
				        // 用户取消分享后执行的回调函数
				    }
				});
			});
		
		
	
		</script>
		
		
		
		
		<div id="productInfo">
			<div id="infoDesc">

				<hr />
				<%=goodsInfo.getGoodsText1()%>
				<!--  
			<span class="descFont">田园生活黏度最畅销产品</span><br/><br/>
			<span class="descFont">通过ISO9001国际认证</span><br/><br/>
			<span class="descFont">在《舌尖上的中国中播出》的产品</span><br/><br/>
			<span class="descFont">中国羽毛球队指定唯一产品</span><br/><br/>
			-->
				<div class="link" onclick="location.href='productDetail.jsp?goodsId=<%=goodsId%>'">项目详情 ></div>

			</div>
		</div>

		<div class="grayDiv">
		
			<!--  
			<div id="friendPurchase">
				<div class="labelHeader">
					<div class="whiteDiv"></div>
					<span class="label">我的朋友订购了<span id="purchaseNum">21</span>份
					</span>
				</div>


				<div id="purchaseDetail" onclick="window.location.href='#'">
					<div class="personalPurchaseDiv">
						<img class="avatar" src="../images/1.png"><br />10
					</div>
					<div class="personalPurchaseDiv">
						<img class="avatar" src="../images/2.png"><br />4
					</div>
					<div class="personalPurchaseDiv">
						<img class="avatar" src="../images/3.png"><br />3
					</div>
					<div class="personalPurchaseDiv">
						<img class="avatar" src="../images/4.png"><br />2
					</div>
					<div class="personalPurchaseDiv">
						<img class="avatar" src="../images/5.png"><br />2
					</div>
					<a class="link" id="friendLink">></a>
				</div>

			</div>
-->
			<div class="labelHeader" id="productSalesPrice">

				<div class="whiteDiv"></div>
				<span class="label"><%=goodsInfo.getGoodsPrice() + "/" + goodsInfo.getGoods_unit()%></span>

			</div>




		</div>

		<div class="grayDiv" id="salesProductImgDiv">
			<img id="salesProductImg" src="<%=productImg%>" />
		</div>

		<div class="grayDiv" id="LastGrayDiv">
			<div id="productSalesInfo">
				<div id="salesInfo">

					<%=goodsInfo.getGoodsText2()%>
					<!--
				<span class="titleFont">产品品种：</span><span class="descFont">稻花香2号</span><br/>
				<span class="titleFont">产品产地：</span><span class="descFont">黑龙江五常</span><br/>
				<span class="titleFont">产品特征：</span><span class="descFont">不惨假；现磨不抛光</span><br/>
				<span class="titleFont">产品规格：</span><span class="descFont">10斤</span><br/>
				<span class="titleFont">包装说明：</span><span class="descFont">10斤/袋，真空包装</span><br/>
				<span class="titleFont">生产日期：</span><span class="descFont">2015年10月</span><br/>
				<span class="titleFont">发货地点：</span><span class="descFont">五常</span><br/>
				-->
				</div>
	
				
	
				<div id="purchaseLeft">
				<div id="teamPurchase" onclick="location.href='startGroup.jsp?goodsId=<%=goodsId%>'">
					<div class="salesPrice" id="teamPrice">
						<span><%=goodsInfo.getGoodsDiscontPrice()%></span>元/份
					</div>
					<div class="purchaseLink">2人团></div>
				</div>
				</div>
				<div id="purchaseRight">
				<div id="personalPurchase" onclick="location.href='purchase.jsp?group=false&goodsId=<%=goodsId%>'">
					<div class="salesPrice" id="personalPrice">
						<span><%=goodsInfo.getGoodsPrice()%></span>元/份
					</div>
					<div class="purchaseLink">单独预定</div>
				</div>
				</div>
			</div>

			<%
				if(status != 1){
			%>
				<script>
					$(function(){
						$("#teamPurchase").hide();
						$("#personalPurchase").hide();
						
					});
					
				</script>
			<%	
				}
			%>

			
			<div id="productQuality">
				<div id="qualityContent">
				
					<div id="qualityLeft">
					<div id="qualityLogo">
						<img id="qualityLogoImg" src="../images/yuanlai.jpg" />

					</div>
					</div>
					<div id="qualityRight">
					<div id="qualityInfo">
						<span id="qualityFont">已通过<%=reportNum%>项田园检测</span>
						<br /> 
						<br /> 
						<span id="qualityLink" onclick="location.href='report.jsp?goodsId=<%=goodsId%>'">查看检测详情></span>
					</div>
					</div>
				</div>
			</div>



			<div id="productComment">
				<div class="labelHeader">
					<div class="whiteDiv"></div>
					<span class="label" id="commentLabel">产品评价（<%=commentListSize%>条）
					</span>
				</div>
				<div id="commentContent">
					<div id="commentInfo">

						<%
							for (int i = commentListSize - 1; i > commentListSize - 3 && i >= 0; i--) {
								Comment comment = commentList.get(i);

								UserInfo userInfo = UserInfoDao.getUserInfo(comment.getWechatId());
								
								String commentTime = comment.getTime();
								Date commentDate = sdf.parse(commentTime);
								SimpleDateFormat commentSdf = new SimpleDateFormat("yy-MM-dd HH:mm");
								String showTime = commentSdf.format(commentDate);
								
						%>
						<div>
							<div class="avatarDiv">
								<img class="avatar" src="<%=userInfo.getPhotoPath()%>" />
							</div>

							<div class="name"><%=userInfo.getWechatName()%></div>
							<div class="time"><%=showTime%></div>
						</div>

						<div class="comment">
							<%=comment.getContent()%>


							<%
								if (comment.getImgPath() != null) {
									String commentImgSrc = PropertiesUtil.getPath()+comment.getImgPath();
							%>
							<br /> <img class="commentImg" src="<%=commentImgSrc%>" />


							<%
								}
							%>
						</div>
						<hr />

						<%
							}
						%>

					</div>


					<div id="commentLinkDiv">

						<span id="commentLink"  onclick="location.href='comment.jsp?goodsId=<%=goodsId%>'">我来说两句</span>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
