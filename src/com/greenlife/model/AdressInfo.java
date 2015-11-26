package com.greenlife.model;

public class AdressInfo {
	private int addrId;
	private String addrDetail;
	private String addrZipcode;
	private String receiverPhone;
	private String receiverName;
	private String wechatId;
	
	public int getAddrId() {
		return addrId;
	}
	public void setAddrId(int addrId) {
		this.addrId = addrId;
	}
	public String getAddrDetail() {
		return addrDetail;
	}
	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}
	public String getAddrZipcode() {
		return addrZipcode;
	}
	public void setAddrZipcode(String addrZipcode) {
		this.addrZipcode = addrZipcode;
	}
	public String getReceiverPhone() {
		return receiverPhone;
	}
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getWechatId() {
		return wechatId;
	}
	public void setWechatId(String wechatId) {
		this.wechatId = wechatId;
	}
}
