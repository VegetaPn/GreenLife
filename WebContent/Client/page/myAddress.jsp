<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
        import="com.greenlife.model.*"  import="com.greenlife.dao.*" import="java.util.*"%>
<!DOCTYPE html>

<html>
    <head>
        <title>我的地址</title>
        <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/myAddress.css" type="text/css">
		<script type="text/javascript" src="../js/myAddress.js"></script>
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->	
			<div id="homeButton"><img src="../images/add.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">我的地址</div>
		</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
		
		<div id="content">
		
		<!-- 在此加入各自的内容物-->
		    <div class="blank"></div>
		    
		    <% String wechatId = "huangjianqiang";
		       //String wechatId = (String)session.getAttribute("wechatId");
		       UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
		       int addressId = userInfo.getAddrId();
		       List<AdressInfo> addressInfos = AdressInfoDao.getAdressList(wechatId);
		       AdressInfo defaultAddressInfo = null;
		       int index = -1;
		       
		       for(int i =0; i<addressInfos.size();i++){
		    	   if(addressInfos.get(i).getAddrId() == addressId){
		    		   defaultAddressInfo = addressInfos.get(i);
		    		   index = i;
		    	   }
		       }
		     %>
		   
	  <%  if(defaultAddressInfo !=null){%>
		    <div class="dCusMess">
				<div class="dCusInfor">
				    <div class="top">
						<img src="../images/maleOrange.png"/>
						<span id="sCusName1" class="sCusName"><%=defaultAddressInfo.getReceiverName()%></span>
						<img src="../images/phoneOrange.png"/>
						<span id="sPhoneNum1" class="sPhoneNum"><%=defaultAddressInfo.getReceiverPhone()%></span>
					</div>
					<div class="bottom">
					    <div class="dDefault">默认</div>
						<div id="dAddress1" class="dAddress">
						    <img class ="iPosition" src="../images/mapMarkerOrange.png"/>
							<%=defaultAddressInfo.getAddrDetail()%>
						</div>
					</div>
				</div>
			</div>
		<%}%>
				
		<%if(index !=-1){
			for(int i =0; i<addressInfos.size();i++){
				if(i != index){%>
					<div class="dCusMess">
					<div class="dCusInfor">
					    <div class="top">
							<img src="../images/maleBlack.png"/>
							<span id="sCusName2" class="sCusName"><%=addressInfos.get(i).getReceiverName()%></span>
							<img src="../images/phoneBlack.png"/>
							<span id="sPhoneNum2" class="sPhoneNum"><%=addressInfos.get(i).getReceiverPhone()%></span>
						</div>
						<div class="bottom">
						    <div id="dAddress2" class="dAddress">
							    <img class ="iPosition" src="../images/mapMarkerBlack.png"/>
								<%=addressInfos.get(i).getAddrDetail()%>
							</div>
						</div>
					</div>
				</div>
				<%
				}
			}
		} %>
		</div>
		
		<div id="dMask">
		    <div id="setDefault" class="dSuspension">
			    <img src="../images/mapMarkerGreen.png"></img>
				<span>设为默认</span>
			</div>
				
			<div id="setAddress" class="dSuspension">
			    <img src="../images/arrow.png"></img>
				<span>修改地址</span>
			</div>
			
		    <div id="delAddress" class="dSuspension">
			    <img src="../images/remove.png"></img>
				<span>删除地址</span>
			</div>
		</div>
       
    </body>
</html>
