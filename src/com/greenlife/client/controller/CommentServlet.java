package com.greenlife.client.controller;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
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
import com.greenlife.util.PropertiesUtil;

/**
 * Servlet implementation class CommentServlet
 */
//@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CommentServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String wechatId = null;

		// 测试
		wechatId = "huangjianqiang";

		/*
		 * HttpSession session = request.getSession(); wechatId =
		 * (String)session.getAttribute("wechatId");
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

		int commentId = CommentDao.addCommentList(comment);

		comment.setCommentId(commentId);
		if (!img.equals("")) {
			String accessToken = (String) request.getSession().getAttribute("accessToken");

			String path = "comment/" + commentId + "/";
			String savePath = PropertiesUtil.getPath() + path;
			String filename = downloadMedia(accessToken, img, savePath);
			if (filename != null) {
				comment.setImgPath(path + filename);
				CommentDao.updateCommentt(comment);
			}

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	private String downloadMedia(String accessToken, String mediaId, String savePath) {
		String filename = null;
		// 拼接请求地址
		String requestUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + accessToken + "&media_id="
				+ mediaId;

		try {
			URL url = new URL(requestUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoInput(true);
			conn.setRequestMethod("GET");

			String disposition = conn.getHeaderField("Content-disposition");

			int index = disposition.indexOf('\"');
			filename = disposition.substring(index + 1, disposition.length() - 1);

			String filePath = savePath + filename;

			BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());

			File file = new File(filePath);
			if (!file.exists()) {
				if (!file.getParentFile().exists()) {
					// 如果目标文件所在的目录不存在，则创建父目录
					if (!file.getParentFile().mkdirs()) {

						return null;
					}
				}

				if (!file.createNewFile()) {
					return null;
				}
			}
			FileOutputStream fos = new FileOutputStream(file);
			byte[] buf = new byte[8096];
			int size = 0;
			while ((size = bis.read(buf)) != -1)
				fos.write(buf, 0, size);
			fos.close();
			bis.close();

			conn.disconnect();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return filename;
	}

}
