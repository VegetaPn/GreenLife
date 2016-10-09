<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="com.greenlife.dao.*" import="com.greenlife.model.*"
import="java.util.*" 
import="java.text.SimpleDateFormat"
import="com.greenlife.util.*"
import="com.greenlife.wechatservice.*"
%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>

<% 
String wechatId = (String)session.getAttribute("wechatId");

int goodsId = Integer.parseInt(request.getParameter("goodsId"));
GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"normal.jpg";
List<Comment> commentList = CommentDao.getCommentList(goodsId);

int commentListSize = commentList.size();

int targetGoodsId = goodsId;

if(goodsInfo.getParentId()!=0){
	targetGoodsId = goodsInfo.getParentId();
}
%>

<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/comment.css" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>
		<script type="text/javascript" src="../js/comment.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    </head>
    <body>
	
		<jsp:include page="header.jsp" />
		
		
		<div id="content">
		
		<div id="product" onclick="location.href='productHome.jsp?goodsId=<%=targetGoodsId%>'">
			<img id="productImg" src="<%=productImg%>"/>
						
			
		</div>
		<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
		
		<div id="commentDiv">
			<hr/>
			<div id="commentLink">发布评论</div>
			<div id="commentLabel">全部评论</div>
			<hr/>
		</div>

		
			<div id="commentInfo">
				<%
						for(int i=commentListSize-1;i>=0;i--){
							Comment comment = commentList.get(i);
							
							UserInfo userInfo = UserInfoDao.getUserInfo(comment.getWechatId());
							String commentTime = comment.getTime();
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
							Date commentDate = sdf.parse(commentTime);
							SimpleDateFormat commentSdf = new SimpleDateFormat("yy-MM-dd HH:mm");
							String showTime = commentSdf.format(commentDate);
					%>
						<div>
							<div class="avatarDiv"><img class="avatar" src="<%=userInfo.getPhotoPath()%>"/></div>
	
							<div class="name"><%=userInfo.getWechatName()%></div>
							<div class="time"><%=showTime%></div>
						</div>
						
						<div class="comment">
						<%=comment.getContent().replace("\n", "<br/>")%>
						
						<%
							if(comment.getImgPath() != null){
								String commentImgSrc = PropertiesUtil.getPath()+comment.getImgPath();
							
						%>
							<br/>
							<img class="commentImg" src="<%=commentImgSrc%>"/>
							
							
						<% 
							}
						%>
						</div>
						<hr/>
						
					<%
						}
						
					%>	
						
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
		
		
		
		
		
	<div id="blackDiv">
	</div>
	
	<div id="commentPost">
		<textarea id="postText" placeholder="在这里输入你想说的话" autofocus></textarea>
		
		<div id="showImgDiv">
			<img id="close" src="../images/close.png">
			<img id="showImg" src=""/>
		</div>
		
		<div id="postArea">
			
			<img id="postImg" src="../images/picture.png"/>
			<span id="postBtn">发布</span>
		</div>
	</div>
	
	<script>
		var localId = "";
		
		$("#postImg").click(function () {
			   
		   		wx.chooseImage({
				    count: 1, // 默认9
				    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
				    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				    success: function (res) {
				    	localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
				    	localId = localIds[0];
				    	$("#showImg").attr('src',localIds);
				    	$("#showImgDiv").show();
				    }
		   		});
	  	 });
		  
		 
		  $("#close").click(function () {
			  localId = "";
			  $("#showImg").attr('src',localId);
		      $("#showImgDiv").hide();
		      
	  	 }); 
		  
		  
		 $("#postBtn").click(function () {
			 $("#postBtn").attr({"disabled":"disabled"});
			 if(localId == ""){
				
				 $.ajax({
		 				type: "post",
		    			url: "/comment",
		     			data: {goodsId: "<%=goodsId%>",text:$("#postText").val(),img:""},
						dataType : "text",
						success : function(data) {
							window.location.reload();
						},
						error : function() {
							alert(arguments[1]);
							$("#postBtn").removeAttr("disabled");
						}
				});	
			 }else{
				 wx.uploadImage({
					   localId: localId, // 需要上传的图片的本地ID，由chooseImage接口获得
					   isShowProgressTips: 1, // 默认为1，显示进度提示
					   success: function (res) {
						   var serverId = res.serverId; // 返回图片的服务器端ID
						   $.ajax({
				 				type: "post",
				    			url: "/comment",
				     			data: {goodsId: "<%=goodsId%>",text:$("#postText").val(),img:serverId},
								dataType : "text",
								success : function(data) {
									window.location.reload();
								},
								error : function() {
									alert(arguments[1]);
									$("#postBtn").removeAttr("disabled");
								}
						});	
							 
					    }
					});
			 }
			 
	  	 });
	</script>	
	
	
	
		<jsp:include page="footer.jsp" />
    </body>
</html>	
	
	
	

