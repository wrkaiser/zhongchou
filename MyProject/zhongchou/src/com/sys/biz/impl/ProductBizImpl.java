package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.form.ProductForm;
import com.sys.form.QuestionForm;

public class ProductBizImpl extends BaseBizImpl{
	//FROM_UNIXTIME(overtime, '%Y-%m-%d')overtime
	public List getList(PageInfo pageinfo,String cid)throws Exception{
		if(cid!=null&&!"".equals(cid))
			pageinfo.setQueryStr(" cid="+cid+" order by ctime desc");
		else
			pageinfo.setQueryStr(" order by ctime desc");
		BaseDao basedao = new BaseDao();
		return basedao.getListByPage("t_product", "*,FROM_UNIXTIME(ctime, '%Y-%m-%d') ctime", pageinfo);
	}
    public void saveorupdate(ProductForm qform)throws Exception{
    	BaseDao basedao = new BaseDao();
    	if(qform.getId()==0){
    		sql="insert into t_product(cid,pname,tname,pcontent,pdesc,ctime) values(?,?,?,?,?,unix_timestamp())";
    		Object[] params={qform.getCid(),qform.getPname(),qform.getTname(),qform.getPcontent(),qform.getPdesc()};
    		basedao.update(sql, params);
    	}else{
    		sql="update t_product set cid=?,pname=?,tname=?,pcontent=?,pdesc=?,ctime=unix_timestamp() where id=?";
    		Object[] params={qform.getCid(),qform.getPname(),qform.getTname(),qform.getPcontent(),qform.getPdesc(),qform.getId()};
    		basedao.update(sql, params);
    	}
    }
    public void delete(String id)throws Exception{
		delete("t_product",id);
	}
    public Map detail(String id)throws Exception{
		return detail("t_product",id);
	}
}
