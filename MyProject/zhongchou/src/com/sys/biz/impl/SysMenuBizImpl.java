package com.sys.biz.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.DateUtils;
import com.sys.biz.SysMenuBiz;
import com.sys.form.SysMenuForm;

public class SysMenuBizImpl implements SysMenuBiz{
    private String sql="";
	public void addMenu(SysMenuForm form) throws Exception {
		BaseDao dao=new BaseDao();
		for (int i = 0; i < form.getMenuids().length; i++) {
			if(form.getMenuids()[i]==0){
				sql="insert into sys_menu(userid,name,keyurl,sortno,fid,is_show,addtime) values(?,?,?,?,?,?,unix_timestamp())";
				Object[] params={form.getUserid(),form.getNames()[i],form.getKeys()[i],form.getSorts()[i],form.getFids()[i],form.getIs_shows()[i]};
				dao.update(sql, params);
			}else{
				sql="update sys_menu set name=?,keyurl=?,sortno=?,is_show=? where menuid=?";
				Object[] params={form.getNames()[i],form.getKeys()[i],form.getSorts()[i],form.getIs_shows()[i],form.getMenuids()[i]};
				dao.update(sql, params);
			}
		}
	}
	
	public void addMenuRight(SysMenuForm form) throws Exception {
		BaseDao dao=new BaseDao();
		//sql="delete from  sys_right where userid='"+form.getUserid()+"' and weiid='"+form.getWeiid()+"'";
		
		ArrayList list = new ArrayList();
		///list.add(sql);
		String now = DateUtils.now();
		for (int i = 0; i < form.getMenuids().length; i++) {
			if(form.getIs_shows()[i]==1){
				list.add("insert into sys_right(menuid,userid,sysroleid,optime,adminid) values("+form.getMenuids()[i]+","+form.getUserid()+","+form.getSysroleid()+",'"+now+"',1)");
			}else if(form.getIs_shows()[i]==0){
				list.add("delete from sys_right where sysroleid='"+form.getSysroleid()+"' and menuid='"+form.getMenuids()[i]+"'");
			}else{
				//什么也不做
			}
		}
		
		if(list.size()>0)
		dao.updateBatch(list);
	}


	public void delmenu(String menuid, String weiid) throws Exception {
		sql="delete from sys_menu where menuid="+menuid;
		BaseDao dao=new BaseDao();
		dao.delete(sql);
	}

	public List listMenu(PageInfo info) throws Exception {
		//sql="select * from sys_menu where  weiid="+weiid+" and fid=0 order by sortno desc,addtime desc";
		BaseDao dao=new BaseDao();
		info.setQueryStr(" fid=0 order by sortno desc,addtime desc");
		List<Map> menus=dao.getListByPage("sys_menu", "*", info);
		for(Map menu:menus){
			sql="select * from sys_menu where  fid="+menu.get("menuid")+" order by sortno desc,fid asc,addtime desc";
			menu.put("cmenus", dao.getList(sql));
		}
		return menus;
	}
	
	public List loopRightMenu(String sysroleid) throws Exception {
		sql="select m.* from sys_menu m inner join sys_right r on m.menuid=r.menuid where  r.sysroleid="+sysroleid+" and m.fid=0 and m.is_show=1 order by m.sortno desc,m.addtime desc";
		BaseDao dao=new BaseDao();
		List<Map> menus=dao.getList(sql);
		for(Map menu:menus){
			sql="select m.* from sys_menu m inner join sys_right r  on m.menuid=r.menuid  where r.sysroleid='"+sysroleid+"' and  m.fid="+menu.get("menuid")+" and m.is_show=1 order by m.sortno desc,m.fid asc,m.addtime desc";
			menu.put("cmenus", dao.getList(sql));
		}
		return menus;
	}

	public List listRightMenu(String sysroleid) throws Exception {
		sql="select * from sys_right where sysroleid='"+sysroleid+"'";
		BaseDao dao=new BaseDao();
		List<Map> menus=dao.getList(sql);
		return menus;
	}
	
	public void copyRightMenu(String weiid,String toweiid) throws Exception {
		BaseDao dao=new BaseDao();
		sql="delete from sys_right where weiid='"+toweiid+"'";
		dao.delete(sql);
		dao.update("insert into sys_right(menuid,userid,weiid,optime,adminid) select menuid,userid,'"+toweiid+"' weiid,optime,adminid from sys_right where weiid='"+weiid+"'");
	}
    
}
