package com.greenlife.util;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.GoodsInfoDao;
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
		info.setEndTime("sdf22332");
		info.setGoods_unit("sdfsd");
		info.setGoodsDiscontPrice(23);
		info.setGoodsName("dsfsd");
		info.setGoodsPrice(23);
		info.setGoodsSoldnum(11);
		info.setGoodsText1("sbsdb");
		info.setGoodsText2("sdf2323");
		info.setGoodsTotalnum(2323);
		info.setIsAdv(1);
		info.setIsDelete(0);
		info.setPackagePath("path");
		info.setReportId(123223);
		info.setStartTime("ds232232323");
		info.setTagImage("s23223");
		info.setTagText("s23223");
		info.setTagTitle("title");
		GoodsInfoDao.addGoodsInfo(info);
	}

}
