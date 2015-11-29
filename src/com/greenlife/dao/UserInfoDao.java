package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.UserInfo;
import com.greenlife.util.DBUtil;

public class UserInfoDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean addUserInfo(UserInfo info){
		String sql = "INSERT INTO `greenlife`.`user_info` "
				+ "(`wechat_id`, `wechat_name`, `phone`, `address_id`, `photo_path`) "
				+ "VALUES (?, ?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, info.getWechatId());
			ps.setString(2, info.getWechatName());
			ps.setString(3, info.getPhone());
			ps.setInt(4, info.getAddrId());
			ps.setString(5, info.getPhotoPath());
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
