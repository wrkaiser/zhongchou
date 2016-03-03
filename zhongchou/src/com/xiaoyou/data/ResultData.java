package com.xiaoyou.data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ResultData {

	private List trxList;
	private Map trxMap;
	private PageInfo pageinfo;
	private String returnCode = "0";
	private String message = "";
	private boolean result = true;

	public ResultData() {

	}
   
	public void setResult(boolean result) {
		this.result = result;
	}

	public ResultData(List datalist) {
		trxList = datalist;
	}

	public ResultData(Map dataMap) {
		trxMap = dataMap;
	}

	/**
	 * Returns the pageinfo.
	 * @return PageInfo
	 */
	public PageInfo getPageinfo() {
		return pageinfo;
	}

	/**
	 * Returns the trxInfo.
	 * @return Collection
	 */
	public List getTrxList() {
		return trxList;
	}

	/**
	 * Sets the pageinfo.
	 * @param pageinfo The pageinfo to set
	 */
	public void setPageinfo(PageInfo pageinfo) {
		this.pageinfo = pageinfo;
	}

	public void setTrxList(List trxList) {
		if (trxList == null)
			return;

		if (this.trxList == null)
			this.trxList = trxList;
		else
			this.trxList.addAll(trxList);
	}

	public Map getTrxInfo() {
		return trxMap;
	}

	public void setTrxInfo(Map trxmap) {
		if (trxmap == null)
			return;

		if (trxMap == null)
			trxMap = trxmap;
		else
			trxMap.putAll(trxmap);
	}

	/**
	 * Returns the returnCode.
	 * @return String
	 */
	public String getReturnCode() {
		return returnCode;
	}

	/**
	 * Sets the returnCode.
	 * @param returnCode The returnCode to set
	 */
	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public boolean isSuccess() {
		return result;
	}


	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		if (message == null || message.equals(""))
			return;

		this.message += message + "<br>";
	}
	public void setTrxInfo(String name,Object value){
		if(trxMap == null)
		   trxMap = new HashMap();
		   
		trxMap.put(name,value);
	}
}
