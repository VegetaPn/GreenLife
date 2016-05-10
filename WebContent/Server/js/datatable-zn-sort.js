/**
 * 
 */
$(document).ready(function() {
	$('.datatable').DataTable({
		"ordering" : true,
		"orderFixed" : {
			"pre" : [ 0, 'desc' ]
		},
		"pagingType" : "simple_numbers", //分页类型
		"searching" : true, //搜索
		"lengthChange" : false, //每页长度不可变
		"pageLength" : 15,
		"processing" : true,//每页长度
		"oLanguage" : { //国际化配置  
			"sProcessing" : "正在获取数据，请稍后...",
			"sLengthMenu" : "显示 _MENU_ 条",
			"sInfo" : " _START_ -  _END_ 条 共 _TOTAL_ 条",
			"sInfoEmpty" : "记录数为0",
			"sInfoFiltered" : "(全部记录数 _MAX_ 条)",
			"sInfoPostFix" : "",
			"sSearch" : "搜索",
			"sUrl" : "",
			"oPaginate" : {
				"sFirst" : "第一页",
				"sPrevious" : "上一页",
				"sNext" : "下一页",
				"sLast" : "最后一页"
			}
		}
	});
});
