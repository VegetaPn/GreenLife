package com.greenlife.util;

import java.util.TimerTask;

import com.greenlife.services.TimerCheckService;

public class GroupCheckTask extends TimerTask {
    @Override
    public void run() {
           System.out.println("run task");
           TimerCheckService.CheckNeedReceiveOrder();
           TimerCheckService.CheckNeedDeleteGroup();
           TimerCheckService.CheckNeedCancelOrder();
           TimerCheckService.CheckGoodsOverTime();
     }
}
