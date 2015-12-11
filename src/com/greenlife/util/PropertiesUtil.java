package com.greenlife.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtil {
	private static String path = null;
	
	public static String getPath(){
		if(path == null){
			loadPath();
		}
		return path;
	}

	private static void loadPath() {
		Properties prop = new Properties();
		try {
			InputStream is = PropertiesUtil.class.getResourceAsStream("init.properties");
			prop.load(is);
			path = prop.getProperty("filePath");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}              
	}
}
