package com.xiaoyou.util;

import org.tempuri.LinkWS;
import org.tempuri.LinkWSSoap;


public class MsgUtil {
	static String CorpID = "BJZX01874";
	static String Pwd = "huixuer2013";
	/**
	 * @param telno
	 * @param msgcontent
	 * @return
	 */
    public static int postMsg(String telno,String msgcontent){
    	LinkWS linkWS = new LinkWS();
		LinkWSSoap soap;
		soap = (LinkWSSoap)linkWS.getLinkWSSoap();
		int remsg=soap.send(CorpID,Pwd,telno,msgcontent+"", "","");
        return remsg;
    }
    public static void main(String[] args){
    	postMsg("15966830169", "你好测试");
    }
   
}
