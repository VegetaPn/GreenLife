<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>商品添加</title>
<script src="../js/previewImage.js"></script>
<script src="../js/addOrReduceNum.js"></script>
<script src="../js/addProduct.js"></script>
</head>
<body>
	<%
		///登录判断，防止未登录直接修改
		if (session.getAttribute("login") == null) {//用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
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
						<form role="form" enctype="multipart/form-data"
							onsubmit="return checkAddProduct()" action="/AddGoodServlet"
							method="post">
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label>商品名称</label> <input id="good_name" type="text"
											name="good_name" class="form-control" autocomplete="off">
									</div>

									<div class="form-group">
										<label>副标题</label> <input id="sub_title" type="text"
											name="sub_title" class="form-control" autocomplete="off">
									</div>
									<div class="form-group">
										<label class="">商品单价</label>
										<div class="input-group">
											<input id="price" type="text" class="form-control"
												autocomplete="off" name="good_price"> <span
												class="input-group-addon">￥</span>
										</div>
									</div>
									<div class="form-group">
										<label class="">团购价</label>
										<div class="input-group">
											<input id="group_price" type="text" class="form-control"
												autocomplete="off" name="group_price"> <span
												class="input-group-addon">￥</span>
										</div>
									</div>

									<div class="form-group">
										<label class="">商品总量</label>
										<div class="input-group">
											<span class="input-group-btn">
												<button class="btn btn-default" onclick="reduction()"
													type="button">-</button>
											</span> <input id="total_num" type="text" class="form-control"
												autocomplete="off" name="total_num" value="0" /> <span
												class="input-group-btn">
												<button class="btn btn-default" onclick="add()"
													type="button">+</button>
											</span>
										</div>
									</div>



									<div class="form-group">
										<label>计量单位</label> <input id="good_unit" type="text"
											autocomplete="off" name="good_unit" class="form-control"
											maxlength=10>
									</div>

									<div class="form-group">
										<label class="">通过检测数量</label>
										<div class="input-group">
											<span class="input-group-btn">
												<button class="btn btn-default" onclick="reduction1()"
													type="button">-</button>
											</span> <input id="report_num" type="text" class="form-control"
												autocomplete="off" name="report_num" value="0" /> <span
												class="input-group-btn">
												<button class="btn btn-default" onclick="add1()"
													type="button">+</button>
											</span>
										</div>
									</div>

									<div class="form-group">
										<label>开始时间</label> <input class=" laydate-icon form-control"
											id="start_time" name="start_time">
									</div>


									<div class="form-group">
										<label>结束时间</label> <input class=" laydate-icon form-control"
											id="end_time" name="end_time">
									</div>

									<div class="form-group">
										<div class="form-group-lg">
											<label>商品描述1(限200字)</label>
											<textarea id="good_text1" name="good_text1"
												class="form-control" rows="3"></textarea>
										</div>
									</div>


									<div class="form-group ">
										<div class="form-group-lg ">
											<label>商品描述2(限200字)</label>
											<textarea id="good_text2" name="good_text2"
												class="form-control" rows="3"></textarea>
										</div>
									</div>
									<div class="form-group-lg">
										<label>设置为广告</label> <label class="checkbox-inline"> <input
											name="adv" type="radio" id="inlineCheckbox1" value="0"
											checked> 否
										</label> <label class="checkbox-inline"> <input type="radio"
											name="adv" id="inlineCheckbox2" value="1"> 是
										</label>

									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label>主页大图片(400*200)</label> <input type="file"
											accept="image/jpeg" name="normal_img"
											onchange="previewImage(this)" id="normal_img">
										<div id="pre_normal">
											<img id="normal_head" width=420 height=210 />
										</div>
									</div>

									<div class="form-group">
										<label>列表小图片(100*100)</label> <input type="file"
											accept="image/jpeg" name="small_img"
											onchange="previewImage(this)" id="small_img">
										<div id="pre_small">
											<img id="small_head" width=100 height=100 />
										</div>
									</div>

									<div class="form-group">
										<label>检测报告长图(400*?,只会预览图片一小部分)</label> <input type="file"
											accept="image/jpeg" name="report_img"
											onchange="previewImage(this)" id="report_img">
										<div id="pre_report"
											style="width: 400px; height: 200px; border: 1px solid #f00; overflow-y: auto;">
											<img id="report_head" />
										</div>
									</div>

									<div class="form-group">
										<label>详细信息长图(400*?,只会预览图片一小部分)</label> <input type="file"
											accept="image/jpeg" name="detail_img"
											onchange="previewImage(this)" id="detail_img">
										<div id="pre_detail"
											style="width: 400px; height: 200px; border: 1px solid #f00; overflow-y: auto;">
											<img id="detail_head" />
										</div>
									</div>
									<input type="submit" class="btn btn-primary" value="提交" />
									<button type="reset" class="btn btn-primary">重置</button>
								</div>
							</div>
						</form>
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
</html>