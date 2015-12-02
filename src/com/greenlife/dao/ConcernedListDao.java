package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.AdressInfo;
import com.greenlife.model.ConcernedList;
import com.greenlife.util.DBUtil;

public class ConcernedListDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	/*
	 * 根据商品id获取关注商品的用户wechat_id，结果以字符串list返回
	 */
	public static List<String> getWechatIdList(int goodsId) {
		List<String> list = new ArrayList<String>();
		String sql = "select * from concerned_list where goods_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, goodsId);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("wechat_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return list;
	}
	
	/*
	 * 返回用户关注的商品list
	 */
	public static List<Integer> getGoodsList(String wechatid) {
		List<Integer> list = new ArrayList<Integer>();
		String sql = "select * from concerned_list where wechat_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatid);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getInt("goods_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return list;
	}
	
	public static boolean addConcernedList(ConcernedList list){
		String sql = "INSERT INTO `greenlife`.`concerned_list` (`wechat_id`, `goods_id`) VALUES (?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, list.getWechatId());
			ps.setInt(2, list.getGoodsId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static boolean updateConcernedList(ConcernedList list){
//		String sql = "INSERT INTO `greenlife`.`concerned_list` (`wechat_id`, `goods_id`) VALUES (?, ?);";
		String sql = "UPDATE `greenlife`.`concerned_list` SET "
				+"goods_id = (?) "
				+"WHERE wechat_id = (?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, list.getGoodsId());
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
