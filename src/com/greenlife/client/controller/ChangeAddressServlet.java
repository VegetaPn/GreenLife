package com.greenlife.client.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.UserInfoDao;
import com.greenlife.model.UserInfo;

/**
 * Servlet implementation class ChangeAddressServlet
 */
@WebServlet("/ChangeAddressServlet")
public class ChangeAddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeAddressServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		 String wechatId = "huangjianqiang";
		 //HttpSession session = request.getSession();
		 //String wechatId = session.getAttribute("wechatId");
		 int goodsId = Integer.valueOf(request.getParameter("goodsId"));
		 String group = request.getParameter("group");
		 int addressId = Integer.valueOf(request.getParameter("addressId"));
		 
		 UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
		 userInfo.setAddrId(addressId);
		 UserInfoDao.updateUserInfo(userInfo);
		 
		 response.sendRedirect("/GreenLife/Client/page/purchase.jsp?goodsId="+goodsId+"&group="+group);
	}

}
