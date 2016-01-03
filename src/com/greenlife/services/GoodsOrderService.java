package com.greenlife.services;

import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.GoodsOrder;
import com.greenlife.wechatservice.WechatService;

public class GoodsOrderService {
	public static boolean cancleOrder(GoodsOrder order){
		
		int state = order.getOrderState();
		
		if(state < 10){
			if(state == 1){
				WechatService.closeOrder(order);
			}else if(state == 2){
				if(!WechatService.refund(order)){
					return false;
				}
			}
			if(state >= 3){
				return false;
			}
			order.setOrderState(9);
		}else{
			if(state == 11){
				WechatService.closeOrder(order);
			}
			if(state >= 12){
				return false;
			}
			order.setOrderState(19);
		}
		
		if(!GoodsOrderDao.updateGoodsOrder(order)){
			return false;
		}
		return true;
	}
	
	public static boolean confirmReceive(GoodsOrder order){
		
		int state = order.getOrderState();
		
		if(state != 4 && state != 13){
			return false;
		}
		
		if(state == 4){
			order.setOrderState(5);
		}
		
		if(state == 13){
			order.setOrderState(14);
		}
		
		
		if(!GoodsOrderDao.updateGoodsOrder(order)){
			return false;
		}
		return true;
	}
}
