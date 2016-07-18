/**
 * 
 */

$(document).ready(function() {
	$.fn.dataTable.ext.errMode = 'none';
	$('#datatable').on( 'error.dt', function ( e, settings, techNote, message ) {
		refreshdata();
    } ).DataTable({
		"ordering" : false,
		"pagingType" : "simple_numbers", // 分页类型
		"searching" : true, // 搜索
		"lengthChange" : false, // 每页长度不可变
		"pageLength" : 15,
		"processing" : true,// 每页长度
		"stateSave" : true,
		"serverSide":true,
		"displayStart":0,
		

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
				"grouptype" : "1",
				"type" : "11"
			}
		},

		"columns" : [ 
		             {"data" : "goodsOrder.tradeTime"},
		     		{"data" : "weichatName"},
		     		{"data" : "goodsName"},
		     		{"data" : "goodsOrder.goodsNum"},
		     		{"data" : "goodsOrder.receiverName"},
		     		{"data" : "goodsOrder.addrDetail"},
		     		{"data" : "goodsOrder.phoneNumber"},
		     		{"data" : "buytype"},
		
		]
	});

});


