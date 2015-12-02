package com.greenlife.client.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class TestServlet extends HttpServlet {

	 /**
	  * 
	  */
	 private static final long serialVersionUID = 7381169134016556647L;

	 public void doGet(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
	   doPost(request,response);
	 }

	 public void doPost(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
	   
	   HttpSession session=request.getSession();
       session.setAttribute("wechatId","110");


	  
	  String forward = "/Client/page/home.jsp";
	  RequestDispatcher rd=request.getRequestDispatcher(forward);
	  rd.forward(request,response);
	 }
	}


