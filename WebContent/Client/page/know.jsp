<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
import="com.greenlife.util.*"%>
 <%@ page errorPage="error.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/header.css" type="text/css">
<link rel="stylesheet" href="../css/know.css" type="text/css">
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>源来生活</title>
</head>
<body>
	
	<jsp:include page="header.jsp" />
	<div id="content">
	
		<img id="konwImg" src="<%=PropertiesUtil.getPath()+"konwYuanlai.jpg"%>"/>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>