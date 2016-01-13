package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.greenlife.model.GoodsOrder;
import com.greenlife.util.DBUtil;

public class GoodsOrderDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static GoodsOrder getGoodsOrderById(int orderId){
		GoodsOrder goodsOrder = new GoodsOrder();
		
		String sql = "select * from goods_order where order_id = ?";
		Connection conn = new DBUtil().getConn();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orderId);
			rs = ps.executeQuery();
			if(rs.next()){
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
				goodsOrder.setReceiverName(rs.getString("addr_detail"));
				goodsOrder.setReceiverName(rs.getString("receiver_name"));
				goodsOrder.setPhoneNumber(rs.getString("phone_number"));
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				
			}else{
				return null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return goodsOrder;
	}
	
	public static ArrayList<HashMap<String, String>> getGoodsBuyInfo(int goodsId){
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		
		String sql = "select wechat_id, count(*) as number, order_state from goods_order "
				+ "where goods_id = ? group by wechat_id"
				+ " order by number DESC;";
		Connection conn = new DBUtil().getConn();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, goodsId);
			rs = ps.executeQuery();
			while (rs.next()){
				String id = rs.getString("wechat_id");
				int number = rs.getInt("number");
				int state = rs.getInt("order_state");
				if(state == 1 || state == 2 || state == 11 || state == 9 || state == 19)continue;
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("wechat_id", id);
				map.put("number", number+"");
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return list;
	}
	
	public static GoodsOrder getGoodsOrderByOutTradeNo(String out_trade_no){
		GoodsOrder goodsOrder = new GoodsOrder();
		
		String sql = "select * from goods_order where out_trade_no = ?";
		Connection conn = new DBUtil().getConn();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, out_trade_no);
			rs = ps.executeQuery();
			if(rs.next()){
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
				goodsOrder.setReceiverName(rs.getString("addr_detail"));
				goodsOrder.setReceiverName(rs.getString("receiver_name"));
				goodsOrder.setPhoneNumber(rs.getString("phone_number"));
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				
			}else{
				return null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return goodsOrder;
	}
	
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
		
		String sql = "select count(*) as cnt from goods_order where goods_id = ? and ((order_state >= 3 and order_state <= 5) or (order_state >= 13 and order_state <=14))";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, goodsId);
			rs = ps.executeQuery();
			if(rs.next()){
				num = rs.getInt("cnt");
			}else{
				return -1;
			}
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
				+ "`addr_detail`, `receiver_name`, `phone_number`"
				+ ", `prepay_id`, `out_trade_no`, `transaction_id`) "
				+ "VALUES (?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?,"
				+ " ?, ?, ?, ?, ?, ?, ?, ?);";
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
			ps.setString(15, order.getPrepayId());
			ps.setString(16, order.getOutTradeNo());
			ps.setString(17, order.getTransactionId());
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
			if(rs.next()){
				order_id = rs.getInt("id");
			}else{
				return -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		return order_id;
	}
	
	
	public static boolean updateGoodsOrder(GoodsOrder order){
		String sql = "UPDATE `greenlife`.`goods_order` SET "
				+ "goods_id = ?, "
				+ "wechat_id = ?, "
				+ "goods_num = ?, "
				+ "trade_time = ?, "
				+ "comment = ?, "
				+ "mail_price = ?, "
				+ "total_price = ?, "
				+ "group_id = ?, "
				+ "send_time = ?, "
				+ "group_minnum = ?, "
				+ "order_state = ?, "
				+ "addr_detail = ?, "
				+ "receiver_name = ?, "
				+ "phone_number = ?, "
				+ "prepay_id = ?, "
				+ "out_trade_no = ?, "
				+ "transaction_id = ? "
				+ "WHERE order_id = ?;";
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
			ps.setString(15, order.getPrepayId());
			ps.setString(16, order.getOutTradeNo());
			ps.setString(17, order.getTransactionId());
			ps.setInt(18, order.getOrderId());
			
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static ArrayList<GoodsOrder> getGoodsOrderListByStateAndDueDay(int order_state,int day){
		
		ArrayList<GoodsOrder> orderList = new ArrayList<>();
		String time = null;
		String sql = "select * from goods_order where order_state = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, order_state);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				GoodsOrder goodsOrder = new GoodsOrder();
				time = rs.getString("trade_time");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
				Date d1 = new Date();
				Date d2 = sdf.parse(time);
				long diff = d1.getTime() - d2.getTime();
				long days = diff / (1000 * 60 * 60 * 24);
				//long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
				//long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60);
				if(days < day){
					continue;
				}
				
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				orderList.add(goodsOrder);
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
		
		return orderList;
	}
	
	
	public static ArrayList<GoodsOrder> getGoodsOrderListByStateAndDueHours(int order_state,int hour){
		
		ArrayList<GoodsOrder> orderList = new ArrayList<>();
		String time = null;
		String sql = "select * from goods_order where order_state = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, order_state);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				GoodsOrder goodsOrder = new GoodsOrder();
				time = rs.getString("trade_time");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
				Date d1 = new Date();
				Date d2 = sdf.parse(time);
				long diff = d1.getTime() - d2.getTime();
				long days = diff / (1000 * 60 * 60 * 24);
				long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
				//long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60);
				if(hours < hour && days == 0){
					continue;
				}
				
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				orderList.add(goodsOrder);
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
		
		return orderList;
	}

	public static ArrayList<GoodsOrder> getGoodsOrderListByState(int order_state){
		
		ArrayList<GoodsOrder> orderList = new ArrayList<>();

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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return orderList;
	}

	
	public static ArrayList<GoodsOrder> getGoodsOrderListByStateAndGoodsId(int order_state, int goods_id){
		
		ArrayList<GoodsOrder> orderList = new ArrayList<>();

		String sql = "select * from goods_order where order_state = ? and goods_id = ?;";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, order_state);
			ps.setInt(2, goods_id);
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return orderList;
	}

	
	public static ArrayList<GoodsOrder> getGoodsOrderListByGroupIdAndState(int groupId, int orderState){
		
		ArrayList<GoodsOrder> orderList = new ArrayList<>();

		String sql = "select * from goods_order where group_id = ? and order_state = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ps.setInt(2, orderState);
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
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
					goodsOrder.setPrepayId(rs.getString("prepay_id"));
					goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
					goodsOrder.setTransactionId(rs.getString("transaction_id"));
					
					orderList.add(goodsOrder);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
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
				goodsOrder.setPrepayId(rs.getString("prepay_id"));
				goodsOrder.setOutTradeNo(rs.getString("out_trade_no"));
				goodsOrder.setTransactionId(rs.getString("transaction_id"));
				
				orderList.add(goodsOrder);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
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
