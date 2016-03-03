package com.sys.form;

import org.apache.struts.action.ActionForm;

import com.xiaoyou.util.StringUtil;


public class MUserForm extends ActionForm {
    private String password;//密码
    private String chkpassword;//确认密码
    private String username;//昵称
    private String chkcode;//验证码
    private String telno;//电话
    private String email;//邮箱
    private String lastIp;
    private String userid;
    private String qq;//
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getChkpassword() {
		return chkpassword;
	}
	public void setChkpassword(String chkpassword) {
		this.chkpassword = chkpassword;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = StringUtil.Html2Text(username);
	}
	public String getChkcode() {
		return chkcode;
	}
	public void setChkcode(String chkcode) {
		this.chkcode = chkcode;
	}
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getLastIp() {
		return lastIp;
	}
	public void setLastIp(String lastIp) {
		this.lastIp = lastIp;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
    
}
