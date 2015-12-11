package com.greenlife.util;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.WechatInfoDao;
import com.greenlife.model.WechatInfo;

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
		WechatInfo info = new WechatInfo();
		info.setCity("234");
		info.setCountry("fsdfsdf");
		info.setHeadimgurl("sdfsd");
		info.setNickname("sdfsd");
		info.setPrivilege("sdfsdfsd");
		info.setProvince("flkfjsd");
		info.setSex("male");
		info.setUnionId("2323423");
		info.setWechatId("huangjianqiang");
		WechatInfoDao.addWechatInfo(info);
		info = WechatInfoDao.getWechatInfo("huangjianqiang");
	}

}
