package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.SharedList;
import com.greenlife.model.UserInfo;
import com.greenlife.util.DBUtil;

public class SharedListDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean addSharedList(SharedList list){
		String sql = "INSERT INTO `greenlife`.`shared_list` "
				+ "(`wechat_id`, `friend_wechat_id`, `goods_id`) VALUES (?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, list.getWechatId());
			ps.setString(2, list.getFirendWechatId());
			ps.setInt(3, list.getGoodsId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	/*
	 * 根据制定用户的分享记录
	 */
	public static List<SharedList> getSharedList(String wechatId) {
		
		List<SharedList> list = new ArrayList<SharedList>();
		String sql = "select * from shared_list where wechat_id = ?";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			rs = ps.executeQuery();
			while (rs.next()) {
				SharedList shared = new SharedList();
				shared.setFirendWechatId(rs.getString("friend_wechat_id"));
				shared.setWechatId(rs.getString("wechat_id"));
				shared.setGoodsId(rs.getInt("goods_id"));
				list.add(shared);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return list;
	}
	
	public static boolean updateSharedList(SharedList list){
		String sql = "UPDATE `greenlife`.`shared_list` SET "
				+"friend_wechat_id = (?) "
				+"goods_id = (?)"
				+"WHERE wechat_id = (?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, list.getFirendWechatId());
			ps.setInt(2, list.getGoodsId());
			ps.setString(3, list.getWechatId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
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
