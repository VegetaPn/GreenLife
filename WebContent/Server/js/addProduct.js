function reduction() {
	var goods_count = document.getElementById("total_num").value;

	if (goods_count != 0) {
		document.getElementById("total_num").value = parseInt(goods_count) - 1;
	}
}

function add(id) {
	
	var goods_count = document.getElementById("total_num").value;
	document.getElementById("total_num").value = parseInt(goods_count) + 1;
}


function reduction1() {
	var goods_count = document.getElementById("report_num").value;

	if (goods_count != 0) {
		document.getElementById("report_num").value = parseInt(goods_count) - 1;
	}
}

function add1() {
	
	var goods_count = document.getElementById("report_num").value;
	document.getElementById("report_num").value = parseInt(goods_count) + 1;
}
/*
 * 
 * 提交前判断填写信息是否完整
 */
function checkAddProduct() {

	/*
	 * 商品名称
	 */
	var name = document.getElementById("name").value;

	/*
	 * 价格
	 */
	var price = document.getElementById("price").value;// 单价
	var group_price = document.getElementById("group_price").value; // 团购价

	/*
	 * 商品总量
	 */
	var total_num = document.getElementById("total_num").value;
	var report_num=document.getElementById("report_num").value;

	/*
	 * 售卖时间
	 */
	var start_time = document.getElementById("start_time").value;// 开始时间
	var end_time = document.getElementById("end_time").value; // 结束时间

	/*
	 * 商品描述
	 */
	var good_text1 = document.getElementById("good_text1").value;
	var good_text2 = document.getElementById("good_text2").value;

	/*
	 * 微信标签内容
	 */
	var tag_title = document.getElementById("tag_title").value;
	var tag_text = document.getElementById("tag_text").value;
	var normal_img = document.getElementById("normal_img").value;
	var small_img = document.getElementById("small_img").value;
	var detail_img = document.getElementById("detail_img").value;
	var report_image = document.getElementById("report_img").value;

	/*
	 * 商品名称检测；
	 */
	if (name == "") {
		alert("请填写商品名称");
		return false;
	}

	/*
	 * 价格格式检测
	 */
	if (price == "") {
		alert("请填写商品价格");
		return false;
	} else {

		var pattern = new RegExp("^[0-9]+(.[0-9]{1,2})?$");// /价格正则表达式
		if (!pattern.test(price)) {// 价格格式
			alert("商品价格格式错误，保留两位小数");
			return false;
		}
	}

	/*
	 * 团购价格格式检测
	 */
	if (group_price == "") {
		alert("请填写团购价格");
		return false;
	} else {
		var pattern = new RegExp("^[0-9]+(.[0-9]{1,2})?$");// /价格正则表达式
		if (!pattern.test(group_price)) {// 价格格式
			alert("团购价格格式错误，保留两位小数");
			return false;
		}

		if (parseFloat(price) < parseFloat(group_price)) {
			alert("团购价格不应大于单价")
			return false;
		}
	}

	if (total_num == "") {
		alert("请填写商品总量");
		return false;
	} else {
		var pattern = new RegExp("^[0-9]{1,11}$");// /价格正则表达式
		if (!pattern.test(total_num)) {// 价格格式
			alert("商品总量填写错误");
			return false;
		}
	}
	
	if (total_num == "") {
		alert("请填写通过检测总量");
		return false;
	} else {
		var pattern = new RegExp("^[0-9]{1,11}$");// /价格正则表达式
		if (!pattern.test(total_num)) {// 价格格式
			alert("通过检测总量总量填写错误");
			return false;
		}
	}

	/*
	 * 时间判定
	 */
	if (start_time == "") {
		alert("请选择开始时间");
		return false;
	}

	if (end_time == "") {
		alert("请选择结束时间");
		return false;
	}

	/*
	 * 商品介绍判断
	 */

	if (good_text1 == "") {
		alert("请填写商品描述1");
		return false;
	}

	if (good_text2 == "") {
		alert("请填写商品描述2");
		return false;
	}

	/*
	 * 微信标签内容判断
	 */

	if (tag_title == "") {
		alert("请填写微信标签标题");
		return false;
	}

	if (tag_text == "") {
		alert("请填写微信标签描述");
		return false;
	}

	if (normal_img == "") {
		alert("请选择一张主页大图片");
		return false;
	}
	if (small_img == "") {
		alert("请选择一张列表小图片");
		return false;
	}

	return true;

}

// 预览图片
function previewImage(file) {
	var MAXWIDTH;
	var MAXHEIGHT;
	var div;
	var id;
	if (file.id == "normal_img") {
		div = document.getElementById('pre_normal');
		id = "normal_head";
		MAXWIDTH = 400;
		MAXHEIGHT = 200;
	} else if (file.id == "small_img") {
		div = document.getElementById('pre_small');
		id = "small_head";
		MAXWIDTH = 100;

	} else if (file.id == "report_img") {
		div = document.getElementById('pre_report');
		id = "report_head";
		MAXWIDTH = 400;
		MAXHEIGHT = 200;

	} else if (file.id == "detail_img") {
		div = document.getElementById('pre_detail');
		id = "detail_head";
		MAXWIDTH = 400;
		MAXHEIGHT = 200;
	}
	if (file.files && file.files[0]) {
		var img = document.getElementById(id);

		var reader = new FileReader();
		reader.onload = function(evt) {
			if(img.value!=""){
			img.src = evt.target.result;
			}else{
				img.src="";
			}
		}
		reader.readAsDataURL(file.files[0]);
		
	} else // 兼容IE
	{
		var sFilter = 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
		file.select();
		var src = document.selection.createRange().text;
		var img = document.getElementById(id);
		img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
		var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth,
				img.offsetHeight);
		status = ('rect:' + rect.top + ',' + rect.left + ',' + rect.width + ',' + rect.height);
		div.innerHTML = "<div id=divhead style='width:" + rect.width
				+ "px;height:" + rect.height + "px;margin-top:" + rect.top
				+ "px;" + sFilter + src + "\"'></div>";
	}
	
	
}
function clacImgZoomParam(maxWidth, maxHeight, width, height) {
	var param = {
		top : 0,
		left : 0,
		width : width,
		height : height
	};
	if (width > maxWidth || height > maxHeight) {
		rateWidth = width / maxWidth;
		rateHeight = height / maxHeight;

		if (rateWidth > rateHeight) {
			param.width = maxWidth;
			param.height = Math.round(height / rateWidth);
		} else {
			param.width = Math.round(width / rateHeight);
			param.height = maxHeight;
		}
	}

	param.left = Math.round((maxWidth - param.width) / 2);
	param.top = Math.round((maxHeight - param.height) / 2);
	return param;
}
