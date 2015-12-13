package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.TodayGroup;
import com.greenlife.util.DBUtil;

public class TodayGroupDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean deleteTodayGroup(int groupId){
		String sql = "delete from today_group where group_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static int addTodayGroup(TodayGroup group){
		String sql = "INSERT INTO `greenlife`.`today_group` "
				+ "(`start_time`, `group_state`, `goods_id`, `wechat_id`) "
				+ "VALUES (?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, group.getStartTime());
			ps.setInt(2, group.getGroupState());
			ps.setInt(3, group.getGoodsId());
			ps.setString(4, group.getWechatId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		int group_id = -1;
		sql = "select max(group_id) as id from today_group;";
		conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			group_id = rs.getInt("id");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return group_id;
	}
	
	public static boolean updateTodayGroup(TodayGroup group){
		String sql = "UPDATE `greenlife`.`today_group` SET "
				+"start_time = (?) "
				+"group_state = (?)"
				+"goods_id = (?)"
				+"wechat_id = (?)"
				+"WHERE group_id = (?);";
	
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, group.getStartTime());
			ps.setInt(2, group.getGroupState());
			ps.setInt(3, group.getGoodsId());
			ps.setString(4, group.getWechatId());
			ps.setInt(5, group.getGroupId());
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
