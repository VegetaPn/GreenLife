package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.UserInfo;
import com.greenlife.util.DBUtil;

public class UserInfoDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean isExist(String wechatId){
		String sql = "select * from user_info where wechat_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			rs = ps.executeQuery();
			if(rs.next()){
				return true;
			}else{
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
	}
	
	public static boolean deleteUserInfo(String wechatId){
		String sql = "delete from user_info where wechat_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static boolean addUserInfo(UserInfo info){
		String sql = "INSERT INTO `greenlife`.`user_info` "
				+ "(`wechat_id`, `wechat_name`, `address_id`, `photo_path`) "
				+ "VALUES (?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, info.getWechatId());
			ps.setString(2, info.getWechatName());
			ps.setInt(3, info.getAddrId());
			ps.setString(4, info.getPhotoPath());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static boolean updateUserInfo(UserInfo info){
		String sql = "UPDATE `greenlife`.`user_info` SET "
				+"wechat_name = (?), "
				+"address_id = (?),"
				+"photo_path = (?) "
				+"WHERE wechat_id = (?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, info.getWechatName());
			ps.setInt(2, info.getAddrId());
			ps.setString(3, info.getPhotoPath());
			ps.setString(4, info.getWechatId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static UserInfo getUserInfo(String wechatId) {
		UserInfo userInfo = new UserInfo();
		String sql = "select * from user_info where wechat_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			rs = ps.executeQuery();
			while (rs.next()) {
				userInfo.setWechatId(rs.getString("wechat_id"));
				userInfo.setWechatName(rs.getString("wechat_name"));
				userInfo.setAddrId(rs.getInt("address_id"));
				userInfo.setPhotoPath(rs.getString("photo_path"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return userInfo;
	}
	
	public static List<UserInfo> getUsersList() {
		
		List<UserInfo> usersList = new ArrayList<UserInfo>();
		String sql = "select * from user_info";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				UserInfo userInfo = new UserInfo();
				
				userInfo.setWechatId(rs.getString("wechat_id"));
				userInfo.setWechatName(rs.getString("wechat_name"));
				userInfo.setAddrId(rs.getInt("address_id"));
				userInfo.setPhotoPath("photo_path");
				
				usersList.add(userInfo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return usersList;
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
