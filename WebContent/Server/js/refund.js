/**
 * 
 */
function refund(orderId){
		$.confirm({
			title : '',
			content : '确认为此订单退款',
			confirmButton : '确定',
			cancelButton : '取消',
			confirmButtonClass : 'btn-primary',
			icon : 'fa fa-question-circle',
			animation : 'scale',
			confirm : function() {
				$("#body").showLoading();
				$.ajax({
					"url" : "/refund",
					"method" : "post",
					"data" : {
						"orderId" : orderId
					},
					"success" : function(data, status) {
						$("#body").hideLoading();
						if(data=="403"){
							window.location.href = "/Server/Page/login.jsp";
						}else if(data=="yes"){
							refreshdata();
							showError("退款成功");
						} else {
							showError("退款失败");
						}

					}
				});
			}
		});
}