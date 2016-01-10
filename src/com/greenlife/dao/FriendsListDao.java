package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.greenlife.model.FriendsList;
import com.greenlife.util.DBUtil;

public class FriendsListDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean deleteFriend(String wechatId, String friendId){
		String sql = "delete from friends_list where wechat_id = ? and friend_wecaht_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			ps.setString(2, friendId);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	
	public static ArrayList<String> getFriendWechatIdList(String wechatId) {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select * from friends_list where wechat_id = ? order by friends_level;";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("friend_wechat_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return list;
	}
	
	public static boolean addFriendList(FriendsList list){
		String sql = "insert into `greenlife`.`friends_list` "
				+ "( `friends_level`, `friend_wechat_id`, `wechat_id`)"
				+ " values (?, ?, ?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, list.getFriendslevel());
			ps.setString(2, list.getFriendsWechatId());
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
	
	
	
	public static boolean increaseLevel(FriendsList list, int num){
		String sql = "update `greenlife`.`friends_list` "
				+ "set `friends_level`= friends_level + " + num +" "
				+ "where `friend_wechat_id`=? and `wechat_id`=?";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, list.getFriendsWechatId());
			ps.setString(2, list.getWechatId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static boolean updateFriendList(FriendsList list){
		String sql = "UPDATE `greenlife`.`friends_list` SET "
				+"friend_wechat_id = (?),"
				+"friends_level = (?)"
				+"WHERE wechat_id = (?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, list.getFriendsWechatId());
			ps.setInt(2, list.getFriendslevel());
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
