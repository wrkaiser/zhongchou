<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib prefix="m" uri="http:/www.xiaoyou.tag/mytag/common_lib" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_responsive_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/style.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/todc_bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/themes.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/inside.css" media="all">
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jQuery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/bootstrap_min.js"></script></style>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/inside.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/bootstrap_min.js"></script></style>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_validate_min.js?2013-11-25-1"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_validate_methods.js?2013-11-25-1"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_form_min.js?2013-11-25-1"></script>

<script type="text/javascript">
	$(function(){
	   $("select[name='role']").val('${detail.role}');
	});
</script>
<title>汇鑫—国内最大的客户管理系统</title>
<!--[if IE 7]><link href="http://stc.weimob.com/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
</head>
<body>
	
    <div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">
                    <div class="box">
                        <div class="box-title">
                            <div class="span10">
                                <h3><i class="icon-edit"></i>添加账号</h3>
                            </div>
                            <div class="span2"><a class="btn" href="Javascript:window.history.go(-1)">返回</a></div>
                        </div>

                        <div class="box-content">


                            <form action="${pageContext.request.contextPath}/back/user.do?m=update" method="post" class="form-horizontal form-validate">
                              <input type="hidden" name="userid" value="${empty detail ? 0:detail.userid }" />
                              <input type="hidden" name="headimg" value="" />
                                <div class="control-group">
                                    <label for="username" class="control-label">账号名称：</label>
                                    <div class="controls">
                                        <input type="text" name="username" id="name" class="input-medium" value="${detail.username}" data-rule-required="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                <div class="control-group">
                                    <label for="realname" class="control-label">真实姓名：</label>
                                    <div class="controls">
                                        <input type="text" name="realname" id="realname" class="input-medium" value="${detail.realname}" data-rule-required="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                 <div class="control-group">
                                    <label for="password" class="control-label">账号密码：</label>
                                    <div class="controls">
                                        <input type="password" name="password" id="password" class="input-medium"  value="${detail.password}"  /><span class="maroon">*默认密码111111</span>
                                    </div>
                                </div>
                               
                                
                                 <div class="control-group">
                                    <label for="email" class="control-label">邮箱：</label>
                                    <div class="controls">
                                        <input type="text" name="email" id="email" class="input-medium" value="${detail.email}" data-rule-required="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                 <div class="control-group">
                                    <label for="qq" class="control-label">QQ：</label>
                                    <div class="controls">
                                        <input type="text" name="qq" id="qq" class="input-medium" value="${detail.qq}" data-rule-required="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                 <div class="control-group">
                                    <label for="telno" class="control-label">电话：</label>
                                    <div class="controls">
                                        <input type="text" name="telno" id="telno" class="input-medium" value="${detail.telno}" data-rule-required="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                
                               <div class="control-group">
                                    <label for="telno" class="control-label">角色：</label>
                                    <div class="controls">
                                     <m:select property="role" sql="select sysroleid,rolename from sys_role " itemLabel="rolename" itemValue="sysroleid" selectValue="${detail.role}"/>
                                        <span class="maroon">*</span>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">保存</button>
                                    <a class="btn" href="Javascript:window.history.go(-1)">取消</a>

                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div></body>
</html>