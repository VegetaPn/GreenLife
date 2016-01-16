package com.greenlife.services;

import java.util.ArrayList;
import java.util.HashMap;

import org.junit.Test;

public class FriendsListServiceTest {

	@Test
	public void test() {
		ArrayList<HashMap<String, String>> ret = FriendsListService.getBuyList(1,"ofK5Fw6xtWJlI53RDFP_37szP7WA");
		for(int i=0;i<ret.size();i++)
			System.out.println(ret.get(i).get("wechat_id"));
	}

}
