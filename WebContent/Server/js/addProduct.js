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
	var good_name = document.getElementById("good_name").value;

	/*
	 * 价格
	 */
	var sub_title = document.getElementById("sub_title").value;//副标题
	var price = document.getElementById("price").value;// 单价
	var group_price = document.getElementById("group_price").value; // 团购价

	/*
	 * 商品总量
	 */
	var total_num = document.getElementById("total_num").value;
	var report_num = document.getElementById("report_num").value;

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

	var normal_img = document.getElementById("normal_img").value;
	var small_img = document.getElementById("small_img").value;
	var detail_img = document.getElementById("detail_img").value;
	var report_image = document.getElementById("report_img").value;

	/*
	 * 商品名称检测；
	 */
	if (good_name == "") {
		alert("请填写商品名称");
		return false;
	}

	if (sub_title == "") {
		alert("请填写副标题");
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

	if (report_num == "") {
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
	if (report_img == "") {
		if (report_num != "0") {
			alert("检测数量不为0，所以你要上传一个检测图片");
			return false;
		}
	}
	return true;

}


