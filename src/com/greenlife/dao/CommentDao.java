package com.greenlife.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenlife.model.Comment;
import com.greenlife.util.DBUtil;

public class CommentDao {
	
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static boolean deleteComment(String wechatId, int goodsId){
		String sql = "delete from comment where wechat_id = ? and goods_id = ?;";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wechatId);
			ps.setInt(2, goodsId);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			clearUp(conn);
		}
		
		return true;
	}
	
	public static boolean addCommentList(Comment cmt){
		
		String sql = "INSERT INTO `greenlife`.`comment` "
				+ "(`goods_id`, `wechat_id`, `comment_content`, `time`, `img_path`) "
				+ "VALUES (?, ?, ?, ?, ?);";
		
		Connection conn = new DBUtil().getConn();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cmt.getGoodsId());
			ps.setString(2, cmt.getWechatId());
			ps.setString(3, cmt.getContent());
			ps.setString(4, cmt.getTime());
			ps.setString(5, cmt.getImgPath());
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
				cmt.setTime(rs.getString("time"));
				cmt.setImgPath(rs.getString("img_path"));
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
