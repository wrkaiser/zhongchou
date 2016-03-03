package com.sys.form;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

public class UploadForm extends ActionForm{
private FormFile imgfile;

public FormFile getImgfile() {
	return imgfile;
}

public void setImgfile(FormFile imgfile) {
	this.imgfile = imgfile;
}
	
	
}
