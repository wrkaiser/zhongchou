package com.sys.biz;

import java.util.List;
import java.util.Map;

import com.xiaoyou.data.PageInfo;
import com.sys.form.CommonTypeForm;

public interface CommonCTypeBiz {
	
	/**
	 * 查询
	 * @return
	 * @throws Exception
	 */
	public List list(PageInfo info) throws Exception;
	
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List list(String wherestr) throws Exception;
	
	
	
	/**
	 * 获取
	 * @param tagid
	 * @return
	 * @throws Exception
	 */
	public Map detail(String tagid) throws Exception;
	
	/** 
	 * 更新或添加标签
	 * @param tem
	 * @throws Exception
	 */
	public void update(CommonTypeForm active) throws Exception;
	
	/**
	 * 
	 * @param tagid
	 * @throws Exception
	 */
	public void del(String tagid) throws Exception;
	
}
