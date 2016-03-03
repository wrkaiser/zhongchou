package com.xiaoyou.biz;

import java.util.List;

import com.xiaoyou.dao.BaseDao;

public class AdBiz {
	private String sql="";
	/**
	 * 获取广告
	 * @param cid分类id
	 * @param limit获取数量,获取所有用大数字代替，例如100
	 * @return
	 */
    public List getAdsByType(String cid,int limit) throws Exception{
    	sql="select * from t_document where cid="+cid+" order by pos desc,ctime desc limit "+limit;
    	BaseDao dao=new BaseDao();
    	return dao.getList(sql);
    }
}
