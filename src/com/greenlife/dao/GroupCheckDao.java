package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.GoodsOrder;

public class GroupCheckDao {
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	//获取过期的订单
	public static List<GoodsOrder> getOverdueOrder(List<GoodsOrder> input){
		List<GoodsOrder> list = new ArrayList<GoodsOrder>();
		GoodsOrder order = null;
		for(int i=0;i<input.size();i++){
			order = input.get(i);
			//order.getTotalPrice()
		}
		return list;
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
