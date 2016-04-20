<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="com.greenlife.dao.*" import="com.greenlife.model.*" import="java.util.*"
    import="com.greenlife.util.PropertiesUtil" import="com.greenlife.services.*" import="java.text.SimpleDateFormat" %>
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
						
			
			</div>
			<div id="productName">
				<%=goodsInfo.getGoodsName()%>
			</div>
			<div id="totalPurchase">已售出<span class="purchaseNum"><%=totalSaleNum %></span>份<hr/></div>
			<%
				for(int i=0;i<size;i++){
					String puchaseWechatId = friendlist.get(i).get("wechat_id");
					String purchaseNum = friendlist.get(i).get("number");
					UserInfo userInfo = UserInfoDao.getUserInfo(puchaseWechatId);
					String wechatName = userInfo.getWechatName();
					
					/*String personalName = null;
					
					if(wechatName.length() == 0){
						personalName = "***";
	
					}else if(wechatName.length() <= 2){
						personalName = wechatName.substring(0,1) + "***";
					}else{
						personalName = wechatName.substring(0,1) + "***" + wechatName.substring(wechatName.length()-1);
						
					}*/
					
					String time = GoodsOrderDao.getMaxTradeTimeByWechatId(puchaseWechatId);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
					Date date = sdf.parse(time);
					
					SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
					SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
					String time1 = sdf1.format(date);
					String time2 = sdf2.format(date);
			%>		
			
			<div class="personalPurchaseDiv">
				
				<div class="avatarDiv"><img class="avatar" src="<%=userInfo.getPhotoPath()%>"/></div>
				<div class="rightDiv">
					<div class="topDiv">
						<span class="name"><%=wechatName%></span>
						<span class="time"><%=time1+" "+time2%></span>
					</div>
				
				
					<div class="personalPurchaseNum"><%=goodsInfo.getGoodsName()+" "+purchaseNum+"份" %></div>
				</div>
				
				<hr/>
				
			</div>
			
			<%
				}
			%>
			
			
			
			
		</div>
       <jsp:include page="footer.jsp" />
    </body>
</html>
