package com.xiaoyou.biz;

import com.sys.form.LuYanForm;
import com.xiaoyou.dao.BaseDao;

public class LuYanBiz {
	/*
	 * 添加更新路演信息
	 * 
	 */
     public  void  addLuYan(LuYanForm luyanform) throws Exception{
    	   BaseDao dao=new BaseDao();
    	   String sql="update zh_pros set luyan='"+luyanform.getContent()+"' where proid="+luyanform.getProid();
    	   dao.update(sql);
    	 //  System.out.println("1");
 }
}
