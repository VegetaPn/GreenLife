<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>示例</title>
</head>
<body>

	<%@ include file="header.jsp"%>

	<div id="page-wrapper"
		style="min-height: 616px; min-width: 700px; float: left">
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">新增商品</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-6">
								<form role="form">
									<div class="form-group">
										<label>商品名称</label> <input class="form-control">

									</div>


									<div class="form-group">
										<label>Text Input with Placeholder</label> <input
											class="form-control" placeholder="Enter text">
									</div>

									<!-- 类型标签  数据库生成 -->
									<div class="form-group">
										<label>选择类型标签</label> <select class="form-control">
											<option>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
										</select>
									</div>

									<div class="form-group">
										<label>商品图片</label> <input type="file" accept="image/*">
									</div>


									<div class="form-group">
										<label>商品描述</label>
										<textarea class="form-control" rows="3"></textarea>
									</div>

									<button type="submit" class="btn btn-primary">提交</button>
									<button type="reset" class="btn btn-primary">重置</button>
								</form>
							</div>
							<!-- /.col-lg-6 (nested) -->

						</div>
						<!-- /.row (nested) -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
	</div>

	<%@ include file="footer.html"%>
</body>
</html>