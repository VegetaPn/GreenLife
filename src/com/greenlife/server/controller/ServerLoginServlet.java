package com.greenlife.server.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.greenlife.dao.AdminListDao;

public class ServerLoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServerLoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/*
	 * Judge the userid and password is all right
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		if (AdminListDao.loginCheck(userId, password)) {// ��¼�ɹ�
			session.setAttribute("login", true);/// ��ӱ��������ж��Ƿ��¼

			response.sendRedirect("/Server/Page/product.jsp");
		} else {
			session.setAttribute("userId", userId);
			session.setAttribute("error", "�û������������");
			response.sendRedirect("/Server/Page/login.jsp");
		}

	}

}
