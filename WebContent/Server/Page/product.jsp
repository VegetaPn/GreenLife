<%@page
	import="java.util.List,com.greenlife.model.*,com.greenlife.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.min1.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/bootstrap-responsiv.css">
<link rel="stylesheet" type="text/css"
	href="../CSS/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="../CSS/table.css">
</head>

<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		} else {
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="content">
		<div class="row">
			<div class="col-sm-6">
				<form>
					<button type="submit" class="btn btn-primary"
						formaction="addproduct.jsp">新增</button>
				</form>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">商品管理</div>
			<!-- /.panel-heading -->

			<div class="panel-body">
				<!-- 商品列表 -->
				<div class="col-sm-12">
					<div class="row-fluid">
						<table
							class="table table-striped table-bordered table-hover datatable"
							id="product">
							<thead>
								<tr>
									<th>编号</th>
									<th>名称</th>
									<th>价格</th>
									<th>团价格</th>
									<th>总量</th>
									<th>卖出</th>
									

								</tr>
							</thead>
							<!-- 每条商品信息 -->
							<tbody>
								<%
									List<GoodsInfo> allGoods = GoodsInfoDao.getGoodsList();//获得所有商品列表
										for (int i = 0; i < allGoods.size(); i++) {
											GoodsInfo oneGoods = allGoods.get(i);//被遍历到的商品
								%>
								<tr class="goods" onclick="showInfo(<%=oneGoods.getGoodsId()%>)">
									<td class="center"><%=oneGoods.getGoodsId()%></td>
									<td class="center"><%=oneGoods.getGoodsName()%></td>
									<td class="center"><%=oneGoods.getGoodsPrice()%></td>
									<td class="center"><%=oneGoods.getGoodsDiscontPrice()%></td>
									<td class="center"><%=oneGoods.getGoodsTotalnum()%></td>
									<td class="center"><%=oneGoods.getGoodsSoldnum()%></td>
								</tr>
								<%
									}
								%>
							</tbody>
							<!-- 每条商品信息 -->
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	%>

	<jsp:include page="footer.html"></jsp:include>
	<script src="../js/jquery.min.js"></script>
	<script src="../js/head.js"></script>
	<script type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/product.js"></script>
	<script type="text/javascript" src="../js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="../js/datatable-zn.js"></script>
</body>

</html>