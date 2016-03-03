package com.xiaoyou.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sys.action.BaseAction;
import com.sys.form.LuYanForm;
import com.xiaoyou.biz.LuYanBiz;

public class LuYanAction extends BaseAction {
	public  ActionForward addLuYan(ActionMapping mapping ,ActionForm form,HttpServletRequest request,HttpServletResponse response)
		      throws Exception{
			   String proid  = request.getParameter("proid");
			   String content= request.getParameter("content");
			   String nowstatus=request.getParameter("nowstatus");  //审核状态栏选种值
			   String cid=request.getParameter("cid");
			   String p=request.getParameter("p");  //当前页
			   LuYanForm luyanform=(LuYanForm)form;
			   luyanform.setContent(content);
			   luyanform.setProid(proid);
			   LuYanBiz lbiz=new LuYanBiz();
			   lbiz.addLuYan(luyanform);
			   try{
				   response.getWriter().print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\"" + request.getContextPath() + "/back/pro/pros.shtml?m=select&status="+nowstatus+"&category="+cid+"&p="+p+ "\"}");
			   }catch (Exception e)
			    {
				      log.error(e.getMessage());
				      response.getWriter().print("修改失败：" + e.getMessage());
				    }
			   //System.out.println("2");
			   return null;
		 }
}
