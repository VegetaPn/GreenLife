package com.greenlife.model;

public class GoodsPostage {
	private int goodsId;
	private String localCity;
	private double localPostage;
	private double alienPostage;
	
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getLocalCity() {
		return localCity;
	}
	public void setLocalCity(String localCity) {
		this.localCity = localCity;
	}
	public double getLocalPostage() {
		return localPostage;
	}
	public void setLocalPostage(double localPostage) {
		this.localPostage = localPostage;
	}
	public double getAlienPostage() {
		return alienPostage;
	}
	public void setAlienPostage(double alienPostage) {
		this.alienPostage = alienPostage;
	}
	
	
}
