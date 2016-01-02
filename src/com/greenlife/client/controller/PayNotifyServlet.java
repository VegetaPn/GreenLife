package com.greenlife.client.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.wechatservice.WechatService;



public class PayNotifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public PayNotifyServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		BufferedReader in = null;
		
		String notifyXML = "";
		
		String SUCCESS = "<xml><return_code><![CDATA[SUCCESS]]></return_code></xml>";
		String FAIL = "<xml><return_code><![CDATA[FAIL]]></return_code></xml>";
		try {
			in = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
			

			char[] buf = new char[1024];

			int length = 0;
			while ((length = in.read(buf)) != -1) {
				notifyXML += new String(buf, 0, length);
			}

			if(WechatService.finishPay(notifyXML)){
				response.getWriter().write(SUCCESS);
			}else{
				response.getWriter().write(FAIL);
			}
			
		} catch (Exception e) {

			e.printStackTrace();
			response.getWriter().write(FAIL);
		} finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
