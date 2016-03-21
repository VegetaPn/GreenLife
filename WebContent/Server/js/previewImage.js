/**
 * 
 */
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
			if (img.value != "") {
				img.src = evt.target.result;
			} else {
				img.src = "";
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