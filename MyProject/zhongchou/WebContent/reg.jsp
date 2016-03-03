<%@page import="java.util.Map"%>
<%@page import="com.xiaoyou.dao.BaseDao"%><%@page import="com.xiaoyou.util.EncodeAndDecode"%><%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%><%
String m=request.getParameter("m");
if(m!=null){
	if("save".equals(m)){
		String mobile=request.getParameter("mobile");
		String password=request.getParameter("password");
		String confirm_user_pwd=request.getParameter("confirm_user_pwd");
		String user_name=request.getParameter("user_name");
		String verify=request.getParameter("verify");
		if("".equals(mobile)){
			out.print("{status:false,errortext:\"手机不能为空！\"}");
			return;
		}
		if("".equals(password)){
			out.print("{status:false,errortext:\"密码不能为空！\"}");
			return;
		}
		if("".equals(user_name)){
			out.print("{status:false,errortext:\"用户名不能为空！\"}");
			return;
		}
		String checkcode=(String)session.getAttribute("checkcode");
		if("".equals(verify)){
			out.print("{status:false,errortext:\"请输入图形验证码！\"}");
			return;
		}
		if(!verify.equalsIgnoreCase(checkcode)){
			out.print("{\"status\":false,errortext:\"验证码输入有误！\"}");
			return;
		}
		String sql="select * from zh_users where telno='"+mobile+"'";
		BaseDao dao=new BaseDao();
	    Map user=dao.queryone(sql);
	    if(user!=null&&user.size()>0){
	    	out.print("{\"status\":false,errortext:\"该手机号已被使用注册！\"}");
			return;
	    }
		sql="insert into zh_users(username,telno,addtime,lasttime,islogin,ischecked,password) values(?,?,unix_timestamp(),unix_timestamp(),0,1,?)";
		EncodeAndDecode encode=new EncodeAndDecode();
		password=encode.encrypt(password);
		Object[] params={user_name,mobile,password};
		try{
			dao.update(sql, params);
			sql="select * from zh_users where telno='"+mobile+"' and password='"+password+"'";
			user=dao.queryone(sql);
			if(user!=null){
				session.setAttribute("QUser", user);
			}
			out.print("{\"status\":true,url:\"center/deal.jsp\"}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
	}
}
%>
<jsp:include page="common.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_会员注册</title>
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
	<div class="register-content">
	  <div class="logo_form register_form">
	  	<h5 class="clearfix"><span>注册</span> <em>已有账号，<a href="log.shtml">立即登录</a></em></h5>
	  	<form action="reg.shtml" name="Form2" wx-validator wx-validator-ajax="" wx-validator-single-error="error">
	  	<input name="m" value="save" type="hidden">
        <div id="error" class="error-text"></div>
	  		<input type="text" name="mobile" wx-validator-rule="required|mobile" wx-validator-placeholder="手机号" wx-validator-mobile-required="手机号不能为空" wx-validator-mobile-mobile="手机号填写不正确"/>
        <input type="password" name="password" wx-validator-rule="required" wx-validator-placeholder="密码" wx-validator-password-required="密码不能为空"/>
        <input type="password" name="confirm_user_pwd" wx-validator-rule="required|equalTo" wx-validator-confirm_user_pwd-required="密码不能为空" wx-validator-param="|password" wx-validator-placeholder="确认密码"/>
        <input type="text" name="user_name" wx-validator-rule="required" wx-validator-user_name-required="用户名不能为空" wx-validator-placeholder="用户名"/>
        <span id="wx-validator-verify-required" class="error-text hidden">不能为空</span>
	  		
        <span id="wx-validator-code-required" class="error-text hidden">不能为空</span>
        <p>
                <p class="verifity-code clearfix">
         <input type="text" name="verify" wx-validator-rule="required" wx-validator-verify-required="图形验证码不能为空" wx-validator-placeholder="请输入图形验证码"/>
          <img id="codeImg" src="ImageServlet" height="40" onclick="this.src='ImageServlet?t='+new Date().getTime()">
     </p>
          <input type="checkbox" name="article" wx-validator-article-nocheck="请阅读协议"/>阅读并同意众筹平台的<a class="agreement" href="${pageContext.request.contextPath}/deal/docList/45470.html" target="_blank">《服务协议》</a>
        </p>
        <span id="wx-validator-article-nocheck" class="error-text hidden">请阅读协议</span>
	  		<a href="javascript:;" type="submit" class="a-register-btn">立即注册</a>
	  	</form>
	  </div>
    </div>
</div>

<script>

</script>
<!--footer static-->
<jsp:include page="foot.jsp"/>
<!--footer static-->
</body>
</html> 

