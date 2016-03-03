package com.xiaoyou.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtils {
	public static String filterField(String f){
		if(f!=null && !f.isEmpty()){
			return f.replace("'", "\\'");
		}
		return "";
	}
	
	public static String replaceBr(String f){
		if(f!=null && !f.isEmpty()){
			return f.replace("'", "\\'").replaceAll("<br />", "").replaceAll("\r", "<br />").trim();
		}
		return "";
	}
	/**
	 * 判断是否是邮箱
	 * @param email
	 * @return
	 */
	public static boolean checkEmail(String email) { 
		if (!email.matches("[\\w\\.\\-]+@([\\w\\-]+\\.)+[\\w\\-]+")) { 
		return false; 
		} 
		return true;
     }
	
	/**
	 * 判断是否是邮箱
	 * @param email
	 * @return
	 */
	public static boolean checkTelno(String email) { 
		if (!email.matches("^((13[0-9])|(15[0-9])|(18[0-9]))\\d{8}$")) { 
		return false; 
		} 
		return true;
     }
	public static void main(String[] agrs){
		SimpleDateFormat df3 = new SimpleDateFormat("MM/dd");
		String overtime= df3.format(new Date("1381567471"));
		System.out.println("StringUtils.main()"+overtime);
	}
	
}
