<%@page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8" import="com.greenlife.dao.*"
        import="com.greenlife.model.*" import="java.util.ArrayList"
        import="java.util.List" import="com.greenlife.util.*"%>
        <%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>源来生活</title>
<meta charset="UTF-8">
<meta name="viewport"
        content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link rel="stylesheet" type="text/css" href="../css/header.css" />
<link rel="stylesheet" type="text/css" href="../css/orderList.css" />
<script type="text/javascript" src="../js/jquery-2.1.3.min.js"></script>



</head>
<body>

        <%
            //获取订单列表
                String wechatId = (String)session.getAttribute("wechatId");

                List<GoodsOrder> orderList = GoodsOrderDao.getGoodsOrderList(wechatId);
                int orderAmount = orderList.size();
                //用于填充的变量
                int whatToShow = 4;
                String showtype = request.getParameter("whatToShow");
                if (showtype != null)
                {
                        whatToShow = Integer.parseInt(showtype);
                }
                GoodsOrder orderToShow = new GoodsOrder();
                GoodsInfo goodsinfo = new GoodsInfo();
                int orderstate = 0;
        %>
        <div id="header">
                <div id="leftButton"  onclick="history.back(-1);">
                        <img src="../images/leftArrowBlack.png" />
                </div>
                <!-- 左上角功能键：返回、或是菜单按键-->

                <div id="homeButton" onclick="javascript:location.href='home.jsp'">
                        <img src="../images/home.png" >
                </div>
                <!-- 右上角功能键，其实就是主页按钮-->
                <div id="title">
                        <%
                            if (whatToShow == 4)
                                {
                                        out.write("订单列表");
                                }
                                else if (whatToShow == 0)
                                {
                                        out.write("订单列表-待成团");
                                }
                                else if (whatToShow == 1)
                                {
                                        out.write("订单列表-待付款");
                                }
                                else if (whatToShow == 2)
                                {
                                        out.write("订单列表-待发货");
                                }
                                else if (whatToShow == 3)
                                {
                                        out.write("订单列表-待收货");
                                }
                        %>
                </div>
        </div>
        <div id="content">
       
        
                <%
                	int showAmount = 0;
                    for (int orderIndex = orderAmount-1; orderIndex >= 0; orderIndex--)
                        {
                                orderToShow = orderList.get(orderIndex);
                                goodsinfo = GoodsInfoDao.getGoodsInfo(orderToShow.getGoodsId());
                            
                                orderstate = orderToShow.getOrderState();
                                String productImg = PropertiesUtil.getPath() + goodsinfo.getPackagePath() + "small.jpg";
                                int targetGoodsId = goodsinfo.getGoodsId();

                            	if(goodsinfo.getParentId()!=0){
                            		targetGoodsId = goodsinfo.getParentId();
                            	}
                                
                                if (whatToShow != 4)
                                {
                                        if (whatToShow == 0 && orderstate != 2)
                                        {
                                                //跳过不是待成团的条目
                                                continue;
                                        }
                                        if (whatToShow == 1 && orderstate != 1 && orderstate != 11)
                                        {
                                                //跳过不是待付款的条目
                                                continue;
                                        }
                                        if (whatToShow == 2 && orderstate != 3 && orderstate != 12)
                                        {
                                                //跳过不是待发货的条目
                                                continue;
                                        }
                                        if (whatToShow == 3 && orderstate != 4 && orderstate != 13)
                                        {
                                                //跳过不是待收货的条目
                                                continue;
                                        }
                                }
                %>

                <!--一个订单条目-->
                <div class="tag">

                        <div class="labelHeader" id="productSalesPrice">

                                <div class="whiteDiv"></div>
                                <span class="label">
                                <%
                                if (orderstate == 1)
                                        {
                                                out.write("待付款");
                                        }
                                        else if (orderstate == 2)
                                        {
                                                out.write("待成团");
                                        }
                                        else if (orderstate == 3)
                                        {
                                                out.write("待发货");
                                        }
                                        else if (orderstate == 4)
                                        {
                                                out.write("待收货");
                                        }
                                        else if (orderstate == 5)
                                        {
                                                out.write("已完成");
                                        }
                                        else if (orderstate == 11)
                                        {
                                                out.write("待付款");
                                        }
                                        else if (orderstate == 12)
                                        {
                                                out.write("待发货");
                                        }
                                        else if (orderstate == 13)
                                        {
                                                out.write("待收货");
                                        }
                                        else if (orderstate == 14)
                                        {
                                                out.write("已完成");
                                        }else if(orderstate == 8 || orderstate == 18){
                                      
                                        		out.write("已退款");
                                        }
                                        else if (orderstate == 9 || orderstate == 19)
                                        {
                                                out.write("已取消");
                                        }else{
                                        	    out.write("未知类型订单");
                                        }
                                 %>
                                </span>

                        </div>

                        <div class="listTag">


                                <!--订单的图片和详情-->
                                <div class="orderMessage">
                                        <!--订单产品图片-->
                                        <div class="productView">
                                                <img class="productImg" src=<%=productImg%> />
                                        </div>
                                        <!--订单详情-->
                                        <div class="detailMessage"
                                                onclick="javascript:location.href='detailOrderMessage.jsp?orderId=<%=orderToShow.getOrderId()%>'">

                                                <div class="productName">
                                                        <span class="blackBold"><%=goodsinfo.getGoodsName()%></span>
                                                </div>

                                                <div class="seeMore">
                                                        <hr class="line" />
                                                        <!--<div class="morePNGalign"><img class="morePNG" src="../images/rightArrowCircle.png"/></div>-->
                                                </div>


                                                <div class="cargoReciever">
                                                        <span class="blackNormal">收货人：</span><span class="orangeText"
                                                                id="recieverName"><%=orderToShow.getReceiverName()%></span>
                                                </div>

                                                <div class="shouldPay">
                                                        <span class="blackNormal">应付款：</span><span class="orangeText"
                                                                id="groupPrice"><%=orderToShow.getTotalPrice()%></span><span
                                                                class="blackNormal" id="originPrice">元 共</span><span
                                                                class="orangeText" id="groupPrice"><%=orderToShow.getGoodsNum()%></span><span
                                                                class="blackNormal" id="originPrice">件</span>
                                                </div>
												<!-- 
                                                <div class="orderTime">
                                                        <span class="blackNormal">预订时间：</span><span class="blackNormal"
                                                                id="timeOrdered"><%=orderToShow.getTradeTime()%></span>
                                                </div>

                                                <div class="deliverTime">
                                                        <span class="blackNormal">发货时间：</span><span class="blackNormal"
                                                                id="timeToDeliver"><%=orderToShow.getSendTime()%></span>
                                                </div>
												 -->
                                        </div>

                                </div>

                                <!-- 条目可进行的操作（按钮）-->


                                <%
                                    if (orderstate == 1 || orderstate == 11)
                                        {
                                        //待付款
                                %>
                                <div class="functionButton"
                                        onclick="javascript:location.href='payForOrder.jsp?orderId=<%=orderToShow.getOrderId()%>'">去付款</div>
                    
                                <%
                                    }
                                        else if (orderstate == 2)
                                        {
                                                //待成团
                                %>
                                <div class="functionButton" onclick="javascript:location.href='group.jsp?groupId=<%=orderToShow.getGroupId()%>'">约好友成团</div>
                              
                                <%
                                    }
                                        else if (orderstate == 12)
                                        {
                                                //待发货
                                %>
                                
                                <%
                                       }
                                        else if(orderstate == 3){                       
                                %>
                                
                                  <div class="functionButton" onclick="javascript:location.href='group.jsp?groupId=<%=orderToShow.getGroupId()%>'">邀请好友参团</div>
                                <%
                                    }
                                        else if (orderstate == 4 || orderstate == 13)
                                        {
                                                //待收货
                                %>
								<div class="functionButton" id="confirmReceive">确认收货</div>
								<script>
									$(function(){
										$("#confirmReceive").one("click",function(){
											$.ajax({
												type: "post",
												url: "/confirmReceive",
												data: {
													orderId:<%=orderToShow.getOrderId()%>
												},
												dataType : "json",
												success : function(data) {
													if(data){
														window.location.reload();
													}else{
														alert("确认收货失败，服务器异常");
														window.location.reload();
													}
													
												},
												error : function() {
													alert("网络异常");
													window.location.reload();
												}
											});
										});
									});
								</script>
                                <%
                                    }
                                        else if (orderstate == 5 || orderstate == 14)
                                        {
                                                //已完成
                                                
                                %>
                         
                           		<div class="functionButton" onclick="location.href='comment.jsp?goodsId=<%=targetGoodsId%>'">我来说两句</div>
                                <%
                                    }
                                %>
                        </div>
                </div>
                <%
                	showAmount++;
                    }
                    
       
                %>
                
                
                
                
                 <%if(showAmount == 0){%>
	        <div id='noOrder'>
	        <div id='noOrderImg'><img src='../images/order.png'/></div>
	        <div id='noOrderDesc'>您还没有相关订单</div>
	        </div>
        
        <%
        }
        %>
        </div>
        
        
        
        <jsp:include page="footer.jsp" />
</body>
</html>

