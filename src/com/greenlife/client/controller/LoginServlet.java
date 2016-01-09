package com.greenlife.client.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.greenlife.dao.UserInfoDao;
import com.greenlife.model.UserInfo;
import com.greenlife.util.PropertiesUtil;
import com.greenlife.wechatservice.WechatInfo;
import com.greenlife.wechatservice.WechatService;

import net.sf.json.JSONObject;

public class LoginServlet extends HttpServlet {


	private static final long serialVersionUID = 7381169134016556647L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("code");
		
		WechatInfo wechatInfo = WechatService.login(code);
		
		HttpSession session = request.getSession();
		session.setAttribute("wechatId", wechatInfo.getWechatId());
		session.setAttribute("nickname",wechatInfo.getNickname());
		session.setAttribute("headimgurl",wechatInfo.getHeadimgurl());
		session.setAttribute("ticket", wechatInfo.getTicket());
		session.setAttribute("accessToken", wechatInfo.getAccessToken());
		
		String requestUrl = request.getParameter("requestUrl");
		
		if(requestUrl == null){
			response.sendRedirect("/Client/page/home.jsp");
		}else{
			response.sendRedirect(requestUrl);
		}
		
		
		
	}
	
	
}
