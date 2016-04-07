/**
 * 
 */
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