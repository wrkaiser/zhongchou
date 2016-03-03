package com.sys.form;


import org.apache.struts.action.ActionForm;

public class SysUserForm extends ActionForm
{
  private int userid;
  private String username;
  private String realname;
  private String password;
  private String email;
  private String qq;
  private String telno;
  private String logip;
  private String headimg;
  private int role;

  public String getRealname()
  {
    return this.realname;
  }

  public void setRealname(String realname) {
    this.realname = realname;
  }

  public int getUserid() {
    return this.userid;
  }

  public void setUserid(int userid) {
    this.userid = userid;
  }

  public String getUsername() {
    return this.username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return this.password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getEmail() {
    return this.email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getQq() {
    return this.qq;
  }

  public void setQq(String qq) {
    this.qq = qq;
  }

  public String getTelno() {
    return this.telno;
  }

  public void setTelno(String telno) {
    this.telno = telno;
  }

  public String getLogip() {
    return this.logip;
  }

  public void setLogip(String logip) {
    this.logip = logip;
  }

  public String getHeadimg() {
    return this.headimg;
  }

  public void setHeadimg(String headimg) {
    this.headimg = headimg;
  }

  public int getRole() {
    return this.role;
  }

  public void setRole(int role) {
    this.role = role;
  }
}
