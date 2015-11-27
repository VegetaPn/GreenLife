package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.GoodsInfo;
import com.greenlife.util.*;

public class GoodsInfoDao {
	
	private static PreparedStatement ps;
	private static ResultSet rs;
	
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
				goodsInfo.setTagTitle(rs.getString("tag_title"));
				goodsInfo.setTagText(rs.getString("tag_text"));
				goodsInfo.setTagImage(rs.getString("tag_image"));
				goodsInfo.setGoodsDiscontPrice(rs.getDouble("goods_discount_price"));
				goodsInfo.setGoods_unit(rs.getString("goods_unit"));
				goodsInfo.setIsDelete(rs.getInt("is_delete"));
				goodsInfo.setIsAdv(rs.getInt("is_adv"));
				goodsInfo.setGoodsText1(rs.getString("goods_text1"));
				goodsInfo.setGoodsText2(rs.getString("goods_text2"));
				goodsInfo.setReportId(rs.getInt("report_id"));
				
				goodsList.add(goodsInfo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
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
