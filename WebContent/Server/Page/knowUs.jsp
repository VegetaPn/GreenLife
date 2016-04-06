<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.greenlife.util.PropertiesUtil,java.util.Date"%>
<%@page
	import="java.util.List ,com.greenlife.model.*,com.greenlife.dao.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="-1">
<title>关于源来生活</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.min.css">
</head>
<body ">

	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		}
	%>
	<jsp:include page="header.jsp"></jsp:include>

	<div class="panel panel-default">
		<div class="panel-heading">关于我们</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-lg-6">
					<form role="form" enctype="multipart/form-data"
						onsubmit="return checkKnowUs()" action="/changeKnowUs"
						method="post">

						<div class="form-group">
							<label>关于我们</label> <input type="file" accept="image/jpeg"
								name="knowus_img" onchange="previewImage(this)" id="knowus_img"
								disabled="true">
							<div id="pre_knowus"
								style="width: 400px; height: 400px; border: 1px solid #f00; overflow-y: auto;">
								<img id="knowus_head"
									src="<%=PropertiesUtil.getPath()%>konwYuanlai.jpg?=<%=(new Date()).getTime()%>" />
							</div>
						</div>

						<div class="form-group row">
							<div class="col-lg-4" id="control">
								<div class="btn btn-primary" onclick="toChange()">修改</div>
							</div>
							<div class="col-lg-4">
								<div class="btn btn-primary" onclick="cancelChange()">放弃修改</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.html"></jsp:include>
	<script src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/previewImage.js"></script>
	<script type="text/javascript" src="../js/knowus.js"></script>
	<script type="text/javascript" src="../js/jquery.js"></script>
</body>
</html>