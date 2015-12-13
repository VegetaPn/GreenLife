package com.greenlife.client.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		 String trade_time = request.getParameter("sPostTime");
		 String comment = request.getParameter("iMessage");
		 double total_price = Double.valueOf(request.getParameter("sTotalPrice"));	
		 String address = request.getParameter("sAddress").trim().replaceAll(" ", ";");
		 String receiver = request.getParameter("sCusName");
		 String phone = request.getParameter("sPhoneNum");
		 
		 GoodsOrder goodsOrder = new GoodsOrder();
		 goodsOrder.setGoodsId(goodsId);
		 goodsOrder.setGoodsNum(goods_num);
		 //goodsOrder.setOrderState(orderState);
		 
		 if(group.equals("true")){
			 
		 }
		 
	}
}
