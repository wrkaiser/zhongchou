package com.sys.form;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;

/**
 * 系统角色form
 */

public  class SysRoleForm extends ActionForm{

	// Fields

	private int sysRoleid;
	private int superroleid;
	private String rolename;
	private String describe;
	private String state;
	private String createtime;
	private int sysRightid;
	private int adminid;
	private int[] menuid;
	public int getSysRoleid() {
		return sysRoleid;
	}
	public void setSysRoleid(int sysRoleid) {
		this.sysRoleid = sysRoleid;
	}
	public int getSuperroleid() {
		return superroleid;
	}
	public void setSuperroleid(int superroleid) {
		this.superroleid = superroleid;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public int getSysRightid() {
		return sysRightid;
	}
	public void setSysRightid(int sysRightid) {
		this.sysRightid = sysRightid;
	}
	public int getAdminid() {
		return adminid;
	}
	public void setAdminid(int adminid) {
		this.adminid = adminid;
	}
	public int[] getMenuid() {
		return menuid;
	}
	public void setMenuid(int[] menuid) {
		this.menuid = menuid;
	}

	

}