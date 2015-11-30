package com.greenlife.util;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.GoodsInfo;

public class DBUtilTest {

//	static DBUtil util;
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
//		util = new DBUtil();
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetConn() {
		GoodsInfo info = new GoodsInfo();
		info.setGoodsId(1);
		info.setGoodsName("大米");
		info.setPackagePath("C:/projects/greenlife/");
		info.setGoodsPrice(110.00);
		info.setGoodsTotalnum(20);
		info.setGoodsSoldnum(1);
		info.setStartTime("2015/11/28/00:00");
		info.setEndTime("2015/12/30/00:00");
		info.setTagTitle("大米饭");
		info.setTagText("大米特好吃");
		info.setTagImage("C:/Projects/greenlife/");
		info.setGoodsDiscontPrice(88.88);
		info.setGoods_unit("袋");
		info.setIsDelete(0);
		info.setIsAdv(0);
		info.setGoodsText1("产地：北京怀柔");
		info.setGoodsText2("物美价廉");
		
		GoodsInfoDao.updateGoodsInfo(info);
	}

}
