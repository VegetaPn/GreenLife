$(document).ready(function() {
	$('.datatable').DataTable({
		"oLanguage": { //国际化配置  
			"sProcessing": "正在获取数据，请稍后...",
			"sLengthMenu": "显示 _MENU_ 条",
			"sZeroRecords": "没有您要搜索的内容",
			"sInfo": " _START_ -  _END_ 条 共 _TOTAL_ 条",
			"sInfoEmpty": "记录数为0",
			"sInfoFiltered": "(全部记录数 _MAX_ 条)",
			"sInfoPostFix": "",
			"sSearch": "搜索",
			"sUrl": "",
			"oPaginate": {
				"sFirst": "第一页",
				"sPrevious": "",
				"sNext": "",
				"sLast": "最后一页"
			}
		},
		"order": [[0,"desc"]]
	});
	$.extend( $.fn.dataTable.defaults, {
	    searching: false,
	    ordering:  false
	} );
});

