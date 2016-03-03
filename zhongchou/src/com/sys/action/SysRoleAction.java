package com.sys.action;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.xiaoyou.data.PageInfo;
import com.xiaoyou.data.ResultData;
import com.sys.biz.impl.SysRoleService;
import com.sys.form.SysRoleForm;

public class SysRoleAction extends BaseAction {
    
	/**
     *列出所有角色
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   String pagenum=(String)request.getParameter("p");;
		   PageInfo pageinfo=new PageInfo();
		   if(pagenum!=null&&!"".equals(pagenum))
			   pageinfo.setCurrentPage(pagenum);
		   ResultData result=com.sys.biz.impl.SysRoleService.getinstance().listallrole(pageinfo);
		   request.setAttribute("rolelist", result.getTrxList());
		   request.setAttribute("pageinfo", pageinfo);
		   return mapping.findForward("list");
	}
	/**
     *选择角色上级
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	public ActionForward select(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   String pagenum=(String)request.getParameter("p");
		   PageInfo pageinfo=new PageInfo();
		   if(pagenum!=null&&!"".equals(pagenum))
			   pageinfo.setCurrentPage(pagenum);
		   ResultData result=SysRoleService.getinstance().listallrole(pageinfo);
		   request.setAttribute("rolelist", result.getTrxList());
		   request.setAttribute("pageinfo", pageinfo);
		   return mapping.findForward("select");
	}
	/**
	 * 进入角色添加页面
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   SysRoleForm roleform=(SysRoleForm)form;
		   return mapping.findForward("add");
	}
	/**
	 * 保存角色
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   SysRoleForm roleform=(SysRoleForm)form;
		   if(roleform.getSysRoleid()==0){
			   SysRoleService.getinstance().saverole(roleform);
			   request.setAttribute("result", "savesuccess");
		   }else{
			   SysRoleService.getinstance().updaterole(roleform);
			   request.setAttribute("result", "updatesuccess");
		   }
		   String pagenum=(String)request.getParameter("p");
		   PageInfo pageinfo=new PageInfo();
		   if(pagenum!=null&&!"".equals(pagenum))
			   pageinfo.setCurrentPage(pagenum);
		   ResultData listresult=SysRoleService.getinstance().listallrole(pageinfo);
		   request.setAttribute("rolelist", listresult.getTrxList());
		   request.setAttribute("pageinfo", pageinfo);
		   response.getWriter().println("恭喜，添加成功！！<script>window.location.href='"+request.getContextPath()+"/back/role.do?m=list'</script>");
			return null;  
	}
	/**
	 * 删除角色
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   SysRoleForm roleform=(SysRoleForm)form;
		   try {
		      SysRoleService.getinstance().deleterole(roleform.getSysRoleid());
		      response.getWriter().println("恭喜，删除成功！！<script>window.location.href='"+request.getContextPath()+"/back/role.do?m=list'</script>");
		      return null;
			} catch (SQLException e) {
				 response.getWriter().println("恭喜，删除成功！！<script>window.location.href='"+request.getContextPath()+"/back/role.do?m=list'</script>");
			      return null;
			}
	}
	/**
	 * 角色详细
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   SysRoleForm roleform=(SysRoleForm)form;
		   ResultData result=SysRoleService.getinstance().detailrole(roleform.getSysRoleid());
		   request.setAttribute("role", result.getTrxInfo());
		   return mapping.findForward("add");
	}
	/**
	 * 授权
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward grant(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		   String[] menuids=request.getParameterValues("menuid");
		   SysRoleForm rightform=(SysRoleForm)form;
		   try {
			   SysRoleService.getinstance().granttorole(rightform);
			   response.getWriter().print("success");
		   } catch (SQLException e) {
			   System.out.println("SysRoleAction.grant()"+e);
			   response.getWriter().print(e.getMessage());
		   }
		   return null;
	}
}
