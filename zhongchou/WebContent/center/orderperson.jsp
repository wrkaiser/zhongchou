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
	String m = request.getParameter("m");
	pageinfo.setPageSize(5);
	if (m != null && m.equals("select")) {
		String proid = request.getParameter("proid");
		pageinfo.setQueryStr("zh_pro_orders.proid=" + proid
				+ " and zh_pro_orders.userid=zh_users.userid");
		List<Map> list = dao.getListByPage("zh_pro_orders , zh_users",
				"zh_pro_orders.*,zh_users.*", pageinfo);
		pageinfo.setCurrentPage(p);
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
<title>${pageinfio.name}_预约的人</title>
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

</head>

<body>
	<!--header static-->
	<jsp:include page="../top.jsp" />
	<!--header end-->
	<!--banner static-->
	<link rel="stylesheet" type="text/css" href="css/user.css?v=20141112">
	<!--main content-->
	<script type="text/javascript">
	var beforeId; //定义全局变量 
	function showInfoCard(thisObj,id){ 
	this.hidden(beforeId); //立刻隐藏前一个选中弹出来的div 
	beforeId = id; 
	 
	var objDiv = $("#"+id); 
	 
	$(objDiv).css("display","block"); 
	 
	$(objDiv).css("left", event.clientX-280); //弹出框的位置X值 
	 
	$(objDiv).css("top", event.clientY-10); //弹出框位置Y值 
	} 
	function hideInfoCard(id){ //隐藏div 
	//延时
	setTimeout('hidden('+id+')',200); 
	} 
	 
	function hidden(id){ 
	$("#"+id).hide(); 
	}
	
	
	</script>
	<div class="bg-grey bg-grey-padding clearfix">
		<div class="wrap">
			<div class="user_l">
				<div class="head-info">
					<a href="javascript:void(0);" class="head-box"><img
						src="${QUser.headimg==null||QUser.headimg==''?'images/user/defaultUser1.png?v=20141112':QUser.headimg}" /></a>
					<p class="user-name">${QUser.username}</p>
					<div class="clearfix project-action">
						<p class="p-wf p-l">
							<!-- <a href="/investor/chosetype" class="identiy">实名认证</a>  --><a
								href="${pageContext.request.contextPath}/center/myinfo.shtml"
								class="person-info">个人资料</a>
						</p>
						<p class="p-wf p-r">
							<a
								href="${pageContext.request.contextPath}/center/changepwd.shtml"
								class="set">设置</a> <!-- <a href="/my/msg" class="message">消息</a> -->
						</p>
					</div>
				</div>
				<div class="project-info">
					<ul>
						<li class="selected selected-radius-t"><a
							href="${pageContext.request.contextPath}/center/deal.shtml">我的项目</a></li>
						<li><a
							href="${pageContext.request.contextPath}/center/myorder.shtml">我预约的项目</a></li>
						<!-- <li><a href="/my/invest/f_status/2">我认购的项目</a></li> -->
						<li><a
							href="${pageContext.request.contextPath}/center/mycollect.shtml">关注的项目</a></li>
				<!-- 		<li><a href="/invation/index">邀请码</a></li> -->
					</ul>
				</div>
			</div>
			<div class="user_r">
				<ul class="project-list-nav clearfix">
					<li class="cell01">用户名</li>
					<li class="cell03">预约金额</li>
					<li class="cell02">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注</li>
				
				</ul>
				<logic:notEmpty name="list">
					<logic:iterate id="l" name="list">

						<div class="project-list-content clearfix">
							<ul>
								<li class="cell01">
								<label  onmouseover="showInfoCard(this,'${l.userid}')" onmouseout="hideInfoCard('${l.userid}')">
										${l.username}
								</label>
								</li>
								<li class="cell03">							
								<em> ${l.money}万</em>
									
									<!-- <span>test111</span> -->
								</li>
								<li class="cell02">
									${l.comm}
								</li>
								
							</ul>

						</div>
						<div id="${l.userid}" style="display:none; width:250px; height:150px; background-color:#D1EEEE;position:absolute;">
						   
						   <ul> <li><img  src="${l.headimg}"></img></li>
						    <li>${l.username}</li>
						    <li>${l.telno}</li>
						    <li>${l.province}</li>
						    <li>${l.city}</li>
						</ul>
						</div>
					</logic:iterate>
				</logic:notEmpty>
				<logic:greaterThan value="1" name="pageinfo" property="totalPages">
					<mytag:commonpage currentPage="${pageinfo.currentPage}"
						totalPages="${pageinfo.totalPages}"
						totalRows="${pageinfo.totalRows}"
						url="${pageContext.request.contextPath}/center/deal.jsp?"
						css="dataTables_paginate paging_full_numbers" kbdable="false" />
				</logic:greaterThan>

				<div class="dataTables_paginate paging_full_numbers">
					<span> </span>
				</div>
				<div class="line-dashed"></div>
				<div class="pager"></div>
			</div>
		</div>
	</div>

	<script src="js/user.js?v=20141112"></script>
	<!--footer static-->
	<jsp:include page="../foot.jsp" />
	<!--footer end-->


</body>
</html>



