package com.greenlife.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class WeixinJssdkUtil {
	public static String buildSignature(String noncestr, String jsapi_ticket, String timestamp, String url) {
	
			
		String str = "jsapi_ticket="+jsapi_ticket + "&" + 
				 	"noncestr="+noncestr + "&" + 
				 	"timestamp="+timestamp + "&" + 
				 	"url="+url;

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
}
