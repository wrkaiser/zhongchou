<%@page import="com.xiaoyou.util.JsonUtils"%><%@page import="java.util.HashMap"%><%@page import="java.util.Map"%><%@page import="com.xiaoyou.dao.BaseDao"%><%@page import="com.xiaoyou.util.EncodeAndDecode"%><%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%><%
String m=request.getParameter("m");
if(m!=null){
	if("login".equals(m)){
		response.setContentType("text/html; charset=utf-8");
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String remember=request.getParameter("remember");
		if("".equals(password)){
			out.print("{status:false,errortext:\"密码不能为空！\"}");
			return;
		}
		if("".equals(username)){
			out.print("{status:false,errortext:\"请输入手机号！\"}");
			return;
		}
		
		String sql="select * from zh_users where telno='"+username+"'";
		BaseDao dao=new BaseDao();
		try{
			Map user=dao.queryone(sql);
		    if(user!=null&&user.size()>0){
		    	EncodeAndDecode encode=new EncodeAndDecode();
		    	if(encode.encrypt(password).equals(user.get("password").toString())){
		    		if("0".equals(user.get("ischecked").toString())){
		    			out.print("{\"status\":false,errortext:\"您的账号已被禁用,请联系管理员！\"}");
		    			return;
		    		}
		    		if("1".equals(remember)){
		    			Map uinfo=new HashMap();
		    			uinfo.put("username", username);
		    			uinfo.put("userid", user.get("userid"));
		    			uinfo.put("password", user.get("password"));
		    			uinfo.put("headimg", user.get("headimg"));
		    			Cookie cookie=new Cookie("_uinf_",encode.encrypt(JsonUtils.mapToJson(user)));
		    			cookie.setPath("/");
		    			//cookie.setDomain("iidaxue.com");
		    			cookie.setMaxAge(7*24*60*60);//保存7天
		    			response.addCookie(cookie);//保存用户信息
		    		}
		    		session.setAttribute("QUser", user);
		    		out.print("{\"status\":true,url:\"center/deal.jsp\"}");
		    	}else{
		    		out.print("{\"status\":false,errortext:\"密码错误！\"}");
		    	}
				return;
		    }else{
		    	out.print("{\"status\":false,errortext:\"用户不存在！\"}");
		    }
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
	}else if("logout".equals(m)){
		Cookie cookie=new Cookie("_uinf_",null);
		cookie.setPath("/");
		//cookie.setDomain("iidaxue.com");
		cookie.setMaxAge(0);//保存7天
		response.addCookie(cookie);//保存用户信息
		session.setAttribute("QUser", null);
		response.sendRedirect("");
	}
}
%>
<jsp:include page="common.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}</title>
<meta name="keywords" content="${pageinfio.keywords}"/>
<meta name="description" content="${pageinfio.description}"/>
<link rel="shortcut icon" href="img/favicon.ico"/>
<!--public js&css start-->
<link href="css/base.css?v=20150309" rel="stylesheet" type="text/css">
<link href="css/common.css?v=20150309" rel="stylesheet" type="text/css">
<script src="js/jquery-1.8.2.js?v=20150309"></script>
<script src="js/common.js?v=20150309"></script>
<script src="js/json2.js?v=20150309"></script>
</head>

<body>
<!--header static-->
<jsp:include page="top.jsp"/>
<!--header end--><!--banner static-->
<link rel="stylesheet" type="text/css" href="css/login_register.css?v=20150309">
<div class="wrap">
	<div class="logo-content">
	  <p class="login_logo"><img src="images/zhongchou.jpg"></p>
	  <div class="logo_form">
	  	<h5 class="clearfix"><span>登录</span> <em>没有账号，<a href="reg.shtml">马上注册</a></em></h5>
	  	<form action="log.shtml" name="loginForm2" wx-validator="" wx-validator-ajax="" wx-validator-single-error="error" autocomplete="off">
	  	<input name="m" value="login" type="hidden">
	  		<div id="error" class="error-text"></div>
	  		<input type="text" name="username" wx-validator-username-required="手机号不能为空" wx-validator-rule="required" wx-validator-placeholder="手机号" placeholder="手机号">
	  		<input type="password" name="password" wx-validator-password-required="密码不能为空" wx-validator-rule="required" wx-validator-placeholder="密码" placeholder="密码">
	        <p class="verifity-code clearfix hidden">
	          <input type="text" name="verify" disabled="disabled" wx-validator-placeholder="请输入图形验证码" wx-validator-verify-required="图形验证码不能为空" placeholder="请输入图形验证码">
	          <img src="ImageServlet" id="codeImg" onclick="this.src='ImageServlet?t='+new Date().getTime()">
	        </p>
            <p>
                <input type="checkbox" name="remember" value="1">记住用户
            </p>
        	<span id="wx-validator-verify-required" class="error-text hidden">不能为空</span>
	  		<p class="p-login"><a href="javascript:;" type="submit" class="a-login-btn">立即登录</a>
	  		<!-- 
	  		<a href="/findpwd/index" class="forget-password">忘记密码</a> --></p>
	  	</form>
	  </div>
    </div>
</div>

<!--footer static-->
<jsp:include page="foot.jsp"/>
<!--footer static-->
</body>
</html> 

