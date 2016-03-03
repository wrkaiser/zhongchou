<%@page import="com.xiaoyou.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@page import="com.xiaoyou.data.PageInfo"%>
<%@page import="com.xiaoyou.util.JsonUtils"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="com.xiaoyou.util.EncodeAndDecode"%>
<%
	Map User = (Map) session.getAttribute("QUser");
	if (User == null) {
		response.sendRedirect(request.getContextPath() + "/log.jsp");
		return;
	}
	String userid = (String) User.get("userid");

	String sql = "";
	BaseDao dao = new BaseDao();
	String m = request.getParameter("m");
	if (m != null && m.equals("update")) {
		String old_password = request.getParameter("old_password");
		String new_password = request.getParameter("new_password");
		String confirm_password = request
				.getParameter("confirm_password");
		sql = "select password from zh_users where userid=" + userid;
		EncodeAndDecode encode = new EncodeAndDecode();
		Map pwd = dao.queryone(sql);
		String password = pwd.get("password").toString(); //获取Map中的password属性，转换为String类型
		try {
			if (old_password == null || "".equals(old_password)
					|| !encode.decrypt(password).equals(old_password)) {
				out.print("{status:false,errortext:\"旧密码输入错误！\"}");
				return;
			}
			if (!new_password.equals(confirm_password)) {
				out.print("{status:false,errortext:\"新密码输入不一致！\"}");
				return;
			}
		} catch (Exception e) {
			out.print("{status:false,errortext:\"系统异常："
					+ e.getMessage() + "\"}");
			return;
		}
		sql = "update zh_users set password='"
				+ encode.encrypt(new_password) + "' where  userid="
				+ userid;
		dao.update(sql);
		out.print("{status:false,errortext:\"修改成功！\"}");
		return;

	}
%>
<jsp:include page="../common.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_设置</title>
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
	<link rel="stylesheet" type="text/css"
		href="css/control.css?v=20141112">
	<!--main content-->
	<form
		action="${pageContext.request.contextPath}/center/changepwd.jsp?m=update"
		method="post" name="changepwd" wx-validator wx-validator-ajax>
		<div class="bg-grey bg-grey-padding clearfix">

			<div class="wrap">
				<div class="user_l">
					<div class="head-info">
						<a href="javascript:void(0);" class="head-box"><img
							src="${QUser.headimg==null||QUser.headimg==''?'images/user/defaultUser1.png?v=20141112':QUser.headimg}" /></a>
						<p class="user-name">${QUser.username}</p>
						<div class="clearfix project-action">
							<p class="p-wf p-l">
							<!-- 	<a href="/investor/chosetype" class="identiy">实名认证</a> --> <a
									href="${pageContext.request.contextPath}/center/myinfo.shtml"
									class="person-info">个人资料</a>
							</p>
							<p class="p-wf p-r">
								<a
									href="${pageContext.request.contextPath}/center/changepwd.shtml"
									class="set">设置</a><!--  <a href="/my/msg" class="message">消息</a> -->
							</p>
						</div>
					</div>
					<div class="project-info">
						<ul>
							<li><a
								href="${pageContext.request.contextPath}/center/deal.shtml">我的项目</a></li>
							<li><a
								href="${pageContext.request.contextPath}/center/myorder.shtml">我预约的项目</a></li>
							<!-- <li><a href="/my/invest/f_status/2">我认购的项目</a></li> -->
							<li><a
								href="${pageContext.request.contextPath}/center/mycollect.shtml">关注的项目</a></li>
							<!-- <li><a href="/invation/index">邀请码</a></li> -->
						</ul>
					</div>
				</div>
				<div class="user_r">
					<ul class="authen-hd clearfix">
						<li><a style="display: block; width: 148px"
							href="${pageContext.request.contextPath}/center/myinfo.shtml">用户资料设置</a></li>
						<!-- 	<li><a style="display: block; width: 148px"
							href="${pageContext.request.contextPath}/center/settbankcard.jsp">银行卡</a></li> -->
						<li class="selected"><a style="display: block; width: 148px"
							href="${pageContext.request.contextPath}/center/changepwd.shtml">修改密码</a></li>
					</ul>
					<div class="form-wrap">
						<div class="form-list form-list-phone">
							<label for="">旧密码<i>＊</i></label>
							<div class="inp">
								<input wx-validator-rule="required" name="old_password"
									wx-validator-param="|" id="old_password" type="password"
									placeholder="" value="">
								<div class="clearfix"></div>
								<div class="validate-msg" id="wx-validator-phone-required">不能为空</div>
							</div>
						</div>
						<div class="form-list form-list-phone">
							<label for="">新密码<i>＊</i></label>
							<div class="inp">
								<input wx-validator-rule="required" name="new_password"
									wx-validator-param="|" id="new_password" type="password"
									placeholder="" value="">
								<div class="clearfix"></div>
								<div class="validate-msg" id="wx-validator-phone-required">不能为空</div>

							</div>
						</div>
						<div class="form-list form-list-phone">
							<label for="">确认密码<i>＊</i></label>
							<div class="inp">
								<input wx-validator-rule="required" name="confirm_password"
									wx-validator-param="|" id="confirm_password" type="password"
									placeholder="" value="">
								<div class="clearfix"></div>
								<div class="validate-msg" id="wx-validator-phone-required">不能为空</div>
							</div>
						</div>
						<div class="save-next">
							<a type="submit" class="btn bg-orange">保存</a>
						</div>
					</div>
				</div>
			</div>

		</div>
	</form>

	<script src="js/user.js?v=20141112"></script>
	<!--footer static-->
	<jsp:include page="../foot.jsp" />
	<!--footer end-->


</body>
</html>



