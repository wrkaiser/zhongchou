package com.sys.action;

import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sys.biz.SysUserBiz;
import com.sys.biz.impl.SysUserBizImpl;
import com.sys.form.SysUserForm;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.EncodeAndDecode;

public class SysUserAction extends BaseAction
{
  public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    Map user = super.getSessionUser(request);
    if (user == null) {
      return mapping.findForward("login");
    }

    String pagenum = request.getParameter("p");
    PageInfo pageinfo = new PageInfo();
    if ((pagenum != null) && (!("".equals(pagenum))))
      pageinfo.setCurrentPage(pagenum);

    SysUserBiz rbiz = new SysUserBizImpl();
    pageinfo.setQueryStr(" userid!='" + user.get("userid") + "'");
    request.setAttribute("list", rbiz.list(pageinfo));
    request.setAttribute("pageinfo", pageinfo);

    return mapping.findForward("list");
  }

  public ActionForward update(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    SysUserForm cform = (SysUserForm)form;
    SysUserBiz cbiz = new SysUserBizImpl();
    Map user = super.getSessionUser(request);
    if (user == null)
      return mapping.findForward("login");
    try
    {
      cbiz.update(cform);
    } catch (Exception e) {
      e.printStackTrace();
      log.error(e.getMessage() + "---" + cform.getPassword());

      response.getWriter().print("修改失败：" + e.getMessage());
    }

    response.getWriter().println("恭喜，添加成功！！<script>window.location.href='" + request.getContextPath() + "/back/user.do?m=list'</script>");
    return null;
  }

  public ActionForward detail(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    String id = request.getParameter("id");
    Map user = super.getSessionUser(request);
    if (user == null)
      return mapping.findForward("login");

    SysUserBiz cbiz = new SysUserBizImpl();
    Map one = cbiz.detail(id);
    if (one != null) {
      EncodeAndDecode code = new EncodeAndDecode();
      one.put("password", code.decrypt(one.get("password").toString()));
    }

    request.setAttribute("detail", one);

    return mapping.findForward("detail");
  }

  public ActionForward del(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    String id = request.getParameter("id");
    Map user = super.getSessionUser(request);
    if (user == null)
      return mapping.findForward("login");
    try
    {
      SysUserBiz cbiz = new SysUserBizImpl();
      cbiz.del(id);
      response.getWriter().println("恭喜，删除成功！！<script>window.location.href='" + request.getContextPath() + "/back/user.do?m=list'</script>");
      return null;
    } catch (SQLException e) {
      System.out.println("PlugMenuAction()" + e.getMessage());
      response.getWriter().print("修改失败：" + e.getMessage()); }
    return null;
  }
}