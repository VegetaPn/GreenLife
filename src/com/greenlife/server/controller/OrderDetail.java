package com.greenlife.server.controller;
/**
 * by hellomie
 * 
 * Ϊ���ܹ�����Ϣ���䵽��������ش�
 * ������ѯ������������
 */
import com.greenlife.model.GoodsOrder;

public class OrderDetail {

	private GoodsOrder goodsOrder;
	
	private String weichatName;  //΢����
	private String goodsName;    //��Ʒ��
	private String buytype;
	
	
	public String getBuytype() {
		return buytype;
	}

	public void setBuytype(int statenum) {
		if (statenum <10) {
			buytype = "团购("+goodsOrder.getOrderId()+")";
		} else{
			buytype = "个人";
		}
	}

	public OrderDetail(GoodsOrder goodsOrder) {
		super();
		this.goodsOrder = goodsOrder;
	}
	
	public GoodsOrder getGoodsOrder() {
		return goodsOrder;
	}
	public void setGoodsOrder(GoodsOrder goodsOrder) {
		this.goodsOrder = goodsOrder;
	}
	
	
	public String getWeichatName() {
		return weichatName;
	}
	public void setWeichatName(String weichatName) {
		this.weichatName = weichatName;
	}
	
	
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
}
