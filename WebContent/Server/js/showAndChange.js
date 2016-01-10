function changeAvaliable() {

	var name = document.getElementById("name");
	name.disabled = false;
	/*
	 * 价格
	 */
	var price = document.getElementById("price");// 单价
	var group_price = document.getElementById("group_price"); // 团购价

	price.disabled = false;
	group_price.disabled = false;

	/*
	 * 商品总量
	 */
	var total_num = document.getElementById("total_num");
	total_num.disabled = false;

	var good_unit = document.getElementById("good_unit");
	good_unit.disabled = false;

	var report_num = document.getElementById("report_num");
	report_num.disabled = false;

	/*
	 * 售卖时间
	 */
	var start_time = document.getElementById("start_time");// 开始时间
	var end_time = document.getElementById("end_time"); // 结束时间

	start_time.disabled = false;
	end_time.disabled = false;

	/*
	 * 商品描述
	 */
	var good_text1 = document.getElementById("good_text1");
	var good_text2 = document.getElementById("good_text2");
	good_text1.disabled = false;
	good_text2.disabled = false;

	/*
	 * 微信标签内容
	 */
	var tag_title = document.getElementById("tag_title");
	var tag_text = document.getElementById("tag_text");
	var normal_img = document.getElementById("normal_img");
	var small_img = document.getElementById("small_img");
	var detail_img = document.getElementById("detail_img");
	var report_image = document.getElementById("report_img");

	tag_title.disabled = false;
	tag_text.disabled = false;
	normal_img.disabled = false;
	small_img.disabled = false;
	detail_img.disabled = false;
	report_img.disabled = false;

	var content = "<div class=\"btn btn-primary\" onclick=\"cancelChange()\">取消</div></div>"
			+ "<input type=\"submit\" class=\"btn btn-primary\" onclick=\"()\" value=\"保存\">"
			+ "</button>";

	document.getElementById("control").innerHTML = content;
}

function cancelChange() {

	var name = document.getElementById("name");
	name.disabled = true;
	;
	/*
	 * 价格
	 */
	var price = document.getElementById("price");// 单价
	var group_price = document.getElementById("group_price"); // 团购价

	price.disabled = true;
	group_price.disabled = true;

	/*
	 * 商品总量
	 */
	var total_num = document.getElementById("total_num");
	total_num.disabled = true;

	var good_unit = document.getElementById("good_unit");
	good_unit.disabled = true;

	var report_num = document.getElementById("report_num");
	report_num.disabled = true;

	/*
	 * 售卖时间
	 */
	var start_time = document.getElementById("start_time");// 开始时间
	var end_time = document.getElementById("end_time"); // 结束时间

	start_time.disabled = true;
	end_time.disabled = true;

	/*
	 * 商品描述
	 */
	var good_text1 = document.getElementById("good_text1");
	var good_text2 = document.getElementById("good_text2");
	good_text1.disabled = true;
	good_text2.disabled = true;

	/*
	 * 微信标签内容
	 */
	var tag_title = document.getElementById("tag_title");
	var tag_text = document.getElementById("tag_text");
	var normal_img = document.getElementById("normal_img");
	var small_img = document.getElementById("small_img");
	var detail_img = document.getElementById("detail_img");
	var report_image = document.getElementById("report_img");

	tag_title.disabled = true;
	tag_text.disabled = true;
	normal_img.disabled = true;
	small_img.disabled = true;
	detail_img.disabled = true;
	report_img.disabled = true;

	var content = "<div class=\"btn btn-primary\" onclick=\"changeAvaliable()\">修改</div>";

	document.getElementById("control").innerHTML = content;
}

function checkChangeProduct() {

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

	return true;

}