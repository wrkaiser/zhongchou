package com.xiaoyou.data;

/**
 * @author jack hou
 * @date 2011-05-10
 * @version 1.0
 */
import java.util.List;


public class PageInfo {
    static final int PAGESTARTROW=0;//默认从第0记录开始
    static final int PAGESIZE=15;//默认的每页显示的记录数15
	int totalRows; //总行数
	int pageSize =PAGESIZE; 
	int currentPage = 1; //当前页数
	int totalPages = 0; //总页数
	int pageStartRow = PAGESTARTROW;//从第几条记录数
	String modelName;
	String queryFields;
	String orderFields;

	public PageInfo(int pageSize) {
		this.pageSize = pageSize;
	}

	public PageInfo() {
	}
	public boolean emptyQuery() {
		return queryStr == null || "".equals(queryStr);
	}
	private String queryStr;

	public void setCurrentPage(String strnum) {
		if (strnum != null && !strnum.equals(""))
			currentPage = Integer.parseInt(strnum);

	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setPageSize(int i) {
		pageSize = i;
	}

	public int getPageStartRow() {
		return pageStartRow;
	}

	public void setPageStartRow(int pageStartRow) {
		this.pageStartRow = pageStartRow;
	}

	/**
	 * Returns the queryStr.
	 * @return String
	 */
	public String getQueryStr() {
		return queryStr;
	}

	/**
	 * Sets the queryStr.
	 * @param queryStr The queryStr to set
	 */
	public void setQueryStr(String queryStr) {
		this.queryStr = queryStr;
	}

	/**
	 * Returns the totalRows.
	 * @return int
	 */
	public int getTotalRows() {
		return totalRows;
	}

	public boolean hasNextPage() {
		if (this.currentPage < this.totalPages)
			return true;
		else
			return false;
	}

	/**
	 * Sets the totalRows.
	 * @param totalRows The totalRows to set
	 */
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
		this.totalPages = (int) Math.ceil((double) totalRows / pageSize);
		reset();
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	private void reset() {
		if (currentPage > totalPages) {
			currentPage = totalPages;
		} else if(currentPage<1){
			currentPage=1;
		}
		setPageStartRow((getCurrentPage()-1)*getPageSize()+1);//设置开始的记录
	}

}