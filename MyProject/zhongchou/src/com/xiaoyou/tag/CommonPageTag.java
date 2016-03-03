package com.xiaoyou.tag;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.sun.jndi.url.ldaps.ldapsURLContextFactory;

public class CommonPageTag extends TagSupport {
	    private int currentPage=0;
	    private int totalPages=0;
	    private int totalRows=0;
	    private String url="";
	    private String css;
	    private int showpages=10;
	    private boolean kbdable;
	    private int pages=5;//每页显示十条
	    private String postlink = "";
	    private String nextlink = "";
	    private String curlink = "";
		@Override
		public int doEndTag() throws JspException {
			HttpServletRequest request=(HttpServletRequest)pageContext.getRequest();
			String L= (String) request.getSession().getAttribute("Language");
			String pre="前一页";
			String next="后一页";
			if ("eng".equals(L)) {
				pre="Previous";
				next="Next";
			}
			StringBuffer sb=new StringBuffer();
			System.out.println(url);
			if(url.indexOf("/plate")>=0){
				postlink = "-"+(currentPage-1)+".html";
				nextlink = "-"+(currentPage+1)+".html";
				
			}else{
				postlink = "&p="+(currentPage-1);
				nextlink = "&p="+(currentPage+1);
				
			}
			sb.append("<div class='"+css+"'><a href='"+url+postlink+"'>"+pre+"</a>");
			if(totalPages<=10){
				for(int page=1;page<=totalPages;page++){
					if(url.indexOf("/plate")>=0){
						curlink = "-"+(page)+".html";
					}else{
						curlink = "&p="+(page);
					}
						sb.append("<A ");
						if(page==currentPage){
							sb.append(" class='paginate_active' ");
						}
						sb.append("href=\""+url);
						sb.append(curlink);
						sb.append("\">");
						sb.append(page);
					sb.append("</A>");
				}
			}else{
				int startpage=0;
				sb.append("<A ");  
				if(1==currentPage){
					startpage=3;
					sb.append(" class='paginate_active' ");
				}
				sb.append("href=\""+url);
				if(url.indexOf("/plate")<0){
					sb.append("&p=1\">1</A>");
				}else{
					sb.append("-1.html\">1</A>");
				}
				
				sb.append("<A ");
				if(2==currentPage){
					startpage=3;
					sb.append(" class='paginate_active' ");
				}
				sb.append("href=\""+url);
				if(url.indexOf("/plate")<0){
					sb.append("&p=2\">2</A>");
				}else{
					sb.append("-2.html\">2</A>");
				}
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
						sb.append(" class='paginate_active' ");
					}
					sb.append("href=\""+url);
					if(url.indexOf("/cate")<0){
						sb.append("&p="+page+"\">"+page+"</A>");
					}else{
						sb.append("-"+page+".html\">"+page+"</A>");
					}
					sb.append("</A>");
			   }
				if(currentPage-6>2||currentPage<totalPages-8){
					sb.append("<a style='border:0'>...</a>");
				}
				sb.append("<A ");
				if(totalPages-1==currentPage){
					startpage=3;
					sb.append(" class='paginate_active' ");
				}
				sb.append("href=\""+url);
				
				if(url.indexOf("/cate")<0){
					sb.append("&p="+(totalPages-1)+"\">"+(totalPages-1)+"</A>");
				}else{
					sb.append("-"+(totalPages-1)+".html\">"+(totalPages-1)+"</A>");
				}
				sb.append("<A ");
				if(totalPages==currentPage){
					startpage=3;
					sb.append(" class='paginate_active' ");
				}
				sb.append("href=\""+url);
				
				
				if(url.indexOf("/plate")<0){
					sb.append("&p="+(totalPages)+"\">"+(totalPages)+"</A>");
				}else{
					sb.append("-"+(totalPages)+".html\">"+(totalPages)+"</A>");
				}
			}
			sb.append("<a href='"+url+nextlink+"'>"+next+"</a>");
			if(kbdable){
				sb.append("<div>跳到第</div><KBD><INPUT class='inputpage' onkeydown=\"if(event.keyCode==13) {window.location='");
				sb.append(url);
				sb.append("&p='+this.value; return false;}\" size=3 type=text name=custompage><span>页</span><input type='button' onclick='javascript:go()' class='pagebtn' value='GO'/> </KBD>");
				sb.append("<script>function go(){var inputpage=$('.inputpage').val();window.location='"+url+"&p='+inputpage;}</script>");
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
