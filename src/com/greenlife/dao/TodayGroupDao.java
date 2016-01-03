package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.greenlife.model.TodayGroup;
import com.greenlife.util.DBUtil;

public class TodayGroupDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	
	public static String getGroupStartTime(int group_id){

		String sql = "select * from today_group where group_id = ?;";
		Connection conn = new DBUtil().getConn();
		String start_time = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, group_id);
			rs = ps.executeQuery();
			if (rs.next()){
				start_time = rs.getString("start_time");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return start_time;
	}
	
	public static ArrayList<TodayGroup> getOverdueOrderByDay(int groupState, int day){
		ArrayList<TodayGroup> list = new ArrayList<TodayGroup>();
		
		String sql = "select * from today_group where group_state = ?;";
		String time = null;
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, 0);
			rs = ps.executeQuery();
			while(rs.next()){
				TodayGroup group = new TodayGroup();
				time = rs.getString("start_time");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
				Date d1 = new Date();
				Date d2 = sdf.parse(time);
				long diff = d1.getTime() - d2.getTime();
				long days = diff / (1000 * 60 * 60 * 24);
				//long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
				//long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60);
				if(days >= day){
					continue;
				}
				
				group.setGoodsId(rs.getInt("goods_id"));
				group.setGroupId(rs.getInt("group_id"));
				group.setGroupState(rs.getInt("group_state"));
				group.setStartTime(time);
				group.setWechatId(rs.getString("wechat_id"));
				group.setIsDelete(rs.getInt("is_delete"));
				
				list.add(group);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return list;
	}
	
	public static ArrayList<TodayGroup> getOverdueOrderByHour(int groupState, int hour){
		ArrayList<TodayGroup> list = new ArrayList<TodayGroup>();
		
		String sql = "select * from today_group where group_state = ?;";
		String time = null;
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, 0);
			rs = ps.executeQuery();
			while(rs.next()){
				TodayGroup group = new TodayGroup();
				
				time = rs.getString("start_time");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
				Date d1 = new Date();
				Date d2 = sdf.parse(time);
				long diff = d1.getTime() - d2.getTime();
				long days = diff / (1000 * 60 * 60 * 24);
				long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
				//long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60);
				if(hours >= hour){
					continue;
				}
				
				group.setGoodsId(rs.getInt("goods_id"));
				group.setGroupId(rs.getInt("group_id"));
				group.setGroupState(rs.getInt("group_state"));
				group.setStartTime(time);
				group.setWechatId(rs.getString("wechat_id"));
				group.setIsDelete(rs.getInt("is_delete"));
				
				list.add(group);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return list;
	}
	
	
	public static TodayGroup getTodayGroup(int groupId){
		TodayGroup group = new TodayGroup();
		String sql = "select * from today_group where group_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			rs = ps.executeQuery();
			if(rs.next()){
				group.setGoodsId(rs.getInt("goods_id"));
				group.setGroupId(rs.getInt("group_id"));
				group.setGroupState(rs.getInt("group_state"));
				group.setStartTime(rs.getString("start_time"));
				group.setWechatId(rs.getString("wechat_id"));
				group.setIsDelete(rs.getInt("is_delete"));
			}else{
				return null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return group;
	}
	
	public static List<Integer> getGroupId(){
		List<Integer> list = new ArrayList<Integer>();
		String sql = "select group_id from today_group;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				int groupId = rs.getInt("group_id");
				list.add(groupId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return list;
	}
	
	public static ArrayList<Integer> getGroupIdByStatus(int group_state){
		ArrayList<Integer> list = new ArrayList<Integer>();
		String sql = "select group_id from today_group where group_state = ?";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, group_state);
			rs = ps.executeQuery();
			while(rs.next()){
				int groupId = rs.getInt("group_id");
				list.add(groupId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return list;
	}
	
	public static ArrayList<Integer> getGroupIdByStatusAndHour(int group_state, int hour){
		ArrayList<Integer> list = new ArrayList<Integer>();
		String sql = "select group_id from today_group where group_state = ?";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, group_state);
			rs = ps.executeQuery();
			while(rs.next()){
				
				String time = rs.getString("start_time");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
				Date d1 = new Date();
				Date d2 = sdf.parse(time);
				long diff = d1.getTime() - d2.getTime();
				long days = diff / (1000 * 60 * 60 * 24);
				long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
				//long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60);
				if(hours >= hour){
					continue;
				}
				
				int groupId = rs.getInt("group_id");
				list.add(groupId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return list;
	}

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
				+ "(`start_time`, `group_state`, `goods_id`, `wechat_id`, `is_delete`) "
				+ "VALUES (?, ?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, group.getStartTime());
			ps.setInt(2, group.getGroupState());
			ps.setInt(3, group.getGoodsId());
			ps.setString(4, group.getWechatId());
			ps.setInt(5, group.getIsDelete());
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
				+"start_time = (?),"
				+"group_state = (?),"
				+"goods_id = (?),"
				+"wechat_id = (?),"
				+"is_delete = (?)"
				+"WHERE group_id = (?);";
	
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, group.getStartTime());
			ps.setInt(2, group.getGroupState());
			ps.setInt(3, group.getGoodsId());
			ps.setString(4, group.getWechatId());
			ps.setInt(5, group.getIsDelete());
			ps.setInt(6, group.getGroupId());
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
