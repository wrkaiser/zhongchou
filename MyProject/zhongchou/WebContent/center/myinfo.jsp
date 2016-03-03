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
	String m = request.getParameter("m");
	if (m != null && m.equals("update")) {
		String image = request.getParameter("user_avatar");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String telno = request.getParameter("phone");
		String username = request.getParameter("user_name");
		try {
			sql = "update zh_users set username='" + username
					+ "', telno='" + telno + "', province='" + province
					+ "', city='" + city + "' ,headimg='" + image
					+ "' where userid=" + userid;
			dao.update(sql);
			sql = "select * from zh_users where userid=" + userid;
			Map user = dao.queryone(sql);
			session.setAttribute("QUser", user);
		} catch (Exception e) {
			out.print("{status:false,errortext:\"系统异常："
					+ e.getMessage() + "\"}");
		}
		out.print("{status:false,errortext:\"修改成功！\"}");
		return;
	}
	sql = "select * from zh_users where userid=" + userid;
	Map map = dao.queryone(sql);
	request.setAttribute("map", map);
%>
<jsp:include page="../common.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_我的资料</title>
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
	<link rel="stylesheet" type="text/css" href="css/user.css?v=20141112">
	<link rel="stylesheet" type="text/css"
		href="${pageContext.request.contextPath}/css/control.css?v=20141112">
	<script type="text/javascript" src="js/control/region.js?v=20141112"></script>
	<script type="text/javascript"
		src="js/control/multi_input.js?v=20141112"></script>
	<script type="text/javascript"
		src="js/control/multi_input_table.js?v=20141112"></script>
	<script type="text/javascript"
		src="js/control/education_background.js?v=20141112"></script>
	<script type="text/javascript"
		src="js/control/work_experience.js?v=20141112"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/wx.upload.js?v=20141112" ></script>
	<script type="text/javascript"
		src="js/control/member_info.js?v=20141112"></script>
	<script type="text/javascript" src="js/control/controls.js?v=20141112"></script>
	<!--main content-->
	<div class="bg-grey bg-grey-padding">
		<div class="wrap clearfix">
			<div class="user_l">
				<div class="head-info">
					<a href="javascript:void(0);" class="head-box"><img
						src="${QUser.headimg==null||QUser.headimg==''?'images/user/defaultUser1.png?v=20141112':QUser.headimg}" /></a>
					<p class="user-name">${QUser.username}</p>
					<div class="clearfix project-action">
						<p class="p-wf p-l">
							<!-- <a href="/investor/chosetype" class="identiy">实名认证</a>  -->
							<a href="${pageContext.request.contextPath}/center/myinfo.shtml"
								class="person-info">个人资料</a>
						</p>
						<p class="p-wf p-r">
							<a href="${pageContext.request.contextPath}/center/changepwd.shtml" class="set">设置</a> 
							<!-- <a href="/my/msg"  class="message">消息</a> -->
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
					<!-- 	<li><a href="/invation/index">邀请码</a></li> -->
					</ul>
				</div>
			</div>
			<div class="user_r">
				<ul class="authen-hd clearfix">
					<li class="selected"><a
						style='display: block; width: 148px'
						href="${pageContext.request.contextPath}/center/myinfo.shtml">用户资料设置</a></li>
			<!--  		<li><a style='display: block; width: 148px'
						href="${pageContext.request.contextPath}/center/settbankcard.shtml">银行卡</a></li>-->
					<li><a style='display: block; width: 148px'
						href="${pageContext.request.contextPath}/center/changepwd.shtml">修改密码</a></li>
				</ul>
				<div class="form-wrap">
					<form id='user_settings' name='user_settings' wx-validator
						wx-validator-ajax
						action='${pageContext.request.contextPath}/center/myinfo.jsp?m=update'
						method='post' autocomplete='off' wx-validator-noscroll>
						<div class="form-list">
							<label for="">上传头像<i>＊</i></label>
							<div class="inp add-list-control clearfix">
								<div class="fl">
									<input type="file" wx-upload-size="8" wx-upload="Upload"
										name="user_avatar_wxupload" wx-upload-param="type=thumb&amp;"
										wx-upload-assign="user_avatar=data.fileUrl"
										wx-upload-set="user_avatar_img=data.fileUrl" hidefocus="true"></input>

									<input type="hidden" wx-validator-rule='required'
										class="picarr" name="user_avatar" id='user_avatar' value="${map.headimg==null||map.headimg==''?'images/user/defaultUser1.png?v=20141112':map.headimg}"></input>
									<div class="add-btn"></div>
								</div>
								<div class="fl">

									<em class="tag">＊图片大小请勿超过8MB</em>
								</div>
							</div>
							<div class="picul inp clearfix" id='user_avatar_picul'>
								<span id='user_avatar_span'><img class='imgarr'
									name="image"
									src="${map.headimg==null||map.headimg==''?'images/user/defaultUser1.png?v=20141112':map.headimg}" /><i
									class="picul-del">删除</i></span>

								<div class='clearfix'></div>
								<div class='validate-msg' id="wx-validator-user_avatar-required"
									style="color: red; display: none;">不能为空</div>
							</div>
							<div class="prompt">
								<i></i>
								<div class="sub">
									<div>请上传用户头像，支持jpg、jpeg、png格式的图片，尺寸50*50</div>
								</div>
							</div>

						</div>
						<script>
							function user_avatarsetVal() {
								var val = [];
								$("#user_avatar_picul").find("img").each(
										function() {
											val.push($(this).attr('src'));
										});
								$("#user_avatar").val(val.join(","));
							}

							//删除图片
							$("#user_avatar_picul").find("span").click(
									function() {
										$(this).remove();
										user_avatarsetVal();
									});

							function user_avatar_wxupload(data) {
								$("#Js-shadeLayer").remove();
								$("#Js-pop-body").remove();
								if (!data.status)
									wx.alert(data.usercode);
								if ($('#user_avatar_picul').find("img").length > 0) {
									$("#user_avatar_picul").find("img").attr(
											"src", data.img);//find()方法遍历
								} else {
									$('#user_avatar_picul')
											.append(
													'<span><img src="'+data.img+'" /><i class="picul-del">删除</i></span>');
								}
								$("#user_avatar_picul").find("span").click(
										function() {
											$(this).remove();
											user_avatarsetVal();
										});
								user_avatarsetVal();
								$("#user_avatar_span").show();
								
							}
						</script>
						<div class="form-list">
							<label for="">所在城市<i>＊</i></label>
							<div class='inp'>
								<div id="address_region_selector" class="clearfix padding-0">
								</div>
								<input type='hidden' wx-validator-rule='required' name='address'
									wx-validator-param='' id='address' type="text"
									placeholder="具体地址" value=''>

								<div class=''>
									<div class='clearfix'></div>
									<div class='validate-msg' id="wx-validator-address-required">不能为空</div>

								</div>
							</div>
						</div>
						<script>
							$("#" + "address_region_selector").city_selector(
									'address', "${map.province},${map.city}");
						</script>
						<div class="form-list form-list-phone">
							<label for="">手机号<i>＊</i></label>
							<div class="inp">
								<input wx-validator-rule='required|mobile' name='phone'
									wx-validator-param='|' id='phone' type="text" placeholder=""
									value='${map.telno }'>
								<div class='clearfix'></div>
								<div class='validate-msg' id="wx-validator-phone-required">不能为空</div>
								<div class='validate-msg' id="wx-validator-phone-mobile">请填写正确的手机号码</div>

							</div>
						</div>
						<div class="form-list form-list-user_name">
							<label for="">用户名<i>＊</i></label>
							<div class="inp">
								<input wx-validator-rule='required|minLength' name='user_name'
									wx-validator-param='|2' id='user_name' type="text"
									placeholder="请输入用户名" value='${map.username }'>
								<div class='clearfix'></div>
								<div class='validate-msg' id="wx-validator-user_name-required">不能为空</div>
								<div class='validate-msg' id="wx-validator-user_name-minLength">用户名不能少于两个汉字或字符</div>

							</div>
							<div class="prompt">
								<i></i>
								<div class="sub">
									<div>不能用数字和特殊符号开头，且大于两位</div>
								</div>
							</div>
						</div>
						<div class="save-next">
							<a type="submit" type="submit" class="btn bg-orange">保存</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--main content-->
	<!--footer static-->
	<jsp:include page="../foot.jsp" />

</body>
</html>


