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
		GoodsInfo info;
		info = GoodsInfoDao.getGoodsInfo(1);
		System.out.println("name: " + info.getGoodsName());
	}

}