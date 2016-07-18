package com.greenlife.server.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
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
		
		
		int groupType = Integer.parseInt(request.getParameter("grouptype"));
		int type = Integer.parseInt(request.getParameter("type"));
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String condition = request.getParameter("search[value]");
		int total=0;
		
		List<GoodsOrder> showedList =null;
		if(condition.equals("")){
			 showedList =GoodsOrderDao.getGoodsOrderListWithoutSearch(groupType, type, start, length);
			 total =GoodsOrderDao.getCountByState(groupType)+GoodsOrderDao.getCountByState(type);
		}else{
			showedList =GoodsOrderDao.getGoodsOrderListAndSearch(groupType, type, start, length,condition);
			total =GoodsOrderDao.getCountWithSearchCondition(groupType, type, condition);
		}
		
	
		
		List<OrderDetail> showedDetailList = this.getDetail(showedList);
		response.setCharacterEncoding("UTF-8");
		String totalString ="{\"start\":" +"\""+start+"\""+","+
				            
							"\"recordsTotal\":" +"\""+total+"\""+","+
							"\"recordsFiltered\":" +"\""+total+"\""+",";
		if (showedDetailList.size() == 0) {
			response.getWriter().write(totalString+" \"data\":" + "[]" + "}");
		} else {
			new JSONArray();
			response.getWriter().write(totalString+" \"data\":" + JSONArray.fromObject(showedDetailList).toString() + "}");
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
