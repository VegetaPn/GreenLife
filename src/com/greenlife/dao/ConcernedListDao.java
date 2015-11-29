package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.ConcernedList;
import com.greenlife.util.DBUtil;

public class ConcernedListDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
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
