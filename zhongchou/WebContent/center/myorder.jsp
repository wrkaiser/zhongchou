<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<%@page import="java.util.Map"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@page import="com.xiaoyou.data.PageInfo"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	Map User = (Map) session.getAttribute("QUser");
   if(User==null){
	   response.sendRedirect(request.getContextPath()+"/log.jsp");
	   return;
   }
	String userid = (String) User.get("userid");
	String sql = "";
	BaseDao dao = new BaseDao();
	PageInfo pageinfo = new PageInfo();
    String p = request.getParameter("p");
	pageinfo.setPageSize(5);
	String m = request.getParameter("m");
	if (m != null) {
		if (m.equals("update")) {
			String comm=request.getParameter("comm");
			String money=request.getParameter("money");

			try{
				if("".equals(money)||!money.matches("[0-9]+")){
					out.print("{status:false,errortext:\"请重新输入！！\"}");
					return;
				}
			}catch(Exception e){
				out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
				}
			String orderId = request.getParameter("orderId");
			sql = "update zh_pro_orders set comm='"
					+comm  + "',money="
					+ money + " where id="
					+ orderId;
			dao.update(sql);
			out.print("{\"status\":true,url:\"center/myorder.jsp\"}");
			return;
		}
		if (m.equals("delete")) {
			String proid = request.getParameter("proid");
			String id = request.getParameter("id");
			sql = "delete  from zh_pro_orders where proid=" +proid
					+ " and  userid=" + userid;
			dao.delete(sql);

		}
	}
	pageinfo.setQueryStr("zh_pro_orders.userid="
			+ userid
			+ " and zh_pros.userid=zh_users.userid and zh_pro_orders.proid=zh_pros.proid order by  zh_pros.addtime");
	pageinfo.setCurrentPage(p);
	List<Map> list = dao.getListByPage("zh_pros , zh_pro_orders,zh_users ",
			"zh_pros.*,zh_pro_orders.money,zh_pro_orders.id,zh_users.username,round(zh_pro_orders.money/zh_pros.financialneeds*zh_pros.transferratio,2) bili", pageinfo);
	request.setAttribute("list", list);
	request.setAttribute("pageinfo", pageinfo);
%>
<jsp:include page="../common.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_我的项目</title>
<meta name="keywords" content="${pageinfio.keywords}" />
<meta name="description" content="${pageinfio.description}" />
<link rel="shortcut icon" href="img/favicon.ico" />
<!--public js&css start-->
<link href="css/ubase.css?v=20141112" rel="stylesheet" type="text/css">
<link href="css/common.css?v=20141112" rel="stylesheet" type="text/css">
<script src="js/jquery-1.8.2.js?v=20141112"></script>
<script src="js/wx.js?v=20141112"></script>
<script src="js/wx.config.js?v=20141112"></script>
<script src="js/common.js?v=20141112"></script>
<script src="js/json2.js?v=20141112"></script>
<link rel="stylesheet" type="text/css" href="css/user.css?v=20141112">
</head>
<style type="text/css">
   .cell05{
      width:105px;
   }

</style>

<body>
	<!--header static-->
	<jsp:include page="../top.jsp" />
	<!--header end-->
	<!--banner static-->
	
	<!--main content-->
	<div class="bg-grey bg-grey-padding clearfix">
		<div class="wrap">
			<div class="user_l">
				<div class="head-info">
					<a href="javascript:void(0);" class="head-box"><img
						src="${QUser.headimg==null||QUser.headimg==''?'images/user/defaultUser1.png?v=20141112':QUser.headimg}" /></a>
					<p class="user-name">${QUser.username}</p>
					<div class="clearfix project-action">
						<p class="p-wf p-l">
							<!-- <a href="" class="identiy">实名认证</a> --> <a
								href="${pageContext.request.contextPath}/center/myinfo.shtml" class="person-info">个人资料</a>
						</p>
						<p class="p-wf p-r">
							<a href="${pageContext.request.contextPath}/center/changepwd.shtml" class="set">设置</a> <!-- <a href="/my/msg"
								class="message">消息</a> -->
						</p>
					</div>
				</div>
				<div class="project-info">
					<ul>
						<li><a href="${pageContext.request.contextPath}/center/deal.shtml">我的项目</a></li>
						<li class="selected "><a
							href="${pageContext.request.contextPath}/center/myorder.shtml">我预约的项目</a></li>
						<!-- <li><a href="/my/invest/f_status/2">我认购的项目</a></li> -->
						<li><a href="${pageContext.request.contextPath}/center/mycollect.shtml">关注的项目</a></li>
						<!-- <li><a href="/invation/index">邀请码</a></li> -->
					</ul>
				</div>
			</div>

			<div class="user_r">
				<ul class="project-list-nav clearfix">
					<li class="cell01">项目</li>
					<li class="cell02">项目名称</li>
					<li class="cell03">筹资目标</li>
					<li class="cell03">预约金额</li>
					<li class="cell05">发起人</li>
					<li class="cell07">操作</li>
				</ul>
				<logic:notEmpty name="list">
					<logic:iterate id="l" name="list">
						<div class="project-list-content clearfix">

							<ul class="clearfix">
								<li class="cell01"><a target="_blank"
									href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html"><img src="${l.proimg }"></a></li>
								<li class="cell02">
									<h4>
										<a target="_blank" href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html">${l.proname
											}</a>
									</h4>
								</li>
								<li class="cell03"><em>${l.financialneeds}万元</em>
									<p>出让股份:<br/>${l.transferratio}%</p></li>
								<li class="cell03"><em>${l.money }万元</em>
									<p>
									  占股比例:<br/> ${l.bili }%
									</p>
								</li>
								<li class="cell05">${l.username }</li>
							
								<li class="cell07"><a class="js-cancel-pre" data-id="6398"
									data-dealid="5524"
									href="${pageContext.request.contextPath }/center/myorder.jsp?m=delete&proid=${l.proid}">取消预约</a>
									<a class="js-change-pre" data-id="${l.id }"
									data-dealid="${l.id }">变更预约</a> <!-- <a href="/">我要预约</a> --></li>
							</ul>
							<div></div>
							<!-- <input value="8" type="hidden" class="zgbcs">-->

						</div>
					</logic:iterate>
				</logic:notEmpty>
				<logic:greaterThan value="1" name="pageinfo" property="totalPages">
					<mytag:commonpage currentPage="${pageinfo.currentPage}"
						totalPages="${pageinfo.totalPages}"
						totalRows="${pageinfo.totalRows}"
						url="${pageContext.request.contextPath}/center/myorder.jsp?"
						css="pager" kbdable="false" />
				</logic:greaterThan>

			</div>
		</div>
	</div>

	<script src="js/user.js?v=20141112"></script>
	<!--footer static-->
	<jsp:include page="../foot.jsp" />
	<!--footer end-->


</body>
</html>



