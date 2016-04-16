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
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min1.css">
<link rel="stylesheet" type="text/css"
	href="../css/bootstrap-responsiv.css">
<link rel="stylesheet" type="text/css"
	href="../css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="../css/table.css">
</head>

<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		}
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="content">
		<div class="row">
			<div class="col-sm-11">
				<form >
					<button type="submit" class="btn btn-primary btn-sm" formaction="addproduct.jsp">
 						 <span class="glyphicon glyphicon-plus"></span> 新增
					</button>
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
							id="product" style="ordering: false;">
							<thead>
								<tr>
									<th style="display: none">序号</th>
									<th>产品编号</th>
									<th>名称</th>
									<th>价格</th>
									<th>团价格</th>
									<th>总量</th>
									<th>卖出</th>
									<th>优先级调整</th>


								</tr>
							</thead>
							<!-- 每条商品信息 -->
							<tbody>
								<%
									List<GoodsInfo> allGoods = GoodsInfoDao.getGoodsListByOrderIndex();//获得所有商品列表
										for (int i = 0; i < allGoods.size(); i++) {
											GoodsInfo oneGoods = allGoods.get(i);//被遍历到的商品
								%>
								<tr class="goods">
									<td style="display: none"
										onclick="showInfo(<%=oneGoods.getGoodsId()%>)"><%=i + 1%></td>
									<td onclick="showInfo(<%=oneGoods.getGoodsId()%>)"
										class="center"><%=oneGoods.getGoodsId()%></td>
									<td onclick="showInfo(<%=oneGoods.getGoodsId()%>)"
										class="center"><%=oneGoods.getGoodsName()%></td>
									<td onclick="showInfo(<%=oneGoods.getGoodsId()%>)"
										class="center"><%=oneGoods.getGoodsPrice()%></td>
									<td onclick="showInfo(<%=oneGoods.getGoodsId()%>)"
										class="center"><%=oneGoods.getGoodsDiscontPrice()%></td>
									<td onclick="showInfo(<%=oneGoods.getGoodsId()%>)"
										class="center"><%=oneGoods.getGoodsTotalnum()%></td>
									<td onclick="showInfo(<%=oneGoods.getGoodsId()%>)"
										class="center"><%=oneGoods.getGoodsSoldnum()%></td>

									<td>
										<%
											if (i != 0) {//第一行不显示按钮
										%>
										<button class="btn-primary"
											onclick="changeTop(<%=oneGoods.getGoodsId()%>)">置顶</button> <%
 	}
 %>
									</td>
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

	<jsp:include page="footer.html"></jsp:include>
</body>

</html>