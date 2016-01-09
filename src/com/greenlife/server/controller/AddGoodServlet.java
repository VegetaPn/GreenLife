package com.greenlife.server.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.model.GoodsInfo;
import com.greenlife.util.PropertiesUtil;

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
		if (request.getSession().getAttribute("login") == null) {// 用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		} else {
			request.setCharacterEncoding("UTF-8");

			String goodName = null;
			int goodId = GoodsInfoDao.getNextGoodsId();
			String packagePath = "goods/" + goodId + "/";

			double goodPrice = 0;
			double groupPrice = 0;
			int totalNum = 0;

			String goodUnit = null;

			int reportNum = 0;

			String startTime = null;
			String endTime = null;

			String goodText1 = null;
			String goodText2 = null;

			String subTitle = null;
			String adv = null;

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

				if (item.isFormField()) {

					String name = item.getFieldName();
					String value = new String(item.getString("UTF-8"));

					if (name.equals("good_name")) {
						goodName = value;
					} else if (name.equals("good_price")) {
						goodPrice = Double.parseDouble(value);
					} else if (name.equals("group_price")) {
						groupPrice = Double.parseDouble(value);
					} else if (name.equals("total_num")) {
						totalNum = Integer.parseInt(value);
					} else if (name.equals("good_unit")) {
						goodUnit = value;
					} else if (name.equals("report_num")) {
						reportNum = Integer.parseInt(value);
					} else if (name.equals("start_time")) {
						startTime = value;
					} else if (name.equals("end_time")) {
						endTime = value;
					} else if (name.equals("good_text1")) {
						goodText1 = value;
					} else if (name.equals("good_text2")) {
						goodText2 = value;
					} else if (name.equals("sub_title")) {
						subTitle = value;
					} else if (name.equals("adv")) {
						adv = value;
					}
				} else {
					String filename = "";
					if (item.getFieldName().equals("normal_img")) {
						filename = "normal.jpg";
					} else if (item.getFieldName().equals("small_img")) {
						filename = "small.jpg";
					} else if (item.getFieldName().equals("detail_img")) {
						filename = "detail.jpg";
					} else if (item.getFieldName().equals("report_img")) {
						filename = "report.jpg";
					}
					if (!item.getName().equals("")) {
						// 将上传的图片保存
						InputStream in = item.getInputStream();

						String path1 = PropertiesUtil.getSavePath() + packagePath;
						File file = new File(path1);

						if (!file.exists() && !file.isDirectory()) {
							file.mkdirs();
						}
						System.out.println(path1);
						FileOutputStream fos = new FileOutputStream(new File(path1 + filename));
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

			GoodsInfo newGood = new GoodsInfo();
			newGood.setGoodsName(goodName);
			newGood.setGoodsId(goodId);
			newGood.setPackagePath(packagePath);
			newGood.setGoodsPrice(goodPrice);
			newGood.setGoodsTotalnum(totalNum);
			newGood.setGoodsDiscontPrice(groupPrice);
			newGood.setGoodsSoldnum(0);
			newGood.setStartTime(startTime);
			newGood.setEndTime(endTime);
			newGood.setGoods_unit(goodUnit);
			newGood.setIsDelete(0);
			newGood.setIsAdv(0);
			newGood.setGoodsText1(goodText1);
			newGood.setGoodsText2(goodText2);
			newGood.setReportNum(reportNum);
			newGood.setSubTitle(subTitle);
			newGood.setIsAdv(Integer.parseInt(adv));

			int i = GoodsInfoDao.addGoodsInfo(newGood);
			response.sendRedirect("/Server/Page/product.jsp");
		}

	}
}
