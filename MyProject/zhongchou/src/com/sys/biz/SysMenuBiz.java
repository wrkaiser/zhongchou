package com.sys.biz;

import java.util.List;
import java.util.Map;

import com.xiaoyou.data.PageInfo;
import com.sys.form.SysMenuForm;

public interface SysMenuBiz {
    /**
     * 添加菜单
     * @param form
     * @throws Exception
     */
    public void addMenu(SysMenuForm form)throws Exception;
    
    /**
     * 添加菜单权限
     * @param form
     * @throws Exception
     */
    public void addMenuRight(SysMenuForm form) throws Exception;
    /**
     * 删除菜单
     * @param menuid
     * @param weixinid
     * @throws Exception
     */
    public void delmenu(String menuid,String weixinid)throws Exception;
    /**
     * 列出微信菜单
     * @param userid
     * @param weixinid
     * @throws Exception
     */
    public List listMenu(PageInfo info) throws Exception;
    
    /**
     * 循环列出weiid 的权限菜单
     * @param weiid
     * @return
     * @throws Exception
     */
    public List loopRightMenu(String weiid) throws Exception;
    
    /**
     * 列出授权menu信息
     * @param userid
     * @return
     * @throws Exception
     */
    public List listRightMenu(String weiid) throws Exception;
    
    /**
     * 复制权限菜单
     * @param weiid
     * @param toweiid
     * @throws Exception
     */
    public void copyRightMenu(String weiid,String toweiid) throws Exception;
}
