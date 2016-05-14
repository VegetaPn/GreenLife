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
		// TODO Auto-generated method stub
		if (request.getSession().getAttribute("login") == null) {// 用户没有登录
			response.getWriter().write("403");
		} else {

			String orderId = request.getParameter("orderId");
			GoodsOrder order = null;
			GoodsOrderDao dao = new GoodsOrderDao();
			order = GoodsOrderDao.getGoodsOrderById(Integer.parseInt(orderId));

			if (GoodsOrderService.cancleOrder(order)) {
				response.getWriter().write("yes");
			} else {
				response.getWriter().write("no");
			}

			response.getWriter().flush();
		}

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
