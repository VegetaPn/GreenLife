package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.greenlife.model.KnowYuanlai;
import com.greenlife.util.DBUtil;

public class KonwYuanlaiDao {
	private static PreparedStatement ps;
	private static ResultSet rs;


	public static boolean addKonwYuanlai(KnowYuanlai konwYuanlai){
		String sql = "insert into konw_yuanlai (`konw_img`) values (?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, konwYuanlai.getKonwImg());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	
	public static boolean updateKonwYuanlai(KnowYuanlai konwYuanlai){
		String sql = "update konw_yuanlai set "
				+ "konw_img = (?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, konwYuanlai.getKonwImg());
			ps.execute();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	public static KnowYuanlai getKonwYuanlai(){
		KnowYuanlai knowYuanlai = new KnowYuanlai();
	
	
		String sql = "select * from konw_yuanlai";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				knowYuanlai.setKonwImg(rs.getString("konw_img"));
				
			}else{
				return null;
			}
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally {
			clearUp(conn);
		}
			
		return knowYuanlai;
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
