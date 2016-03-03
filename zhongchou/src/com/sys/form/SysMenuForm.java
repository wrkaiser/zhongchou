package com.sys.form;

import org.apache.struts.action.ActionForm;

public class SysMenuForm extends ActionForm {
	private String[] names;
	private String[] keys;
	private int[] sorts;
	private int[] menuids;
    private String sysroleid;
    private String userid;
    private String appid;
    private int[] fids;
    private int[] is_shows;
    private String appsecret;
    
	public String[] getNames() {
		return names;
	}
	public void setNames(String[] names) {
		this.names = names;
	}
	public String[] getKeys() {
		return keys;
	}
	public void setKeys(String[] keys) {
		this.keys = keys;
	}
	public int[] getSorts() {
		return sorts;
	}
	public void setSorts(int[] sorts) {
		this.sorts = sorts;
	}
	public int[] getMenuids() {
		return menuids;
	}
	public void setMenuids(int[] menuids) {
		this.menuids = menuids;
	}
	
	public String getSysroleid() {
		return sysroleid;
	}
	public void setSysroleid(String sysroleid) {
		this.sysroleid = sysroleid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public int[] getFids() {
		return fids;
	}
	public void setFids(int[] fids) {
		this.fids = fids;
	}
	public int[] getIs_shows() {
		return is_shows;
	}
	public void setIs_shows(int[] isShows) {
		is_shows = isShows;
	}
	public String getAppsecret() {
		return appsecret;
	}
	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}


}
