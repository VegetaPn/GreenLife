/**
 * 
 */

function toChange() {
	knowus = document.getElementById("knowus_img");
	knowus.disabled = false;

	var content = "<input type=\"submit\" class=\"btn btn-success\" onclick=\"()\" value=\"保存\">"
			+ "</button>";

	document.getElementById("control").innerHTML = content;
}

function cancelChange() {
	window.location.href = "/Server/Page/product.jsp";
}

function checkKnowUs() {

	if (document.getElementById("knowus_img").value == "") {
		showError("未选择图片");
		return false;
	} else {
		return true;
	}
}


