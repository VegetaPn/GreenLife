
/*
 * 
 * 提交前判断填写信息是否完整
 */
function checkAddProduct() {
	var parent_id = document.getElementById("parent_id").value;
	
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
	var good_unit = document.getElementById("good_unit").value;

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
	 * 邮费
	 */
	var local_city =document.getElementById("local_city").value;
	var local_postage =document.getElementById("local_postage").value;
	var alien_postage=document.getElementById("alien_postage").value;

	/*
	 * 微信标签内容
	 */
	var normal_img = document.getElementById("normal_img").value;
	var small_img = document.getElementById("small_img").value;
	var detail_img = document.getElementById("detail_img").value;
	var report_image = document.getElementById("report_img").value;

	if(parent_id == ""){
		showError("请填写父产品编号");
		return false;
	}
	
	/*
	 * 商品名称检测；
	 */
	if (good_name == "") {
		showError("请填写商品名称");
		return false;
	}

	if (sub_title == "") {
		showError("请填写副标题");
		return false;
	}
	/*
	 * 价格格式检测
	 */
	if (price == "") {
		showError("请填写商品价格");
		return false;
	} else {

		var pattern = new RegExp("^[0-9]+(.[0-9]{1,2})?$");// /价格正则表达式
		if (!pattern.test(price)) {// 价格格式
			showError("商品价格格式错误，保留两位小数");
			return false;
		}
	}

	/*
	 * 团购价格格式检测
	 */
	if (group_price == "") {
		showError("请填写团购价格");
		return false;
	} else {
		var pattern = new RegExp("^[0-9]+(.[0-9]{1,2})?$");// /正则表达式
		if (!pattern.test(group_price)) {// 价格格式
			showError("团购价格格式错误，保留两位小数");
			return false;
		}

		if (parseFloat(price) < parseFloat(group_price)) {
			showError("团购价格不应大于单价")
			return false;
		}
	}

	if (total_num == "") {
		showError("请填写商品总量");
		return false;
	} else {
		var pattern = new RegExp("^[0-9]{1,11}$");// /正则表达式
		if (!pattern.test(total_num)) {// 价格格式
			showError("商品总量填写错误");
			return false;
		}
	}

	if (good_unit == "") {
		showError("请填写计量单位");
		return false;
	}
	

	if (report_num == "") {
		showError("请填写通过检测总量");
		return false;
	} else {	
		var pattern = new RegExp("^[0-9]{1,11}$");// /正则表达式
		if (!pattern.test(report_num)) {
			showError("通过检测总量填写错误");
			return false;
		}
	}


	/*
	 * 时间判定
	 */
	if (start_time == "") {
		showError("请选择开始时间");
		return false;
	}

	if (end_time == "") {
		showError("请选择结束时间");
		return false;
	}

	/*
	 * 商品介绍判断
	 */

	if (good_text1 == "") {
		showError("请填写商品描述1");
		return false;
	}

	if (good_text2 == "") {
		showError("请填写商品描述2");
		return false;
	}

	/*
	 * 邮费标准检测
	 */
	if(local_city==""){
		showError("请填写至少一个本地城市");
		return false;
	}else{
		//格式检测
		var pattern = new RegExp("^([\u4e00-\u9fa5]*[1])+$");// /正则表达式
		if (!pattern.test(local_city)) {
			showError("本地城市格式填写错误");
			return false;
		}
	}
	
	
	
	if(local_postage==""){
		showError("请填写本地邮费");
		return false;
	}else{
		var pattern = new RegExp("^[0-9]+(.[0-9]{1,2})?$");// /正则表达式
		if (!pattern.test(local_postage)) {// 价格格式
			showError("本地邮费格式错误，保留两位小数");
			return false;
		}
	}
	
	if(alien_postage==""){
		showError("请填写外地地邮费");
		return false;
	}else{
		var pattern = new RegExp("^[0-9]+(.[0-9]{1,2})?$");// /正则表达式
		if (!pattern.test(alien_postage)) {// 价格格式
			showError("外地邮费格式错误，保留两位小数");
			return false;
		}
	}
	
	
	/*
	 * 微信标签内容判断
	 */

	if (normal_img == "") {
		showError("请选择一张主页大图片");
		return false;
	}
	if (small_img == "") {
		showError("请选择一张列表小图片");
		return false;
	}
	if (report_img == "") {
		if (report_num != "0") {
			showError("检测数量不为0，所以你要上传一个检测图片");
			return false;
		}
	}
	
	return true;

}
