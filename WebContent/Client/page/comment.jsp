<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="com.greenlife.dao.*" import="com.greenlife.model.*"
import="java.util.*" 
import="java.text.SimpleDateFormat"
import="com.greenlife.util.PropertiesUtil"
%>
<!DOCTYPE html>

<% 
String wechatId = (String)session.getAttribute("wechatId");
wechatId = "huangjianqiang";//测试
int goodsId = 1;//Integer.parseInt(request.getParameter("goosId"));
GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"normal.jpg";
List<Comment> commentList = CommentDao.getCommentList(goodsId);

int commentListSize = commentList.size();
%>

<html>
    <head>
        <title>评论详情</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/comment.css" type="text/css">
		<script type="text/javascript" src="../js/comment.js"></script>
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">田园生活</div>
		</div>
		
		
		<div id="content">
		
		<div id="product">
			<div id="productImgDiv"><img id="productImg" src="<%=productImg%>"/></div>
						
			<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
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
							
					%>
						<div>
							<div class="avatarDiv"><img class="avatar" src="<%=userInfo.getPhotoPath()%>"/></div>
	
							<div class="name"><%=userInfo.getWechatName()%></div>
							<div class="time"><%=comment.getTime()%></div>
						</div>
						
						<div class="comment">
						<%=comment.getContent()%>
						
						
						<%
							if(!comment.getImgPath().equals("")){
								
							
						%>
							<br/>
							<img class="commentImg" src=""/>
							
							
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
		
		
		<div id="blackDiv">
		</div>
		
		<div id="commentPost">
			<textarea id="postText" placeholder="在这里输入你想说的话" autofocus></textarea>
			<div id="postArea">
				<img id="postImg" src="../images/picture.png"/>添加图片
				<span id="postBtn">发布</span>
			</div>
		</div>
		
		
		</div>
    </body>
</html>
