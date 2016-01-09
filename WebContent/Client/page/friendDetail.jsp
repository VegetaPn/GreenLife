<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="com.greenlife.dao.*" import="com.greenlife.model.*" import="java.util.*"
    import="com.greenlife.util.PropertiesUtil" import="com.greenlife.services.*"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>

<%
	String wechatId = (String)session.getAttribute("wechatId");
	int goodsId = Integer.parseInt(request.getParameter("goodsId"));
	GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
	String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"normal.jpg";
	
	ArrayList<HashMap<String, String>> friendlist = FriendsListService.getBuyList(goodsId,wechatId);
	

	int size = friendlist.size();
	
	int totalSaleNum = 0;
	for(int i=0;i<size;i++){
		String strNum = friendlist.get(i).get("number");
		totalSaleNum += Integer.parseInt(strNum);
		
	}
%>


<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/friendDetail.css" type="text/css">
    </head>
    <body>
	
		<jsp:include page="header.jsp" />
		
		<div id="content">
		
			<div id="product" onclick="location.href='productHome.jsp?goodsId=<%=goodsId%>'">
			<div id="productImgDiv"><img id="productImg" src="<%=productImg%>"/></div>
						
			<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
			</div>
		
			<div id="totalPurchase">已售出<span class="purchaseNum"><%=totalSaleNum %></span>份<hr/></div>
			<%
				for(int i=0;i<size;i++){
					String puchaseWechatId = friendlist.get(i).get("wechatid");
					String purchaseNum = friendlist.get(i).get("number");
					UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
					
			%>		
			
			<div class="personalPurchaseDiv">
				
				<img class="avatar" src="<%=userInfo.getPhotoPath()%>"/>
				<span class="name"><%=userInfo.getWechatName() %></span>
				<span class="personalPurchaseNum">已购买<span class="purchaseNum"><%=purchaseNum %></span>份</span>  
				<hr/>
				
			</div>
			
			<%
				}
			%>
			
			
			
			
		</div>
       <jsp:include page="footer.jsp" />
    </body>
</html>
