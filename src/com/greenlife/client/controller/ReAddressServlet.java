package com.greenlife.client.controller;

import java.io.IOException;

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
	   
	   String wechatId = "huangjianqiang";
	   //HttpSession session = request.getSession();
	   //String wechatId = session.getAttribute("wechatId");
	   String type = request.getParameter("type");
	   int iType = Integer.valueOf(type);
	   
	   int addrId = -1;		   
	   String receiverName =request.getParameter("iConsignee");
	   String receiverPhone =request.getParameter("iPhnoe");
	   String addrDetail1  =request.getParameter("iRegione").trim();  
	   addrDetail1 = addrDetail1.replaceAll(" ",";");
	   
	   if(addrDetail1.split(";").length == 2){
		   addrDetail1 +=";null";
	   }
	   else if(addrDetail1.split(";").length == 1){
		   addrDetail1 +=";null;null";
	   }
	   
	   String addrDetail2  = request.getParameter("iAddress");
	   StringBuffer addrDetail = new StringBuffer(addrDetail1+";"+ addrDetail2);
	   String zipAddress = request.getParameter("zipAddress");
	   String check = request.getParameter("iCheck");
	   
	   AdressInfo address = new AdressInfo();
	   address.setWechatId(wechatId);
	   address.setAddrZipcode(zipAddress); 
	   address.setReceiverName(receiverName);
	   address.setReceiverPhone(receiverPhone);
       address.setAddrDetail(addrDetail.toString());
       
       if(iType == 1){
    	   addrId = Integer.valueOf(request.getParameter("addressid"));
    	   address.setAddrId(addrId);
           //更新地址
    	   if(addrId!=-1)
    		   AdressInfoDao.updateAdressInfo(address);
       }
       else{
    	   addrId = AdressInfoDao.addAdressInfo(address);
    	   //如果userInfo无默认地址，则将其改成默认地址
           UserInfo userInfo = UserInfoDao.getUserInfo(wechatId);
	       if(userInfo.getAddrId()<=0){
	    	   userInfo.setAddrId(addrId);
	    	   UserInfoDao.updateUserInfo(userInfo);
	       }
       }

      //int addrid = addressInfoDao.addAdressInfo(address);
       
       if(addrId !=-1){
           //修改默认地址
           if(check!=null){
        	   UserInfoDao userInfoDao = new UserInfoDao();
        	   UserInfo userInfo = userInfoDao.getUserInfo(wechatId);
        	   userInfo.setAddrId(addrId);
        	   userInfoDao.updateUserInfo(userInfo);
           }
       }  
       
      String group = request.getParameter("group");
	  String goodsId = request.getParameter("goodsId");
	  if(group == null)
           response.sendRedirect("/GreenLife/Client/page/myAddress.jsp");
	  else
		   response.sendRedirect("/GreenLife/Client/page/changeAddress.jsp?group="+group+"&goodsId="+goodsId);
	 }
}
