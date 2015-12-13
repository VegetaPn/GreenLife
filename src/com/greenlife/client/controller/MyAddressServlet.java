package com.greenlife.client.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
	   //设置响应所采用的编码方式
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
       int iAddress = Integer.valueOf(addressId);
       
       //设置默认值
       if(itype == 0){
           //修改默认地址
           UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
	       userInfo.setAddrId(Integer.valueOf(addressId));
	       UserInfoDao.updateUserInfo(userInfo);
       }
       //删除  
       else if(itype == 1){
    	   AdressInfoDao.deleteAdressList(iAddress);
    	   
    	   //判断删除的时候是默认地址，如果是默认地址，则修改默认地址
    	   UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
    	   if(iAddress == userInfo.getAddrId()){
    		   List<AdressInfo> addressInfos = AdressInfoDao.getAdressList(wechatId);
    		   if(addressInfos!=null&&addressInfos.size()>0){
    			   userInfo.setAddrId(addressInfos.get(0).getAddrId());
    			   UserInfoDao.updateUserInfo(userInfo);
    			   
    			   //向ajax返回数据
    			   PrintWriter out = response.getWriter();
    			   out.write("defualt="+addressInfos.get(0).getAddrId()); 
    		   }
    		   else{
    			   userInfo.setAddrId(-1);
    			   UserInfoDao.updateUserInfo(userInfo);
    		   }
    	   }
       }
	 }
}
