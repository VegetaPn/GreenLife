package com.greenlife.wechatservicetest;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.model.GoodsOrder;
import com.greenlife.wechatservice.WechatService;



public class PlaceOrderTest {
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
	public void testPlaceOrder(){
		int orderId = 1;

		
		String userIp = "192.168.1.1";
	
		WechatService.placeOrder(orderId, userIp);
		
	}
}
