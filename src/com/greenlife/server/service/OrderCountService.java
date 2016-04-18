package com.greenlife.server.service;

import com.greenlife.dao.GoodsOrderDao;

public class OrderCountService {
	public static int getToGroupCount() {
		return GoodsOrderDao.getCountByState(2);
	}

	public static int getToPayCount() {
		return GoodsOrderDao.getCountByState(1)+GoodsOrderDao.getCountByState(11);
	}

	public static int getToSendCount() {
		return GoodsOrderDao.getCountByState(3)+GoodsOrderDao.getCountByState(12);
	}

	public static int getToReceiveCount() {
		return GoodsOrderDao.getCountByState(4)+GoodsOrderDao.getCountByState(13);
	}

	public static int getFinishCount() {
		return GoodsOrderDao.getCountByState(5)+GoodsOrderDao.getCountByState(14);
	}

	public static int getRefundCount() {
		return GoodsOrderDao.getCountByState(8)+GoodsOrderDao.getCountByState(18);
	}
	
	
}
