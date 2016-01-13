package com.greenlife.services;

import java.util.ArrayList;
import java.util.HashMap;

import com.greenlife.dao.FriendsListDao;
import com.greenlife.dao.GoodsOrderDao;
import com.greenlife.model.FriendsList;

public class FriendsListService {
	
	/**
	 * hashmap:key: wechatid,number
	 * @return
	 */
	public static ArrayList<HashMap<String, String>> getBuyList(int goods_id, String wechat_id){
		ArrayList<Integer> label = new ArrayList<Integer>();
		ArrayList<HashMap<String, String>> ret = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> bylist = GoodsOrderDao.getGoodsBuyInfo(goods_id);
		ArrayList<String> friends = FriendsListDao.getFriendWechatIdList(wechat_id);
		
		for(int i=0;i<bylist.size();i++){
			//System.out.println("bylist:"+bylist.get(i).get("wechat_id"));
			boolean flag = false;
			String friendId = bylist.get(i).get("wechat_id");
			for(int j=0;j<friends.size();j++){
				if(friends.get(j).equals(friendId)){
					flag = true;
					break;
				}
			}
			if(flag){
				label.add(0);
			}else{
				label.add(1);
			}
		}
		for(int i=0;i<bylist.size();i++){
			if(label.get(i)==0){
				ret.add(bylist.get(i));
			}
		}
		for(int i=0;i<bylist.size();i++){
			if(label.get(i)==1){
				ret.add(bylist.get(i));
			}
		}
//		for(int i=0;i<ret.size();i++)
//			System.out.println(ret.get(i).get("wechat_id"));
		return ret;
	}
	
	public static boolean updateFriendsList(FriendsList friendsList){
		
		int level = FriendsListDao.getFriendsList(friendsList.getWechatId(), friendsList.getFriendsWechatId());
		if(level == -1){
			FriendsListDao.addFriendList(friendsList);
		} else {
			FriendsListDao.increaseLevel(friendsList, friendsList.getFriendslevel());
		}
		return true;
	}
}
