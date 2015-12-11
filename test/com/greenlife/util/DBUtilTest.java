package com.greenlife.util;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.UserInfoDao;

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
		System.out.print(UserInfoDao.isExist("huangjianqiang"));
	}

}
