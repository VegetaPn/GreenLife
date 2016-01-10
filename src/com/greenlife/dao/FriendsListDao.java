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
	
	public static int getFriendsList(String wechatId, String friendId) {
		int level = -1;
		String sql = "select * from friends_list where wechat_id = ? or friend_wechat_id = ? "
				+ "order by friends_level;";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			ps.setString(2, wechatId);
			rs = ps.executeQuery();
			if (rs.next()) {
				level = rs.getInt("friends_level");
			} else {
				return -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return level;
	}
	
	public static ArrayList<String> getFriendWechatIdList(String wechatId) {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select * from friends_list where wechat_id = ? or friend_wechat_id = ? "
				+ "order by friends_level;";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			ps.setString(2, wechatId);
			rs = ps.executeQuery();
			while (rs.next()) {
				String id1 = rs.getString("friend_wechat_id");
				String id2 = rs.getString("wechat_id");
				if(id1.equals(wechatId)){
					list.add(id2);
				} else if(id2.equals(wechatId)){
					list.add(id1);
				}
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
		String fid = list.getWechatId();
		String sid = list.getFriendsWechatId();
		if(fid.compareTo(sid) > 0){
			fid = list.getFriendsWechatId();
			sid = list.getWechatId();
		}
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, list.getFriendslevel());
			ps.setString(2, sid);
			ps.setString(3, fid);
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
		
		String fid = list.getWechatId();
		String sid = list.getFriendsWechatId();
		if(fid.compareTo(sid) > 0){
			fid = list.getFriendsWechatId();
			sid = list.getWechatId();
		}
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sid);
			ps.setString(2, fid);
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
		
		String fid = list.getWechatId();
		String sid = list.getFriendsWechatId();
		if(fid.compareTo(sid) > 0){
			fid = list.getFriendsWechatId();
			sid = list.getWechatId();
		}
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sid);
			ps.setInt(2, list.getFriendslevel());
			ps.setString(3, fid);
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
