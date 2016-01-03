<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.greenlife.dao.*" import="com.greenlife.model.*"
    import="com.greenlife.util.*"
%>
    <%@ page errorPage="error.jsp"%>
    
<%
	int goodsId = Integer.parseInt(request.getParameter("goodsId"));
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
	
	String reportPath = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"report.jpg";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="../css/header.css" type="text/css">
        <link rel="stylesheet" href="../css/report.css" type="text/css">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    </head>
<body>
	<jsp:include page="header.jsp" />
	<div id="content">
	
		<img id="reportImg" src="<%=reportPath%>"/>
	</div>
</body>
</html>