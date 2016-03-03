<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/Login.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/vilidate.js?02"></script>
<title>众筹网后台管理系统</title>
</head>
<body>
<div id="webtitle">众筹网后台管理系统</div>
<div id="page">
 <form action="${pageContext.request.contextPath}/mem/login.html" target="_parent" onsubmit="return exresultcheck();" method="post">
  <div class="login_con">
     <p><span>用户名</span><input type="text" class="input_zh" value="${empty muserform ? '':muserform.username}" name="username" check=".+" msg="用户名不能为空" datatype="Require"/></p>
     <p><span>密码&nbsp;&nbsp;&nbsp;</span><input type="password" name="password" check=".+" msg="密码不能为空" datatype="Require" value="" class="input_mm" /></p>
    
     <p class="erro_info">
  <logic:notEmpty name="nameerror">
    *${nameerror}
   </logic:notEmpty>
<logic:notEmpty name="passerror">
   *${passerror}
   </logic:notEmpty>
    </p>
     <p class="bt"><input type="submit" value="登录" /></p>
  </div>
    </form>
</div>
<div id="webinfo">
网站管理系统 联系我们:wrkaiser@163.com
</div>
</body>
</html>
