package com.sys.form;
import org.apache.struts.action.ActionForm;

public class MessageForm extends ActionForm{
	private int id;
	private String  content;//留言内容',//
	private String  type;//'留言类型',
	private String  telno;//'电话',
	private String  email;
	private String  name;
	private String rescontent;
	
	public String getRescontent() {
		return rescontent;
	}
	public void setRescontent(String rescontent) {
		this.rescontent = rescontent;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
