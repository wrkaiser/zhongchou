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
	if (User == null) {
		response.sendRedirect(request.getContextPath() + "/log.jsp");
		return;
	}
	String userid = (String) User.get("userid");
	String sql = "";
	BaseDao dao = new BaseDao();
	PageInfo pageinfo = new PageInfo();
	String p = request.getParameter("p");
	pageinfo.setPageSize(5);
	String m  = request.getParameter("m");
	if(m!=null&&m.equals("select")){
		String ischecked=request.getParameter("ischecked");
		pageinfo.setQueryStr("zh_pros.userid="
				+ userid
				+ " and zh_pros.userid=zh_users.userid and zh_pros.ischecked="+ischecked+"  order by  zh_pros.addtime");
		List<Map> list = dao.getListByPage("zh_pros , zh_users ",
				"zh_pros.*", pageinfo);
		pageinfo.setCurrentPage(p);
		request.setAttribute("list", list);
		request.setAttribute("pageinfo", pageinfo);
	
	}else{
	pageinfo.setQueryStr("zh_pros.userid="
			+ userid
			+ " and zh_pros.userid=zh_users.userid order by  zh_pros.addtime");
	pageinfo.setCurrentPage(p);
	List<Map> list = dao.getListByPage("zh_pros , zh_users ",
			"zh_pros.*", pageinfo);
	request.setAttribute("list", list);
	request.setAttribute("pageinfo", pageinfo);
	
	}
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
<style type="text/css">
.cell02 {
width: 314px;
padding-right: 20px;
}
</style>
</head>

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
							<!-- <a href="/investor/chosetype" class="identiy">实名认证</a> -->
							 <a href="${pageContext.request.contextPath}/center/myinfo.shtml" class="person-info">个人资料</a>
						</p>
						<p class="p-wf p-r">
							<a href="${pageContext.request.contextPath}/center/changepwd.shtml" class="set">设置</a> 
							<!-- <a href="/my/msg"
								class="message">消息</a> -->
						</p>
					</div>
				</div>
				<div class="project-info">
					<ul>
						<li class="selected selected-radius-t"><a href="${pageContext.request.contextPath}/center/deal.shtml">我的项目</a></li>
						<li><a
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
					<li class="cell04 js-show-menu cell04-title"><a> 全部 <i
							class="up"></i></a>
						<ul class="menu-drop">
							<li class="type-default"><a href="${pageContext.request.contextPath}/center/deal.shtml">全部</a></li>
							<li><a href="${pageContext.request.contextPath}/center/deal.shtml?m=select&ischecked=0">未发布</a></li>
							<li><a href="${pageContext.request.contextPath}/center/deal.shtml?m=select&ischecked=1">审核中</a></li>
							<li><a href="${pageContext.request.contextPath}/center/deal.shtml?m=select&ischecked=2">预约中</a></li>
							<li><a href="${pageContext.request.contextPath}/center/deal.shtml?m=select&ischecked=3">发行中</a></li>
							<li><a href="${pageContext.request.contextPath}/center/deal.shtml?m=select&ischecked=4">已结束</a></li>
							<li><a href="${pageContext.request.contextPath}/center/deal.shtml?m=select&ischecked=5">未通过</a></li>
						</ul></li>
					<li class="cell06">操作</li>
				</ul>
				<logic:notEmpty name="list">
					<logic:iterate id="l" name="list">

						<div class="project-list-content clearfix">
							<ul>
								<li class="cell01"><a target="_blank"
									href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html"><img
										src="${l.proimg}" /></a></li>
								<li class="cell02">
									<h4>
										<a target="_blank"
											href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html">${l.proname}</a>
									</h4> <!-- <span>test111</span> -->
								</li>
								<li class="cell03"><em>${l.financialneeds}万</em>
								<p></p></li>
								<li class="cell04">
								<c:if test="${l.ischecked==0 }">未发布</c:if>
								<c:if test="${l.ischecked==1 }">审核中</c:if>
								<c:if test="${l.ischecked==2 }">预约中</c:if>
								<c:if test="${l.ischecked==3 }">发行中</c:if>
								<c:if test="${l.ischecked==4 }">已结束</c:if>
								<c:if test="${l.ischecked==5 }">未通过</c:if>
								</li>
								<li class="cell07"><a target="_blank"
									href="center/newdeal.shtml?proid=${l.proid}&m=detail" >修改项目</a>
									<c:if test="${l.ischecked==2 }"><a 
									href="${pageContext.request.contextPath}/center/orderperson.shtml?proid=${l.proid}&m=select" >预约的人</a>
									</c:if>
								  <c:if test="${l.ischecked==3 }"><a 
									href="${pageContext.request.contextPath}/center/orderperson.shtml?proid=${l.proid}&m=select" >预约的人</a>
									</c:if>
									 <c:if test="${l.ischecked==4 }"><a 
									href="${pageContext.request.contextPath}/center/orderperson.shtml?proid=${l.proid}&m=select" >预约的人</a>
									</c:if>
									</li>
							</ul>

						</div>
					</logic:iterate>
				</logic:notEmpty>
				<logic:greaterThan value="1" name="pageinfo" property="totalPages">
					<mytag:commonpage currentPage="${pageinfo.currentPage}"
						totalPages="${pageinfo.totalPages}"
						totalRows="${pageinfo.totalRows}"
						url="${pageContext.request.contextPath}/center/deal.jsp?"
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



