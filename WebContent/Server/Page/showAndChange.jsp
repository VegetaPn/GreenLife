<%@page import="com.greenlife.util.PropertiesUtil"%>
<%@page
	import="java.util.List ,com.greenlife.model.*,com.greenlife.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品添加</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<script src="../js/bootstrap.min.js"></script>
</head>

<body>
	<%
		///登录判断，防止未登录直接修改
		GoodsInfo showedGood = null;
		String id = request.getParameter("id");
		if (id == null) {
			response.sendRedirect("/GreenLife/Server/Page/product.jsp");
		} else {
			if (session.getAttribute("login") == null) {
				response.sendRedirect("/GreenLife/Server/Page/login.jsp");
			} else {
				showedGood = GoodsInfoDao.getGoodsInfo(Integer.parseInt(id));
	%>


	<jsp:include page="header.jsp"></jsp:include>
	<div id="page-wrapper"
		style="min-height: 616px; min-width: 700px; float: left">
		<!-- /.row -->
		<div class="row">
			<h5>
				<a href="product.jsp"> <-返回</a>
			</h5>
			<div class="col-lg-12">
				<div class="panel panel-default">

					<div class="panel-heading ">

						<p class="center">
							<i style="color: #0000FF">（<%=showedGood.getGoodsId()%> : <%=showedGood.getGoodsName()%>）
							</i>详细信息
						</p>
					</div>
					<div class="panel-body ">

						<form role="form" enctype="multipart/form-data"
							action="/GreenLife/ChangeGoodServlet"
							onsubmit="return checkChangeProduct()" method="post">
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label>商品编号</label> <input id="good_id" type="text"
											value="<%=showedGood.getGoodsId()%>" readonly=true
											name="good_id" class="form-control">
									</div>
									<div class="form-group">
										<label>商品名称</label> <input id="name" type="text"
											value="<%=showedGood.getGoodsName()%>" disabled="true"
											name="good_name" class="form-control">
									</div>

									<div class="form-group">
										<label class="">商品单价</label>
										<div class="input-group">
											<input id="price" type="text" class="form-control"
												value="<%=showedGood.getGoodsPrice()%>" disabled="true"
												name="good_price"> <span class="input-group-addon">￥</span>
										</div>
									</div>
									<div class="form-group">
										<label class="">团购价</label>
										<div class="input-group">
											<input id="group_price" type="text" class="form-control"
												value="<%=showedGood.getGoodsDiscontPrice()%>"
												disabled="true" name="group_price"> <span
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
												value="<%=showedGood.getGoodsTotalnum()%>" name="total_num"
												disabled="true" value="0" /> <span class="input-group-btn">
												<button class="btn btn-default" onclick="add()"
													type="button">+</button>
											</span>
										</div>
									</div>
									<div class="form-group">
										<label class="">卖出总量</label> <input type="text"
											class="form-control"
											value="<%=showedGood.getGoodsSoldnum()%>" disabled="true"
											value="0" />

									</div>

									<div class="form-group">
										<label>计量单位</label> <select class="form-control"
											value="<%=showedGood.getGoods_unit()%>" disabled="true"
											name="good_unit" id="good_unit">
											<option>斤</option>
											<option>袋</option>
											<option>包</option>
											<option>只</option>
											<option>个</option>
										</select>
									</div>

									<div class="form-group">
										<label class="">通过检测数量</label>
										<div class="input-group">
											<span class="input-group-btn">
												<button class="btn btn-default" onclick="reduction1()"
													type="button">-</button>
											</span> <input id="report_num" type="text" class="form-control"
												value="<%=showedGood.getReportId()%>" disabled="true"
												name="total_num" value="0" /> <span class="input-group-btn">
												<button class="btn btn-default" onclick="add1()"
													type="button">+</button>
											</span>
										</div>
									</div>


									<div class="form-group">
										<label>开始时间</label> <input class=" laydate-icon form-control"
											value="<%=showedGood.getStartTime()%>" disabled="true"
											id="start_time" name="start_time">
									</div>


									<div class="form-group">
										<label>结束时间</label> <input class=" laydate-icon form-control"
											value="<%=showedGood.getEndTime()%>" disabled="true"
											id="end_time" name="end_time">
									</div>


									<div class="form-group">
										<div class="form-group-lg">
											<label>商品描述1</label>
											<textarea id="good_text1" name="good_text1" disabled="true"
												class="form-control" rows="3"><%=showedGood.getGoodsText1()%></textarea>
										</div>
									</div>

									<div class="form-group ">
										<div class="form-group-lg ">
											<label>商品描述2</label>
											<textarea id="good_text2" name="good_text2" disabled="true"
												class="form-control" rows="3"><%=showedGood.getGoodsText2()%></textarea>
										</div>
									</div>


									<!-- 微信内容输入 -->
									<div class="form-group">
										<div style="margin-top: 2em;">
											<div clas="form-group">
												<label>微信标签标题</label> <input type="text" id="tag_title"
													value="<%=showedGood.getTagTitle()%> " disabled="true"
													name="tag_title" class="form-control">
											</div>

											<div class="form-group">
												<label>微信标签描述</label>
												<textarea id="tag_text" name="tag_text" class="form-control"
													disabled="true" rows="3"><%=showedGood.getTagText()%></textarea>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label>主页大图片(400*200)</label> <input type="file"
											accept="image/jpeg" name="normal_img" disabled="true"
											onchange="previewImage(this)" id="normal_img">
										<div id="pre_normal">
											<img id="normal_head"
												src="PropertiesUtil.getSavePath()%><%=showedGood.getPackagePath()%>normal.jpg"
												width=420 height=210 />
										</div>
									</div>

									<div class="form-group">
										<label>列表小图片(100*100)</label> <input type="file"
											disabled="true" accept="image/jpeg" name="small_img"
											onchange="previewImage(this)" id="small_img">
										<div id="pre_small">
											<img id="small_head"
												src="<%=PropertiesUtil.getSavePath()%><%=showedGood.getPackagePath()%>small.jpg"
												width=100 height=100 />
										</div>
									</div>

									<div class="form-group">
										<label>检测报告长图(400*?,只会预览图片一小部分)</label> <input type="file"
											disabled="true" accept="image/jpeg" name="report_img"
											onchange="previewImage(this)" id="report_img">
										<div id="pre_report"
											overflow-y:auto;
											style="width: 400px; height: 200px; border: 1px solid #f00; overflow-y: auto;">
											<img id="report_head"
												src="PropertiesUtil.getSavePath()%><%=showedGood.getPackagePath()%>report.jpg" />
										</div>
									</div>
									<div class="form-group">
										<label>详细信息长图(400*?,只会预览图片一小部分)</label> <input type="file"
											disabled="true" accept="image/jpeg" name="detail_img"
											onchange="previewImage(this)" id="detail_img">
										<div id="pre_detail"
											style="width: 400px; height: 200px; border: 1px solid #f00; overflow-y: auto;">
											<img id="detail_head"
												src="PropertiesUtil.getSavePath()%><%=showedGood.getPackagePath()%>detail.jpg" />
										</div>
									</div>
									<div id="control" class="form-group">
										<div class="btn btn-primary" onclick="changeAvaliable()">
											修改</div>
									</div>


								</div>

							</div>

						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<%
		}
		}
	%>
	<jsp:include page="footer.html"></jsp:include>
	<script type="text/javascript" src="../js/showAndChange.js"></script>
	<script type="text/javascript" src="../js/addProduct.js"></script>
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