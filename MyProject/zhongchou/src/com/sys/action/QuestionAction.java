package com.sys.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.xiaoyou.data.PageInfo;
import com.sys.biz.impl.MessageBizImpl;
import com.sys.biz.impl.QuestionBizImpl;
import com.sys.form.MessageForm;
import com.sys.form.QuestionForm;

/**
 * 留言管理
 * @author Administrator
 *
 */
public class QuestionAction extends BaseAction {
    
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
			String type=request.getParameter("type");
			String cid=request.getParameter("cid");
			QuestionBizImpl questbiz = new QuestionBizImpl();
		    String pagenum=request.getParameter("p");
		    PageInfo pageinfo=new PageInfo();
		    if(pagenum!=null&&!"".equals(pagenum)){
		    	pageinfo.setCurrentPage(pagenum);
		    }
		    request.setAttribute("quests", questbiz.getList(pageinfo,type,cid));
		    request.setAttribute("pageinfo", pageinfo);
		    request.setAttribute("type", type);
		    request.setAttribute("cid", cid);
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
			QuestionForm dform=(QuestionForm)form;
			QuestionBizImpl questbiz = new QuestionBizImpl();
			try {
				questbiz.saveorupdate(dform);
				response.getWriter().print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\""+request.getContextPath()+"/back/quest.do?m=list&t="+dform.getType()+"\"}");
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
			String type=request.getParameter("type");
			QuestionBizImpl questbiz = new QuestionBizImpl();
			try {
				questbiz.delete(id);
				response.sendRedirect(request.getContextPath()+"/back/quest.do?m=list&t="+type);
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
			String type=request.getParameter("type");
			String cid=request.getParameter("cid");
			String id = request.getParameter("id");
			QuestionBizImpl questbiz = new QuestionBizImpl();
			request.setAttribute("quest", questbiz.detail(id));
			  request.setAttribute("type", type);
			  request.setAttribute("cid", cid);
		}
		return mapping.findForward("detail");
	}
	
}
	
	
	
