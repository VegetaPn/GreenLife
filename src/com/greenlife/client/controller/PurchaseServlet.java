package com.greenlife.client.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.GoodsOrder;

/**
 * Servlet implementation class PurchaseServlet
 */
//@WebServlet("/PurchaseServlet")
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
		// TODO Auto-generated method stub
		 request.setCharacterEncoding("UTF-8");
		   
		 String wechatId = "huangjianqiang";
		 //HttpSession session = request.getSession();
		 //String wechatId = session.getAttribute("wechatId");
		 int goodsId = Integer.valueOf(request.getParameter("goodsId"));
		 String group = request.getParameter("group");
		 
		 int goods_num = Integer.valueOf(request.getParameter("iNumber"));
		 String send_time = request.getParameter("sPostTime");
		 String comment = request.getParameter("iMessage");
		 double total_price = Double.valueOf(request.getParameter("sTotalPrice"));	
		 String address = request.getParameter("sAddress").trim().replaceAll(" ", ";");
		 String receiver = request.getParameter("sCusName");
		 String phone = request.getParameter("sPhoneNum");
		 
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
		 
		 Date now = new Date(); 
		 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
		 String tradeTime = dateFormat.format( now ); 
		 goodsOrder.setTradeTime(tradeTime);
		 goodsOrder.setMailPrice(0);
		 
		 if(group.equals("true")){
			 goodsOrder.setOrderState(1);
		 }
		 else{
			 goodsOrder.setOrderState(11);
		 }
		 
		 GoodsOrderDao.addGoodsOrder(goodsOrder);
		 
	}
}
