package com.greenlife.client.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.AdressInfoDao;
import com.greenlife.dao.UserInfoDao;
import com.greenlife.model.AdressInfo;
import com.greenlife.model.UserInfo;

public class ReAddressServlet extends HttpServlet{

	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	 public void doGet(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
	   doPost(request,response);
	 }

	 public void doPost(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
	   //设置响应所采用的编码方式
	   request.setCharacterEncoding("UTF-8");
	   
	   String wechatId = request.getParameter("wechatId");
	   String receiverName =request.getParameter("iConsignee");
	   String receiverPhone =request.getParameter("iPhnoe");
	   String addrDetail1  =request.getParameter("iRegione");
	   String addrDetail2  =request.getParameter("iAddress");
	   StringBuffer addrDetail = new StringBuffer(addrDetail1+" "+ addrDetail2);
	   String check =request.getParameter("iCheck");
	   
	   AdressInfo address = new AdressInfo();
	   address.setWechatId(wechatId);
	   address.setAddrZipcode("10044");             //先自己设置
	   address.setReceiverName(receiverName);
	   address.setReceiverPhone(receiverPhone);
       address.setAddrDetail(addrDetail.toString());
       
       AdressInfoDao addressInfoDao = new AdressInfoDao();
       addressInfoDao.addAdressInfo(address);
	   
       //修改默认地址
       if(check!=null){
    	   UserInfoDao userInfoDao = new UserInfoDao();
    	   UserInfo userInfo = new UserInfo();
    	   userInfo = userInfoDao.getUserInfo(wechatId);
    	   userInfo.setAddrId(address.getAddrId());
       }
       
       
	  String forward = "/Client/page/home.jsp";
	  RequestDispatcher rd=request.getRequestDispatcher(forward);
	  rd.forward(request,response);
	 }
}
