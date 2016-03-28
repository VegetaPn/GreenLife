package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.greenlife.model.WechatInfo;
import com.greenlife.util.DBUtil;

public class WechatInfoDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean isExist(String wechatId){
		String sql = "select * from wechat_info where wechat_id = ?";
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
	
	public static boolean addWechatInfo(WechatInfo info){
		String sql = "INSERT INTO `greenlife`.`wechat_info` "
				+ "(`wechat_id`, `access_token`, `refresh_token`, `refresh_time`) "
				+ "VALUES (?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, info.getWechatId());
			ps.setString(2, info.getAccessToken());
			ps.setString(3, info.getRefreshToken());
			ps.setString(4, info.getRefreshTime());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static boolean updateWechatInfo(WechatInfo info){
		String sql = "UPDATE `greenlife`.`wechat_info` SET "
				+"access_token = (?), "
				+"refresh_token = (?), "
				+"refresh_time = (?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, info.getAccessToken());
			ps.setString(2, info.getRefreshToken());
			ps.setString(3, info.getRefreshTime());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static WechatInfo getWechatInfo(String wechatId) {
		WechatInfo wechatInfo = new WechatInfo();
		String sql = "select * from wechat_info where wechat_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			rs = ps.executeQuery();
			while (rs.next()) {
				wechatInfo.setWechatId(rs.getString("wechat_id"));
				wechatInfo.setAccessToken(rs.getString("access_token"));
				wechatInfo.setRefreshToken(rs.getString("refresh_token"));
				wechatInfo.setRefreshTime(rs.getString("refresh_time"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return wechatInfo;
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
