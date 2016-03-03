package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.form.DocumentForm;

public class BaseBizImpl {
	public String sql="";
	public void delete(String table,String id)throws Exception{
		sql="delete from "+table+" where id="+id;
		BaseDao basedao = new BaseDao();
		basedao.delete(sql);
	}
	public Map detail(String table,String id)throws Exception{
		sql="select *  from "+table+" where id="+id;
		BaseDao basedao = new BaseDao();
	    return basedao.queryone(sql);
    }
}
