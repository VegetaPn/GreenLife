package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.GoodsInfo;
import com.greenlife.util.DBUtil;

public class GoodsInfoDao {
	
	private static PreparedStatement ps;
	private static ResultSet rs;

	public static boolean deleteGoodsInfo(int goodsId){
		String sql = "delete from goods_info where goods_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, goodsId);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static int getNextGoodsId(){
		int goods_id = -1;
		String sql = "select max(goods_id) as id from goods_info;";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				goods_id = rs.getInt("id") + 1;
			}else{
				return -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		return goods_id;
	}
	
	public static int addGoodsInfo(GoodsInfo info){
		String sql = "INSERT INTO `greenlife`.`goods_info` "
				+ "(`goods_name`, `package_path`, "
				+ "`goods_price`, `goods_totalnum`, `goods_soldnum`, "
				+ "`start_time`, `end_time`, `goods_discount_price`, "
				+ "`goods_unit`, `is_delete`, `is_adv`, `goods_text1`, "
				+ "`goods_text2`, `report_id`, `sub_title`, `report_num`) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, ?, ?, ?, ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, info.getGoodsName());
			ps.setString(2, info.getPackagePath());
			ps.setDouble(3, info.getGoodsPrice());
			ps.setInt(4, info.getGoodsTotalnum());
			ps.setInt(5, info.getGoodsSoldnum());
			ps.setString(6, info.getStartTime());
			ps.setString(7, info.getEndTime());
			ps.setDouble(8, info.getGoodsDiscontPrice());
			ps.setString(9, info.getGoods_unit());
			ps.setInt(10, info.getIsDelete());
			ps.setInt(11, info.getIsAdv());
			ps.setString(12, info.getGoodsText1());
			ps.setString(13, info.getGoodsText2());
			ps.setInt(14, info.getReportId());
			ps.setString(15, info.getSubTitle());
			ps.setInt(16, info.getReportNum());
			
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		int goods_id = -1;
		sql = "select max(goods_id) as id from goods_info;";
		conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				goods_id = rs.getInt("id");
			}else{
				return -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			clearUp(conn);
		}
		return goods_id;
	}
	
	public static boolean updateGoodsInfo(GoodsInfo info){
		String sql = "UPDATE `greenlife`.`goods_info` SET "
				+ "`goods_name`=? , "
				+ "`package_path`=? , "
				+ "`goods_price`=? , "
				+ "`goods_totalnum`=? , "
				+ "`goods_soldnum`=? , "
				+ "`start_time`=? , "
				+ "`end_time`=? , "
				+ "`goods_discount_price`=? , "
				+ "`goods_unit`=? , "
				+ "`is_delete`=? , "
				+ "`is_adv`=? , "
				+ "`goods_text1`=? , "
				+ "`goods_text2`=? , "
				+ "`report_id`=? , "
				+ "`sub_title`=? , "
				+ "`report_num`=?  "
				+ "WHERE (`goods_id`= ?);";
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, info.getGoodsName());
			ps.setString(2, info.getPackagePath());
			ps.setDouble(3, info.getGoodsPrice());
			ps.setInt(4, info.getGoodsTotalnum());
			ps.setInt(5, info.getGoodsSoldnum());
			ps.setString(6, info.getStartTime());
			ps.setString(7, info.getEndTime());
			ps.setDouble(8, info.getGoodsDiscontPrice());
			ps.setString(9, info.getGoods_unit());
			ps.setInt(10, info.getIsDelete());
			ps.setInt(11, info.getIsAdv());
			ps.setString(12, info.getGoodsText1());
			ps.setString(13, info.getGoodsText2());
			ps.setInt(14, info.getReportId());
			ps.setString(15, info.getSubTitle());
			ps.setInt(16, info.getReportNum());
			ps.setInt(17, info.getGoodsId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		return true;
	}
	
	
	public static GoodsInfo getGoodsInfo(int goodsId) {
		GoodsInfo goodsInfo = new GoodsInfo();
		
		String sql = "select * from goods_info where goods_id = ?";
		Connection conn = new DBUtil().getConn();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, goodsId);
			rs = ps.executeQuery();
			if(rs.next()){
				// stupid set method......
				goodsInfo.setGoodsId(rs.getInt("goods_id"));
				goodsInfo.setGoodsName(rs.getString("goods_name"));
				goodsInfo.setPackagePath(rs.getString("package_path"));
				goodsInfo.setGoodsPrice(rs.getDouble("goods_price"));
				goodsInfo.setGoodsTotalnum(rs.getInt("goods_totalnum"));
				goodsInfo.setGoodsSoldnum(rs.getInt("goods_soldnum"));
				goodsInfo.setStartTime(rs.getString("start_time"));
				goodsInfo.setEndTime(rs.getString("end_time"));
				goodsInfo.setGoodsDiscontPrice(rs.getDouble("goods_discount_price"));
				goodsInfo.setGoods_unit(rs.getString("goods_unit"));
				goodsInfo.setIsDelete(rs.getInt("is_delete"));
				goodsInfo.setIsAdv(rs.getInt("is_adv"));
				goodsInfo.setGoodsText1(rs.getString("goods_text1"));
				goodsInfo.setGoodsText2(rs.getString("goods_text2"));
				goodsInfo.setReportId(rs.getInt("report_id"));
				goodsInfo.setSubTitle(rs.getString("sub_title"));
				goodsInfo.setReportNum(rs.getInt("report_num"));
			}else{
				return null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return goodsInfo;
	}
	
	
	public static List<GoodsInfo> getGoodsList() {
		
		List<GoodsInfo> goodsList = new ArrayList<>();
		String sql = "select * from goods_info";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				GoodsInfo goodsInfo = new GoodsInfo();
				
				// stupid set method......
				goodsInfo.setGoodsId(rs.getInt("goods_id"));
				goodsInfo.setGoodsName(rs.getString("goods_name"));
				goodsInfo.setPackagePath(rs.getString("package_path"));
				goodsInfo.setGoodsPrice(rs.getDouble("goods_price"));
				goodsInfo.setGoodsTotalnum(rs.getInt("goods_totalnum"));
				goodsInfo.setGoodsSoldnum(rs.getInt("goods_soldnum"));
				goodsInfo.setStartTime(rs.getString("start_time"));
				goodsInfo.setEndTime(rs.getString("end_time"));
				goodsInfo.setGoodsDiscontPrice(rs.getDouble("goods_discount_price"));
				goodsInfo.setGoods_unit(rs.getString("goods_unit"));
				goodsInfo.setIsDelete(rs.getInt("is_delete"));
				goodsInfo.setIsAdv(rs.getInt("is_adv"));
				goodsInfo.setGoodsText1(rs.getString("goods_text1"));
				goodsInfo.setGoodsText2(rs.getString("goods_text2"));
				goodsInfo.setReportId(rs.getInt("report_id"));
				goodsInfo.setSubTitle(rs.getString("sub_title"));
				goodsInfo.setReportNum(rs.getInt("report_num"));
				goodsList.add(goodsInfo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			clearUp(conn);
		}
		
		return goodsList;
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
