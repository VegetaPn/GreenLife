package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.AdminList;
import com.greenlife.model.AdressInfo;
import com.greenlife.util.DBUtil;


public class AdminListDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean loginCheck(String userId, String pwd){
		String sql = "select * from admin_list where user_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userId);
			rs = ps.executeQuery();
			if(rs.next()){
				String password = rs.getString("password");
				if(pwd.equals(password)){
					return true;
				}
				else{
					return false;
				}
			}
			else{
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static boolean addAdminList(AdminList admin){
		String sql = "INSERT INTO `greenlife`.`admin_list` (`user_id`, `password`) VALUES (?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, admin.getUserId());
			ps.setString(2, admin.getPassword());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static boolean updateAdminList(AdminList admin){
		String sql = "UPDATE `greenlife`.`admin_list` SET "
				+"password = (?) "
				+"WHERE user_id = (?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, admin.getPassword());
			ps.setString(2, admin.getUserId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static List<AdminList> getAdminList() {
		
		List<AdminList> adminList = new ArrayList<AdminList>();
		String sql = "select * from admin_list";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				AdminList adminlist = new AdminList();
				
				// stupid set method......
				adminlist.setPassword(rs.getString("password"));
				adminlist.setUserId(rs.getString("user_id"));
				
				adminList.add(adminlist);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return adminList;
	}
	
	public static void clearUp(Connection conn) {
        try {
            if(rs != null){
                rs.close();
            }
            if(ps != null){
                ps.close();
            }
            if(conn != null){
                conn.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
