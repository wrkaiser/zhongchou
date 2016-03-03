package com.sys.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.JsonUtil;
import com.xiaoyou.util.StringUtil;
import com.sys.biz.SysMenuBiz;
import com.sys.biz.impl.SysMenuBizImpl;
import com.sys.form.SysMenuForm;



public class SysMenuAction extends BaseAction{
	/**
	 * 设置微信菜单密钥
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		String id=request.getParameter("id");
		SysMenuBiz wbiz=new SysMenuBizImpl();
		try {
			wbiz.delmenu(id,"0");
			 response.getWriter().println("参数错误！！<script>window.location.href='"+request.getContextPath()+"/back/menu/'</script>");
		     
			
		} catch (Exception e) {
			log.error(StringUtil.msgfmt(e));
			response.getWriter().print("删除失败"+e.getMessage()+"<script></script>");
			
		}
		return null;
	}
	
	/**
	 * 微信菜单别表
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		SysMenuBiz wbiz=new SysMenuBizImpl();
		PageInfo info = new PageInfo();
		String p = request.getParameter("p");
		if(p!=null){
			info.setCurrentPage(p);
		}
		info.setPageSize(10);
		request.setAttribute("menus", wbiz.listMenu(info));
		request.setAttribute("pageinfo", info);
		return mapping.findForward("list");
	} 
	
	/**
	 * 微信菜单别表
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward rightmenulist(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		String sysroleid = request.getParameter("sysroleid");
		
		SysMenuBiz wbiz=new SysMenuBizImpl();
		PageInfo pageinfo = new PageInfo();
		
		String p = request.getParameter("p");
		if(p!=null){
			pageinfo.setCurrentPage(p);
		}
		pageinfo.setPageSize(50);
		request.setAttribute("menus", wbiz.listMenu(pageinfo));
		request.setAttribute("pageinfo", pageinfo);
		request.setAttribute("rights", JsonUtil.generate(wbiz.listRightMenu(sysroleid)));
		request.setAttribute("sysroleid", sysroleid);
		return mapping.findForward("rightmenulist");
	} 
	
	/**
	 * 保存菜单信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			response.getWriter().print("<div id=\"fallr-icon\" class=\"icon-msg-error\"></div>登陆失效请重新登陆<a href='"+request.getContextPath()+"/log.shtml'>登陆</a>");
		}else{
			SysMenuForm wform=(SysMenuForm)form;
			wform.setUserid(user.get("userid").toString());
			SysMenuBiz wbiz=new SysMenuBizImpl();
			try {
				wbiz.addMenu(wform);
					response.getWriter().print("保存成功<script>location.reload();</script>");
			} catch (Exception e) {
				e.printStackTrace();
				log.error(StringUtil.msgfmt(e));
				response.getWriter().print("修改失败："+e.getMessage());
			}
		}
		return null;
	}
	
	
	/**
	 * 保存菜单信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward saveright(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			response.getWriter().print("<div id=\"fallr-icon\" class=\"icon-msg-error\"></div>登陆失效请重新登陆<a href='"+request.getContextPath()+"/log.shtml'>登陆</a>");
		}else{
			SysMenuForm wform=(SysMenuForm)form;
			SysMenuBiz wbiz=new SysMenuBizImpl();
			try {
				wbiz.addMenuRight(wform);
				response.getWriter().print("保存成功<script>location.reload();</script>");
			} catch (Exception e) {
				e.printStackTrace();
				log.error(StringUtil.msgfmt(e));
				response.getWriter().print("修改失败："+e.getMessage());
			}
		}
		return null;
	}

	/**
	 * 设置微信菜单密钥-重置
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward resetright(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		String weiid=request.getParameter("weiid");
		String toweiiid = request.getParameter("toweiid");
		if(weiid==null||toweiiid==null||weiid.equals(toweiiid)){
			 response.getWriter().println("参数错误！！<script>window.location.href='"+request.getContextPath()+"/back/account/lists.html'</script>");
		      return null;
		}
		
		SysMenuBiz wbiz=new SysMenuBizImpl();
		try {
			wbiz.copyRightMenu(weiid, toweiiid);
			 response.getWriter().println("恭喜，设置成功！！<script>window.location.href='"+request.getContextPath()+"/back/account/lists.html'</script>");
		} catch (Exception e) {
			log.error(StringUtil.msgfmt(e));
			 response.getWriter().println("设置失败！！<script>window.location.href='"+request.getContextPath()+"/back/account/lists.html'</script>");
		      return null;
		}
		return null;
	}
}
