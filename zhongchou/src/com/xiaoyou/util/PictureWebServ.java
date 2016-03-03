package com.xiaoyou.util;

import java.util.ResourceBundle;

import javax.sql.DataSource;

import com.alsaw.exception.JdbcException;

public class PictureWebServ {
	private static final ResourceBundle resource;
	static {
		try {
			 resource = ResourceBundle
					.getBundle("META-INF/front-pictureweb");
		} catch (Exception e) {
			e.printStackTrace();
			throw new JdbcException(e);
		}
	}
	public static String getPicturePath(String key){
		String path="";
		if(key!=null&&!"".equals(key)){
			path = resource.getString(key);
		}else{
			path = resource.getString("image1.alumninet.net");
		}
		return path;
	}
}
