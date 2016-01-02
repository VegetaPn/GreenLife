package com.greenlife.wechatservicetest;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.GoodsOrder;
import com.greenlife.wechatservice.WechatService;

public class GetGoodsOrderByOutTradeNoTest {
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {

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
	public void test(){
		GoodsOrder goodsOrder = GoodsOrderDao.getGoodsOrderByOutTradeNo("1451757000198");
		String c = goodsOrder.getComment();
		c =c+c;
	}
}
