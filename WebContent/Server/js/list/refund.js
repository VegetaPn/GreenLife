/**
 * 
 *//**
 * 
 */

$(document).ready(function() {
	$('#datatable').DataTable({
		"ordering" : true,
		"orderFixed" : {
			"pre" : [ 0, 'desc' ]
		},
		"pagingType" : "simple_numbers", // 分页类型
		"searching" : true, // 搜索
		"lengthChange" : false, // 每页长度不可变
		"pageLength" : 15,
		"processing" : true,// 每页长度
		

		"language" : { // 国际化配置
			"lengthMenu" : "显示 _MENU_ 条",
			"info" : " _START_ -  _END_ 条 共 _TOTAL_ 条",
			"infoEmpty" : "记录数为0",
			"infoFiltered" : "(全部记录数 _MAX_ 条)",
			"infoPostFix" : "",
			"search" : "搜索",
			"url" : "",
			"paginate" : {
				"first" : "第一页",
				"previous" : "上一页",
				"next" : "下一页",
				"last" : "最后一页"
			}
		},

		"ajax" : {
			"url" : "/search",
			"type" : "Post",
			"data" : {
				"grouptype" : "8",
				"type" : "18"
			}
		},

		"columns" : [ 
		             {"data" : "goodsOrder.tradeTime"},
		             {"data" : "goodsOrder.outTradeNo"},
		             {"data" : "weichatName"},
		             {"data" : "goodsName"},
		     		{"data" : "goodsOrder.goodsNum"},
		     		{"data" : "goodsOrder.receiverName"},
		     		{"data" : "goodsOrder.phoneNumber"},
		     		{"data" : "buytype"},
		
		]
	});

});

