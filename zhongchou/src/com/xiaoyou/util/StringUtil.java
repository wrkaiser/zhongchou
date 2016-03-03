package com.xiaoyou.util;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.regex.Pattern;

public class StringUtil {
	
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
	
	public static String msgfmt(Exception e) {
		StringBuffer sb = new StringBuffer();
		sb.append(e.getMessage());
		for (StackTraceElement el : e.getStackTrace()) {
			sb.append(el);
		}
		return sb.toString();
	}

	/**
	 * 样式过滤
	 * 
	 * @param inputString
	 * @return
	 */
	public static String Html2Text(String inputString) {
		String htmlStr = inputString; // 含html标签的字符串
		String textStr = "";
		java.util.regex.Pattern p_script;
		java.util.regex.Matcher m_script;
		java.util.regex.Pattern p_style;
		java.util.regex.Matcher m_style;
		java.util.regex.Pattern p_html;
		java.util.regex.Matcher m_html;
		try {
			String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script>
			String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style>
			String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
			p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
			m_script = p_script.matcher(htmlStr);
			htmlStr = m_script.replaceAll(""); // 过滤script标签
			p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
			m_style = p_style.matcher(htmlStr);
			htmlStr = m_style.replaceAll(""); // 过滤style标签
			p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
			m_html = p_html.matcher(htmlStr);
			htmlStr = m_html.replaceAll(""); // 过滤html标签
			textStr = htmlStr;
		} catch (Exception e) {
			System.err.println("Html2Text: " + e.getMessage());
		}
		return textStr;// 返回文本字符串
	}
	
	public static  String getPercent(int x1,int total){  
		NumberFormat formatter = new DecimalFormat("00.00");
		Float xx = Float.parseFloat(x1+".0");
		Float yy = Float.parseFloat(total+".0");
		Double x=new Double(xx/yy);
		x = x*100;
	    String xcxx = formatter.format(x);
		return xcxx;
	}  
	
	
	public static void main(String[] args){
		System.out.println(StringUtil.getPercent(5,97));
	}
}
