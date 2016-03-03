package com.sys.form;
import org.apache.struts.action.ActionForm;

public class VCourseForm extends ActionForm{
	private int id;
	private String cid;//` int(11) default NULL COMMENT '所属分类',
	private String pname;//` varchar(200) default NULL COMMENT '课程名称',
	private String tname;//` varchar(20) default NULL COMMENT '授课教师',
	private String img;//` text COMMENT '授课内容',
	private String pdesc;//` varchar(2000) default NULL COMMENT '授课简介',
	private String url;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPdesc() {
		return pdesc;
	}
	public void setPdesc(String pdesc) {
		this.pdesc = pdesc;
	}
	
	
}
