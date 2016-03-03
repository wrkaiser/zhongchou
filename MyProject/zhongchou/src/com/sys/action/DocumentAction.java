package com.sys.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.biz.impl.DocumentBizImpl;
import com.sys.form.DocumentForm;

public class DocumentAction
  extends BaseAction
{
  private static Map types = new HashMap();
  
  static
  {
    BaseDao dao = new BaseDao();
    List<Map> maps = new ArrayList();
    try
    {
      maps = dao.getList("select cid,cname from wei_common_ctype order by pos");
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    for (Map m : maps) {
      types.put(m.get("id"), m.get("cname"));
    }
  }
  
  public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    Map user = super.getSessionUser(request);
    String pid = request.getParameter("pid");
    String cid = request.getParameter("cid"); //类别ID
    if (user == null) {
      return mapping.findForward("login");
    }
    DocumentBizImpl docbiz = new DocumentBizImpl();
    String pagenum = request.getParameter("p");
    PageInfo pageinfo = new PageInfo();
    if ((pagenum != null) && (!"".equals(pagenum))) {
      pageinfo.setCurrentPage(pagenum);
    }
    request.setAttribute("docs", docbiz.getList(cid,pid, pageinfo,super.getBLanguage(request)));
    request.setAttribute("pageinfo", pageinfo);
    request.setAttribute("pid", pid);
    
    if(cid==null||cid.isEmpty()){cid = "";}
    request.setAttribute("cid", cid); 
    
    request.setAttribute("name", types.get(pid));
    
    return mapping.findForward("list");
  }
  
  public ActionForward save(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    Map user = super.getSessionUser(request);
    if (user == null) {
      return mapping.findForward("login");
    }
    DocumentForm dform = (DocumentForm)form;
    DocumentBizImpl docbiz = new DocumentBizImpl();
    try
    {
      docbiz.saveorupdate(dform,super.getBLanguage(request));
      response.getWriter().print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\"" + request.getContextPath() + "/back/doc.do?m=list&pid=" + dform.getPid()+"&cid="+dform.getCid() + "\"}");
    }
    catch (Exception e)
    {
      log.error(e.getMessage());
      response.getWriter().print("修改失败：" + e.getMessage());
    }
    return null;
  }
  
  public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    Map user = super.getSessionUser(request);
    if (user == null) {
      return mapping.findForward("login");
    }
    String pid = request.getParameter("pid");
    String cid = request.getParameter("cid");
    String id = request.getParameter("id");
    DocumentBizImpl docbiz = new DocumentBizImpl();
    try
    {
      docbiz.delete(id,super.getBLanguage(request));
      response.sendRedirect(request.getContextPath() + "/back/doc.do?m=list&pid=" + pid+"&cid="+cid);
    }
    catch (Exception e)
    {
      log.error(e.getMessage());
      response.getWriter().print("删除失败：" + e.getMessage());
    }
    return null;
  }
  
  public ActionForward detail(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    Map user = super.getSessionUser(request);
    if (user == null) {
      return mapping.findForward("login");
    }
    String pid = request.getParameter("pid");
    String id = request.getParameter("id");
    String cid = request.getParameter("cid");
    DocumentBizImpl docbiz = new DocumentBizImpl();
    
    request.setAttribute("pid", pid);
    Map detail = docbiz.detail(id,super.getBLanguage(request));
    if (detail == null) {
      detail = new HashMap();
    }else{
    	cid = detail.get("cid")+"";
    }
    request.setAttribute("doc", detail);
    if ((cid == null) || (cid.isEmpty())) {
      cid = "";
    }else{
    	detail.put("cid", cid);
    	
    }
    
    request.setAttribute("name", types.get(pid));
    request.setAttribute("cid", cid);
    
    return mapping.findForward("detail");
  }
}
