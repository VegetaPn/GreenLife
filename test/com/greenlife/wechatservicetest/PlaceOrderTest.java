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
		GoodsOrder goodsOrder = new GoodsOrder();
		
		goodsOrder.setAddrDetail("地址");
		goodsOrder.setGoodsId(1);
		goodsOrder.setGoodsNum(2);
		goodsOrder.setGroupMinnum(2);
		goodsOrder.setMailPrice(0);
		goodsOrder.setOrderState(1);
		goodsOrder.setPhoneNumber("1888");
		goodsOrder.setReceiverName("afsa");
		goodsOrder.setSendTime("aa");
		goodsOrder.setTotalPrice(0.01);
		goodsOrder.setWechatId("ofK5FwyPHRh9EaEJRj9cgMK4uJrg");
		
		String userIp = "192.168.1.1";
	
		WechatService.placeOrder(goodsOrder, userIp);
		
	}
}
