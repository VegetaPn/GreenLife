package com.greenlife.client.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.wechatservice.PayInfo;
import com.greenlife.wechatservice.WechatService;

import net.sf.json.JSONObject;


public class PayFinishServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public PayFinishServlet() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("orderId"));

		if(WechatService.QueryPaySuccess(orderId)){
			response.getWriter().write(JSONObject.fromObject(true).toString());
		}else{
			response.getWriter().write(JSONObject.fromObject(false).toString());
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
