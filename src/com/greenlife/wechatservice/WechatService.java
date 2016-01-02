package com.greenlife.wechatservice;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.dao.TodayGroupDao;
import com.greenlife.dao.UserInfoDao;
import com.greenlife.model.GoodsInfo;
import com.greenlife.model.GoodsOrder;
import com.greenlife.model.TodayGroup;
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

		

		if (!UserInfoDao.isExist(openid)) {
			UserInfo userInfo = new UserInfo();
			userInfo.setWechatId(openid);
			userInfo.setWechatName(nickname);
			userInfo.setPhotoPath(headimgurl);
			UserInfoDao.addUserInfo(userInfo);
		} else {
			UserInfo userInfo = UserInfoDao.getUserInfo(openid);
			userInfo.setWechatId(openid);
			userInfo.setWechatName(nickname);
			userInfo.setPhotoPath(headimgurl);
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

	public static PayInfo placeOrder(int orderId, String userIp) {
		GoodsOrder goodsOrder = GoodsOrderDao.getGoodsOrderById(orderId);
		GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsOrder.getGoodsId());

		
		if(goodsOrder.getOrderState() != 1 && goodsOrder.getOrderState() != 11){
			return null;
		}
		
		PlaceOrderInfo placeOrderInfo = new PlaceOrderInfo();

		placeOrderInfo.setAppid(PropertiesUtil.getAppId());
		placeOrderInfo.setMch_id(PropertiesUtil.getMchId());
		placeOrderInfo.setDevice_info("WEB");
		placeOrderInfo.setNonce_str("abcdefg");
		placeOrderInfo.setBody(goodsInfo.getGoodsName());
		placeOrderInfo.setOut_trade_no(Long.toString(new Date().getTime()));
		placeOrderInfo.setTotal_fee(((int) (goodsOrder.getTotalPrice() * 100)));
		placeOrderInfo.setSpbill_create_ip(userIp);
		placeOrderInfo.setNotify_url("http://" + PropertiesUtil.getURL() + "/payNotify");
		placeOrderInfo.setTrade_type("JSAPI");
		placeOrderInfo.setOpenid(goodsOrder.getWechatId());

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

		String sign = MD5Signature(strs);
		placeOrderInfo.setSign(sign);

		XStream xs = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		xs.alias("xml", PlaceOrderInfo.class);
		String xml = xs.toXML(placeOrderInfo);

		String url = "https://api.mch.weixin.qq.com/pay/unifiedorder";

		String returnXml = postXML(url, xml);
		
		if(returnXml == null){
			return null;
		}
		
		PlaceOrderReturnInfo reInfo = new PlaceOrderReturnInfo();
		XStream xs1 = new XStream(new DomDriver());
		xs1.alias("xml", PlaceOrderReturnInfo.class);
		reInfo = (PlaceOrderReturnInfo) xs1.fromXML(returnXml);

		String return_code = reInfo.getReturn_code();
		String return_msg = reInfo.getReturn_msg();
		if (return_code.equals("FAIL")) {

			System.out.println("下单失败（错误描述：" + return_msg + "）");
			return null;
		}

		String result_code = reInfo.getResult_code();

		if (result_code.equals("FAIL")) {
			String err_code_des = reInfo.getErr_code_des();

			System.out.println("下单失败（错误描述：" + err_code_des + "）");
			return null;
		}

		
		goodsOrder.setOutTradeNo(placeOrderInfo.getOut_trade_no());
		goodsOrder.setPrepayId(reInfo.getPrepay_id());
		if(!GoodsOrderDao.updateGoodsOrder(goodsOrder)){
			return null;
		}
		
		PayInfo payInfo = new PayInfo();
		payInfo.setAppId(placeOrderInfo.getAppid());
		payInfo.setTimeStamp(Long.toString((new Date()).getTime()));
		payInfo.setNonceStr("abcdefg");
		payInfo.setMyPackage("prepay_id="+reInfo.getPrepay_id());
		payInfo.setSignType("MD5");
		
		List<String> strs1 = new ArrayList<String>();
		
		strs1.add("appId=" + payInfo.getAppId());
		strs1.add("timeStamp=" + payInfo.getTimeStamp());
		strs1.add("nonceStr=" + payInfo.getNonceStr());
		strs1.add("package=" + payInfo.getMyPackage());
		strs1.add("signType=" + payInfo.getSignType());
		
		String paySign = WechatService.MD5Signature(strs1);
		payInfo.setPaySign(paySign);
		
		
		return payInfo;
	}

	public static boolean QueryPaySuccess(int orderId){
		GoodsOrder goodsOrder = GoodsOrderDao.getGoodsOrderById(orderId);
		
		QueryOrderReturnInfo reInfo = queryOrder(goodsOrder);
		
		if(reInfo == null){
			return true;
		}
		
		if(!reInfo.getTrade_state().equals("SUCCESS")){
			return false;
		}
		
		return true;
	}
	
	public static QueryOrderReturnInfo queryOrder(GoodsOrder goodsOrder) {
		QueryOrderInfo queryOrderInfo = new QueryOrderInfo();

		queryOrderInfo.setAppid(PropertiesUtil.getAppId());
		queryOrderInfo.setMch_id(PropertiesUtil.getMchId());
		queryOrderInfo.setNonce_str("abcdefg");
		queryOrderInfo.setOut_trade_no(goodsOrder.getOutTradeNo());
		queryOrderInfo.setTransaction_id(goodsOrder.getTransactionId());

		List<String> strs = new ArrayList<String>();
		strs.add("appid=" + queryOrderInfo.getAppid());
		strs.add("mch_id=" + queryOrderInfo.getMch_id());
		strs.add("nonce_str=" + queryOrderInfo.getNonce_str());

		if (queryOrderInfo.getTransaction_id() != null) {
			strs.add("transaction_id=" + queryOrderInfo.getTransaction_id());
		}

		strs.add("out_trade_no=" + queryOrderInfo.getOut_trade_no());

		String sign = MD5Signature(strs);

		queryOrderInfo.setSign(sign);

		XStream xs = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		xs.alias("xml", QueryOrderInfo.class);
		String xml = xs.toXML(queryOrderInfo);

		String url = "https://api.mch.weixin.qq.com/pay/orderquery";

		String returnXml = postXML(url, xml);

		if(returnXml == null){
			return null;
		}
		
		
		QueryOrderReturnInfo reInfo = new QueryOrderReturnInfo();
		XStream xs1 = new XStream(new DomDriver());
		xs1.alias("xml", QueryOrderReturnInfo.class);
		reInfo = (QueryOrderReturnInfo) xs1.fromXML(returnXml);

		if(reInfo.getReturn_code().equals("FAIL")){
			return null;
		}
		
		if(reInfo.getResult_code().equals("FAIL")){
			return null;
		}
		
		
		return reInfo;
	}

	public static boolean closeOrder(GoodsOrder goodsOrder) {
		CloseOrderInfo closeOrderInfo = new CloseOrderInfo();

		closeOrderInfo.setAppid(PropertiesUtil.getAppId());
		closeOrderInfo.setMch_id(PropertiesUtil.getMchId());
		closeOrderInfo.setNonce_str("abcdefg");
		closeOrderInfo.setOut_trade_no("");

		List<String> strs = new ArrayList<String>();
		strs.add("appid=" + closeOrderInfo.getAppid());
		strs.add("mch_id=" + closeOrderInfo.getMch_id());
		strs.add("nonce_str=" + closeOrderInfo.getNonce_str());
		strs.add("out_trade_no=" + closeOrderInfo.getOut_trade_no());

		String sign = MD5Signature(strs);

		closeOrderInfo.setSign(sign);

		XStream xs = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		xs.alias("xml", CloseOrderInfo.class);
		String xml = xs.toXML(closeOrderInfo);

		String url = "https://api.mch.weixin.qq.com/pay/closeorder";

		String returnXml = postXML(url, xml);

		if(returnXml == null){
			return false;
		}
		
		CloseOrderReturnInfo reInfo = new CloseOrderReturnInfo();
		XStream xs1 = new XStream(new DomDriver());
		xs1.alias("xml", CloseOrderReturnInfo.class);
		reInfo = (CloseOrderReturnInfo) xs1.fromXML(returnXml);

		if (reInfo.getReturn_code().equals("FAIL")) {
			System.out.println("关闭订单失败（错误描述：" + reInfo.getReturn_msg() + "）");
			return false;
		}

		if (reInfo.getErr_code() != null) {
			System.out.println("关闭订单失败（错误描述" + reInfo.getErr_code_des() + "）");
			return false;
		}

		return true;
	}

	public static boolean refund(GoodsOrder goodsOrder) {

		RefundInfo refundInfo = new RefundInfo();

		refundInfo.setAppid(PropertiesUtil.getAppId());
		refundInfo.setMch_id(PropertiesUtil.getMchId());
		refundInfo.setDevice_info("WEB");
		refundInfo.setNonce_str("abcdefg");
		refundInfo.setTransaction_id(goodsOrder.getTransactionId());
		refundInfo.setOut_trade_no(goodsOrder.getOutTradeNo());

		refundInfo.setOut_refund_no(Long.toString(new Date().getTime()));
		refundInfo.setTotal_fee(((int) (goodsOrder.getTotalPrice() * 100)));
		refundInfo.setRefund_fee(((int) (goodsOrder.getTotalPrice() * 100)));
		refundInfo.setOp_user_id(PropertiesUtil.getMchId());
		
		
		List<String> strs = new ArrayList<String>();
		strs.add("appid=" + refundInfo.getAppid());
		strs.add("mch_id=" + refundInfo.getMch_id());
		strs.add("device_info=" + refundInfo.getDevice_info());
		strs.add("nonce_str=" + refundInfo.getNonce_str());

		if (refundInfo.getTransaction_id() != null) {
			strs.add("transaction_id=" + refundInfo.getTransaction_id());
		}

		strs.add("out_trade_no=" + refundInfo.getOut_trade_no());

		strs.add("out_refund_no=" + refundInfo.getOut_refund_no());
		strs.add("total_fee=" + refundInfo.getTotal_fee());
		strs.add("refund_fee=" + refundInfo.getRefund_fee());
		strs.add("op_user_id=" + refundInfo.getOp_user_id());

		String sign = MD5Signature(strs);

		refundInfo.setSign(sign);
		
		XStream xs = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		xs.alias("xml", RefundInfo.class);
		String xml = xs.toXML(refundInfo);

		String url = "https://api.mch.weixin.qq.com/secapi/pay/refund";

		String returnXml = useCertToHttpPost(url, xml);

		if(returnXml == null){
			return false;
		}
		
		
		RefundReturnInfo reInfo = new RefundReturnInfo();
		XStream xs1 = new XStream(new DomDriver());
		xs1.alias("xml", RefundReturnInfo.class);
		reInfo = (RefundReturnInfo) xs1.fromXML(returnXml);

		if (reInfo.getReturn_code().equals("FAIL")) {
			System.out.println("退款失败（错误描述：" + reInfo.getReturn_msg() + "）");
			return false;
		}

		if (reInfo.getResult_code().equals("FAIL")) {
			System.out.println("退款失败（错误描述：" + reInfo.getErr_code_des() + "）");
			return false;
		}

		return true;

	}



	public static boolean finishPay(String notifyXML) {

		PayNotifyInfo notifyInfo = new PayNotifyInfo();
		XStream xs = new XStream(new DomDriver());
		xs.alias("xml", PayNotifyInfo.class);
		notifyInfo = (PayNotifyInfo) xs.fromXML(notifyXML);

		if (notifyInfo.getReturn_code().equals("FAIL")) {
			return false;
		}
		
		
		
		List<String> strs = new ArrayList<String>();
		if (notifyInfo.getReturn_code() != null) {
			strs.add("return_code=" + notifyInfo.getResult_code());
		}
		if (notifyInfo.getReturn_msg() != null) {
			strs.add("return_msg=" + notifyInfo.getReturn_msg());
		}
		if (notifyInfo.getAppid() != null) {
			strs.add("appid=" + notifyInfo.getAppid());
		}
		if (notifyInfo.getMch_id() != null) {
			strs.add("mch_id=" + notifyInfo.getMch_id());
		}
		if (notifyInfo.getDevice_info() != null) {
			strs.add("device_info=" + notifyInfo.getDevice_info());
		}
		if (notifyInfo.getNonce_str() != null) {
			strs.add("nonce_str=" + notifyInfo.getNonce_str());
		}
		if (notifyInfo.getResult_code() != null) {
			strs.add("result_code=" + notifyInfo.getResult_code());
		}
		if (notifyInfo.getErr_code() != null) {
			strs.add("err_code=" + notifyInfo.getErr_code());
		}
		if (notifyInfo.getErr_code_des() != null) {
			strs.add("err_code_des=" + notifyInfo.getErr_code_des());
		}
		if (notifyInfo.getOpenid() != null) {
			strs.add("openid=" + notifyInfo.getOpenid());
		}
		if (notifyInfo.getIs_subscribe() != null) {
			strs.add("is_subscribe=" + notifyInfo.getIs_subscribe());
		}
		if (notifyInfo.getTrade_type() != null) {
			strs.add("trade_type=" + notifyInfo.getTrade_type());
		}
		if (notifyInfo.getBank_type() != null) {
			strs.add("bank_type=" + notifyInfo.getBank_type());
		}
		if (notifyInfo.getTotal_fee() != null) {
			strs.add("total_fee=" + notifyInfo.getTotal_fee());
		}
		if (notifyInfo.getFee_type() != null) {
			strs.add("fee_type=" + notifyInfo.getFee_type());
		}
		if (notifyInfo.getCash_fee() != null) {
			strs.add("cash_fee=" + notifyInfo.getCash_fee());
		}
		if (notifyInfo.getCash_fee_type() != null) {
			strs.add("cash_fee_type=" + notifyInfo.getCash_fee_type());
		}
		if (notifyInfo.getCoupon_fee() != null) {
			strs.add("coupon_fee=" + notifyInfo.getCoupon_fee());
		}
		if (notifyInfo.getCoupon_count() != null) {
			strs.add("coupon_count=" + notifyInfo.getCoupon_count());
		}
		if (notifyInfo.getCoupon_id_$n() != null) {
			strs.add("coupon_id_$n=" + notifyInfo.getCoupon_id_$n());
		}
		if (notifyInfo.getCoupon_fee_$n() != null) {
			strs.add("coupon_fee_$n=" + notifyInfo.getCoupon_fee_$n());
		}
		if (notifyInfo.getTransaction_id() != null) {
			strs.add("transaction_id=" + notifyInfo.getTransaction_id());
		}
		if (notifyInfo.getOut_trade_no() != null) {
			strs.add("out_trade_no=" + notifyInfo.getOut_trade_no());
		}
		if (notifyInfo.getAttach() != null) {
			strs.add("attach=" + notifyInfo.getAttach());
		}
		if (notifyInfo.getTime_end() != null) {
			strs.add("time_end=" + notifyInfo.getTime_end());
		}

		String sign = MD5Signature(strs);

		if (!notifyInfo.getSign().equals(sign)) {
			return false;
		}

		
		if (notifyInfo.getResult_code().equals("FAIL")) {
			System.out.println("支付失败（错误描述：" + notifyInfo.getErr_code_des() + "）");
			return true;
		}

		String out_trade_no = notifyInfo.getOut_trade_no();
		GoodsOrder goodsOrder = GoodsOrderDao.getGoodsOrderByOutTradeNo(out_trade_no);
		
		if(goodsOrder == null){
			return false;
		}
		
		int orderState = goodsOrder.getOrderState();
		
		if(orderState == 2 || orderState == 12){
			return true;
		}
		
		
		GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(goodsOrder.getGoodsId());
		
		if(goodsInfo == null){
			return false;
		}
		
		goodsInfo.setGoodsSoldnum(goodsInfo.getGoodsSoldnum()+goodsOrder.getGoodsNum());
		if(!GoodsInfoDao.updateGoodsInfo(goodsInfo)){
			return false;
		}
		
		String transaction_id = notifyInfo.getTransaction_id();
		goodsOrder.setTransactionId(transaction_id);
		
		int groupId = goodsOrder.getGroupId();
		
		if(orderState == 1 && groupId == 0){
			TodayGroup todayGroup = new TodayGroup();
			todayGroup.setGoodsId(goodsOrder.getGoodsId());
			todayGroup.setGroupState(0);
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
			String startTime = sdf.format(new Date());
			todayGroup.setStartTime(startTime);
			todayGroup.setWechatId(goodsOrder.getWechatId());
			
			int newGroupId = TodayGroupDao.addTodayGroup(todayGroup);
			if(newGroupId == -1){
				return false;
			}
			goodsOrder.setGroupId(newGroupId);
			
			goodsOrder.setOrderState(2);
			if(!GoodsOrderDao.updateGoodsOrder(goodsOrder)){
				return false;
			}
		}else if(orderState == 1 && groupId != 0){
			TodayGroup todayGroup = TodayGroupDao.getTodayGroup(groupId);
			
			//已成团，订单状态转到待发货
			if(todayGroup.getGroupState() == 1){
				goodsOrder.setOrderState(3);
				if(!GoodsOrderDao.updateGoodsOrder(goodsOrder)){
					return false;
				}
			}else{				
				//检查已参团人数
				List<GoodsOrder> goodsOrders = GoodsOrderDao.getGoodsOrderListByGroupId(groupId);
				int joinGroupNum = 0;
				
				for(GoodsOrder oGoodsOrder : goodsOrders){
					if(oGoodsOrder.getOrderState() == 2){
						joinGroupNum++;
					}
				}
				
				if(joinGroupNum+1 >= goodsOrder.getGroupMinnum()){
					todayGroup.setGroupState(1);
					
					if(!TodayGroupDao.updateTodayGroup(todayGroup)){
						return false;
					}
					
					for(GoodsOrder oGoodsOrder : goodsOrders){
						if(oGoodsOrder.getOrderState() == 2){
							oGoodsOrder.setOrderState(3);
							GoodsOrderDao.updateGoodsOrder(oGoodsOrder);
						}
					}
					goodsOrder.setOrderState(3);
					GoodsOrderDao.updateGoodsOrder(goodsOrder);
					
				}else{
					goodsOrder.setOrderState(2);
					if(!GoodsOrderDao.updateGoodsOrder(goodsOrder)){
						return false;
					}
				}
				
				
			}
		
		}else if(orderState == 11){
			goodsOrder.setOrderState(12);
			if(!GoodsOrderDao.updateGoodsOrder(goodsOrder)){
				return false;
			}
		}
		
		
		
		return true;
	}

	
	private static String useCertToHttpPost(String url, String xmlInfo) {
		FileInputStream instream = null;
		CloseableHttpClient httpclient = null;
		try {
			KeyStore keyStore = KeyStore.getInstance("PKCS12");
			instream = new FileInputStream(new File(PropertiesUtil.getCertPath()));

			keyStore.load(instream, PropertiesUtil.getMchId().toCharArray());

			SSLContext sslcontext = SSLContexts.custom()
					.loadKeyMaterial(keyStore, PropertiesUtil.getMchId().toCharArray()).build();

			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" },
					null, SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
			httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();

			HttpPost post = new HttpPost(url);
			StringEntity sendEntity = new StringEntity(xmlInfo);
			post.setEntity(sendEntity);
			post.setHeader("Content-Type", "text/xml;charset=UTF-8");
			HttpResponse response = httpclient.execute(post);
			HttpEntity entity = response.getEntity();
			BufferedReader in = new BufferedReader(new InputStreamReader(entity.getContent(), "UTF-8"));
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
				if (instream != null) {

					instream.close();
				}
				if (httpclient != null) {
					httpclient.close();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}

		}

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

	public static String MD5Signature(List<String> strs) {
		Collections.sort(strs);
		strs.add("key=" + PropertiesUtil.getSignKey());
	

		String str = "";

		int size = strs.size();
		for (int i = 0; i < size - 1; i++) {
			str += strs.get(i) + "&";
		}

		str += strs.get(size - 1);

		MessageDigest md = null;
		String signature = null;

		try {
			md = MessageDigest.getInstance("MD5");

			byte[] digest = md.digest(str.toString().getBytes("UTF-8"));
			signature = byteToStr(digest);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return signature.toUpperCase();

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
