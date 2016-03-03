package com.sys.action;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sys.biz.CommonCTypeBiz;
import com.sys.biz.impl.CommonCTypeBizImpl;
import com.sys.form.CommonTypeForm;

/**
 * 微网页CommonTypeAction
 * @author Administrator
 *
 */
public class CommonCTypeAction extends BaseAction {
    
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
		String id = request.getParameter("id");
		if(user==null){
			return mapping.findForward("login");
		}else{
		   
		   CommonCTypeBiz rbiz = new CommonCTypeBizImpl();
		   String w = "";
		   if(id!=null&&!id.isEmpty()){
			   w = " where type="+id;
		   }
		   request.setAttribute("list", rbiz.list(w));
		}
		request.setAttribute("id", id);
		return mapping.findForward("list");
	}
	
	/**
     * update
     * @param mapping
     * @param form
     * @param request
     * @param response 
     * @return
     * @throws Exception
     */
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		CommonTypeForm cform = (CommonTypeForm)form;
		CommonCTypeBiz cbiz = new CommonCTypeBizImpl();
		Map user = super.getSessionUser(request);
		if(user==null){
			return mapping.findForward("login");
		}else{
			try{
				cbiz.update(cform);
			}catch(Exception e){
				log.error(e.getMessage());
				response.getWriter().print("修改失败："+e.getMessage());
			}
		} 
		   response.getWriter().print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\""+request.getContextPath()+"/back/commonctype.do?m=list\"}");

		return null;  
	}
	
	/**
     * detail
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		CommonTypeForm cform = (CommonTypeForm)form;
		String id = request.getParameter("id");
		Map user = super.getSessionUser(request);
		if(user==null){
			return mapping.findForward("login");
		}else{
			CommonCTypeBiz cbiz = new CommonCTypeBizImpl();
			Map one  = cbiz.detail(id);
			request.setAttribute("detail", one);
		}
		return mapping.findForward("detail");
		  
	}
	
	/**
	 * del
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception  
	 */
	public ActionForward del(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   String id = request.getParameter("id");
		   Map user = super.getSessionUser(request);
		   if(user==null){
				return mapping.findForward("login");
			}else{
		   try {
			   CommonCTypeBiz cbiz = new CommonCTypeBizImpl();
			   cbiz.del(id);
			   response.getWriter().println("恭喜，删除成功！！<script>window.location.href='"+request.getContextPath()+"/back/commonctype.do?m=list'</script>");
			     
		      return null;
			} catch (SQLException e) {
			  System.out.println("systemplateAction()"+e.getMessage());
				response.getWriter().print("修改失败："+e.getMessage());
			  return null;
			}
			} 
	}

	
}
	
	
	
