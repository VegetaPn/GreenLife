package com.greenlife.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

	private Connection conn;
	
	public Connection getConn() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://123.206.31.239:3306/greenlife?useUnicode=true&amp;characterEncoding=UTF-8";
            String username = "greenlife";
            String password = "greenlife";
            
            conn = DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return conn;
	}
}
