<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
   import="com.greenlife.model.*"  import="com.greenlife.dao.*" import ="java.util.*"
   import="java.text.*" import="com.greenlife.util.*" import="com.greenlife.services.*" %>
   <%@ page errorPage="error.jsp"%>
<!DOCTYPE html>

<%
String wechatId = (String)session.getAttribute("wechatId");

int goodsId = Integer.parseInt(request.getParameter("goodsId"));
//String wechatId = "ofK5Fw6xtWJlI53RDFP_37szP7WA";
//int goodsId = 1;
//String group = "false"; 
GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
String group = request.getParameter("group");

boolean notClick = false;

if(GoodsInfoService.getGoodsStatus(goodsInfo)!=1){
	notClick = true;
}

double price = 0;
if(group.equals("false")){
	price = goodsInfo.getGoodsPrice();
}
else if(group.equals("true")){
	price = goodsInfo.getGoodsDiscontPrice();
}else{
	price = goodsInfo.getGoodsDiscontPrice();
	int groupId = Integer.parseInt(group);
	TodayGroup todayGroup = TodayGroupDao.getTodayGroup(groupId);
	 if(todayGroup.getIsDelete() == 1){
		 notClick = true;
	 }
}

//剩余数量
int remNumber = goodsInfo.getGoodsTotalnum() - goodsInfo.getGoodsSoldnum();

String productImg = PropertiesUtil.getPath() + goodsInfo.getPackagePath() + "small.jpg";


SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
Date endTime = sdf.parse(goodsInfo.getEndTime());
Calendar calendar = new GregorianCalendar(); 
calendar.setTime(endTime); 
calendar.add(calendar.DATE,1); 
endTime=calendar.getTime(); 
UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
int addressId = userInfo.getAddrId();
List<AdressInfo> addressInfos = AdressInfoDao.getAdressList(wechatId);
AdressInfo defaultAddressInfo = null;
int index = -1;
String defaultAddr = new String();

for(int i =0; i<addressInfos.size();i++){
	   if(addressInfos.get(i).getAddrId() == addressId){
		   defaultAddressInfo = addressInfos.get(i);
		   index = i;
		   
    	   StringBuffer temp = new StringBuffer();
    	   String[] temps = addressInfos.get(i).getAddrDetail().split(";");
    	   for(int j = 0;j<temps.length; j++){
    		   if(!temps[j].equals("null")){
    			   temp.append(temps[j]+" ");
    		   }
    	   }
    	   defaultAddr = temp.toString();
	   }
}
%>



<html>
    <head>
        <title>源来生活</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" href="../css/header.css" type="text/css">
		<link rel="stylesheet" href="../css/purchase.css" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>
		<script>
		   var reminder = <%=remNumber%>;
		</script>
    </head>
    <body>
	
	
		<jsp:include page="header.jsp" />
		
		<div id="content">
		    <div class="blank"></div>
		    
			<!--第一层用户信息-->
			<%if(defaultAddressInfo!=null){%>
		    <div id="dCusMess">
				<div id="dCusInfor">
				    <div class="top">
						<img src="../images/maleOrange.png"/>
						<span id="sCusName"><%=defaultAddressInfo!=null?defaultAddressInfo.getReceiverName():""%></span>
						<img src="../images/phoneOrange.png"/>
						<span id="sPhoneNum"><%=defaultAddressInfo!=null?defaultAddressInfo.getReceiverPhone():""%></span>
					</div>
					<div class="bottom">
						<img id="imgtemp" src="../images/mapMarkerOrange.png"/>
						<span id="sAddress"><%=defaultAddressInfo!=null?defaultAddr:""%></span>
					</div>
				</div>
				<div id="dToAddress">
					<a href="changeAddress.jsp?group=<%=group%>&goodsId=<%=goodsId%>"><img id="iToAddress" src="../images/rightArrowCircle3.png" ></a>
				</div>
			</div>
			<% }else{%>
				<div id="dCusMess">
				   <div id="dHint">
				      <span id="sHint"> 请前往地址中心添加收货地址</span>
				   </div>
				   <div id="dToAddress">
					  <a href="changeAddress.jsp?group=<%=group%>&goodsId=<%=goodsId%>"><img id="iToAddress" src="../images/rightArrowCircle3.png" ></a>
				   </div>
				</div>
			<% }%>

			<!--第二层产品信息-->
			<div id="dProductMess">
			    <div id="dProductImg">
				    <img id="iProductImg" src="<%=productImg%>" onclick="location.href='productDetail.jsp?goodsId=<%=goodsId%>'"/>
				</div>
				<div id="dProductInfor">
				    <p id="pProductName"><%=goodsInfo.getGoodsName()%></P>
					<p id="pPrice"><%=group.equals("false")?"单价":"成团价" %>:<span id="sProductPrice">
					      <%=price%></span>元/<%=goodsInfo.getGoods_unit()%></p>
				</div>
			</div>
			
			<!--第四层购买数量及增减-->
			<div id="dSell">
			    <div class="left"><span>数量:</span></div>
				<div class="middle">
				    <img id="iDecrease" src="../images/minusCommodity.png" onclick="decrease()"/>
					<input type="number" id="iNumber" name="iNumber" value="1"  onchange ="calculate()"/>
					<img id="iIncrease" src="../images/addCommodity.png" onclick="increase()"/>
				</div>
				<div class="right">
				    <p>x<span id="sNumber">1</span>份</p>
					<p>合计：<span id="stPrice"><%=price%></span></p>
				</div>
			</div>
			
			<!--第六层发货时间信息-->
			<div id="dPostTime">
			    <span>现在订购，发货时间：<span id="sPostTime" ><%=sdf.format(endTime)%></span></span>
			</div>

			<div id="dMail">
			    <span class="span">邮费：</span><span id="sMail">免邮费</span>
			</div>
						
			<div class="blank"></div>
			
			<!--第七层留言-->
			<div id="dMessage">
			    <input type="text" id="iMessage" name="iMessage" placeholder="给田园生活留个言"/>
				<span>请在24小时内付款否则订单将取消</span>
			</div>
			
				<jsp:include page="footer.jsp" />
		</div>
		
		<!--最底层-->
		<div id="dSubmit">
			<div class="right">
				<div id="iSubmit" <%=notClick?"disabled='disabled' style='background-color:gray'":"" %>>确认支付</div>
			</div>
			<div class="left">实付款：<span><span id="sTotalPrice"><%=price%></span>元</span></div>
		</div>
		
		<div id="prompt"></div>
		<script>
		 $("#iSubmit").click(function(){
			 $("#iSubmit").attr("disabled", "disabled"); 
			 if(<%=defaultAddressInfo==null?1:0%>){
				$("#prompt").html("<span>请添加地址</span>");
				$("#prompt").show();
				setTimeout("$('#prompt').hide()",2000);
				return;
			 }
		 	 $.ajax({		 
				type: "post",//数据提交的类型（post或者get）
				url: "/purchase",//数据提交得地址
				data: {
					sCusName:$("#sCusName").text(),
					sPhoneNum:$("#sPhoneNum").text(),
					sAddress:$("#sAddress").text(),
					sTotalPrice:$("#stPrice").text(),
					iMessage:$("#iMessage").val(),
					sPostTime:$("#sPostTime").text(),
					iNumber:$("#iNumber").val(),
					goodsId:<%=goodsId%>,
					group:<%=group%>
				},//提交的数据(自定义的一些后台程序需要的参数)
				dataType: "text",//返回的数据类型
				success: function(data){
					location.href = "payForOrder.jsp?"+data;
				},
			 	error: function(){
			        alert(arguments[1]);
				}
			 	});
			}); 
		 

		 function decrease(){
		 	var number = $("#iNumber").val();
		 	if(number>1){
		 		number = parseInt(number) - 1;
		 		$("#iNumber").val(number);
		 		$("#sNumber").text(number);
		 		var price = $("#sProductPrice").text();
		 		$("#stPrice").text(parseInt(number)*parseFloat(price));
		 		$("#sTotalPrice").text(parseInt(number)*parseFloat(price));
		 	}
		 } 

		 function increase(){
		 	var number = $("#iNumber").val();
		 	number = parseInt(number) + 1;
		 	if(number>reminder){
				$("#prompt").html("<span>供货不足!</span>");
				$("#prompt").show();
				setTimeout("$('#prompt').hide()",2000);
		 		return;
		 	}
		 	$("#iNumber").val(number);
		 	$("#sNumber").text(number);
		 	var price = $("#sProductPrice").text();
		 	var total = (parseInt(number)*parseFloat(price)).toFixed(2);
		 	$("#stPrice").text(total);
		 	
		 	$("#sTotalPrice").text(total);
		 }

		 function calculate(){
		 	var number = $("#iNumber").val();
		 	var re = /^[1-9]+[0-9]*]*$/;
		     if(!re.test(number)){
		     	$("#iNumber").val(1);
		     	number = 1;
		     	$("#prompt").html("<span>请输入正整数</span>");
				$("#prompt").show();
				setTimeout("$('#prompt').hide()",2000);
		     }
		     if(number>reminder){
		     	$("#iNumber").val(1);
		     	number = 1;
		     	$("#prompt").html("<span>供货不足！</span>");
				$("#prompt").show();
				setTimeout("$('#prompt').hide()",2000);
		     }
		 	$("#sNumber").text(number);
		 	var price = $("#sProductPrice").text();
		 	var total = (parseInt(number)*parseFloat(price)).toFixed(2);
		 	$("#stPrice").text(total);
		 	
		 	document.getElementById("sTotalPrice").innerText = total;	
		 }

		 function mousedown(){
		 	$("#iToAddress").attr("src","../images/rightArrowCircle2.png");
		 }

		 function mouseup(){
		 	$("#iToAddress").attr("src","../images/rightArrowCircle3.png");
		 }
		</script>
	
    </body>
</html>
