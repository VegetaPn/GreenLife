package com.greenlife.client.controller;


import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.greenlife.util.PropertiesUtil;
import com.greenlife.wechatservice.LoginInfo;
import com.greenlife.wechatservice.WechatService;

public class LoginServlet extends HttpServlet {


	private static final long serialVersionUID = 7381169134016556647L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("code");
		
		LoginInfo loginInfo = WechatService.login(code);
		
		if(loginInfo == null){
			String appid = PropertiesUtil.getAppId();
			String url = PropertiesUtil.getURL();
		
			String refreshUrl = null;
			
			String requestUrl = request.getParameter("requestUrl");
			if(requestUrl == null){
				refreshUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appid+"&redirect_uri=http%3A%2F%2F"+url+"%2Flogin&response_type=code&scope=snsapi_userinfo#wechat_redirect";
			}else{
				refreshUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appid+"&redirect_uri=http%3A%2F%2F"+url+"%2Flogin?requestUrl="+requestUrl+"&response_type=code&scope=snsapi_userinfo#wechat_redirect";
			}
			
			response.sendRedirect(refreshUrl);
		}else{
			HttpSession session = request.getSession();
			session.setAttribute("wechatId", loginInfo.getWechatId());
			session.setAttribute("nickname",loginInfo.getNickname());
			session.setAttribute("headimgurl",loginInfo.getHeadimgurl());
			session.setAttribute("ticket", loginInfo.getTicket());
			session.setAttribute("accessToken", loginInfo.getAccessToken());
			
			String requestUrl = request.getParameter("requestUrl");
			
			if(requestUrl == null){
				response.sendRedirect("/Client/page/home.jsp");
			}else{
				response.sendRedirect(requestUrl);
			}
		}
	}
	
	
}
