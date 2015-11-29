package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.GoodsOrder;
import com.greenlife.util.DBUtil;

public class GoodsOrderDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean addGoodsOrder(GoodsOrder order){
		String sql = "INSERT INTO `greenlife`.`goods_order` (`order_id`, `goods_id`, "
				+ "`wechat_id`, `addr_id`, `goods_num`, `trade_time`, `comment`, "
				+ "`mail_price`, `total_price`, `group_id`, `send_time`,"
				+ " `group_minnum`, `order_state`) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, order.getOrderId());
			ps.setInt(2, order.getGoodsId());
			ps.setString(3, order.getWechatId());
			ps.setInt(4, order.getAddrId());
			ps.setInt(5, order.getGoodsNum());
			ps.setString(6, order.getTradeTime());
			ps.setString(7, order.getComment());
			ps.setDouble(8, order.getMailPrice());
			ps.setDouble(9, order.getTotalPrice());
			ps.setInt(10, order.getGroupId());
			ps.setString(11, order.getSendTime());
			ps.setInt(12, order.getGroupMinnum());
			ps.setInt(13, order.getOrderState());
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
