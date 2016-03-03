package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.form.QuestionForm;

public class QuestionBizImpl extends BaseBizImpl{
	//FROM_UNIXTIME(overtime, '%Y-%m-%d')overtime
	public List getList(PageInfo pageinfo,String type,String cid)throws Exception{
		if(type!=null&&!"".equals(type)){
			if(cid!=null&&!"".equals(cid)){
				pageinfo.setQueryStr(" type="+type+" and cid="+cid+" order by addtime desc");
			}else{
				pageinfo.setQueryStr(" type="+type+" order by addtime desc");
			}
		}
		else{
			if(cid!=null&&!"".equals(cid)){
				pageinfo.setQueryStr(" cid="+cid+" order by addtime desc");
			}else{
				pageinfo.setQueryStr(" order by addtime desc");
			}
		}
		BaseDao basedao = new BaseDao();
		return basedao.getListByPage("t_questions", "*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime", pageinfo);
	}
    public void saveorupdate(QuestionForm qform)throws Exception{
    	BaseDao basedao = new BaseDao();
    	if(qform.getId()==0){
    		sql="insert into t_questions(cid,type,question,answer,item1,item2,item3,item4,expain,addtime,qno) values(?,?,?,?,?,?,?,?,?,unix_timestamp(),?)";
    		Object[] params={qform.getCid(),qform.getType(),qform.getQuestion(),qform.getAnswer(),qform.getItem1(),qform.getItem2(),qform.getItem3(),qform.getItem4(),qform.getExpain(),qform.getQno()};
    		basedao.update(sql, params);
    	}else{
    		sql="update t_questions set cid=?,question=?,answer=?,item1=?,item2=?,item3=?,item4=?,expain=?,addtime=unix_timestamp(),qno=? where id=?";
    		Object[] params={qform.getCid(),qform.getQuestion(),qform.getAnswer(),qform.getItem1(),qform.getItem2(),qform.getItem3(),qform.getItem4(),qform.getExpain(),qform.getQno(),qform.getId()};
    		basedao.update(sql, params);
    	}
    }
    public void delete(String id)throws Exception{
		delete("t_questions",id);
	}
    public Map detail(String id)throws Exception{
		return detail("t_questions",id);
	}
}
