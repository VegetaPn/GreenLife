<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
			<div id="productImgDiv"><img id="productImg" src="../images/product.jpg"/></div>
			<div id="productName">
				2015现磨五常稻花香大米
			</div>
			
		</div>
		
		<div id="commentDiv">
			<hr/>
			<div id="commentLink">发布评论</div>
			<div id="commentLabel">全部评论</div>
			<hr/>
		</div>

		
			<div id="commentInfo">
				<div>
					<div class="avatarDiv"><img class="avatar" src="../images/1.png"/></div>

					<div class="name">秦始皇</div>
					<div class="time">一天前</div>
				</div>
				
				
				<div class="comment">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet.</div>
				<hr/>	
				
				<div>
					<div class="avatarDiv"><img class="avatar" src="../Images/2.png"/></div>

					<div class="name">姚晨</div>
					<div class="time">两天前</div>
				</div>
				
				
				<div class="comment">
				Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar
				tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
				Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus sapien 
				nunc eget odio.
				<br/>
				<img class="commentImg" src="../images/product.jpg"/>
				</div>
				<hr/>	
				
						
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
