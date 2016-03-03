package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.form.ProductForm;
import com.sys.form.QuestionForm;
import com.sys.form.VCourseForm;

public class VCourseBizImpl extends BaseBizImpl{
	//FROM_UNIXTIME(overtime, '%Y-%m-%d')overtime
	public List getList(PageInfo pageinfo,String cid)throws Exception{
		if(cid!=null&&!"".equals(cid))
			pageinfo.setQueryStr(" cid="+cid+" order by ctime desc");
		else
			pageinfo.setQueryStr(" order by ctime desc");
		BaseDao basedao = new BaseDao();
		return basedao.getListByPage("t_vcourses", "*,FROM_UNIXTIME(ctime, '%Y-%m-%d') ctime", pageinfo);
	}
    public void saveorupdate(VCourseForm qform)throws Exception{
    	BaseDao basedao = new BaseDao();
    	if(qform.getId()==0){
    		sql="insert into t_vcourses(cid,pname,tname,img,url,pdesc,ctime) values(?,?,?,?,?,?,unix_timestamp())";
    		Object[] params={qform.getCid(),qform.getPname(),qform.getTname(),qform.getImg(),qform.getUrl(),qform.getPdesc()};
    		basedao.update(sql, params);
    	}else{
    		sql="update t_vcourses set cid=?,pname=?,tname=?,img=?,pdesc=?,url=?,ctime=unix_timestamp() where id=?";
    		Object[] params={qform.getCid(),qform.getPname(),qform.getTname(),qform.getImg(),qform.getPdesc(),qform.getUrl(),qform.getId()};
    		basedao.update(sql, params);
    	}
    }
    public void delete(String id)throws Exception{
		delete("t_vcourses",id);
	}
    public Map detail(String id)throws Exception{
		return detail("t_vcourses",id);
	}
}
