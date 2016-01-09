<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.greenlife.util.PropertiesUtil"%>
 <%@ page isErrorPage="true"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String url = PropertiesUtil.getURL();
%>

<HTML>
<HEAD>
<TITLE>抱歉，出错了</TITLE>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv=refresh content="5;URL = http://<%=url %>/">
<STYLE type=text/css></STYLE>
<LINK type=text/css rel=stylesheet>
<STYLE type=text/css>
BODY {
	FONT-SIZE: 9pt; COLOR: #842b00; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
TABLE {
	FONT-SIZE: 9pt; COLOR: #842b00; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
TD {
	FONT-SIZE: 9pt; COLOR: #842b00; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
BODY {
	SCROLLBAR-HIGHLIGHT-COLOR: buttonface; SCROLLBAR-SHADOW-COLOR: buttonface; SCROLLBAR-3DLIGHT-COLOR: buttonhighlight; SCROLLBAR-TRACK-COLOR: #eeeeee; BACKGROUND-COLOR: #ffffff
}
A {
	FONT-SIZE: 9pt; COLOR: #842b00; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
A:hover {
	FONT-SIZE: 9pt; COLOR: #0188d2; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: underline
}
H1 {
	FONT-SIZE: 9pt; FONT-FAMILY: "Tahoma", "宋体"
}
</STYLE>



<BODY topMargin="20">
<TABLE cellSpacing="0" width="100%" align="center" border="0" cellpadding="0">
  <TBODY>
  <TR colspan="2">
    <TD vAlign=top align=middle>
    </TD>
    <TD>
      <H1>无法找到该页</H1>
      HTTP 错误 404：您正在搜索的页面可能已经删除、更名或暂时不可用。 
      <HR noShade SIZE=0>

      <P>☉ 请尝试以下操作：</P>
      <UL>
        <LI>确保浏览器的地址栏中显示的网站地址的拼写和格式正确无误。 
        <LI>如果通过单击链接而到达了该网页，请与网站管理员联系，通知他们该链接的格式不正确。 
        <LI>单击<A href="javascript:history.back(-1)"><FONT 
        color=#ff0000>后退</FONT></A>按钮尝试另一个链接。 </LI></UL>
      <P>☉ <%=url %> 网：      
      <UL>
        <LI><A href="源来生活" 
        target=_blank>http://<%=url %>/</A></LI>
      </UL>
      <HR noShade SIZE=0>

      <P>☉ 如果您对本站有任何疑问、意见、建议、咨询，请联系管理员</A> 
      <BR>
      &nbsp;&nbsp;&nbsp;<BR>
      </P><!------------End this!---------------></TD></TR></TBODY></TABLE>
      <jsp:include page="footer.jsp" />
      </BODY></HTML>
