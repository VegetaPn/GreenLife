package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.Comment;
import com.greenlife.model.UserInfo;
import com.greenlife.util.DBUtil;

public class CommentDao {
	
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean addCommentList(Comment cmt){
		List<Comment> list = new ArrayList<Comment>();
		
		String sql = "INSERT INTO `greenlife`.`comment` "
				+ "(`goods_id`, `wechat_id`, `comment_content`) VALUES (?, ?, ?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cmt.getGoodsId());
			ps.setString(2, cmt.getWechatId());
			ps.setString(3, cmt.getContent());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static List<Comment> getCommentList(int goodsId){
		List<Comment> list = new ArrayList<Comment>();
		
		String sql = "select * from comment";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Comment cmt = new Comment();
				cmt.setWechatId(rs.getString("wechat_id"));
				cmt.setGoodsId(rs.getInt("goods_id"));
				cmt.setContent(rs.getString("comment_content"));
				list.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			clearUp(conn);
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
