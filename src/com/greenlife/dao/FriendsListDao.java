package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.FriendsList;
import com.greenlife.util.DBUtil;

public class FriendsListDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean addFriendList(FriendsList list){
		String sql = "INSERT INTO `greenlife`.`friends_list` (`wechat_id`, `friend_wechat_id`) VALUES (?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, list.getWechatId());
			ps.setString(2, list.getFriendsWechatId());
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
				+"friend_wechat_id = (?) "
				+"WHERE wechat_id = (?);";
		
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
