package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.greenlife.model.GoodsInfo;
import com.greenlife.model.GoodsPostage;
import com.greenlife.util.DBUtil;

public class GoodsPostageDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	
	public static GoodsPostage getGoodsPostage(int goodsId){
		GoodsPostage goodsPostage = new GoodsPostage();
		
		String sql = "select * from goods_postage where goods_id = ?";
		Connection conn = new DBUtil().getConn();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, goodsId);
			rs = ps.executeQuery();
			if(rs.next()){
				// stupid set method......
				goodsPostage.setGoodsId(rs.getInt("goods_id"));
				goodsPostage.setLocalCity(rs.getString("local_city"));
				goodsPostage.setLocalPostage(rs.getDouble("local_postage"));
				goodsPostage.setAlienPostage(rs.getDouble("alien_postage"));
				
			}else{
				return null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return goodsPostage;
	}
	

	public static boolean addGoodsPostage(GoodsPostage goodsPostage){
		String sql = "INSERT INTO `greenlife`.`goods_postage` "
				+ "(`goods_id`,  `local_city`, `local_postage`, `alien_postage`) "
				+ "VALUES (?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, goodsPostage.getGoodsId());
			ps.setString(2, goodsPostage.getLocalCity());
			ps.setDouble(3, goodsPostage.getLocalPostage());
			ps.setDouble(4, goodsPostage.getAlienPostage());
			
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static boolean updateGoodsPostage(GoodsPostage goodsPostage){
		String sql = "UPDATE `greenlife`.`goods_postage` SET "
				+ "`local_city`=? , "
				+ "`local_postage`=? , "
				+ "`alien_postage`=? "
				+ "WHERE (`goods_id`= ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, goodsPostage.getLocalCity());
			ps.setDouble(2, goodsPostage.getLocalPostage());
			ps.setDouble(3, goodsPostage.getAlienPostage());
			ps.setInt(4, goodsPostage.getGoodsId());
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
