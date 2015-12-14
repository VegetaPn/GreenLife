package com.greenlife.server.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddProductServlet
 */

public class AddGoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddGoodServlet() {

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// TODO Auto-generated method stub
		/*
		 * ��ƷID
		 */
		int goodId = 00000;

		/*
		 * ��Ʒ����
		 */
		String goodName = request.getParameter("good_name");

		/*
		 * ��ƷͼƬ·��
		 */
		String packagePath = "goods/" + goodId;

		/*
		 * ��Ʒ�۸���ͨ���Ź�
		 */
		double goodPrice = Double.parseDouble(request.getParameter("good_price"));
		double groupPrice = Double.parseDouble(request.getParameter("group_price"));

		/*
		 * ��Ʒ���� ��������
		 */
		int totalNum = Integer.parseInt(request.getParameter("total_num"));
		int soldNum = 0;

		/*
		 * ��ʼ���ںͽ�������
		 */
		String startTime = request.getParameter("start_time");
		String endTime = request.getParameter("end_time");

		/*
		 * ΢�ű�ǩ����
		 */
		String tagTitle = request.getParameter("tag_title");
		String tagText = request.getParameter("tag_text");
		String tagImage = request.getParameter("tag_image");/// �ļ�·��

		/*
		 * ��Ʒ����
		 */

		String goodText1 = request.getParameter("good_text1");
		String goodText2 = request.getParameter("good_text2");

		System.out.println(goodId + " " + goodName + " " + packagePath + " " + goodPrice + " " + groupPrice + " "
				+ totalNum + " " + startTime + " " + endTime + " " + tagTitle + " " + tagText + " " + tagImage + " "
				+ goodText1 + " " + goodText2 + " ");
	}

}
