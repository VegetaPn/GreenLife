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
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>
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
		    		   break;
		    	   }
		       }
		     %>
		   <script>
		      //def是默认的地址在地址列表中的位置,defAdr是默认的地址id
		      var def = <%=index%>;
		      var defAdr = <%=index==-1?-1:addressInfos.get(index).getAddrId()%>;

				$(document).ready(function(){
				      if(def!=-1){
				    	  $(".dDeCusMess").show();
				      }
					 $("#setDefault").click(function(){
						 if(currentid == defAdr){
						  	hiddMask();
						  	alert("该地址已经是默认地址");
						   	return;
						 }
					 	 $.ajax({
							type: "post",//数据提交的类型（post或者get）
								url: "/GreenLife/myAddress",//数据提交得地址
							data: {addressid:currentid,type:0},//提交的数据(自定义的一些后台程序需要的参数)
							dataType: "text",//返回的数据类型
							success: function(data){//请求成功后返执行的方法
								if(currentid == null){
									//隐藏mask
									hiddMask();
									return;				
								}
							
								var sDeCusName = $("#sCusName"+currentid).text();
								var sDePhoneNum = $("#sPhoneNum"+currentid).text();
								var dDeAddress = $("#dAddress"+currentid).text();
								
								//判断是否有默认地址，如果替换位置，否则，删除
								if(!$(".dDeCusMess").is(':hidden')){
									$("#sCusName"+currentid).text($("#sDeCusName").text());
									$("#sPhoneNum"+currentid).text(	$("#sDePhoneNum").text());
									$("#dAddress"+currentid).html("<img class ='iPosition' src='../images/mapMarkerBlack.png'/>"+$("#dDeAddress").text());
								}
								else{
									$("#"+currentid).remove();
								}
								$("#sDeCusName").text(sDeCusName);
								$("#sDePhoneNum").text(sDePhoneNum);
								$("#dDeAddress").html("<img class ='iPosition' src='../images/mapMarkerOrange.png'/>"+dDeAddress);
								//现实默认地址								
								$(".dDeCusMess").show();
								//隐藏mask
								hiddMask();
						 	},
						 	error: function(){
						        alert(arguments[1]);
							}
						 	});
						}); 
					 
					 
					 
					 $("#delAddress").click(function(){
					 	 $.ajax({		 
							type: "post",//数据提交的类型（post或者get）
							url: "/GreenLife/myAddress",//数据提交得地址
							data: {addressid:currentid,type:2},//提交的数据(自定义的一些后台程序需要的参数)
							dataType: "text",//返回的数据类型
							success: function(data){//请求成功后返执行的方法
								if(currentid == null){
									//隐藏mask
									hiddMask();
									return;
								}
							   
							    //如果删除的是默认地址，则将其隐藏
							    if(currentid == defAdr){
							    	$("#"+currentid).hide();
							    }
							    else{
								    $("#"+currentid).remove();
							    }
								//隐藏mask
								hiddMask();
						 	},
						 	error: function(){
						        alert(arguments[1]);
							}
						 	});
						}); 		 
					 
			});
		   </script>
		    <div class="dDeCusMess" id="<%=defaultAddressInfo!=null?defaultAddressInfo.getAddrId():-1%>" onclick="displayMask(this)">
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
							<%=defaultAddressInfo!=null?defaultAddressInfo.getAddrDetail():-1%>
						</div>
					</div>
				</div>
			</div>
				
		<%if(index !=-1){
			for(int i =0; i<addressInfos.size();i++){
				if(i != index){%>
				 <div class="dCusMess" id="<%=addressInfos.get(i).getAddrId()%>" onclick="displayMask(this)">
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
