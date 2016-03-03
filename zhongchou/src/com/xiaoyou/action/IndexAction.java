package com.xiaoyou.action;

import java.util.List;
import java.util.Map;

import javax.jms.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sys.action.BaseAction;
import com.xiaoyou.biz.AdBiz;
import com.xiaoyou.biz.DealBiz;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.JsonUtil;
import com.xiaoyou.util.StringUtil;

public class IndexAction extends BaseAction {
	/**
	 * 首页初始化
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward index(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdBiz abiz = new AdBiz();// 广告业务biz
		List tbads = abiz.getAdsByType("38", 100);
		DealBiz dbiz = new DealBiz();
		List cats = dbiz.getTypeName();
		List hotdeals = dbiz.getHotsDeals();
		List newdeals = dbiz.getNewDeals();
		request.setAttribute("cats", cats);
		request.setAttribute("tbads", tbads);
		request.setAttribute("hotdeals", hotdeals);
		request.setAttribute("newdeals", newdeals);
		return mapping.findForward("index");
	}
	public ActionForward exit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		 try{
		    request.getSession().removeAttribute("QUser");
		    response.getWriter().print("1");
		 }catch(Exception e){
			 System.out.print("系统异常：" + e.getMessage());
		 }
		 return null;
		
	}
	
}
