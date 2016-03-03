package com.sys.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.xiaoyou.data.PageInfo;
import com.sys.biz.impl.ProductBizImpl;
import com.sys.biz.impl.MessageBizImpl;
import com.sys.biz.impl.QuestionBizImpl;
import com.sys.biz.impl.VCourseBizImpl;
import com.sys.form.ProductForm;
import com.sys.form.MessageForm;
import com.sys.form.QuestionForm;
import com.sys.form.VCourseForm;

/**
 * 留言管理
 * @author Administrator
 *
 */
public class VCourseAction extends BaseAction {
    
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
			String cid=request.getParameter("cid");
			VCourseBizImpl cbiz = new VCourseBizImpl();
		    String pagenum=request.getParameter("p");
		    PageInfo pageinfo=new PageInfo();
		    if(pagenum!=null&&!"".equals(pagenum)){
		    	pageinfo.setCurrentPage(pagenum);
		    }
		    request.setAttribute("courses", cbiz.getList(pageinfo,cid));
		    request.setAttribute("pageinfo", pageinfo);
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
			VCourseForm dform=(VCourseForm)form;
			VCourseBizImpl cbiz = new VCourseBizImpl();
			try {
				cbiz.saveorupdate(dform);
				response.getWriter().print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\""+request.getContextPath()+"/back/vcourse.do?m=list&cid="+dform.getCid()+"\"}");
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
			String cid=request.getParameter("cid");
			VCourseBizImpl cbiz = new VCourseBizImpl();
			try {
				cbiz.delete(id);
				response.sendRedirect(request.getContextPath()+"/back/vcourse.do?m=list&cid="+cid);
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
			String cid=request.getParameter("cid");
			String id = request.getParameter("id");
			VCourseBizImpl cbiz = new VCourseBizImpl();
			request.setAttribute("course", cbiz.detail(id));
			request.setAttribute("cid", cid);
		}
		return mapping.findForward("detail");
	}
	
}
	
	
	
