function showError(str,callback) {   //错误提示
	$.alert({
		title:"",
		content:""+str,
		confirmButton : '确定',
	});
	
	callback();
}

function refreshdata() {
	refreshnav();
	var table = $('#datatable').DataTable();
	table.ajax.reload( function(){
	}, false );
}

function refreshnav(){
	 $("#navbar-list").load('/Server/Page/navbaroforder.jsp',function(){
	 });
}
