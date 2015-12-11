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

public class MyAddressServlet extends HttpServlet{

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
	   //������Ӧ�����õı��뷽ʽ
	   request.setCharacterEncoding("UTF-8");
	   
	   String wechatId = "huangjianqiang";
	   //HttpSession session = request.getSession();
	   //String wechatId = session.getAttribute("wechatId");
	   
	   String addressId =request.getParameter("addressid");
	   String type =request.getParameter("type");
	   
	   //return error
       if(addressId == null||type==null){
    	   //forward = "/Client/page/myAddress.jsp";
       }
       
       int itype = Integer.valueOf(type);
       
       //����Ĭ��ֵ
       if(itype == 0){
           //�޸�Ĭ�ϵ�ַ
           UserInfoDao userInfoDao = new UserInfoDao();
           UserInfo userInfo = userInfoDao.getUserInfo(wechatId);
	       userInfo.setAddrId(Integer.valueOf(addressId));
	       userInfoDao.updateUserInfo(userInfo);
       }
       //�޸�
       else if(itype == 1){
    	   
       }
       //ɾ��                        --------------------------------���
       else if(itype == 2){
    	   AdressInfoDao addressInfoDao = new AdressInfoDao();
    	   //addressInfoDao.
       }
	 }
}
