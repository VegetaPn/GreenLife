<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.*"
	import="java.text.SimpleDateFormat" import="com.greenlife.util.*"
	import="com.greenlife.services.*"%>
<%@ page errorPage="error.jsp"%>

<%
	String wechatId = (String) session.getAttribute("wechatId");

	List<Integer> goodsIdList = ConcernedListDao.getGoodsList(wechatId);

%>

<!DOCTYPE html>

<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/collection.css" type="text/css">
    </head>
    <body>
	
		<jsp:include page="header.jsp" />
		
		<div id="content">
		
		
			<%
				
				int size = goodsIdList.size();
				
				GoodsInfo goodsInfo = null;
				for(int i=0;i<size;i++){
					int goodsId = goodsIdList.get(i);
					goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
		
					Date date = new Date();
					String salesState = null;
					
					int status = GoodsInfoService.getGoodsStatus(goodsInfo);
					
					
					if(status == 0){
						salesState = "未开始";
					}
					if(status == 1){
						salesState = "预定中";
					}
					if(status == 2){
						salesState = "已售完";
					}
					if(status == 3){
						salesState = "已下架";
					}

					String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"small.jpg";
					
					    
			   
					
			%>		
			<div id="collectProduct">
				
				<div class="normalProduct" onclick="javascript:location.href='productHome.jsp?goodsId=<%=goodsInfo.getGoodsId()%>'">
					<div class="nPic"><img src="<%=productImg%>"/></div>
					<div class="nSellInfo">
						<div class="nName"><%=goodsInfo.getGoodsName()%></div>
						<div class="nIntro"><%=goodsInfo.getSubTitle()%></div>
						<div class="nCheapprice">￥<%=goodsInfo.getGoodsPrice()%><span>/<%=goodsInfo.getGoods_unit()%></span>
							</div>
						
						<% 	
						int state = GoodsInfoService.getGoodsStatus(goodsInfo);
						String gState = "";
						String gTime = "";
						long time1 = 0;
						long time2 = 0;
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");	
						Calendar cal = Calendar.getInstance();  
						switch (state){
						case 0: {
							gState = "未开始";	
							gTime = "距开始";
							cal.setTime(sdf.parse(sdf.format(new Date())));
							time1 = cal.getTimeInMillis();        
							cal.setTime(sdf.parse(goodsInfo.getEndTime()));    
							time2 = cal.getTimeInMillis();
							break;
						}
						case 1: {
							gState = "预定中";
							gTime = "剩余时间";
							cal.setTime(sdf.parse(goodsInfo.getStartTime()));  
							time1 = cal.getTimeInMillis();    
							cal.setTime(sdf.parse(goodsInfo.getEndTime()));
							time2 = cal.getTimeInMillis();    
							break;
						}
						case 2: {
							gState = "已售完";
							break;
							}
					}
				      	       
				        long between_days=(time2-time1)/(1000*3600*24);  

					%>
					
					<%if(!gState.equals("已售完")){ %>
					<div class="nOrderTime"><%=gTime%>：<%=between_days%>天</div>
					<%} %>
					</div>
				</div>
					<%
						if(salesState.equals("未开始")){
					%>
						<span class="arcLabel" id="salesState">未开始</span>
						
					<%
						}else if(salesState.equals("预定中")){
					%>
						<span class="arcLabel">预定中</span>
					
					<%
						}else if(salesState.equals("已售完")){
							
						
					%>
						<span class="sellOutLabel">已售完</span>
					
					<% 
						}else{
							
						
					%>
						<span class="sellOutLabel">已下架</span>
					<%
						}
					%>
						<img class="link" src="../images/rightArrowCircle2.png"></img>
			</div>	
			
			<%
				}		
			%>
		
		</div>
       <jsp:include page="footer.jsp" />
    </body>
</html>
