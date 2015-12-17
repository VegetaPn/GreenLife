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
		request.setCharacterEncoding("UTF-8");
		/*
		 * ��Ʒ����
		 */
		String goodName = null;
		String packagePath ="goods/"+GoodsInfoDao.getNextGoodsId()+"/";
	
		/*
		 * �����۸�
		 */
		double goodPrice = 0;
		double groupPrice = 0;
		int totalNum = 0;

		String goodUnit = null;

		int reportNum = 0;

		/*
		 * ����ʱ��
		 */
		String startTime = null;
		String endTime = null;

		/*
		 * ��Ʒ����
		 */
		String goodText1 = null;
		String goodText2 = null;

		// ΢�ű�ǩ
		String tagTitle = null;
		String tagText = null;



		// Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();

		// Create a new file upload handler //�����ô�СĬ��Ϊ���޴�
		ServletFileUpload upload = new ServletFileUpload(factory);

		// Parse the request
		List<FileItem> items = null;
		try {
			items = upload.parseRequest(request);/// ��ȡ�����ݵ��б�
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Iterator<FileItem> iter = items.iterator();
		// ���ζ�ȡ���е�����
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next(); // �ӱ��ύ��һ�����ݣ��ļ����߱�����

			// TODO Auto-generated method stub
			/*
			 * ��ƷID
			 */

			if (item.isFormField()) {
				// �������ͨ���ֶ�
				String name = item.getFieldName();
				String value = new String(item.getString("UTF-8"));

				/*
				 * ��Ʒ����
				 */

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
				} else if (name.equals("tag_title")) {
					tagTitle = value;
				} else if (name.equals("tag_text")) {
					tagText = value;
				} else if (name.equals("good_text1")) {
					goodText1 = value;
				} else if (name.equals("good_text2")) {
					goodText2 = value;
				} else {
				}
				System.out.println(value);
			} else {
				// �������
				String filename = "";
				System.out.println(item.getFieldName());
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
					System.out.println(item.getName());
					InputStream in = item.getInputStream();
					String path1 = PropertiesUtil.getPath()+packagePath + filename;
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
		// �����Ʒ
		GoodsInfo newGood = new GoodsInfo();
		newGood.setGoodsName(goodName);
		newGood.setGoodsId(0);
		newGood.setPackagePath(packagePath);
		newGood.setGoodsPrice(goodPrice);
		newGood.setGoodsTotalnum(totalNum);
		newGood.setGoodsSoldnum(0);
		newGood.setStartTime(startTime);
		newGood.setEndTime(endTime);
		newGood.setTagTitle(tagTitle);
		newGood.setTagText(tagText);
		newGood.setTagImage("no");
		newGood.setGoods_unit(goodUnit);
		newGood.setIsDelete(0);
		newGood.setIsAdv(0);
		newGood.setGoodsText1(goodText1);
		newGood.setGoodsText2(goodText2);
		newGood.setReportId(reportNum);
		
	}
	

}
