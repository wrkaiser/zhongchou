package com.xiaoyou.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sys.action.BaseAction;
import com.xiaoyou.biz.DealBiz;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.JsonUtil;
import com.xiaoyou.util.JsonUtils;

public class DealAction extends BaseAction{
	/*
	 * 获取项目列表（众筹中）
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String c = request.getParameter("id"); // 获取类型表的id
		String x = request.getParameter("x"); // 获取排序类型
		String p = request.getParameter("p");
		request.setAttribute("c", c);
		request.setAttribute("x", x);
		PageInfo pageinfo = new PageInfo();
		pageinfo.setCurrentPage(p);
		pageinfo.setPageSize(5);
		DealBiz dbiz = new DealBiz();
		try{
			List list = dbiz.getZhongChouList(c, x, pageinfo);
			request.setAttribute("list", list);
		}catch(Exception e){
			System.out.print("系统异常：" + e.getMessage());
		}
		String count = dbiz.getZhongChouing();
		String count1 = dbiz.getAll();
		String count2 = dbiz.getSuccessed();
		String count3 = dbiz.getWillStart();
		List cate = dbiz.getTypeName();
		request.setAttribute("cate", cate);
		request.setAttribute("count", count);
		request.setAttribute("count1", count1);
		request.setAttribute("count2", count2);
		request.setAttribute("count3", count3);
		request.setAttribute("pageinfo", pageinfo);
		return mapping.findForward("list");
	}
   /*
    *  获取所有项目列表
    * 
    */
	public ActionForward allProsList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String c = request.getParameter("id"); // 获取类型表的id
		String x = request.getParameter("x");// 获取排序类型
		String p = request.getParameter("p");
		request.setAttribute("c", c);
		request.setAttribute("x", x);
		PageInfo pageinfo = new PageInfo();
		pageinfo.setCurrentPage(p);
		pageinfo.setPageSize(5);
		DealBiz dbiz = new DealBiz();
		try{
		List list = dbiz.getAllProsList(c, x, pageinfo);
		request.setAttribute("list", list);
		}catch(Exception e){
			System.out.print("系统异常：" + e.getMessage());
		}
		String count = dbiz.getZhongChouing();
		String count1 = dbiz.getAll();
		String count2 = dbiz.getSuccessed();
		String count3 = dbiz.getWillStart();
		List cate = dbiz.getTypeName();
	
		request.setAttribute("cate", cate);
		request.setAttribute("count", count); // 众筹中项目数量
		request.setAttribute("count1", count1); // 所有项目数量
		request.setAttribute("count2", count2); // 已成功项目数量
		request.setAttribute("count3", count3); // 即将开始项目数量
		request.setAttribute("pageinfo", pageinfo);
		return mapping.findForward("allpros");
	}
   /*
    * 获取已成功（结束）项目列表
    * 
    */
	public ActionForward successedList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String c = request.getParameter("id");
		String x = request.getParameter("x");
		String p = request.getParameter("p");
		request.setAttribute("c", c);
		request.setAttribute("x", x);
		PageInfo pageinfo = new PageInfo();
		pageinfo.setCurrentPage(p);
		pageinfo.setPageSize(5);
		DealBiz dbiz = new DealBiz();
		try{
		List list = dbiz.getSuccessedList(c, x, pageinfo);
		request.setAttribute("list", list);
		}catch(Exception e){
			System.out.print("系统异常：" + e.getMessage());
		}
		String count = dbiz.getZhongChouing();
		String count1 = dbiz.getAll();
		String count2 = dbiz.getSuccessed();
		String count3 = dbiz.getWillStart();
		List cate = dbiz.getTypeName();
		
		request.setAttribute("cate", cate);
		request.setAttribute("count", count);
		request.setAttribute("count1", count1);
		request.setAttribute("count2", count2);
		request.setAttribute("count3", count3);
		request.setAttribute("pageinfo", pageinfo);
		return mapping.findForward("successed");
	}
    /*
     * 获取即将开始项目列表
     * 
     */
	public ActionForward willStartList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String c = request.getParameter("id");
		String x = request.getParameter("x");
		String p = request.getParameter("p");
		request.setAttribute("c", c);
		request.setAttribute("x", x);
		PageInfo pageinfo = new PageInfo();
		pageinfo.setCurrentPage(p);
		pageinfo.setPageSize(5);
		DealBiz dbiz = new DealBiz();
		try{
		List list = dbiz.getWillStartList(c, x, pageinfo);
		request.setAttribute("list", list);
		}catch(Exception e){
			System.out.print("系统异常：" + e.getMessage());
		}
		String count = dbiz.getZhongChouing();
		String count1 = dbiz.getAll();
		String count2 = dbiz.getSuccessed();
		String count3 = dbiz.getWillStart();
		List cate = dbiz.getTypeName();
		request.setAttribute("cate", cate);
		request.setAttribute("count", count);
		request.setAttribute("count1", count1);
		request.setAttribute("count2", count2);
		request.setAttribute("count3", count3);
		request.setAttribute("pageinfo", pageinfo);
		return mapping.findForward("willstart");
	}
  /*
   * 单个项目的详细信息页
   * 
   */
	public ActionForward proDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String proid = request.getParameter("id");
		Map user = (Map) request.getSession().getAttribute("QUser");
		if (user == null) {
			DealBiz dbiz = new DealBiz();
			List list = dbiz.getOrderDetail(proid);
			Map map = dbiz.getProDetail(proid);
			List list1 = dbiz.getProPicture(proid);
			request.setAttribute("list", list); // 获取项目预定人的信息
			request.setAttribute("map", map); // 项目的详细信息
			request.setAttribute("list1", list1); // 獲取項目相册的信息
			return mapping.findForward("prodetail");
		} else {
			String userid = user.get("userid").toString();
			DealBiz dbiz = new DealBiz();
			List list = dbiz.getOrderDetail(proid);
			Map map = dbiz.getProDetail(proid, userid);
			List list1 = dbiz.getProPicture(proid);
			request.setAttribute("list", list);
			request.setAttribute("map", map);
			request.setAttribute("list1", list1);
			return mapping.findForward("prodetail");

		}

	}
   /*
    * 点击取消关注
    */
	public ActionForward clickCollect(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map user = (Map) request.getSession().getAttribute("QUser");
		if (user == null) {
			response.getWriter().print("-1");
			return null;
		} else {
			String userid = user.get("userid").toString();
			String proid = request.getParameter("proid");
			try {
				DealBiz dbiz = new DealBiz();
				// System.out.println("1");
				dbiz.getProCollects(proid, userid);
				// System.out.println("2");
				Map map1 = dbiz.getProDetail(proid, userid);
				// System.out.println("3");
				response.getWriter().print("99");
			} catch (Exception e) {

				System.out.print("系统异常：" + e.getMessage());

			}
			return null;
		}
	}
	/*
     * 项目团队的信息
     * 
     */
	public ActionForward teamList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
		    throws Exception{
		 String proid  = request.getParameter("proid");
		   try{
			   DealBiz dbiz=new DealBiz();
		       List list =dbiz.getTeamMember(proid); 
		       if(list!=null){
		       response.getWriter().print(JsonUtil.generate(list));
		       }else{
		       response.getWriter().print("99");
		       }
	      }catch(Exception e){
		         System.out.print("系统异常："
			    	+ e.getMessage());
		         }
	       return null;
	}  
	 /*
	   * 获取提问回复信息列表
	   * 
	   */
		public ActionForward commList(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			try {
				String proid = request.getParameter("proid");
				String p = request.getParameter("p");
				DealBiz dbiz = new DealBiz();
				PageInfo pageinfo = new PageInfo();
				pageinfo.setCurrentPage(p);
				pageinfo.setPageSize(10);
				List list = dbiz.getCommList(proid, pageinfo);
				int totalpage = pageinfo.getTotalPages();

				if (list != null) {
					// System.out.println("222");
					response.getWriter().print(
							JsonUtils.listToJson(list, totalpage));
				} else {
					response.getWriter().print("99");
				}

			} catch (Exception e) {
				System.out.print("系统异常：" + e.getMessage());
			}
			return null;
		}
	 /*
	  * 提问操作，并返回确认提示
	  * 
	  */
		public ActionForward question(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			Map user = (Map) request.getSession().getAttribute("QUser");
			try {
				if (user == null) {
					response.getWriter().print("0");
					// request.setAttribute("status","0");
				} else {

					String userid = user.get("userid").toString();
					String proid = request.getParameter("proid");
					String content = request.getParameter("content");
					String id = request.getParameter("id");
					DealBiz dbiz = new DealBiz();
					Map map = dbiz.getProDetail(proid);
					if (id == null || "".equals(id)) {
						dbiz.insertComm(proid, userid, content);
						response.getWriter().print("1");
					} else {
						if ((map.get("userid").toString()).equals(userid)) {
							dbiz.insertComm(proid, userid, content, id);
							response.getWriter().print("2");
						} else {
							response.getWriter().print("3");
						}
					}
				}
			} catch (Exception e) {
				System.out.print("系统异常：" + e.getMessage());
			}
			return null;

		}
	/*
	 * 判断用户是否登录，如果登录是否预约
	 * 
	 */
		public ActionForward isLogin(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			Map user = (Map) request.getSession().getAttribute("QUser");
			String proid=request.getParameter("proid");
			DealBiz dbiz = new DealBiz();
			String prouserid=dbiz.getProUserid(proid);
	
			try {
				if (user == null) {
					response.getWriter().print("0");
				} else {
					
					String userid=user.get("userid").toString();
					if(userid.equals(prouserid)){
						response.getWriter().print("0");
					}else{
					
					Boolean bl=dbiz.login(userid, proid);
					if(bl){
						response.getWriter().print("1");
					}else{
						response.getWriter().print("2");
					}	
					}
				}
			} catch (Exception e) {
				System.out.print("系统异常：" + e.getMessage());
			}

			return null;
		}
		/*
		 * 预约操作
		 * 
		 */
		public ActionForward orderLt(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			Map user = (Map) request.getSession().getAttribute("QUser");
			String proid=request.getParameter("proid");
			String money=request.getParameter("money");
			String comm =request.getParameter("ordercomm");
			String userid =user.get("userid").toString();
			try{
			DealBiz dbiz = new DealBiz();
			String financialneeds= dbiz.getFinancialneeds(proid);
			String mininvestment=dbiz.getMininvestment(proid);
			 if(Integer.parseInt(money)<=Integer.parseInt(financialneeds)&&Integer.parseInt(money)>=Integer.parseInt(mininvestment)){
				 dbiz.addOrder(proid, userid, money, comm);
			   response.getWriter().print("{\"status\":true,url:\""+request.getContextPath() +"/deal/proDetail/"+proid+".html\"}");
			 }else if(Integer.parseInt(money)>Integer.parseInt(financialneeds)){
				 response.getWriter().print("{\"status\":false,errortext:\"预约金额不能大于融资金额\"}");
			 }else {
				 response.getWriter().print("{\"status\":false,errortext:\"预约金额应大于等于最低投资金额\"}");
			 }
			}catch (Exception e) {
				 response.getWriter().print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
			}
		    //	System.out.println("2222");
			// return mapping.findForward("prodetail");
			return null;
		}
		/*
		 * 取消预约
		 * 
		 */
		public ActionForward cancel(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			Map user = (Map) request.getSession().getAttribute("QUser");
			String proid=request.getParameter("proid");
			String userid =user.get("userid").toString();
			try{
			DealBiz dbiz = new DealBiz();
			dbiz.cancelOrder(proid, userid);
			response.getWriter().print("{\"status\":true,url:\""+request.getContextPath() +"/deal/proDetail/"+proid+".html\"}");
			}catch (Exception e) {
				 response.getWriter().print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
			}
			return null;
		}
		/*
		 * 关键字模糊查找项目
		 * 
		 */
		public ActionForward search(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			String c = request.getParameter("c"); // 获取类型表的id
			String x = request.getParameter("x");// 获取排序类型
			String p = request.getParameter("p");
			request.setAttribute("c", c);
			request.setAttribute("x", x);
			PageInfo pageinfo = new PageInfo();
			pageinfo.setCurrentPage(p);
			pageinfo.setPageSize(40);
			String name=request.getParameter("q");  //获取输入的关键词
			
	     	DealBiz dbiz = new DealBiz();
			List list =dbiz.searchPros(name,pageinfo);
			request.setAttribute("list", list);
			String count = dbiz.getZhongChouing();
			String count1 = dbiz.getAll();
			String count2 = dbiz.getSuccessed();
			String count3 = dbiz.getWillStart();
			List cate = dbiz.getTypeName();
			request.setAttribute("cate", cate);
			request.setAttribute("count", count); // 众筹中项目数量
			request.setAttribute("count1", count1); // 所有项目数量
			request.setAttribute("count2", count2); // 已成功项目数量
			request.setAttribute("count3", count3); // 即将开始项目数量
			request.setAttribute("pageinfo", pageinfo);
			return mapping.findForward("allpros");
			
		}
		public ActionForward docList(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			String id=request.getParameter("id");
			DealBiz dbiz=new DealBiz();
			Map map =dbiz.getDoc(id);
			request.setAttribute("doc", map);
			return  mapping.findForward("about");
			
		}
		
}
