package com.greenlife.client.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.greenlife.dao.CommentDao;
import com.greenlife.dao.ConcernedListDao;
import com.greenlife.model.Comment;
import com.greenlife.model.ConcernedList;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CommentServlet() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String wechatId = null;
		
		//测试
		wechatId ="huangjianqiang";
		
		/*
		HttpSession session = request.getSession();
		wechatId = (String)session.getAttribute("wechatId");
		*/
		Integer goodsId = Integer.parseInt(request.getParameter("goodsId"));
		String text = request.getParameter("text");
		String img = request.getParameter("img");
		
		
		Comment comment = new Comment();
		comment.setGoodsId(goodsId);
		comment.setWechatId(wechatId);
		comment.setContent(text);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
		String time = sdf.format(new Date());
		
		comment.setTime(time);
		
		if(!img.equals("")){
			
		}
		
		
		CommentDao.addCommentList(comment);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
