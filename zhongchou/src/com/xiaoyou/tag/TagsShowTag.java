package com.xiaoyou.tag;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class TagsShowTag extends TagSupport {
	    private String path;//配置路径
	    private String tagstring;//开始位置
		@Override
		public int doEndTag() throws JspException {
			HttpServletRequest request=(HttpServletRequest)pageContext.getRequest();
			StringBuffer sb=new StringBuffer();
			if(tagstring!=null&&!"".equals(tagstring)){
				for(String tag:tagstring.split(" ")){
					sb.append("<a href=\"");
					sb.append(path);
					sb.append("tag/");
					sb.append(tag);
					sb.append("\">#");
					sb.append(tag);
					sb.append("</a>");
				}
			}
			try {
				pageContext.getOut().print(sb.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return EVAL_PAGE;
		}
		public String getPath() {
			return path;
		}
		public void setPath(String path) {
			this.path = path;
		}
		public String getTagstring() {
			return tagstring;
		}
		public void setTagstring(String tagstring) {
			this.tagstring = tagstring;
		}
		
		
	      
      
}
