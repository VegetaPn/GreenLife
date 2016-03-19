/**
 * 
 */
$(document).ready(function() {
	$('.send').on('click', function() {
		var orderId = $(this).attr("id");
		
		$.confirm({
			title : '',
			content : '确认发货',
			confirmButton : '确定',
			cancelButton : '取消',
			confirmButtonClass : 'btn-primary',
			icon : 'fa fa-question-circle',
			animation : 'scale',
			confirm : function() {
				
				window.location.href = "/SendGoodOrderServlet?orderId=" + orderId;

			}
		});
	});
});