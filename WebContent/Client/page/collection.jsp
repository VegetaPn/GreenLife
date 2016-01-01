<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.greenlife.dao.*"
	import="com.greenlife.model.*" import="java.util.*"
	import="java.text.SimpleDateFormat" import="com.greenlife.util.*"%>


<%
	String wechatId = (String) session.getAttribute("wechatId");

	List<Integer> goodsIdList = ConcernedListDao.getGoodsList(wechatId);

%>

<!DOCTYPE html>

<html>
    <head>
        <title>田园生活</title>
        <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/collection.css" type="text/css">
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">田园生活</div>
		</div>
		
		<div id="content">
		
		
			<%
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
				int size = goodsIdList.size();
				
				GoodsInfo goodsInfo = null;
				for(int i=0;i<size;i++){
					int goodsId = goodsIdList.get(i);
					goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
		
					
					Date startTime = sdf.parse(goodsInfo.getStartTime());
					Date endTime = sdf.parse(goodsInfo.getEndTime());
					Date date = new Date();
					String salesState = null;
					if (date.getTime() < startTime.getTime()) {
						salesState = "预售中";
					} else if (date.getTime() > endTime.getTime()) {
						salesState = "已售完";
					} else {
						salesState = "进行中";
					}
		
					if (goodsInfo.getGoodsSoldnum() >= goodsInfo.getGoodsTotalnum()) {
						salesState = "已售完";
					}

					String productImg = PropertiesUtil.getPath()+goodsInfo.getPackagePath()+"small.jpg";
					
					    
			        long time1 = startTime.getTime();                 
			        long time2 = endTime.getTime();        
			        long between_days=(time2-time1)/(1000*3600*24);
					
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
												
							if(salesState.equals("进行中")){
	
						%>
						
								<div class="nOrderTime">剩余时间：<%=between_days%>天</div>
						
						<%
							}
						%>
					</div>
				</div>
					<%
						if(salesState.equals("进行中")){
					%>
						<span class="arcLabel" id="salesState">进行中</span>
						
					<%
						}else if(salesState.equals("预售中")){
					%>
						<span class="arcLabel">预售中</span>
					
					<%
						}else{
							
						
					%>
						<span class="sellOutLabel">已售完</span>
					
					<% 
						}
					%>
						<img class="link" src="../images/rightArrowCircle2.png"></img>
			</div>	
			
			<%
				}		
			%>
		
		</div>
       
    </body>
</html>
