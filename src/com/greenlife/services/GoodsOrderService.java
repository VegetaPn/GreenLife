package com.greenlife.services;

import com.greenlife.dao.GoodsInfoDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.GoodsInfo;
import com.greenlife.model.GoodsOrder;
import com.greenlife.wechatservice.WechatService;

public class GoodsOrderService {
	public static boolean cancleOrder(GoodsOrder order){
		
		int state = order.getOrderState();
		
		if(state < 10){
			if(state == 1){
				
				order.setOrderState(9);
			}
			else if(state == 2){
				
				if(WechatService.refund(order)){
					GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(order.getGoodsId());
					goodsInfo.setGoodsSoldnum(goodsInfo.getGoodsSoldnum()-order.getGoodsNum());
					GoodsInfoDao.updateGoodsInfo(goodsInfo);
					order.setOrderState(8);
				}else{
					return false;
				}
			}
			else if(state == 3){
				
				if(WechatService.refund(order)){
					GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(order.getGoodsId());
					goodsInfo.setGoodsSoldnum(goodsInfo.getGoodsSoldnum()-order.getGoodsNum());
					GoodsInfoDao.updateGoodsInfo(goodsInfo);
					order.setOrderState(8);
				}else{
					return false;
				}
			}
			else if(state == 5){
				
				if(WechatService.refund(order)){
					GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(order.getGoodsId());
					goodsInfo.setGoodsSoldnum(goodsInfo.getGoodsSoldnum()-order.getGoodsNum());
					GoodsInfoDao.updateGoodsInfo(goodsInfo);
					order.setOrderState(8);
					
				}else{
					return false;
				}
			}else{
				return false;
			}
			
		}else{
			if(state == 11){
				
				order.setOrderState(19);
			}
			else if(state == 12){
				if(WechatService.refund(order)){
					GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(order.getGoodsId());
					goodsInfo.setGoodsSoldnum(goodsInfo.getGoodsSoldnum()-order.getGoodsNum());
					GoodsInfoDao.updateGoodsInfo(goodsInfo);
					order.setOrderState(18);
					
				}else{
					return false;
				}
			}
			else if(state == 14){
				if(WechatService.refund(order)){
					GoodsInfo goodsInfo = GoodsInfoDao.getGoodsInfo(order.getGoodsId());
					goodsInfo.setGoodsSoldnum(goodsInfo.getGoodsSoldnum()-order.getGoodsNum());
					GoodsInfoDao.updateGoodsInfo(goodsInfo);
					order.setOrderState(18);
				}else{
					return false;
				}
			}else{
				return false;
			}
			
		}
		
		if(!GoodsOrderDao.updateGoodsOrder(order)){
			return false;
		}
		return true;
	}
	
	
	public static boolean sendGoods(GoodsOrder order){
		int state = order.getOrderState();
		if(state != 3 && state != 12){
			return false;
		}
		
		if(state == 3){
			order.setOrderState(4);
		}
		
		if(state == 12){
			order.setOrderState(13);
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