function reduction(type) {
	if (type == "goods_unit") {
		var goods_unit = document.getElementById("goods_unit").value;

		if (goods_unit != 0) {
			document.getElementById("goods_unit").value = parseInt(goods_unit) - 1;
		}
	} else if (type == "goods_count") {
		var goods_count = document.getElementById("goods_count").value;

		if (goods_count != 0) {
			document.getElementById("goods_count").value = parseInt(goods_count) - 1;
		}
	}

}

function add(type) {
	if (type == "goods_unit") {
		var goods_unit = document.getElementById("goods_unit").value;
		document.getElementById("goods_unit").value = parseInt(goods_unit) + 1;

	} else if (type == "goods_count") {
		var goods_count = document.getElementById("goods_count").value;
		document.getElementById("goods_count").value = parseInt(goods_count) + 1;
	}

}
/*
 * 
 * 提交前判断填写信息是否完整
 */
function checkSubmit(){
	
	
}



