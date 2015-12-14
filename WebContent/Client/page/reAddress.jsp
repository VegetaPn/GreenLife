<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
   import="com.greenlife.model.*" import="com.greenlife.dao.*" %>
<!DOCTYPE html>

<html>
    <head>
        <title>收货地址</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/reAddress.css" type="text/css">
		<script type="text/javascript" src="../js/reAddress.js"></script>
    </head>
    <body>
	
		<div id="header">
			<div id="leftButton"><img src="../images/leftArrowBlack.png"/></div> <!-- 左上角功能键：返回、或是菜单按键-->
			<div id="homeButton"><img src="../images/home.png"></div>   <!-- 右上角功能键，其实就是主页按钮-->
			<div id="title">收货地址</div>
		</div>
		<%  
		    String addressId =request.getParameter("addressid");
		    String group = request.getParameter("group");
		    String goodsId = request.getParameter("goodsId");
		    
		    String addressDetail = new String();
		    AdressInfo addressInfo = null;
		    int iAddress = -1;
		    StringBuffer region = new StringBuffer();
		    if(addressId!=null){
			    iAddress = Integer.valueOf(addressId);
	 	        addressInfo =AdressInfoDao.getAdressInfo(iAddress);
			    
			    String[] temps = addressInfo.getAddrDetail().split(";");
			    for(int j = 0;j<temps.length;j++){
			    	if(j==temps.length -1){
			    		addressDetail = temps[j];
			    	}
			    	else{
				    	if(!temps[j].equals("null")){
				    		region.append(temps[j]+" ");
			    		}
			    	}
			    }
		    }
		%>
		<div id="content">
		
			<!-- 在此加入各自的内容物-->
			<div class="blank"></div>
			<form method="post" onsubmit="return validate()"
			   action="/reAddress<%=iAddress!=-1?"?type=1&addressid="+iAddress:"?type=2"%><%=goodsId!=null?"&goodsId="+goodsId+"&group="+group:""%>" >
				<div class="dPanel">
					<div class="cell">
					   <span>收货人</span><br/>
					   <input type="text" id="iConsignee" name="iConsignee" class="input" value="<%=iAddress!=-1?addressInfo.getReceiverName():""%>"/>
					</div>
					<div class="cell">
					   <span>手机号码</span><br/>
					   <input type="text" id="iPhnoe" name="iPhnoe" class="input" value="<%=iAddress!=-1?addressInfo.getReceiverPhone():""%>"/>
					</div>
					<div class="cell">
					   <span>地区信息</span><br/>
					   <input type="text" id="iRegione" name="iRegione" class="input" value="<%=iAddress!=-1?region.toString():""%>" readonly="readonly"></input>
					   <img id="iToAddress" src="../images/rightArrowGray.png"/>
					</div>
					<div id="location" class="cell">
						<select class="select" name="province" id="s1">
						  <option></option>
						</select>
						<select class="select" name="city" id="s2">
						  <option></option>
						</select>
						<select class="select" name="town" id="s3">
						  <option></option>
						</select>
				    </div>
					<div class="cell">
					   <span>详细地址</span><br/>
					   <input type="text" id="iAddress" name="iAddress" class="input" value="<%=iAddress!=-1?addressDetail:""%>"/>
					</div>
					<div class="cell">
					   <span>邮编</span><br/>
					   <input type="text" id="zipAddress" name="zipAddress" class="input" value="<%=iAddress!=-1?addressInfo.getAddrZipcode():""%>"/>
					</div>
					<div class="cell">
					   <input type="checkbox" id="iCheck" name="iCheck"/>
					   <span>默认地址</span><br/>
					   <input type="submit" id="iSure" class="input" value="确认"/>
					</div>						
				</div>
			</form>
		</div>
    </body>
</html>
