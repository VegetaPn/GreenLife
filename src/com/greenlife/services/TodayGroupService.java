package com.greenlife.services;

import java.util.ArrayList;
import java.util.List;

import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.dao.TodayGroupDao;
import com.greenlife.model.GoodsOrder;
import com.greenlife.model.TodayGroup;

public class TodayGroupService {
	public static boolean isInGroup(int groupId,String wechatId){
		List<GoodsOrder> orderList = GoodsOrderDao.getGoodsOrderListByGroupId(groupId);
		for(GoodsOrder oGoodsOrder : orderList){
			if(oGoodsOrder.getWechatId().equals(wechatId)){
				return true;
			}
		}
		return false;
	}
	
	
//	public ArrayList<TodayGroup> getOverDueGroup(){
//		ArrayList<TodayGroup> ret = new ArrayList<TodayGroup>();
//		ArrayList<TodayGroup> list = TodayGroupDao.getOverdueOrder(groupState, day)
//		return null;
//	}
}
