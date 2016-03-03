package com.sys.biz;


import java.util.List;
import java.util.Map;

import com.sys.form.SysUserForm;
import com.xiaoyou.data.PageInfo;

public abstract interface SysUserBiz
{
  public abstract List list(PageInfo paramPageInfo)
    throws Exception;

  public abstract List list(String paramString)
    throws Exception;

  public abstract Map detail(String paramString)
    throws Exception;

  public abstract void update(SysUserForm paramSysUserForm)
    throws Exception;

  public abstract void del(String paramString)
    throws Exception;
}
