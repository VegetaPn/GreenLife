<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品添加</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<script src="../js/bootstrap.min.js"></script>
<script src="../js/addProduct.js" type="text/javascript" charset="utf-8"></script>
</head>

<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/GreenLife/Server/Page/login.jsp");
		}
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<div id="page-wrapper"
		style="min-height: 616px; min-width: 700px; float: left">
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">新增商品</div>
					<div class="panel-body ">
						<div class="row">
							<div class="col-lg-8">
								<form role="form">
									<div class="form-group">
										<label>商品名称</label> <input type="text" class="form-control"
											placeholder="商品名称">
									</div>


									<div class="form-group">
										<label class="">商品单价</label>
										<div class="input-group">
											<input type="text" class="form-control" placeholder="商品价格">
											<span class="input-group-addon">￥</span>
										</div>
									</div>
									<div class="form-group">
										<label class="">每份数量</label>
										<div class="input-group">
											<span class="input-group-btn">
												<button class="btn btn-default"
													onclick="reduction('goods_unit')" type="button">-</button>
											</span> <input id="goods_unit" type="text" value="0"
												class="form-control" /> <span class="input-group-btn">
												<button class="btn btn-default" onclick="add('goods_unit')"
													type="button">+</button>
											</span> <span class="input-group-addon">个/份</span>
										</div>
									</div>

									<div class="form-group">
										<label class="">商品总量</label>
										<div class="input-group">
											<span class="input-group-btn">
												<button class="btn btn-default"
													onclick="reduction('goods_count')" type="button">-</button>
											</span> <input id="goods_count" type="text" class="form-control"
												value="0" /> <span class="input-group-btn">
												<button class="btn btn-default" onclick="add('goods_count')"
													type="button">+</button>
											</span> <span class="input-group-addon">份</span>
										</div>
									</div>
									
									<div class="form-group">
										<label>开始时间</label> <input placeholder="开始时间" class=" laydate-icon form-control"
											id="start">
									</div>
									
									<div class="form-group">
										<label>结束时间</label> <input  placeholder="结束时间" class=" laydate-icon form-control"
											id="end">
									</div>


									<div class="form-group">
										<div class="form-group-lg">
											<label>商品描述1</label>
											<textarea class="form-control" rows="3"></textarea>
										</div>
									</div>
									
									<div class="form-group">
									<div class="form-group-lg">
										<label>商品描述2</label>
										<textarea class="form-control" rows="3"></textarea>
									</div>
									</div>

									<!-- 微信内容输入 -->
									<div class="form-group">
								
										<div  style="margin-top: 2em;">
											<div clas="form-group">
												<label>微信标签名称</label> <input type="text"
													class="form-control" placeholder="商品名称">
											</div>

											<div class="form-group">
												<label>微信标签描述</label>
												<textarea class="form-control" rows="3"></textarea>
											</div>

											<div class="form-group">
												<label>微信标签图片</label> <input type="file" accept="image/*">
											</div>

										</div>
									</div>
						
									<button type="submit" class="btn btn-primary"
										onsubmit="checkAddProduct()">提交</button>
									<button type="reset" class="btn btn-primary">重置</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.html"></jsp:include>
	<script type="text/javascript" src="../js/laydate.js"></script>
	<script type="text/javascript">
	!function() {
		laydate.skin('molv');//切换皮肤，请查看skins下面皮肤库
		laydate({
			elem : '#demo'
		});//绑定元素
	}();

	//日期范围限制
	var start = {
		elem : '#start',
		format : 'YYYY-MM-DD',
		min : laydate.now(), //设定最小日期为当前日期
		max : '2099-06-16', //最大日期
		istime : true,
		istoday : false,
		choose : function(datas) {
			end.min = datas; //开始日选好后，重置结束日的最小日期
			end.start = datas //将结束日的初始值设定为开始日
		}
	};

	var end = {
		elem : '#end',
		format : 'YYYY-MM-DD',
		min : laydate.now(),
		max : '2099-06-16',
		istime : true,
		istoday : false,
		choose : function(datas) {
			start.max = datas; //结束日选好后，充值开始日的最大日期
		}
	};
	laydate(start);
	laydate(end);

	//自定义日期格式
	laydate({
		elem : '#test1',
		format : 'YYYY年MM月DD日',
		festival : true, //显示节日
		choose : function(datas) { //选择日期完毕的回调
			alert('得到：' + datas);
		}
	});
</script>
</body>
</html>