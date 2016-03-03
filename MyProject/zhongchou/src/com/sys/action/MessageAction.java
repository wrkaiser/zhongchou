package com.sys.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.xiaoyou.data.PageInfo;
import com.sys.biz.impl.MessageBizImpl;
import com.sys.form.MessageForm;

/**
 * 留言管理
 * @author Administrator
 *
 */
public class MessageAction extends BaseAction {
    
	/**
     * 列表
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user = super.getSessionUser(request);
		if(user==null){
			return mapping.findForward("login");
		}else{
			MessageBizImpl docbiz = new MessageBizImpl();
			 String type=request.getParameter("t");
		    String pagenum=request.getParameter("p");
		    PageInfo pageinfo=new PageInfo();
		    if(pagenum!=null&&!"".equals(pagenum)){
		    	pageinfo.setCurrentPage(pagenum);
		    }
		    request.setAttribute("msgs", docbiz.getList(pageinfo,type));
		    request.setAttribute("pageinfo", pageinfo);
		    request.setAttribute("type", type);
		}
		return mapping.findForward("list");
	}
	/**
     * 添加
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user = super.getSessionUser(request);
		if(user==null){
			return mapping.findForward("login");
		}else{
			MessageForm dform=(MessageForm)form;
			MessageBizImpl docbiz = new MessageBizImpl();
			try {
				docbiz.saveorupdate(dform);
				response.getWriter().print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\""+request.getContextPath()+"/back/msg.do?m=list\"}");
			} catch (Exception e) {
				log.error(e.getMessage());
				response.getWriter().print("修改失败："+e.getMessage());
			}
		}
		return null;
	}
	/**
     * 删除
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user = super.getSessionUser(request);
		if(user==null){
			return mapping.findForward("login");
		}else{
			String id = request.getParameter("id");
			MessageBizImpl docbiz = new MessageBizImpl();
			try {
				docbiz.delete(id);
				response.sendRedirect(request.getContextPath()+"/back/msg.do?m=list");
			} catch (Exception e) {
				log.error(e.getMessage());
				response.getWriter().print("删除失败："+e.getMessage());
			}
		}
		return null;
	}
	/**
     * 详情
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user = super.getSessionUser(request);
		if(user==null){
			return mapping.findForward("login");
		}else{
			String id = request.getParameter("id");
			MessageBizImpl docbiz = new MessageBizImpl();
			request.setAttribute("msg", docbiz.detail(id));
		}
		return mapping.findForward("detail");
	}
	
}
	
	
	
