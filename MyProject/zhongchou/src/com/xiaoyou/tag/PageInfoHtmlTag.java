package com.xiaoyou.tag;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class PageInfoHtmlTag extends TagSupport {
	 private int currentPage=0;
	    private int totalPages=0;
	    private int totalRows=0;
	    private String url="";
	    private String css;
	    private int showpages=10;
	    private boolean kbdable;
	    private int pages=15;//每页显示十条
		@Override
		public int doEndTag() throws JspException {
			HttpServletRequest request=(HttpServletRequest)pageContext.getRequest();
			StringBuffer sb=new StringBuffer();
			sb.append("<div class="+css+"><a href='"+url+(currentPage-1)+"'>前一页</a>");
			if(totalPages<=10){
				for(int page=1;page<=totalPages;page++){
						sb.append("<A ");
						if(page==currentPage){
							sb.append(" class='on' ");
						}
						sb.append("href=\""+url);
						sb.append(page);
						sb.append("\">");
						sb.append(page);
					sb.append("</A>");
				}
			}else{
				int startpage=0;
				sb.append("<A ");
				if(1==currentPage){
					startpage=3;
					sb.append(" class='on' ");
				}
				sb.append("href=\""+url);
				sb.append("1\">1</A>");
				sb.append("<A ");
				if(2==currentPage){
					startpage=3;
					sb.append(" class='on' ");
				}
				sb.append("href=\""+url);
				sb.append("2\">2</A>");
				if(currentPage>=totalPages-8){
					startpage=totalPages-8;
				}else if(currentPage>2){
					startpage=currentPage;
				}
				if(currentPage>=totalPages-8||currentPage-6>2){
					sb.append("<a style='border:0'>...</a>");
				}
				for(int page=startpage;page<=totalPages&&page<(startpage+6);page++){
					sb.append("<A ");
					if(page==currentPage){
						sb.append(" class='on' ");
					}
					sb.append("href=\""+url);
					sb.append(page);
					sb.append("\">");
					sb.append(page);
				sb.append("</A>");
			   }
				if(currentPage-6>2||currentPage<totalPages-8){
					sb.append("<a style='border:0'>...</a>");
				}
				sb.append("<A ");
				if(totalPages-1==currentPage){
					startpage=3;
					sb.append(" class='on' ");
				}
				sb.append("href=\""+url);
				sb.append("_"+(totalPages-1)+"\">"+(totalPages-1)+"</A>");
				sb.append("<A ");
				if(totalPages==currentPage){
					startpage=3;
					sb.append(" class='on' ");
				}
				sb.append("href=\""+url);
				sb.append(totalPages+"\">"+totalPages+"</A>");
			}
			sb.append("<a href='"+url+(currentPage+1)+"'>后一页</a>");
			if(kbdable){
				sb.append("<div>跳到第</div><KBD><INPUT class='inputpage' onkeydown=\"if(event.keyCode==13) {window.location='");
				sb.append(url);
				sb.append("'+this.value; return false;}\" size=3 type=text name=custompage><span>页</span><input type='button' onclick='javascript:go()' class='pagebtn' value='GO'/> </KBD>");
				sb.append("<script>function go(){var inputpage=$('.inputpage').val();window.location='"+url+"'+inputpage;}</script>");
			}
			sb.append("</div>");
			try {
				pageContext.getOut().print(sb.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return EVAL_PAGE;
		}
		public int getCurrentPage() {
			return currentPage;
		}
		public void setCurrentPage(int currentPage) {
			this.currentPage = currentPage;
		}
		public int getTotalPages() {
			return totalPages;
		}
		public void setTotalPages(int totalPages) {
			this.totalPages = totalPages;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
		public int getTotalRows() {
			return totalRows;
		}
		public void setTotalRows(int totalRows) {
			this.totalRows = totalRows;
		}
		public int getPages() {
			return pages;
		}
		public void setPages(int pages) {
			this.pages = pages;
		}
		public String getCss() {
			return css;
		}
		public void setCss(String css) {
			this.css = css;
		}
		public boolean isKbdable() {
			return kbdable;
		}
		public void setKbdable(boolean kbdable) {
			this.kbdable = kbdable;
		}
		
	      
      
}
