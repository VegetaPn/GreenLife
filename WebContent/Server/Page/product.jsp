<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理</title>
</head>
<body>

	<%@ include file="header.jsp"%>



	<!-- 商品表 -->
	<div style="min-height: 362px; float: left" id="page-wrapper">
  <%@ include file="header.jsp"%>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">商品管理</div>
					<!-- /.panel-heading -->

					<div class="panel-body">
						<div class="dataTable_wrapper">
							<div
								class="dataTables_wrapper form-inline dt-bootstrap no-footer"
								id="dataTables-example_wrapper">


								<div class="row">
									<!-- 商品列表 -->
									<div class="col-sm-12">
										<table aria-describedby="dataTables-example_info" role="grid"
											class="table table-striped table-bordered table-hover dataTable no-footer"
											id="dataTables-example">
											<thead>
												<tr role="row">
													<th
														aria-label="Rendering engine: activate to sort column ascending"
														style="width: 175px;" colspan="1" rowspan="1"
														aria-controls="dataTables-example" tabindex="0"
														class="sorting">商品名称</th>
													<th aria-sort="ascending"
														aria-label="Browser: activate to sort column descending"
														style="width: 203px;" colspan="1" rowspan="1"
														aria-controls="dataTables-example" tabindex="0"
														class="sorting_asc">单价</th>
													<th
														aria-label="Platform(s): activate to sort column ascending"
														style="width: 184px;" colspan="1" rowspan="1"
														aria-controls="dataTables-example" tabindex="0"
														class="sorting">产地</th>
													<th
														aria-label="Engine version: activate to sort column ascending"
														style="width: 150px;" colspan="1" rowspan="1"
														aria-controls="dataTables-example" tabindex="0"
														class="sorting">描述</th>
													<th
														aria-label="CSS grade: activate to sort column ascending"
														style="width: 108px;" colspan="1" rowspan="1"
														aria-controls="dataTables-example" tabindex="0"
														class="sorting">检测</th>
												</tr>
											</thead>

											<!-- 每条商品信息 -->
											<tbody>
												<tr role="row" class="gradeU odd">
													<td class="">Other browsers</td>
													<td class="sorting_1">All others</td>
													<td>-</td>
													<td class="center">-</td>
													<td class="center">U</td>
												</tr>
												<tr role="row" class="gradeA even">
													<td class="">Trident</td>
													<td class="sorting_1">AOL browser (AOL desktop)</td>
													<td>Win XP</td>
													<td class="center">6</td>
													<td class="center">A</td>
												</tr>
												<tr role="row" class="gradeA odd">
													<td class="">Gecko</td>
													<td class="sorting_1">Camino 1.0</td>
													<td>OSX.2+</td>
													<td class="center">1.8</td>
													<td class="center">A</td>
												</tr>
												<tr role="row" class="gradeA even">
													<td class="">Gecko</td>
													<td class="sorting_1">Camino 1.5</td>
													<td>OSX.3+</td>
													<td class="center">1.8</td>
													<td class="center">A</td>
												</tr>
												<tr role="row" class="gradeX odd">
													<td class="">Misc</td>
													<td class="sorting_1">Dillo 0.8</td>
													<td>Embedded devices</td>
													<td class="center">-</td>
													<td class="center">X</td>
												</tr>
												<tr role="row" class="gradeA even">
													<td class="">Gecko</td>
													<td class="sorting_1">Epiphany 2.20</td>
													<td>Gnome</td>
													<td class="center">1.8</td>
													<td class="center">A</td>
												</tr>
												<tr role="row" class="gradeA odd">
													<td class="">Gecko</td>
													<td class="sorting_1">Firefox 1.0</td>
													<td>Win 98+ / OSX.2+</td>
													<td class="center">1.7</td>
													<td class="center">A</td>
												</tr>
												<tr role="row" class="gradeA even">
													<td class="">Gecko</td>
													<td class="sorting_1">Firefox 1.5</td>
													<td>Win 98+ / OSX.2+</td>
													<td class="center">1.8</td>
													<td class="center">A</td>
												</tr>
												<tr role="row" class="gradeA odd">
													<td class="">Gecko</td>
													<td class="sorting_1">Firefox 2.0</td>
													<td>Win 98+ / OSX.2+</td>
													<td class="center">1.8</td>
													<td class="center">A</td>
												</tr>
												<tr role="row" class="gradeA even">
													<td class="">Gecko</td>
													<td class="sorting_1">Firefox 3.0</td>
													<td>Win 2k+ / OSX.3+</td>
													<td class="center">1.9</td>
													<td class="center">A</td>
												</tr>
											</tbody>
											<!-- 每条商品信息 -->
										</table>
									</div>
								</div>
								<!-- 商品列表 -->


								<div class="row">
									<!-- 翻页索引 -->
									<div class="col-sm-6">
										<div aria-live="polite" role="status"
											id="dataTables-example_info" class="dataTables_info">
											1-10个 ，共57个</div>
									</div>
									<div class="col-sm-6">
										<div id="dataTables-example_paginate"
											class="dataTables_paginate paging_simple_numbers">
											<ul class="pagination">
												<li id="dataTables-example_previous" tabindex="0"
													aria-controls="dataTables-example"
													class="paginate_button previous disabled"><a href="#">上一页</a></li>
												<li tabindex="0" aria-controls="dataTables-example"
													class="paginate_button "><a href="#">1</a></li>
												<li tabindex="0" aria-controls="dataTables-example"
													class="paginate_button active"><a href="#">2</a></li>
												<li tabindex="0" aria-controls="dataTables-example"
													class="paginate_button "><a href="#">3</a></li>
												<li tabindex="0" aria-controls="dataTables-example"
													class="paginate_button "><a href="#">4</a></li>
												<li tabindex="0" aria-controls="dataTables-example"
													class="paginate_button "><a href="#">5</a></li>
												<li tabindex="0" aria-controls="dataTables-example"
													class="paginate_button "><a href="#">6</a></li>
												<li id="dataTables-example_next" tabindex="0"
													aria-controls="dataTables-example"
													class="paginate_button next"><a href="#">下一页</a></li>
											</ul>
										</div>
									</div>
								</div>
								<!-- 翻页索引 -->
							</div>
						</div>

					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</div>




	<%@ include file="footer.html"%>


	<script src="../bower_components/jquery/dist/jquery.min.js"></script>
	<script src="../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="../bower_components/metisMenu/dist/metisMenu.min.js"></script>
	<script
		src="../bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
	<script
		src="../bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
	<script src="../dist/js/sb-admin-2.js"></script>

</body>
</html>