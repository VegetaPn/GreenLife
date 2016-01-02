package com.greenlife.client.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.AdressInfoDao;
import com.greenlife.dao.UserInfoDao;
import com.greenlife.model.AdressInfo;
import com.greenlife.model.UserInfo;

public class MyAddressServlet extends HttpServlet{

	
	
	private static final long serialVersionUID = 1L;

	 public void doGet(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
	   doPost(request,response);
	 }

	 public void doPost(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
	  
	   request.setCharacterEncoding("UTF-8");
	   
	 
	 
	   String wechatId = (String)request.getSession().getAttribute("wechatId");
	   
	   String addressId =request.getParameter("addressid");
	   String type =request.getParameter("type");
	   
	   //return error
       if(addressId == null||type==null){
    	   //forward = "/Client/page/myAddress.jsp";
       }
       
       int itype = Integer.valueOf(type);
       int iAddress = Integer.valueOf(addressId);
       
       
       if(itype == 0){
           UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
	       userInfo.setAddrId(Integer.valueOf(addressId));
	       UserInfoDao.updateUserInfo(userInfo);
       }

       else if(itype == 1){
    	   AdressInfoDao.deleteAdressList(iAddress);
    	   
       	   UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
    	   if(iAddress == userInfo.getAddrId()){
    		   List<AdressInfo> addressInfos = AdressInfoDao.getAdressList(wechatId);
    		   if(addressInfos!=null&&addressInfos.size()>0){
    			   userInfo.setAddrId(addressInfos.get(0).getAddrId());
    			   UserInfoDao.updateUserInfo(userInfo);
    			   
    			  
    			   PrintWriter out = response.getWriter();
    			   out.write("defualt="+addressInfos.get(0).getAddrId()); 
    		   }
    		   else{
    			   userInfo.setAddrId(0);
    			   UserInfoDao.updateUserInfo(userInfo);
    		   }
    	   }
       }
	 }
}
