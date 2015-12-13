package com.greenlife.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class MyTimerListener implements ServletContextListener {
	
    private GroupCheckTimer  mytimer = new GroupCheckTimer();
    
    public void contextInitialized(ServletContextEvent event) {
        mytimer.timerStart();
    }
    
    public void contextDestroyed(ServletContextEvent event) {
        mytimer.timerStop();
    }
    
}