package com.greenlife.util;


import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtil {
	private static String path = null;
	private static String appId = null;
	private static String appsecret = null;
	private static String URL = null;
	private static String savePath = null;
	private static String mchId = null;
	private static String signKey = null;
	private static String certPath  = null;
	public static String getSavePath(){
		if(savePath == null){
			loadProperties();
		}
		return savePath;
	}
	
	public static String getCertPath(){
		if(certPath == null){
			loadProperties();
		}
		return certPath;
	}
	
	public static String getPath(){
		if(path == null){
			loadProperties();
		}
		return path;
	}
	
	public static String getSignKey(){
		if(signKey == null){
			loadProperties();
		}
		return signKey;
	}
	
	public static String getAppId(){
		if(appId == null){
			loadProperties();
		}
		return appId;
	}
	
	public static String getAppsecret(){
		if(appsecret == null){
			loadProperties();
		}
		return appsecret;
	}
	
	
	public static String getURL(){
		if(URL == null){
			loadProperties();
		}
		return URL;
	}
	              
	
	public static String getMchId(){
		if(mchId == null){
			loadProperties();
		}
		return mchId;
	}

	private static void loadProperties() {
		Properties prop = new Properties();
		try {
			InputStream is = PropertiesUtil.class.getResourceAsStream("init.properties");
			prop.load(is);
			savePath = prop.getProperty("savePath");
			path = prop.getProperty("path");
			appId = prop.getProperty("appId");
			appsecret = prop.getProperty("appsecret");
			URL = prop.getProperty("URL");
			mchId = prop.getProperty("mchId");
			certPath = prop.getProperty("certPath");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}              
	}
	
	

}
