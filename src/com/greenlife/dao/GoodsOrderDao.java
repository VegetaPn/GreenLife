package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.GoodsOrder;
import com.greenlife.util.DBUtil;

public class GoodsOrderDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean deleteGoodsOrder(int orderId){
		String sql = "delete from goods_order where order_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orderId);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static int getGoodsOrderNum(int goodsId){
		int num = -1;
		
		String sql = "select count(*) as cnt from goods_order where goods_id = ?";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, goodsId);
			rs = ps.executeQuery();
			rs.next();
			num = rs.getInt("cnt");
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		
		return num;
	}
	
	
	public static int addGoodsOrder(GoodsOrder order){
		String sql = "INSERT INTO `greenlife`.`goods_order`"
				+ " (`goods_id`, `wechat_id`, "
				+ "`goods_num`, `trade_time`, `comment`, "
				+ "`mail_price`, `total_price`, `group_id`, "
				+ "`send_time`, `group_minnum`, `order_state`, "
				+ "`addr_detail`, `receiver_name`, `phone_number`) "
				+ "VALUES (?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?,"
				+ " ?, ?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			//ps.setInt(1, order.getOrderId());
			ps.setInt(1, order.getGoodsId());
			ps.setString(2, order.getWechatId());
			ps.setInt(3, order.getGoodsNum());
			ps.setString(4, order.getTradeTime());
			ps.setString(5, order.getComment());
			ps.setDouble(6, order.getMailPrice());
			ps.setDouble(7, order.getTotalPrice());
			ps.setInt(8, order.getGroupId());
			ps.setString(9, order.getSendTime());
			ps.setInt(10, order.getGroupMinnum());
			ps.setInt(11, order.getOrderState());
			ps.setString(12, order.getAddrDetail());
			ps.setString(13, order.getReceiverName());
			ps.setString(14, order.getPhoneNumber());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		int order_id = -1;
		sql = "select max(order_id) as id from goods_order;";
		conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			order_id = rs.getInt("id");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return order_id;
	}
	
	
	public static boolean updateGoodsOrder(GoodsOrder order){
		String sql = "UPDATE `greenlife`.`goods_order` SET "
				+ "goods_id = (?), "
				+ "wechat_id = (?), "
				+ "goods_num = (?), "
				+ "trade_time = (?), "
				+ "comment = (?), "
				+ "mail_price = (?), "
				+ "total_price = (?), "
				+ "group_id = (?), "
				+ "send_time = (?), "
				+ "group_minnum = (?), "
				+ "order_state = (?), "
				+ "addr_detail = (?), "
				+ "receiver_name = (?), "
				+ "phone_number = (?), "
				+ "WHERE order_id = (?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, order.getGoodsId());
			ps.setString(2, order.getWechatId());
			ps.setInt(3, order.getGoodsNum());
			ps.setString(4, order.getTradeTime());
			ps.setString(5, order.getComment());
			ps.setDouble(6, order.getMailPrice());
			ps.setDouble(7, order.getTotalPrice());
			ps.setInt(8, order.getGroupId());
			ps.setString(9, order.getSendTime());
			ps.setInt(10, order.getGroupMinnum());
			ps.setInt(11, order.getOrderState());
			ps.setString(12, order.getAddrDetail());
			ps.setString(13, order.getReceiverName());
			ps.setString(14, order.getPhoneNumber());
			ps.setInt(15, order.getOrderId());
			
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
public static List<GoodsOrder> getGoodsOrderListByState(int order_state){
		
		List<GoodsOrder> orderList = new ArrayList<>();

		String sql = "select * from goods_order where order_state = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, order_state);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				GoodsOrder goodsOrder = new GoodsOrder();
				
				goodsOrder.setOrderId(rs.getInt("order_id"));
				goodsOrder.setGoodsId(rs.getInt("goods_id"));
				goodsOrder.setWechatId(rs.getString("wechat_id"));
				goodsOrder.setGoodsNum(rs.getInt("goods_num"));
				goodsOrder.setTradeTime(rs.getString("trade_time"));
				goodsOrder.setComment(rs.getString("comment"));
				goodsOrder.setMailPrice(rs.getDouble("mail_price"));
				goodsOrder.setTotalPrice(rs.getDouble("total_price"));
				goodsOrder.setGroupId(rs.getInt("group_id"));
				goodsOrder.setSendTime(rs.getString("send_time"));
				goodsOrder.setGroupMinnum(rs.getInt("group_minnum"));
				goodsOrder.setOrderState(rs.getInt("order_state"));
				goodsOrder.setAddrDetail(rs.getString("addr_detail"));
				goodsOrder.setReceiverName(rs.getString("receiver_name"));
				goodsOrder.setPhoneNumber(rs.getString("phone_number"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return orderList;
	}
	
	
	public static List<GoodsOrder> getGoodsOrderListByGroupId(int groupId){
		
		List<GoodsOrder> orderList = new ArrayList<>();

		String sql = "select * from goods_order where group_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				GoodsOrder goodsOrder = new GoodsOrder();
				
				goodsOrder.setOrderId(rs.getInt("order_id"));
				goodsOrder.setGoodsId(rs.getInt("goods_id"));
				goodsOrder.setWechatId(rs.getString("wechat_id"));
				goodsOrder.setGoodsNum(rs.getInt("goods_num"));
				goodsOrder.setTradeTime(rs.getString("trade_time"));
				goodsOrder.setComment(rs.getString("comment"));
				goodsOrder.setMailPrice(rs.getDouble("mail_price"));
				goodsOrder.setTotalPrice(rs.getDouble("total_price"));
				goodsOrder.setGroupId(rs.getInt("group_id"));
				goodsOrder.setSendTime(rs.getString("send_time"));
				goodsOrder.setGroupMinnum(rs.getInt("group_minnum"));
				goodsOrder.setOrderState(rs.getInt("order_state"));
				goodsOrder.setAddrDetail(rs.getString("addr_detail"));
				goodsOrder.setReceiverName(rs.getString("receiver_name"));
				goodsOrder.setPhoneNumber(rs.getString("phone_number"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return orderList;
	}
	
	
	public static List<GoodsOrder> getGoodsOrderList(List<Integer> groupId){
		
		List<GoodsOrder> orderList = new ArrayList<>();
		
		for(int i=0;i<groupId.size();i++){
		
			String sql = "select * from goods_order where group_id = ?";
			Connection conn = new DBUtil().getConn();
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, groupId.get(i));
				rs = ps.executeQuery();
				
				while (rs.next()) {
					GoodsOrder goodsOrder = new GoodsOrder();
					
					goodsOrder.setOrderId(rs.getInt("order_id"));
					goodsOrder.setGoodsId(rs.getInt("goods_id"));
					goodsOrder.setWechatId(rs.getString("wechat_id"));
					goodsOrder.setGoodsNum(rs.getInt("goods_num"));
					goodsOrder.setTradeTime(rs.getString("trade_time"));
					goodsOrder.setComment(rs.getString("comment"));
					goodsOrder.setMailPrice(rs.getDouble("mail_price"));
					goodsOrder.setTotalPrice(rs.getDouble("total_price"));
					goodsOrder.setGroupId(rs.getInt("group_id"));
					goodsOrder.setSendTime(rs.getString("send_time"));
					goodsOrder.setGroupMinnum(rs.getInt("group_minnum"));
					goodsOrder.setOrderState(rs.getInt("order_state"));
					goodsOrder.setAddrDetail(rs.getString("addr_detail"));
					goodsOrder.setReceiverName(rs.getString("receiver_name"));
					goodsOrder.setPhoneNumber(rs.getString("phone_number"));
					
					orderList.add(goodsOrder);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				clearUp(conn);
			}
			
		}
		return orderList;
	}
	
	public static List<GoodsOrder> getGoodsOrderList(String wechat_id) {
		
		List<GoodsOrder> orderList = new ArrayList<>();
		String sql = "select * from goods_order where wechat_id = ?";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechat_id);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				GoodsOrder goodsOrder = new GoodsOrder();
				
				goodsOrder.setOrderId(rs.getInt("order_id"));
				goodsOrder.setGoodsId(rs.getInt("goods_id"));
				goodsOrder.setWechatId(rs.getString("wechat_id"));
				goodsOrder.setGoodsNum(rs.getInt("goods_num"));
				goodsOrder.setTradeTime(rs.getString("trade_time"));
				goodsOrder.setComment(rs.getString("comment"));
				goodsOrder.setMailPrice(rs.getDouble("mail_price"));
				goodsOrder.setTotalPrice(rs.getDouble("total_price"));
				goodsOrder.setGroupId(rs.getInt("group_id"));
				goodsOrder.setSendTime(rs.getString("send_time"));
				goodsOrder.setGroupMinnum(rs.getInt("group_minnum"));
				goodsOrder.setOrderState(rs.getInt("order_state"));
				goodsOrder.setAddrDetail(rs.getString("addr_detail"));
				goodsOrder.setReceiverName(rs.getString("receiver_name"));
				goodsOrder.setPhoneNumber(rs.getString("phone_number"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return orderList;
	}
	

	public static List<GoodsOrder> getGoodsOrderList(int goodsId) {
		
		List<GoodsOrder> orderList = new ArrayList<>();
		String sql = "select * from goods_order where goods_id = ?";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ps.setInt(1, goodsId);
			while (rs.next()) {
				GoodsOrder goodsOrder = new GoodsOrder();
				
				goodsOrder.setOrderId(rs.getInt("order_id"));
				goodsOrder.setGoodsId(rs.getInt("goods_id"));
				goodsOrder.setWechatId(rs.getString("wechat_id"));
				goodsOrder.setGoodsNum(rs.getInt("goods_num"));
				goodsOrder.setTradeTime(rs.getString("trade_time"));
				goodsOrder.setComment(rs.getString("comment"));
				goodsOrder.setMailPrice(rs.getDouble("mail_price"));
				goodsOrder.setTotalPrice(rs.getDouble("total_price"));
				goodsOrder.setGroupId(rs.getInt("group_id"));
				goodsOrder.setSendTime(rs.getString("send_time"));
				goodsOrder.setGroupMinnum(rs.getInt("group_minnum"));
				goodsOrder.setOrderState(rs.getInt("order_state"));
				goodsOrder.setAddrDetail(rs.getString("addr_detail"));
				goodsOrder.setReceiverName(rs.getString("receiver_name"));
				goodsOrder.setPhoneNumber(rs.getString("phone_number"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return orderList;
	}
	
	
	public static List<GoodsOrder> getGoodsOrderList() {
		
		List<GoodsOrder> orderList = new ArrayList<>();
		String sql = "select * from goods_order";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				GoodsOrder goodsOrder = new GoodsOrder();
				
				goodsOrder.setOrderId(rs.getInt("order_id"));
				goodsOrder.setGoodsId(rs.getInt("goods_id"));
				goodsOrder.setWechatId(rs.getString("wechat_id"));
				goodsOrder.setGoodsNum(rs.getInt("goods_num"));
				goodsOrder.setTradeTime(rs.getString("trade_time"));
				goodsOrder.setComment(rs.getString("comment"));
				goodsOrder.setMailPrice(rs.getDouble("mail_price"));
				goodsOrder.setTotalPrice(rs.getDouble("total_price"));
				goodsOrder.setGroupId(rs.getInt("group_id"));
				goodsOrder.setSendTime(rs.getString("send_time"));
				goodsOrder.setGroupMinnum(rs.getInt("group_minnum"));
				goodsOrder.setOrderState(rs.getInt("order_state"));
				goodsOrder.setAddrDetail(rs.getString("addr_detail"));
				goodsOrder.setReceiverName(rs.getString("receiver_name"));
				goodsOrder.setPhoneNumber(rs.getString("phone_number"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		
		return orderList;
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
