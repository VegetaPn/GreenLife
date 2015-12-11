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
import com.greenlife.dao.WechatInfoDao;
import com.greenlife.model.UserInfo;

import net.sf.json.JSONObject;

public class LoginServlet extends HttpServlet {


	private static final long serialVersionUID = 7381169134016556647L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String appid = "wx8882f63ed713f1af";
		String secret = "d4624c36b6795d1d99dcf0547af5443d";
		
		
		String code = request.getParameter("code");

		String url = null;
		if (code != null) {
			url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appid+"&secret="+secret+"&code="
					+ code + "&grant_type=authorization_code";
		}

		String jsonStr = getStrFromURL(url);
		JSONObject jsonObject = JSONObject.fromObject(jsonStr);
		String access_token = (String)jsonObject.get("access_token");
		Integer expires_in = (Integer)jsonObject.get("expires_in");
		String refresh_token = (String)jsonObject.get("refresh_token");
		String openid = (String)jsonObject.get("openid");
		String scope = (String)jsonObject.get("scope");
		String unionid = (String)jsonObject.get("unionid");
		
		
		
		
		String refreshUrl = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid="+appid+"&grant_type=refresh_token&refresh_token="+refresh_token;
		jsonStr = getStrFromURL(refreshUrl);
		jsonObject = JSONObject.fromObject(jsonStr);
		access_token = (String)jsonObject.get("access_token");
		expires_in = (Integer)jsonObject.get("expires_in");
		refresh_token = (String)jsonObject.get("refresh_token");
		openid = (String)jsonObject.get("openid");
		scope = (String)jsonObject.get("scope");
	
		String userInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token="+access_token+"&openid="+openid+"&lang=zh_CN";
		jsonStr = getStrFromURL(userInfoUrl);
		jsonObject = JSONObject.fromObject(jsonStr);
		openid = (String)jsonObject.get("openid");
		String nickname = (String)jsonObject.get("nickname");
		Integer sex = (Integer)jsonObject.get("sex");	
		String province = (String)jsonObject.get("province");	
		String city = (String)jsonObject.get("city");	
		String country = (String)jsonObject.get("country");	
		String headimgurl = (String)jsonObject.get("headimgurl");	
		unionid = (String)jsonObject.get("unionid");
		
		
		String jsTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appid+"&secret="+secret; 
		jsonStr = getStrFromURL(jsTokenUrl);
		jsonObject = JSONObject.fromObject(jsonStr);
		
		String jsAccessToken  = (String)jsonObject.get("access_token");
		
		
		String ticketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+jsAccessToken+"&type=jsapi";
		jsonStr = getStrFromURL(ticketUrl);
		jsonObject = JSONObject.fromObject(jsonStr);
		String ticket  = (String)jsonObject.get("ticket");

		
		UserInfo userInfo = new UserInfo();
		userInfo.setWechatId(openid);
		userInfo.setWechatName(nickname);
		userInfo.setPhotoPath(headimgurl);
		
		if(!UserInfoDao.isExist(openid)){
			
			UserInfoDao.addUserInfo(userInfo);
		}else{
			UserInfoDao.updateUserInfo(userInfo);
		}
		
		
		HttpSession session = request.getSession();
		session.setAttribute("wechatId", openid);
		session.setAttribute("nickname",nickname);
		session.setAttribute("headimgurl",headimgurl);
		session.setAttribute("ticket", ticket);
		session.setAttribute("appid", appid);
		
		
		response.sendRedirect("/Client/page/home.jsp");
		
	}
	
	
	private String getStrFromURL(String url){
		StringBuilder sb = new StringBuilder();
		try {
			URL realUrl = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) realUrl.openConnection();
		
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.connect();

			InputStream in = conn.getInputStream();
			BufferedReader read = new BufferedReader(new InputStreamReader(in, "UTF-8"));
			String valueString = null;
			while ((valueString = read.readLine()) != null) {
				sb.append(valueString);
			}
			read.close();
			in.close();
			in = null;
			if (conn != null) {
				
				conn.disconnect();
			}
			
			return sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
