package com.greenlife.client.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.dao.TodayGroupDao;
import com.greenlife.model.GoodsInfo;
import com.greenlife.model.GoodsOrder;
import com.greenlife.model.TodayGroup;
import com.greenlife.services.GoodsInfoService;
import com.greenlife.services.TodayGroupService;
import com.greenlife.wechatservice.WechatService;


public class PurchaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");
		   
		 String wechatId = (String)request.getSession().getAttribute("wechatId");
		 int goodsId = Integer.valueOf(request.getParameter("goodsId"));
		 String group = request.getParameter("group");
		 
		 GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsId);
		 if(GoodsInfoService.getGoodsStatus(goodsInfo) != 1){
			 return;
		 }
		 
		 
		 
		 int goods_num = Integer.valueOf(request.getParameter("iNumber"));
		 String send_time = request.getParameter("sPostTime");
		 String comment = request.getParameter("iMessage");
		 double total_price = Double.valueOf(request.getParameter("sTotalPrice"));	
		 String address = request.getParameter("sAddress").trim().replaceAll(" ", ";");
		 String receiver = request.getParameter("sCusName");
		 String phone = request.getParameter("sPhoneNum");
		 String orderTime = request.getParameter("orderTime");
		 double mailPrice = Double.valueOf(request.getParameter("mailPrice"));
		 
		 int serchOrderId = GoodsOrderDao.getOrderIdByWechatIdAndOrderTime(wechatId, orderTime);
		 
		 if(serchOrderId==-1){
			 GoodsOrder goodsOrder = new GoodsOrder();
			 goodsOrder.setGoodsId(goodsId);
			 goodsOrder.setGoodsNum(goods_num);
			 goodsOrder.setAddrDetail(address);
			 goodsOrder.setComment(comment);
			 goodsOrder.setPhoneNumber(phone);
			 goodsOrder.setReceiverName(receiver);
			 goodsOrder.setTotalPrice(total_price);
			 goodsOrder.setWechatId(wechatId);
			 goodsOrder.setGroupMinnum(2);
			 goodsOrder.setSendTime(send_time);
			 goodsOrder.setOrderTime(orderTime);
			 goodsOrder.setMailPrice(mailPrice);
			 Date now = new Date(); 
			 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
			 String tradeTime = dateFormat.format(now); 
			 goodsOrder.setTradeTime(tradeTime);
			 
			 
			 if(group.equals("true")){
				 goodsOrder.setOrderState(1);
			 }
			 else if(group.equals("false")){
				 goodsOrder.setOrderState(11);
			 } else{
				 int groupId = Integer.parseInt(group);
				 
				 TodayGroup todayGroup = TodayGroupDao.getTodayGroup(groupId);
				 if(todayGroup.getIsDelete() == 1 || TodayGroupService.isInGroup(groupId,wechatId)){
					 return;
				 }
				 
				 goodsOrder.setOrderState(1);
				 goodsOrder.setGroupId(groupId);
			 }
			 
			 
			 int orderId = GoodsOrderDao.addGoodsOrder(goodsOrder);
			 
			 response.setContentType("application/json");	
			 PrintWriter out = response.getWriter();
			 out.write("{\"result\":\"success\",\"orderId\":"+orderId+"}");
			//out.write("orderId="+orderId);
		 }else{
			 response.setContentType("application/json");
			 PrintWriter out = response.getWriter();
			 out.write("{\"result\":\"failure\",\"orderId\":"+serchOrderId+"}");
		 }
		 
		
	}
	
	
	
}




