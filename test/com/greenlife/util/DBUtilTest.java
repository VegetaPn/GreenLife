package com.greenlife.util;

import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.CommentDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.dao.TodayGroupDao;
import com.greenlife.model.Comment;
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
//		GoodsOrder order = new GoodsOrder();
//		order.setAddrDetail("北京市;北京;海淀区上园村3号北京交通大学");
//		order.setComment("太好了");
//		order.setGoodsId(1);
//		order.setGoodsNum(1);
//		//order.setGroupId(groupId);
//		order.setGroupMinnum(2);
//		order.setMailPrice(12.22);
//		//order.setOrderId(3);
//		order.setOrderState(0);
//		order.setPhoneNumber("18813095177");
//		order.setReceiverName("黄坚强");
//		order.setSendTime("2015/12/31/21:20:00");
//		order.setTotalPrice(50.00);
//		order.setTradeTime("2015/12/30/21:20:00");
//		order.setWechatId("huangjianqiang");
//		GoodsOrderDao.addGoodsOrder(order);
		System.out.print(TodayGroupDao.getTodayGroup(1).toString());
	}

	@Test
	public void testComment(){
		Comment comment = new Comment();
		comment.setCommentId(1);
		comment.setContent("aa");
		comment.setImgPath("img");
		comment.setGoodsId(1);
		comment.setTime("a");
		comment.setWechatId("a");
		CommentDao.updateComment(comment);
	}
}
