package com.greenlife.util;

import java.util.List;

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
		List<AdressInfo> list = AdressInfoDao.getAdressList("huangjianqiang");
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i).getReceiverName());
		}
		AdressInfo info = AdressInfoDao.getAdressInfo(2);
		System.out.println(info.getReceiverName());
	}

}
