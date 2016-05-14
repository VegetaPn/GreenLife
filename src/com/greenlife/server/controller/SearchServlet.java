package com.greenlife.server.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.dao.UserInfoDao;
import com.greenlife.model.GoodsInfo;
import com.greenlife.model.GoodsOrder;
import com.greenlife.model.UserInfo;

import net.sf.json.JSONArray;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		int grouptype = Integer.parseInt(request.getParameter("grouptype"));
		int type = Integer.parseInt(request.getParameter("type"));
		List<GoodsOrder> person = GoodsOrderDao.getGoodsOrderListByState(type);// 团购订单付款
		List<GoodsOrder> group = GoodsOrderDao.getGoodsOrderListByState(grouptype);// 个人订单付款
		List<GoodsOrder> all = new ArrayList<GoodsOrder>();
		all.addAll(person);
		all.addAll(group);
		List<OrderDetail> alldetail = getDetail(all);
		response.setCharacterEncoding("UTF-8");
		if (alldetail.size() == 0) {
			response.getWriter().write("{ \"data\":" + "[]" + "}");
		} else {
			new JSONArray();
			response.getWriter().write("{ \"data\":" + JSONArray.fromObject(alldetail).toString() + "}");
			response.getWriter().flush();
		}
	}

	private List<OrderDetail> getDetail(List<GoodsOrder> list) {
		List<OrderDetail> orderDetailList = new ArrayList<OrderDetail>();
		for (int i = 0; i < list.size(); i++) {
			GoodsOrder order = list.get(i);
			OrderDetail temp =new OrderDetail(order);
			GoodsInfo tempgood = GoodsInfoDao.getGoodsInfo(temp.getGoodsOrder().getGoodsId());
			UserInfo tempuser = UserInfoDao.getUserInfo(temp.getGoodsOrder().getWechatId());
			temp.setGoodsName(tempgood.getGoodsName());
			temp.setWeichatName(tempuser.getWechatName());
			temp.setBuytype(order.getOrderState());

			orderDetailList.add(temp);
		}

		return orderDetailList;
	}

}
