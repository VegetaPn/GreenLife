package com.greenlife.services;

import java.util.ArrayList;

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.dao.TodayGroupDao;
import com.greenlife.model.GoodsOrder;
import com.greenlife.model.TodayGroup;

public class TimerCheckService {
	
	public static void CheckNeedCancelOrder(){
		ArrayList<GoodsOrder> list = GoodsOrderDao.getGoodsOrderListByStateAndDueHours(1, 24);
		for(int i=0;i<list.size();i++){
			GoodsOrder order = list.get(i);
			GoodsOrderService.cancleOrder(order);
		}
		list = GoodsOrderDao.getGoodsOrderListByStateAndDueHours(11, 24);
		for(int i=0;i<list.size();i++){
			GoodsOrder order = list.get(i);
			GoodsOrderService.cancleOrder(order);
		}
		
//		ArrayList<Integer> groupList = TodayGroupDao.getGroupIdByStatusAndHour(0, 24);
//		for(int i=0;i<groupList.size();i++){
//			int groupId = groupList.get(i);
//			list = GoodsOrderDao.getGoodsOrderListByGroupIdAndState(groupId, 2);
//			for(int j=0;j<list.size();j++){
//				GoodsOrder order = list.get(i);
//				GoodsOrderService.cancleOrder(order);
//			}
//		}
	}
	
	public static void CheckNeedReceiveOrder(){
		ArrayList<GoodsOrder> list = GoodsOrderDao.getGoodsOrderListByStateAndDueDay(4, 7);
		for(int i=0;i<list.size();i++){
			GoodsOrder order = list.get(i);
			/*
			 * 在这里调用确认收货的方法
			 */
			GoodsOrderService.confirmReceive(order);
		}
		list = GoodsOrderDao.getGoodsOrderListByStateAndDueDay(13, 7);
		for(int i=0;i<list.size();i++){
			GoodsOrder order = list.get(i);
			/*
			 * 在这里调用确认收货的方法
			 */
			GoodsOrderService.confirmReceive(order);
		}
	}
	
	public static void CheckNeedDeleteGroup(){
		ArrayList<TodayGroup> list = TodayGroupDao.getOverdueOrderByHour(0, 24);
		for(int i=0;i<list.size();i++){
			TodayGroup group = list.get(i);
			group.setIsDelete(1);
			TodayGroupDao.updateTodayGroup(group);
			ArrayList<GoodsOrder> orderlist = GoodsOrderDao.getGoodsOrderListByGroupIdAndState(
					group.getGroupId(), 2);
			for(int j=0;j<orderlist.size();j++){
				GoodsOrder order = orderlist.get(j);
				GoodsOrderService.cancleOrder(order);
			}
		}
		list = TodayGroupDao.getOverdueOrderByHour(1, 24);
		for(int i=0;i<list.size();i++){
			TodayGroup group = list.get(i);
			group.setIsDelete(1);
			TodayGroupDao.updateTodayGroup(group);
		
		}
	}
	
	public static void CheckGoodsOverTime(){
		ArrayList<Integer> goodslist = GoodsInfoDao.getOverTimeGoodsIdList();
		for(int i=0;i<goodslist.size();i++){
			int goodsId = goodslist.get(i);
			ArrayList<GoodsOrder> orderlist = GoodsOrderDao.getGoodsOrderListByStateAndGoodsId(1, goodsId);
			for(int j=0;j<orderlist.size();j++){
				GoodsOrder order = orderlist.get(j);
				GoodsOrderService.cancleOrder(order);
			}
			orderlist = GoodsOrderDao.getGoodsOrderListByStateAndGoodsId(11, goodsId);
			for(int j=0;j<orderlist.size();j++){
				GoodsOrder order = orderlist.get(j);
				GoodsOrderService.cancleOrder(order);
			}
			ArrayList<TodayGroup> groupList = TodayGroupDao.getOverdueOrderByGoodsId(goodsId);
			for(int j=0;j<groupList.size();j++){
				TodayGroup group = groupList.get(j);
				group.setIsDelete(1);
				TodayGroupDao.updateTodayGroup(group);
			}
		}
	}
}
