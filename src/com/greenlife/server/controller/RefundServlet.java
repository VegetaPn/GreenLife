package com.greenlife.server.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.GoodsOrder;
import com.greenlife.services.GoodsOrderService;

/**
 * Servlet implementation class RefundServlet
 */
@WebServlet("/RefundServlet")
public class RefundServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RefundServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String orderId = request.getParameter("orderId");
		String locate=request.getParameter("locate");
		GoodsOrder order = null;
		GoodsOrderDao dao = new GoodsOrderDao();
		order = dao.getGoodsOrderById(Integer.parseInt(orderId));
		// 取消订单
		GoodsOrderService.cancleOrder(order);

		System.out.println("post");
		// System.out.println("now order_state:" + order.getOrderState());

		response.sendRedirect(locate);

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getSession().getAttribute("login") == null) {// 用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		} else {
		this.doPost(request, response);
		}

	}

}
