package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.AdressInfo;
import com.greenlife.util.DBUtil;

public class AdressInfoDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean addAdressInfo(AdressInfo info){
		String sql = "INSERT INTO `greenlife`.`address_info` "
			+"(`addr_id`, `addr_detail`, `addr_zipcode`, "
				+"`receiver_phone`, `wechat_id`, `receiver_name`)"
				+" VALUES (?, ?, ?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, info.getAddrId());
			ps.setString(2, info.getAddrDetail());
			ps.setString(3, info.getAddrZipcode());
			ps.setString(4, info.getReceiverPhone());
			ps.setString(5, info.getWechatId());
			ps.setString(6, info.getReceiverName());
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