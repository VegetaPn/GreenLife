function showError(str) {   //错误提示
	$.alert({
		title:"",
		content:""+str,
		confirmButton : '确定',
	});
}

function refreshdata() {
	refreshnav();
	var table = $('#datatable').DataTable();
	table.ajax.reload( function(json){
		$("#body").hideLoading();
	}, false );
}

function refreshnav(){
	 $("#navbar-list").load('/Server/Page/navbaroforder.jsp',function(){
	 });
}
