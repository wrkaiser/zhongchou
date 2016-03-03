package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.form.DocumentForm;
import com.sys.form.MessageForm;

public class MessageBizImpl extends BaseBizImpl{
	//FROM_UNIXTIME(overtime, '%Y-%m-%d')overtime
	public List getList(PageInfo pageinfo,String type)throws Exception{
		if(type!=null)
			pageinfo.setQueryStr(" type='"+type+"' order by addtime desc");
		else
			pageinfo.setQueryStr(" order by addtime desc");
		BaseDao basedao = new BaseDao();
		return basedao.getListByPage("t_message", "*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime,FROM_UNIXTIME(restime, '%Y-%m-%d') restime", pageinfo);
	}
    public void saveorupdate(MessageForm mform)throws Exception{
    	BaseDao basedao = new BaseDao();
    	if(mform.getId()==0){
    		sql="insert into t_message(content,type,telno,email,name,addtime) values(?,?,?,?,?,unix_timestamp())";
    		Object[] params={mform.getContent(),mform.getType(),mform.getTelno(),mform.getEmail(),mform.getName()};
    		basedao.update(sql, params);
    	}else{
    		sql="update t_message set rescontent=?,restime=unix_timestamp() where id=?";
    		Object[] params={mform.getRescontent(),mform.getId()};
    		basedao.update(sql, params);
    	}
    }
    public void delete(String id)throws Exception{
		delete("t_message",id);
	}
    public Map detail(String id)throws Exception{
		return detail("t_message",id);
	}
}
