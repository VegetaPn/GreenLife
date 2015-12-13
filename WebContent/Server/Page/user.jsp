<%@page
	import="java.util.List,com.greenlife.model.*,com.greenlife.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>示例</title>
</head>
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.min1.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/bootstrap-responsiv.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/jquery.dataTables.min.css">
<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/GreenLife/Server/Page/login.jsp");
		}
	%>
	<jsp:include page="header.jsp"></jsp:include>


	<div class="panel">
		<div class="panel-heading ">
			信息管理 <span>&gt;</span> 用户列表
		</div>

		<div class="panel-body ">

			<table
				class="table table-striped table-bordered table-hover datatable ">
				<thead>
					<tr>
						<th>用户微信号</th>
						<th>用户微信昵称</th>
						<th>手机号</th>
						<th>地址</th>
					</tr>
				</thead>
				<tbody>
					<%
						        List<UserInfo> allUser = UserInfoDao.getUsersList();//用户信息
								
								for (int i = 0; i < allUser.size(); i++) {
									UserInfo oneUser = allUser.get(i);//
									AdressInfo ad = AdressInfoDao.getAdressInfo(oneUser.getAddrId());
									
									
							%>
							<tr class="goods">
								<td><%=oneUser.getWechatId()%></td>
								<td><%=oneUser.getWechatName()%></td>
								<td><%=oneUser.getPhone()%></td>
								<td><%=ad.getAddrDetail()%></td>
														   
							</tr>
							<%
								}
							%>
						
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="footer.html"></jsp:include>
	<script src="../js/jquery.min.js"></script>
	<script src="../js/head.js"></script>
	<script type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="../js/datatable-zn.js"></script>

</body>
</html>