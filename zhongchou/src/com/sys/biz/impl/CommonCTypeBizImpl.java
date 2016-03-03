package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.DateUtils;
import com.sys.biz.CommonCTypeBiz;
import com.sys.form.CommonTypeForm;

public class CommonCTypeBizImpl implements CommonCTypeBiz {
	
	private static final String TABLE_NAME = "wei_common_ctype ";

	public List list(PageInfo pageinfo) throws Exception {
		BaseDao BaseDao = new BaseDao();
	    List list = BaseDao.getListByPage(TABLE_NAME+" t", "t.*", pageinfo);
	    return list;
	}
	
	
	
	public List list(String wherestr) throws Exception {
		BaseDao BaseDao = new BaseDao();
	    List list = BaseDao.getList("select * from "+TABLE_NAME+ wherestr+" order by ctype desc,pos,credate desc");
	    return list;
	}
	

	public Map detail(String  tagid) throws Exception {
		BaseDao BaseDao = new BaseDao();
		return BaseDao.queryone("select * from "+this.TABLE_NAME+" where cid="+tagid);
	}

	public void update(CommonTypeForm a) throws Exception {
		BaseDao BaseDao = new BaseDao();
		
        String sql = "";
        if(a.getId()>=0){
        	sql = "update "+this.TABLE_NAME+" set cname=?,ctype=?,pos=?,showlink=? where cid=?";
        	BaseDao.update(sql,new Object[]{a.getName(),a.getType(),a.getPos(),a.getShowlink(),a.getId()});
        }else{
        	BaseDao.update("insert into "+this.TABLE_NAME+"(cname,ctype,pos,credate,showlink)values(?,?,?,?,?)",new Object[]{a.getName(),a.getType(),a.getPos(),DateUtils.now(),a.getShowlink()});
        }
	}

	public void del(String tagid) throws Exception {
		BaseDao BaseDao = new BaseDao();
		BaseDao.update("delete from "+this.TABLE_NAME+" where cid=?",new Object[]{tagid});
	}



}
