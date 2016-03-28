<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.greenlife.util.PropertiesUtil"%>
    
    
<%
	String appid = PropertiesUtil.getAppId();
	String url = PropertiesUtil.getURL();
	String refreshUrl = null;
	
	String requestUrl = (String)request.getAttribute("requestUrl");
	if(requestUrl == null){
		refreshUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appid+"&redirect_uri=http%3A%2F%2F"+url+"%2Flogin&response_type=code&scope=snsapi_base#wechat_redirect";
	}else{
		refreshUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appid+"&redirect_uri=http%3A%2F%2F"+url+"%2Flogin?requestUrl="+requestUrl+"&response_type=code&scope=snsapi_base#wechat_redirect";
	}
		
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="0.1;url=<%=refreshUrl%>">
<title>自动登录中</title>
</head>
<body>
</body>
</html>