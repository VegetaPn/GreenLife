package com.greenlife.util;

import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.greenlife.dao.CommentDao;
import com.greenlife.model.Comment;

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
		Comment cmt = new Comment();
		cmt.setContent("sdfsdkfjsl");
		cmt.setGoodsId(1);
		cmt.setWechatId("huangjianqiang");
		CommentDao.addCommentList(cmt);
		List<Comment> list = CommentDao.getCommentList(1);
		System.out.println(list.size());
	}

}
