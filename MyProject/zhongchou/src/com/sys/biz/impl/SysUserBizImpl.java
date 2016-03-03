package com.sys.biz.impl;

import java.util.List;
import java.util.Map;

import com.sys.biz.SysUserBiz;
import com.sys.form.SysUserForm;
import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.EncodeAndDecode;

public class SysUserBizImpl
  implements SysUserBiz
{
  private static final String TABLE_NAME = "wei_user ";

  public List list(PageInfo pageinfo)
    throws Exception
  {
    BaseDao BaseDao = new BaseDao();
    List list = BaseDao.getListByPage("wei_user  t inner join sys_role on sys_role.sysroleid=t.role", "t.*,sys_role.rolename", pageinfo);
    return list;
  }

  public List list(String wherestr)
    throws Exception
  {
    BaseDao BaseDao = new BaseDao();
    List list = BaseDao.getList("select * from wei_user " + wherestr + " order by userid desc");
    return list;
  }

  public Map detail(String tagid)
    throws Exception
  {
    BaseDao BaseDao = new BaseDao();
    return BaseDao.queryone("select * from " + "wei_user " + " where userid=" + tagid);
  }

  public void update(SysUserForm a) throws Exception
  {
    BaseDao BaseDao = new BaseDao();

    String sql = "";
    EncodeAndDecode code = new EncodeAndDecode();
    if ((a.getPassword() == null) || (a.getPassword().isEmpty()))
      a.setPassword("111111");

    a.setPassword(code.encrypt(a.getPassword()));
    if (a.getUserid() > 0) {
      sql = "update " + "wei_user " + " set username=?,realname=?,password=?,email=?,qq=?,telno=?,logtime=unix_timestamp(),logip=?,headimg=?,role=? where userid=?";
      BaseDao.update(sql, new Object[] { a.getUsername(), a.getRealname(), a.getPassword(), a.getEmail(), a.getQq(), a.getTelno(), a.getLogip(), a.getHeadimg(), Integer.valueOf(a.getRole()), Integer.valueOf(a.getUserid()) });
    } else {
      BaseDao.update("insert into " + "wei_user " + "(username,realname,password,email,qq,telno,regtime,logtime,logip,headimg,role)values(?,?,?,?,?,?,unix_timestamp(),unix_timestamp(),?,?,?)", new Object[] { a.getUsername(), a.getRealname(), a.getPassword(), a.getEmail(), a.getQq(), a.getTelno(), a.getLogip(), a.getHeadimg(), Integer.valueOf(a.getRole()) });
    }
  }

  public void del(String userid) throws Exception
  {
    BaseDao BaseDao = new BaseDao();
    BaseDao.update("delete from " + "wei_user " + " where userid=?", new Object[] { userid });
  }
}
