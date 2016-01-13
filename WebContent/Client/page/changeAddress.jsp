<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
        import="com.greenlife.model.*"  import="com.greenlife.dao.*" import="java.util.*"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>

<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/myAddress.css" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>
    </head>
    <body>
	
	<div id="header">
		<div id="leftButton">
			<img src="../images/leftArrowBlack.png" onclick="history.back(-1);" />
		</div>
		<div id="homeButton">
			<img id="addAddr" src="../images/add.png"/>
		</div>
		<div id="title">源来生活</div>
	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
		
		<div id="content">
		
		<!-- 在此加入各自的内容物-->
		    <div class="blank"></div>
		    
		    <% 
		       String wechatId = (String)session.getAttribute("wechatId");
		       String goodsId = request.getParameter("goodsId");
		       String group = request.getParameter("group");
		       
		       UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
		       int addressId = userInfo.getAddrId();
		       List<AdressInfo> addressInfos = AdressInfoDao.getAdressList(wechatId);
		       AdressInfo defaultAddressInfo = null;
		       
		       List<String> addrList = new ArrayList<String>();
		       int index = -1;
		       for(int i =0; i<addressInfos.size();i++){
		    	   if(addressInfos.get(i).getAddrId() == addressId){
		    		   defaultAddressInfo = addressInfos.get(i);
		    		   index = i;	    		   
		    	   }
		    	   
		    	   StringBuffer temp = new StringBuffer();
		    	   String[] temps = addressInfos.get(i).getAddrDetail().split(";");
		    	   for(int j = 0;j<temps.length; j++){
		    		   if(!temps[j].equals("null")){
		    			   temp.append(temps[j]+" ");
		    		   }
		    	   }
		    	   addrList.add(temp.toString());
		       }
		     %>
		     
		     <script>
		         var group=<%=group%>;
		         var goodsId=<%=goodsId%>
				 $("#addAddr").click(function(){
					 location.href = "reAddress.jsp?group="+group+"&goodsId="+goodsId;
					}); 

		     </script>
		     
		   <% if(addressInfos == null||addressInfos.size() == 0){%>
				<div id="dHint">
				    <div id="hint">添加地址</div>
				</div>
				<script>
				   $("#hint").click(function(){
					 location.href = "reAddress.jsp?group="+group+"&goodsId="+goodsId;
					}); 
				</script>
		   <%}
		   else{%>
			     <%if(defaultAddressInfo!=null){ %>
			    <div id="dHint">
				    <div id="hint" style="background-color: white; color: red">请点击以下地址，跳转到订单页面</div>
				</div>
				    <div class="dDeCusMess" style="display:block" id="<%=defaultAddressInfo!=null?defaultAddressInfo.getAddrId():-1%>" 
				            onclick="location.href='/changeAddress?addressId=<%=defaultAddressInfo.getAddrId()%>&group=<%=group%>&goodsId=<%=goodsId%>'">
						<div class="dCusInfor">
						    <div class="top">
								<img src="../images/maleOrange.png"/>
								<span id="sDeCusName" class="sCusName"><%=defaultAddressInfo!=null?defaultAddressInfo.getReceiverName():-1%></span>
								<img src="../images/phoneOrange.png"/>
								<span id="sDePhoneNum" class="sPhoneNum"><%=defaultAddressInfo!=null?defaultAddressInfo.getReceiverPhone():-1%></span>
							</div>
							<div class="bottom">
							    <div class="dDefault">默认</div>
								<div id="dDeAddress" class="dAddress">
								    <img class ="iPosition" src="../images/mapMarkerOrange.png"/>
									<%=defaultAddressInfo!=null?addrList.get(index):-1%>
								</div>
							</div>
						</div>
					</div>
					<% }%>
					
			<%for(int i =0; i<addressInfos.size();i++){
					if(i != index){%>
					 <div class="dCusMess" id="<%=addressInfos.get(i).getAddrId()%>" 
					       onclick="location.href='/changeAddress?addressId=<%=addressInfos.get(i).getAddrId()%>&group=<%=group%>&goodsId=<%=goodsId%>'">
						<div class="dCusInfor" >
						    <div class="top">
								<img src="../images/maleBlack.png"/>
								<span id="sCusName<%=addressInfos.get(i).getAddrId()%>" class="sCusName"><%=addressInfos.get(i).getReceiverName()%></span>
								<img src="../images/phoneBlack.png"/>
								<span id="sPhoneNum<%=addressInfos.get(i).getAddrId()%>" class="sPhoneNum"><%=addressInfos.get(i).getReceiverPhone()%></span>
							</div>
							<div class="bottom">
							    <div id="dAddress<%=addressInfos.get(i).getAddrId()%>" class="dAddress">
								    <img class ="iPosition" src="../images/mapMarkerBlack.png"/>
									<%=addrList.get(i)%>
								</div>
							</div>
						</div>
					</div>
					<%
					}
				}%>
			<%}%>
		</div>
		<jsp:include page="footer.jsp" />
    </body>
</html>
