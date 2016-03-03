package com.sys.form;

import org.apache.struts.action.ActionForm;

public class LuYanForm extends ActionForm {
	private String content; //路演内容
    private String proid;
	public String getProid() {
		return proid;
	}

	public void setProid(String proid) {
		this.proid = proid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	
}
