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
		AdressInfo info = new AdressInfo();
		info.setAddrDetail("sdfsdf");
		info.setAddrZipcode("100044");
		info.setReceiverName("黄坚强");
		info.setWechatId("huangjianqiang");
		info.setReceiverPhone("133301000332");
		int ret = AdressInfoDao.addAdressInfo(info);
		System.out.println("AddrId:" + ret);
	}

}
