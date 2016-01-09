/**
 * 
 */
$(document).ready(function() {
	$('.refund').on('click', function() {
		var orderId = $(this).attr("id");

		var locate=window.location.pathname;
		
		$.confirm({
			title : '',
			content : '确认为此订单退款',
			confirmButton : '确定',
			cancelButton : '取消',
			confirmButtonClass : 'btn-primary',
			icon : 'fa fa-question-circle',
			animation : 'scale',
			confirm : function() {
				
				window.location.href = "/Refund?orderId=" + orderId+"&locate="+locate;

			}
		});
	});
});