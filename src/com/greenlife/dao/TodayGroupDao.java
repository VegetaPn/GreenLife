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
	
	public static boolean addTodayGroup(TodayGroup group){
		String sql = "INSERT INTO `greenlife`.`today_group` "
				+ "(`group_id`, `start_time`, `group_state`) VALUES (?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, group.getGroupId());
			ps.setString(2, group.getStartTime());
			ps.setInt(3, group.getGroupState());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static boolean updateTodayGroup(TodayGroup group){
		String sql = "UPDATE `greenlife`.`today_group` SET "
				+"start_time = (?) "
				+"group_state = (?)"
				+"WHERE group_id = (?);";
	
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, group.getStartTime());
			ps.setInt(2, group.getGroupState());
			ps.setInt(3, group.getGroupId());
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
