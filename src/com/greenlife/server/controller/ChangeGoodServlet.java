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

import com.greenlife.*;
import com.greenlife.model.*;
import com.greenlife.util.PropertiesUtil;
import com.greenlife.dao.*;

public class ChangeGoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ChangeGoodServlet() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getSession().getAttribute("login") == null) {// 用户没有登录
			response.sendRedirect("/Server/Page/login.jsp");
		} else {
			request.setCharacterEncoding("UTF-8");

			GoodsInfo changedGood = null;
			GoodsPostage postage=null;
			
			int  goodId=0;
			
			int parentId = 0;
			String goodName = null;
			String packagePath = null;

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
			
			
			//�ʷ�
			String localCity=null;
			double localPostage=0;
			double alienPostage=0;
			
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

					
					if (name.equals("good_id")) {
						goodId =Integer.parseInt(value);
						changedGood = GoodsInfoDao.getGoodsInfo(goodId);
						postage =GoodsPostageDao.getGoodsPostage(goodId);
						packagePath = changedGood.getPackagePath();
					} else if (name.equals("parent_id")) {
						parentId = Integer.parseInt(value);
					}else if (name.equals("good_name")) {
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
					}else if(name.equals("local_city")){
						/////////////////////////
						localCity=value;
						
					}else if(name.equals("local_postage")){
						localPostage = Double.parseDouble(value);
					}else if(name.equals("alien_postage")){
						alienPostage = Double.parseDouble(value);
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
						
						InputStream in = item.getInputStream();

						String path1 = PropertiesUtil.getSavePath() + packagePath;
						File file = new File(path1);

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

			changedGood.setParentId(parentId);
			changedGood.setGoodsName(goodName);
			changedGood.setGoodsPrice(goodPrice);
			changedGood.setGoodsTotalnum(totalNum);
			changedGood.setGoodsSoldnum(0);
			changedGood.setGoodsDiscontPrice(groupPrice);
			changedGood.setStartTime(startTime);
			changedGood.setEndTime(endTime);

			changedGood.setGoods_unit(goodUnit);
			changedGood.setIsDelete(0);
			changedGood.setIsAdv(0);
			changedGood.setGoodsText1(goodText1);
			changedGood.setGoodsText2(goodText2);
			changedGood.setReportNum(reportNum);
			changedGood.setSubTitle(subTitle);
			changedGood.setIsAdv(Integer.parseInt(adv));
			GoodsInfoDao.updateGoodsInfo(changedGood);
			
			
			
			
			if(postage==null){
				postage =new GoodsPostage();
				postage.setGoodsId(goodId);
				postage.setLocalCity(localCity);
				postage.setLocalPostage(localPostage);
				postage.setAlienPostage(alienPostage);
				GoodsPostageDao.addGoodsPostage(postage);	
			}else{
				postage.setLocalCity(localCity);
				postage.setLocalPostage(localPostage);
				postage.setAlienPostage(alienPostage);
				GoodsPostageDao.updateGoodsPostage(postage);	
			}
			
			
			response.sendRedirect("/Server/Page/product.jsp");
		}
	}

}
