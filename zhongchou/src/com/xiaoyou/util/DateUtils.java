package com.xiaoyou.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


public class DateUtils {
	private static final String FORMAT = "yyyy-MM-dd HH:mm:ss";
	private static SimpleDateFormat sdf=new SimpleDateFormat(FORMAT);
	
	public static String now(){
		return sdf.format(new Date());
		
	}
	
	public static String changeTime(String date,String type,int cnt){
		Date dt;
		try {
			dt = sdf.parse(date);
		} catch (ParseException e) {
			return null;
		}
		Calendar rightNow = Calendar.getInstance();
		rightNow.setTime(dt);
		if("year".equals(type)){
			rightNow.add(Calendar.YEAR,cnt);//加+，减-
		}else if("month".equals(type)){
			rightNow.add(Calendar.MONTH,cnt);//加+，减-
		}else if("minus".equals(type)){
			rightNow.add(Calendar.MINUTE,cnt);//加+，减-
		}
		
		Date dt1=rightNow.getTime();
		return sdf.format(dt1);
	}
	
	public static String changeTime(Date date,String type,int cnt){
		Calendar rightNow = Calendar.getInstance();
		rightNow.setTime(date);
		if("year".equals(type)){
			rightNow.add(Calendar.YEAR,cnt);//加+，减-  年份
		}else if("month".equals(type)){
			rightNow.add(Calendar.MONTH,cnt);//加+，减- 月份
		}else if("minus".equals(type)){
			rightNow.add(Calendar.MINUTE,cnt);//加+，减- 分钟
		}else if("day".equals(type)){
			rightNow.add(Calendar.DAY_OF_MONTH, cnt);  //天数相加减
		}
		Date dt1=rightNow.getTime();
		return sdf.format(dt1);
	}
}
