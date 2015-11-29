package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.ReportList;
import com.greenlife.util.DBUtil;

public class ReportListDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean addReportList(ReportList list){
		String sql = "INSERT INTO `greenlife`.`report_list` (`report_id`, `report_num`) VALUES (?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, list.getReportId());
			ps.setInt(2, list.getReportNum());
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
