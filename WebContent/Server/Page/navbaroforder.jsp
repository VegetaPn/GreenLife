<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.server.service.*"%>
<div class="row" id="navbar-list">
	<button type="button" onclick="location.href='togroup.jsp'"
		class="btn btn-primary">待成团(<%=OrderCountService.getToGroupCount()%>)</button>
	<button type="button" onclick="location.href='topay.jsp'"
		class="btn btn-info">待付款(<%=OrderCountService.getToPayCount()%>)</button>
	<button type="button" onclick="location.href='tosend.jsp'"
		class="btn btn-success">待发货(<%=OrderCountService.getToSendCount()%>)</button>

	<button type="button" onclick="location.href='toreceive.jsp'"
		class="btn btn-warning">待收货(<%=OrderCountService.getToReceiveCount()%>)</button>
	<button type="button" onclick="location.href='finish.jsp'"
		class="btn btn-danger">已完成(<%=OrderCountService.getFinishCount()%>)</button>
	<button type="button" onclick="location.href='refund.jsp'"
		class="btn btn-primary">已退款(<%=OrderCountService.getRefundCount()%>)</button>
</div>