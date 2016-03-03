package com.xiaoyou.util;
import java.util.EventListener;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface TransforEventListener extends EventListener{
	void update(HttpServletRequest request,HttpServletResponse response,String to,long send,long size ) ;  
}