package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.SysRoleDao;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.data.ResultData;
import com.sys.form.SysRoleForm;

public class SysRoleService {
	  private SysRoleService(){}
	  public static SysRoleService getinstance(){
		return new SysRoleService();
	  }
	  /**
	   * 列出所有的菜单
	   * @return
	   * @throws Exception
	   */
      public ResultData listallrole(PageInfo pageinfo)throws Exception{
    	  List<Map<String, Object>> rolelist=SysRoleDao.getinstance().queryall(pageinfo);//查询所有系统菜单
    	  ResultData result=new ResultData(rolelist);
    	  return result;
      }
      
      /**
	   * 列出所有父角色
	   * @return
	   * @throws Exception
	   */
      public ResultData listallfather()throws Exception{
    	  List<Map<String, Object>> rolelist=SysRoleDao.getinstance().queryallfather();//查询所有系统菜单
    	  ResultData result=new ResultData(rolelist);
    	  return result;
      }
      /**
	   * 列出所有子角色
	   * @return
	   * @throws Exception
	   */
      public ResultData listallchild(int fatherid)throws Exception{
    	  List<Map<String, Object>> rolelist=SysRoleDao.getinstance().queryallchild(fatherid);//查询所有系统菜单
    	  ResultData result=new ResultData(rolelist);
    	  return result;
      }
     /**
       * 保存菜单
       * @param roleform
       * @return
       * @throws Exception
       */
      public ResultData saverole(SysRoleForm roleform)throws Exception{
    	  ResultData result=new ResultData();
    	  int sucess=SysRoleDao.getinstance().save(roleform);
    	  if(sucess>-1)
    	     result.setResult(true); 
    	  else 
    		 result.setResult(false);
    	  return result;
      }
      /**
       * 更新菜单
       * @param roleform
       * @return
       * @throws Exception
       */
      public ResultData updaterole(SysRoleForm roleform)throws Exception{
    	  ResultData result=new ResultData();
    	  int sucess=SysRoleDao.getinstance().update(roleform);
    	  if(sucess>-1)
    	     result.setResult(true); 
    	  else 
    		 result.setResult(false);
    	  return result;
      }
      /**
       * 删除角色
       * @param roleid
       * @throws Exception
       */
      public void deleterole(int roleid)throws Exception{
    	  ResultData result=new ResultData();
    	  SysRoleDao.getinstance().delete(roleid);
      }
      /**
       * 角色详细
       * @param roleid
       * @throws Exception
       */
      public ResultData detailrole(int roleid)throws Exception{
    	  Map map=SysRoleDao.getinstance().detail(roleid);
    	  return new ResultData(map);
      }
      /**
       * 角色授权
       * @param roleid
       * @throws Exception
       */
      public void granttorole(SysRoleForm rightform)throws Exception{
    	  SysRoleDao.getinstance().saveright(rightform);
      }
}
