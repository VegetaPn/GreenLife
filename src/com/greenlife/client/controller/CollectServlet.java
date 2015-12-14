package com.greenlife.client.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.greenlife.dao.ConcernedListDao;
import com.greenlife.model.ConcernedList;


//@WebServlet("/CollectServlet")
public class CollectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CollectServlet() {
        super();
      
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String wechatId = null;
		

		wechatId = (String)request.getSession().getAttribute("wechatId");
		
		Integer goodsId = Integer.parseInt(request.getParameter("goodsId"));
		String isCollected = request.getParameter("isCollected");
		
		
		if(isCollected.equalsIgnoreCase("false")){
			ConcernedList list = new ConcernedList();
			list.setWechatId(wechatId);
			list.setGoodsId(goodsId);
			ConcernedListDao.addConcernedList(list);
		}else{
	
			ConcernedListDao.CancleConcerned(wechatId, goodsId);
		}
		
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
