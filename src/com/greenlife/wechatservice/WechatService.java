package com.greenlife.wechatservice;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.dao.UserInfoDao;
import com.greenlife.model.GoodsInfo;
import com.greenlife.model.GoodsOrder;
import com.greenlife.model.UserInfo;
import com.greenlife.util.PropertiesUtil;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;

import net.sf.json.JSONObject;

public class WechatService {
	public static WechatInfo login(String code) {
		String appid = PropertiesUtil.getAppId();
		String secret = PropertiesUtil.getAppsecret();

		String url = null;
		if (code != null) {
			url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appid + "&secret=" + secret + "&code="
					+ code + "&grant_type=authorization_code";
		}

		String jsonStr = getJsonStrFromURL(url);
		JSONObject jsonObject = JSONObject.fromObject(jsonStr);
		String access_token = (String) jsonObject.get("access_token");
		Integer expires_in = (Integer) jsonObject.get("expires_in");
		String refresh_token = (String) jsonObject.get("refresh_token");
		String openid = (String) jsonObject.get("openid");
		String scope = (String) jsonObject.get("scope");
		String unionid = (String) jsonObject.get("unionid");

		String refreshUrl = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=" + appid
				+ "&grant_type=refresh_token&refresh_token=" + refresh_token;
		jsonStr = getJsonStrFromURL(refreshUrl);
		jsonObject = JSONObject.fromObject(jsonStr);
		access_token = (String) jsonObject.get("access_token");
		expires_in = (Integer) jsonObject.get("expires_in");
		refresh_token = (String) jsonObject.get("refresh_token");
		openid = (String) jsonObject.get("openid");
		scope = (String) jsonObject.get("scope");

		String userInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=" + access_token + "&openid=" + openid
				+ "&lang=zh_CN";
		jsonStr = getJsonStrFromURL(userInfoUrl);
		jsonObject = JSONObject.fromObject(jsonStr);
		openid = (String) jsonObject.get("openid");
		String nickname = (String) jsonObject.get("nickname");
		Integer sex = (Integer) jsonObject.get("sex");
		String province = (String) jsonObject.get("province");
		String city = (String) jsonObject.get("city");
		String country = (String) jsonObject.get("country");
		String headimgurl = (String) jsonObject.get("headimgurl");
		unionid = (String) jsonObject.get("unionid");

		String jsTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appid
				+ "&secret=" + secret;
		jsonStr = getJsonStrFromURL(jsTokenUrl);
		jsonObject = JSONObject.fromObject(jsonStr);

		String jsAccessToken = (String) jsonObject.get("access_token");

		String ticketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + jsAccessToken
				+ "&type=jsapi";
		jsonStr = getJsonStrFromURL(ticketUrl);
		jsonObject = JSONObject.fromObject(jsonStr);
		String ticket = (String) jsonObject.get("ticket");

		UserInfo userInfo = new UserInfo();
		userInfo.setWechatId(openid);
		userInfo.setWechatName(nickname);
		userInfo.setPhotoPath(headimgurl);

		if (!UserInfoDao.isExist(openid)) {

			UserInfoDao.addUserInfo(userInfo);
		} else {
			UserInfoDao.updateUserInfo(userInfo);
		}

		WechatInfo wechatInfo = new WechatInfo();
		wechatInfo.setAccessToken(jsAccessToken);
		wechatInfo.setCity(city);
		wechatInfo.setCountry(country);
		wechatInfo.setHeadimgurl(headimgurl);
		wechatInfo.setNickname(nickname);
		wechatInfo.setProvince(province);
		wechatInfo.setSex(sex);
		wechatInfo.setTicket(ticket);
		wechatInfo.setUnionId(unionid);
		wechatInfo.setWechatId(openid);

		return wechatInfo;
	}

	public static boolean placeOrder(GoodsOrder goodsOrder, String userIp, String wechatId) {
		GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsOrder.getGoodsId());

		PlaceOrderInfo placeOrderInfo = new PlaceOrderInfo();

		placeOrderInfo.setAppid(PropertiesUtil.getAppId());
		placeOrderInfo.setMch_id(PropertiesUtil.getMchId());
		placeOrderInfo.setDevice_info("WEB");
		placeOrderInfo.setNonce_str("abcdefg");
		placeOrderInfo.setBody(goodsInfo.getGoodsName());
		placeOrderInfo.setOut_trade_no(Long.toString(new Date().getTime()));
		placeOrderInfo.setTotal_fee(((int) (goodsOrder.getTotalPrice() * 100)));
		placeOrderInfo.setSpbill_create_ip(userIp);
		placeOrderInfo.setNotify_url("http://" + PropertiesUtil.getURL() + "/notify");
		placeOrderInfo.setTrade_type("JSAPI");
		placeOrderInfo.setOpenid(wechatId);
		placeOrderInfo.setKey("");

		List<String> strs = new ArrayList<String>();
		strs.add("appid=" + placeOrderInfo.getAppid());
		strs.add("mch_id=" + placeOrderInfo.getMch_id());
		strs.add("device_info=" + placeOrderInfo.getDevice_info());
		strs.add("nonce_str=" + placeOrderInfo.getNonce_str());
		strs.add("body=" + placeOrderInfo.getBody());
		strs.add("out_trade_no=" + placeOrderInfo.getOut_trade_no());
		strs.add("total_fee=" + placeOrderInfo.getTotal_fee());
		strs.add("spbill_create_ip=" + placeOrderInfo.getSpbill_create_ip());
		strs.add("notify_url=" + placeOrderInfo.getNotify_url());
		strs.add("trade_type=" + placeOrderInfo.getTrade_type());
		strs.add("openid=" + placeOrderInfo.getOpenid());
		Collections.sort(strs);
		strs.add("key=" + placeOrderInfo.getKey());

		String sign = MD5Signature((String[]) strs.toArray());
		placeOrderInfo.setSign(sign);
		
		
		XStream xs = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		xs.alias("xml", PlaceOrderInfo.class);
		String xml = xs.toXML(placeOrderInfo);

		String url = "https://api.mch.weixin.qq.com/pay/unifiedorder";

		String returnXml = postXML(url, xml);
		PlaceOrderReturnInfo reInfo = new PlaceOrderReturnInfo();
		XStream xs1 = new XStream(new DomDriver());
		xs1.alias("xml", PlaceOrderReturnInfo.class);
		reInfo = (PlaceOrderReturnInfo) xs1.fromXML(returnXml);

		String return_code = reInfo.getReturn_code();
		
		if(return_code == "FAIL"){ 
			return false; 
		}
		
	
		 String result_code = reInfo.getResult_code();
		
		 if(result_code == "FAIL"){ 
			 String err_code_des = reInfo.getErr_code_des();
	
			 System.out.println("下单失败(错误描述："+err_code_des+")"); 
			 return false; 
		 }
		 
		 
		 
		// 存入数据库操作 out_trade_no prepay_id

		return true;
	}

	public static String postXML(String urlStr, String xmlInfo) {
		OutputStreamWriter out = null;
		BufferedReader in = null;

		try {
			URL url;
			url = new URL(urlStr);
			URLConnection con = url.openConnection();
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setRequestProperty("Pragma:", "no-cache");
			con.setRequestProperty("Cache-Control", "no-cache");
			con.setRequestProperty("Content-Type", "text/xml");
			out = new OutputStreamWriter(con.getOutputStream());
			out.write(new String(xmlInfo.getBytes("UTF-8")));
			out.flush();

			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String str = "";

			char[] buf = new char[1024];

			int length = 0;
			while ((length = in.read(buf)) != -1) {
				str += new String(buf, 0, length);
			}

			return str;
		} catch (Exception e) {

			e.printStackTrace();
			return null;
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

	}

	public static String MD5Signature(String[] strs) {

		int length = strs.length;

		if (length == 0) {
			return null;
		}

		String str = "";
		for (int i = 0; i < length - 1; i++) {
			str += strs[i] + "&";
		}

		str += strs[length - 1];

		MessageDigest md = null;
		String signature = null;

		try {
			md = MessageDigest.getInstance("MD5");

			byte[] digest = md.digest(str.toString().getBytes("UTF-8"));
			signature = byteToStr(digest);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return signature;

	}

	public static String buildSignature(String noncestr, String jsapi_ticket, String timestamp, String url) {

		String str = "jsapi_ticket=" + jsapi_ticket + "&" + "noncestr=" + noncestr + "&" + "timestamp=" + timestamp
				+ "&" + "url=" + url;

		MessageDigest md = null;
		String signature = null;

		try {
			md = MessageDigest.getInstance("SHA-1");

			byte[] digest = md.digest(str.toString().getBytes());
			signature = byteToStr(digest);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return signature;
	}

	private static String byteToStr(byte[] byteArray) {
		String strDigest = "";
		for (int i = 0; i < byteArray.length; i++) {
			strDigest += byteToHexStr(byteArray[i]);
		}
		return strDigest;
	}

	private static String byteToHexStr(byte mByte) {
		char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
		tempArr[1] = Digit[mByte & 0X0F];

		String s = new String(tempArr);
		return s;
	}

	private static String getJsonStrFromURL(String url) {
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
