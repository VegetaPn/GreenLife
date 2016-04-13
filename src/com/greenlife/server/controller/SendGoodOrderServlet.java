package com.greenlife.server.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.GoodsOrder;

/**
 * Servlet implementation class SendGoodOrderServlet
 */

public class SendGoodOrderServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		if (request.getSession().getAttribute("login") == null) {// 用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		} else {
			request.setCharacterEncoding("UTF-8");
			int orderId = Integer.parseInt(request.getParameter("orderId"));
			
			GoodsOrder order = new GoodsOrder();
			GoodsOrderDao dao = new GoodsOrderDao();
			order = dao.getGoodsOrderById(orderId);
			int order_state = order.getOrderState();
			order.setOrderState(order_state + 1);
			
			dao.updateGoodsOrder(order);
			response.sendRedirect("/Server/Page/tosend.jsp");
		}

	}

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SendGoodOrderServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

}
