package com.xiaoyou.util;


import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;



public class IpUtil {
	private static Logger log = Logger.getLogger(IpUtil.class);
	
	public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");   
        ip=request.getHeader("x-forwarded-for");

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
            ip = request.getHeader("Proxy-Client-IP");   
        }   
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
            ip = request.getHeader("WL-Proxy-Client-IP");   
        }   
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
            ip = request.getHeader("HTTP_CLIENT_IP");   
        }   
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");   
        }   
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
            ip = request.getRemoteAddr();   
        }   
        
        if (ip != null && ip.length() > 15) { // "***.***.***.***".length()
			// =
					// 15
			if (ip.indexOf(",") > 0) {
				ip = ip.substring(0,ip.indexOf(","));
			}
        }
        return ip;   
    }   
	
	

	
	/**
	 * 用来获取手机拨号上网（包括CTWAP和CTNET）时由PDSN分配给手机终端的源IP地址。
	 * 
	 * @return
	 * @author SHANHY
	 */
	public static String getPhoneIp() {
		try {
			for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {
				NetworkInterface intf = en.nextElement();
				for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {
					InetAddress inetAddress = enumIpAddr.nextElement();
					if (!inetAddress.isLoopbackAddress()) {
						log.info("access-from-phone-ip:"+inetAddress.getHostAddress());
						return inetAddress.getHostAddress();
					}
				}
			}
		} catch (SocketException e) {
			log.error(e);
		}catch (Exception e) {
			log.error(e);
		}
		return null;
	}

 
}
