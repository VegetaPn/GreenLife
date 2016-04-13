package com.greenlife.server.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.greenlife.util.PropertiesUtil;

/**
 * Servlet implementation class ChangeKnowUsServlet
 */
@WebServlet("/ChangeKnowUsServlet")
public class ChangeKnowUsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangeKnowUsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getSession().getAttribute("login") == null) {// 用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		} else {
			DiskFileItemFactory factory = new DiskFileItemFactory();

			ServletFileUpload upload = new ServletFileUpload(factory);

			List<FileItem> items = null;
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e) {

				e.printStackTrace();
			}
			Iterator<FileItem> iter = items.iterator();
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (!item.isFormField()) {
					if (item.getFieldName().equals("knowus_img")) {

						if (!item.getName().equals("")) {
							
							InputStream in = item.getInputStream();
							String path1 = PropertiesUtil.getSavePath() + "konwYuanlai.jpg";
							FileOutputStream fos = new FileOutputStream(new File(path1));
							byte[] b = new byte[1024];
							int size = 0;
							while ((size = in.read(b)) > 0) {
								fos.write(b, 0, size);
							}
							in.close();
							fos.close();
						}
					}
				}
			}

		}
		
		response.sendRedirect("/Server/Page/product.jsp");
	}

}
