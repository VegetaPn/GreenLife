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
	
	public static boolean addWechatInfo(WechatInfo info){
		
		String sql = "INSERT INTO `greenlife`.`wechat_info` "
				+ "(`wechat_id`, `nickname`, `sex`, `province`, "
				+ "`city`, `country`, `headimgurl`, `privilege`, `unionid`) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, info.getWechatId());
			ps.setString(2, info.getNickname());
			ps.setString(3, info.getSex());
			ps.setString(4, info.getProvince());
			ps.setString(5, info.getCity());
			ps.setString(6, info.getCountry());
			ps.setString(7, info.getHeadimgurl());
			ps.setString(8, info.getPrivilege());
			ps.setString(9, info.getUnionId());
			
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static boolean deleteWechatInfo(String wechatId){
		String sql = "delete from wechat_info where wechat_id = ?;";
		
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
	
	public static WechatInfo getWechatInfo(String wechatId){
		WechatInfo info = new WechatInfo();
		
		String sql = "select * from wechat_info where wechat_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			rs = ps.executeQuery();
			rs.next();
			info.setCity(rs.getString("city"));
			info.setCountry(rs.getString("country"));
			info.setHeadimgurl(rs.getString("headimgurl"));
			info.setNickname(rs.getString("nickname"));
			info.setSex(rs.getString("sex"));
			info.setPrivilege(rs.getString("privilege"));
			info.setProvince(rs.getString("province"));
			info.setUnionId(rs.getString("unionid"));
			info.setWechatId(rs.getString("wechat_id"));
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return info;
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
