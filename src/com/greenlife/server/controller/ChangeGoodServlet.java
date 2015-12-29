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

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.model.GoodsInfo;
import com.greenlife.util.PropertiesUtil;

/**
 * Servlet implementation class ChangeProduct
 */

public class ChangeGoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangeGoodServlet() {
		super();
		// TODO Auto-generated constructor stub
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

		GoodsInfo changedGood = null;
		String goodName = null;
		String packagePath = null;

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
				System.out.println(name);
				if (name.equals("good_id")) {
					changedGood = GoodsInfoDao.getGoodsInfo(Integer.parseInt(value));
					packagePath = changedGood.getPackagePath();
				} else if (name.equals("good_name")) {
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
					// String path1 = PropertiesUtil.getSavePath()+packagePath +
					// filename;
					String path1 = PropertiesUtil.getSavePath()+ packagePath;
					File file = new File(path1);
					// �ļ������ڣ�Ҳ�����ļ���
					if (!file.exists() && !file.isDirectory()) {
						file.mkdir();
					}
					FileOutputStream fos = new FileOutputStream(new File(path1 + "/" + filename));
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
		System.out.println("teci chakan" + goodName);
		changedGood.setGoodsName(goodName);
		changedGood.setGoodsPrice(goodPrice);
		changedGood.setGoodsTotalnum(totalNum);
		changedGood.setGoodsSoldnum(0);
		changedGood.setGoodsDiscontPrice(groupPrice);
		changedGood.setStartTime(startTime);
		changedGood.setEndTime(endTime);
		changedGood.setTagTitle(tagTitle);
		changedGood.setTagText(tagText);
		changedGood.setTagImage("no");
		changedGood.setGoods_unit(goodUnit);
		changedGood.setIsDelete(0);
		changedGood.setIsAdv(0);
		changedGood.setGoodsText1(goodText1);
		changedGood.setGoodsText2(goodText2);
		changedGood.setReportId(reportNum);

		GoodsInfoDao.updateGoodsInfo(changedGood);
		response.sendRedirect("/Server/Page/product.jsp");
	}

}
