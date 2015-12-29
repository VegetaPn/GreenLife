package com.greenlife.services;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.greenlife.model.GoodsInfo;

public class GoodsInfoService {
	//2015/12/22/00:00
	public static int getGoodsStatus(GoodsInfo info){
		try {
			String start_time = info.getStartTime();
			String end_time = info.getEndTime();
			int totalNum = info.getGoodsTotalnum();
			int soldNum = info.getGoodsSoldnum();
			SimpleDateFormat sdf = new SimpleDateFormat("YY/MM/dd/hh:mm");
			Date start = sdf.parse(start_time);
			Date end = sdf.parse(end_time);
			Date now = new Date();
			if(start.before(now)){
				return 0;
			} else if(now.after(start) && now.before(end)){
				if(soldNum < totalNum){
					return 1;
				} else {
					return 2;
				}
			} else {
				return 3;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
}
