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
<script type="text/javascript" src="../js/addProduct.js" ></script>
</head>

<body>


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
								<form role="form" onsubmit="return checkAddProduct()" 
									action="/GreenLife/AddGoodServlet" method="post">
									<div class="form-group">
										<label>商品名称</label> <input id="name" type="text" name="good_name"
											class="form-control" placeholder="商品名称">
									</div>


									<div class="form-group">
										<label class="">商品单价</label>
										<div class="input-group">
											<input id="price" type="text" class="form-control" name="good_price"
												placeholder="商品价格"> <span class="input-group-addon">￥</span>
										</div>
									</div>
									<div class="form-group">
										<label class="">团购价</label>
										<div class="input-group">
											<input id="group_price" type="text" class="form-control" name="group_price"
												placeholder="团购价格"> <span class="input-group-addon">￥</span>
										</div>
									</div>
									
									<div class="form-group">
										<label class="">商品总量</label>
										<div class="input-group">
											<span class="input-group-btn">
												<button class="btn btn-default"
													onclick="reduction()" type="button">-</button>
											</span> <input id="total_num" type="text" class="form-control" name="total_num"
												value="0" /> <span class="input-group-btn">
												<button class="btn btn-default" onclick="add()"
													type="button">+</button>
											</span> <span class="input-group-addon">份</span>
										</div>
									</div>
									

									<div class="form-group">
										<label>计量单位</label> <select class="form-control" id="unit">
											<option>斤</option>
											<option>袋</option>
											<option>包</option>
											<option>只</option>
											<option>个</option>
										</select>
									</div>

									
									<div class="form-group">
										<label>开始时间</label> <input placeholder="开始时间"
											class=" laydate-icon form-control" id="start_time" name="start_time">
									</div>


									<div class="form-group">
										<label>结束时间</label> <input placeholder="结束时间"
											class=" laydate-icon form-control" id="end_time" name="end_time">
									</div>


									<div class="form-group">
										<div class="form-group-lg">
											<label>商品描述1</label>
											<textarea id="good_text1" name="good_text1"class="form-control" rows="3"></textarea>
										</div>
									</div>

									<div class="form-group ">
										<div class="form-group-lg ">
											<label>商品描述2</label>
											<textarea id="good_text2" name="good_text2" class="form-control" rows="3"></textarea>
										</div>
									</div>


									<!-- 微信内容输入 -->
									<div class="form-group">
										<div style="margin-top: 2em;">
											<div clas="form-group">
												<label>微信标签标题</label> <input type="text" id="tag_title" name="tag_title"
													class="form-control" placeholder="商品名称">
											</div>

											<div class="form-group">
												<label>微信标签描述</label>
												<textarea id="tag_text" name="tag_text" class="form-control" rows="3"></textarea>
											</div>

											<div class="form-group">
												<label>微信标签图片</label> <input type="file" accept="image/*" name="tag_image"
													id="tag_image">
											</div>
										</div>
									</div>

									<input type="submit" class="btn btn-primary" value="提交" />
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
				elem : '#date'
			});//绑定元素
		}();

		//日期范围限制
		var start = {
			elem : '#start_time',
			format : 'YYYY/MM/DD/hh:mm',
			min : laydate.now(), //设定最小日期为当前日期
			max : '2099/06/16/00:00', //最大日期
			istime : true,
			istoday : true,
			choose : function(datas) {
				end.min = datas; //开始日选好后，重置结束日的最小日期
				end.start = datas //将结束日的初始值设定为开始日
			}
		};

		var end = {
			elem : '#end_time',
			format : 'YYYY/MM/DD/hh:mm',
			min : laydate.now(),
			max : '2099/06/16/00:00',
			istime : true,
			istoday : false,
			choose : function(datas) {
				start.max = datas; //结束日选好后，充值开始日的最大日期
			}
		};
		laydate(start);
		laydate(end);
	</script>
</body>
</html>