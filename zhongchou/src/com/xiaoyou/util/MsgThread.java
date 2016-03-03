package com.xiaoyou.util;

import org.apache.log4j.Logger;

public class MsgThread extends Thread {
	private Logger log = Logger.getLogger(MsgThread.class);
	private String telno;
	
	private String msg;
	
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public MsgThread(){}
	public MsgThread(String telno,String msg){
		this.telno = telno;
		this.msg = msg;
	}
    @Override
    public void run(){
    	try {
    		MsgUtil.postMsg(telno,msg);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
    }
    
    
}