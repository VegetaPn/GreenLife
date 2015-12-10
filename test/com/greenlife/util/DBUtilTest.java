package com.greenlife.util;

import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.AdressInfoDao;
import com.greenlife.dao.ConcernedListDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.AdressInfo;
import com.greenlife.model.GoodsOrder;

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
		List<GoodsOrder> orderList = GoodsOrderDao.getGoodsOrderList();
		System.out.println(orderList.size());
	}

}
