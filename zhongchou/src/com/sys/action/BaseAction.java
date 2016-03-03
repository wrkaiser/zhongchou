package com.sys.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.actions.DispatchAction;

public class BaseAction extends DispatchAction {
    
    /**
     * 是否登录
     * @param user
     * @param id
     * @return
     */
    public Map getSessionUser(HttpServletRequest request){
    	 Map user = (Map)request.getSession().getAttribute("User");
		 if(user==null){
			 return null;
		 }
		 return user;
    }
    
    
    public String getBLanguage(HttpServletRequest request) {
		String type=(String)request.getSession().getAttribute("BLanguage");
//		System.out.println("语言类型："+type);
		if (type==null||"".equals(type)) {
			return "";
		}else if (type.equals("eng")) {
			return "_eng";
		}else{
			return "";
		}
	}
}
