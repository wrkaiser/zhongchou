package com.xiaoyou.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.xiaoyou.data.PageInfo;
import com.sys.form.SysRoleForm;

public class SysRoleDao extends BaseDao{
	private String sql="";
	private SysRoleDao(){}
	public static SysRoleDao getinstance(){
		return new SysRoleDao();
	}
	/**
	 * 查询所有角色
	 * @return
	 * @throws Exception
	 */
	public List queryall(PageInfo pageinfo)throws Exception{
		List list=getListByPage("sys_role", "sysroleid,superroleid,rolename,descb,state,createtime", pageinfo);
		return list;
	}
	/**
	 * 查询所有父角色
	 * @return
	 * @throws Exception
	 */
	public List queryallfather()throws Exception{
		sql="select sysroleid,rolename from sys_role where superroleid is null";
		List list=getList(sql);
		return list;
	}
	/**
	 * 查询所有子角色
	 * @return
	 * @throws Exception
	 */
	public List queryallchild(int fatherid)throws Exception{
		sql="select sysroleid,rolename from sys_role where superroleid='"+fatherid+"'";
		List list=getList(sql);
		return list;
	}
	/**
	 * 保存添加角色
	 * @param roleform
	 * @return
	 * @throws Exception
	 */
	public int save(SysRoleForm roleform)throws Exception{
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String createtime=format.format(new Date());
		Object[] params={roleform.getSuperroleid()==0?null:roleform.getSuperroleid(),roleform.getRolename(),roleform.getDescribe(),roleform.getState(),createtime};//暂时不用排序
		sql="insert into sys_role(superroleid,rolename,descb,state,createtime) values(?,?,?,?,?)";
		this.update(sql, params);
		return 1;
	}
	/**
	 * 更新角色
	 * @param roleform
	 * @return
	 * @throws Exception
	 */
	public int update(SysRoleForm roleform)throws Exception{
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String createtime=format.format(new Date());
		Object[] params={roleform.getSuperroleid()==0?null:roleform.getSuperroleid(),roleform.getRolename(),roleform.getDescribe(),roleform.getState(),createtime,roleform.getSysRoleid()};//暂时不用排序
		sql="update sys_role set superroleid=?,rolename=?,descb=?,state=?,createtime=? where sysroleid=?";
		this.update(sql, params);
		return 1;
	}
	/**
	 * 删除角色
	 * @param roleid
	 * @return
	 * @throws Exception
	 */
	public int delete(int roleid)throws Exception{
		sql="delete from sys_role where sysroleid='"+roleid+"'";
		this.update(sql);
		return 1;
	}
	/**
	 * 角色详细
	 * @param roleid
	 * @return
	 * @throws Exception
	 */
	public Map detail(int roleid)throws Exception{
		sql="select child.*,parent.rolename frolename from sys_role  child left join sys_role parent on parent.sysroleid=child.superroleid where child.sysroleid='"+roleid+"'";
		return queryone(sql);
	}
	/**
	 * 角色授权
	 * @param roleid
	 * @return
	 * @throws Exception
	 */
	public void saveright(SysRoleForm rightform)throws Exception{
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String createtime=format.format(new Date());
		ArrayList alSql=new ArrayList();
		sql="delete from sys_right where sysroleid='"+rightform.getSysRoleid()+"'";
		alSql.add(sql);
		for(int menid:rightform.getMenuid()){
			sql="insert into sys_right(menuid,sysroleid,optime,adminid) values('"+menid+"','"+rightform.getSysRoleid()+"','"+createtime+"','"+rightform.getAdminid()+"')";
			alSql.add(sql);
		}
		updateBatch(alSql);
	}
    
}
