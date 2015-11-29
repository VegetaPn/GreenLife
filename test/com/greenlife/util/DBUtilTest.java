package com.greenlife.util;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.AdressInfoDao;
import com.greenlife.model.AdressInfo;

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
		//DBUtil util = new DBUtil();
		//util.getConn();
		AdressInfo info = new AdressInfo();
		info.setAddrDetail("222");
		info.setAddrId(2222);
		info.setAddrZipcode("sdfsd");
		info.setReceiverName("sdfsd");
		info.setReceiverPhone("2e423423");
		info.setWechatId("23423");
		AdressInfoDao.addAdressInfo(info);
	}

}
