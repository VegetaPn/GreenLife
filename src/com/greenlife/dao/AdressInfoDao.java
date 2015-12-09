package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.AdressInfo;
import com.greenlife.model.GoodsInfo;
import com.greenlife.util.DBUtil;

public class AdressInfoDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static List<AdressInfo> getAdressList(String wechatId){
		List<AdressInfo> list = new ArrayList<AdressInfo>();
		String sql = "select * from address_info where wechat_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			rs = ps.executeQuery();
			while (rs.next()) {
				AdressInfo info = new AdressInfo();
				info.setAddrId(rs.getInt("addr_id"));
				info.setAddrDetail(rs.getString("addr_detail"));
				info.setAddrZipcode(rs.getString("addr_zipcode"));
				info.setReceiverPhone(rs.getString("receiver_phone"));
				info.setReceiverName(rs.getString("receiver_name"));
				info.setWechatId(rs.getString("wechat_id"));
				list.add(info);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return list;
	}
	
	
	public static AdressInfo getAdressInfo(int addrId){
		AdressInfo info = new AdressInfo();
		String sql = "select * from address_info where addr_id = ?";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, addrId);
			rs = ps.executeQuery();
			while (rs.next()) {
				info.setAddrId(rs.getInt("addr_id"));
				info.setAddrDetail(rs.getString("addr_detail"));
				info.setAddrZipcode(rs.getString("addr_zipcode"));
				info.setReceiverPhone(rs.getString("receiver_phone"));
				info.setReceiverName(rs.getString("receiver_name"));
				info.setWechatId(rs.getString("wechat_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return info;
	}
	
	//return value -1 means add error
	public static int addAdressInfo(AdressInfo info){
		int addrId = -1;
		String sql = "INSERT INTO `greenlife`.`address_info` "
			+"(`addr_detail`, `addr_zipcode`, "
				+"`receiver_phone`, `wechat_id`, `receiver_name`)"
				+" VALUES (?, ?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			//ps.setInt(1, info.getAddrId());
			ps.setString(1, info.getAddrDetail());
			ps.setString(2, info.getAddrZipcode());
			ps.setString(3, info.getReceiverPhone());
			ps.setString(4, info.getWechatId());
			ps.setString(5, info.getReceiverName());
			ps.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		sql = "select max(addr_id) as id from address_info";
		conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			addrId = rs.getInt("id");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
		}
		return addrId;
	}
	
	public static boolean updateAdressInfo(AdressInfo info){
		String sql = "UPDATE `greenlife`.`address_info` SET "
				+"addr_detail = (?), "
				+"addr_zipcode = (?), "
				+"receiver_phone = (?), "
				+"wechat_id = (?), "
				+"receiver_name = (?) "
				+"WHERE addr_id = (?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, info.getAddrDetail());
			ps.setString(2, info.getAddrZipcode());
			ps.setString(3, info.getReceiverPhone());
			ps.setString(4, info.getWechatId());
			ps.setString(5, info.getReceiverName());
			ps.setInt(6, info.getAddrId());
			ps.executeUpdate();
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