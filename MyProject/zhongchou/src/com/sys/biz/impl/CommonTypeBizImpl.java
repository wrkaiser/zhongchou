package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.biz.CommonTypeBiz;
import com.sys.form.CommonTypeForm;

public class CommonTypeBizImpl implements CommonTypeBiz {
	
	private static final String TABLE_NAME = "wei_common_type ";

	public List list(PageInfo pageinfo) throws Exception {
		BaseDao BaseDao = new BaseDao();
	    List list = BaseDao.getListByPage(TABLE_NAME+" t", "t.*", pageinfo);
	    return list;
	}
	
	
	
	public List list(String wherestr) throws Exception {
		BaseDao BaseDao = new BaseDao();
	    List list = BaseDao.getList("select t.*,c.cname from "+TABLE_NAME+" t left join wei_common_ctype c on c.cid=t.type "+ wherestr+" order by t.type desc,t.sort desc,t.id desc");
	    return list;
	}
	

	public Map detail(String  tagid) throws Exception {
		BaseDao BaseDao = new BaseDao();
		return BaseDao.queryone("select * from "+this.TABLE_NAME+" where id="+tagid);
	}

	public void update(CommonTypeForm a) throws Exception {
		BaseDao BaseDao = new BaseDao();
		
        String sql = "";
        if(a.getId()>0){
        	sql = "update "+this.TABLE_NAME+" set name=?,type=?,sort=?,label=?,showlink=?,showdel=?,changecid=?,showcont=?,showdoc=?,showpic=?,otherlink=?,showvideo=?,showfile=?,showisrec=?,ctype=?,showabst=?,modifytime=? where id=?";
        	BaseDao.update(sql,new Object[]{a.getName(),a.getType(),a.getSort(),a.getLabel(),a.getShowlink(),a.getShowdel(),a.getChangecid(),a.getShowcont(),a.getShowdoc(),a.getShowpic(),a.getOtherlink(),a.getShowvideo(),a.getShowfile(),a.getShowisrec(),a.getCtype(),a.getShowabst(),a.getModifytime(),a.getId()});
        }else{
        	BaseDao.update("insert into "+this.TABLE_NAME+"(name,type,sort,label,showlink,showdel,changecid,showcont,showdoc,showpic,otherlink,showvideo,showfile,showisrec,ctype,showabst,modifytime)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",new Object[]{a.getName(),a.getType(),a.getSort(),a.getLabel(),a.getShowlink(),a.getShowdel(),a.getShowcont(),a.getChangecid(),a.getShowdoc(),a.getShowpic(),a.getOtherlink(),a.getShowvideo(),a.getShowfile(),a.getShowisrec(),a.getCtype(),a.getShowabst(),a.getModifytime()});
        }
	}

	public void del(String tagid) throws Exception {
		BaseDao BaseDao = new BaseDao();
		BaseDao.update("delete from "+this.TABLE_NAME+" where id=?",new Object[]{tagid});
	}



}
