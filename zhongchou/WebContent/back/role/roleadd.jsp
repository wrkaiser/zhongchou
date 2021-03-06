<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
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
                                <h3><i class="icon-edit"></i>添加角色</h3>
                            </div>
                            <div class="span2"><a class="btn" href="Javascript:window.history.go(-1)">返回</a></div>
                        </div>

                        <div class="box-content">


                            <form action="${pageContext.request.contextPath}/back/role.do?m=save" method="post" class="form-horizontal form-validate">
        			 <input type="hidden" name="sysRoleid" value="${role.sysroleid }">
                     
                                <div class="control-group">
                                    <label for="username" class="control-label">角色名称：</label>
                                    <div class="controls">
                                        <input type="text" name="rolename" id="name" class="input-medium" value="${role.rolename}" data-rule-required="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                <div class="control-group">
                                    <label for="username" class="control-label">上级ID：</label>
                                    <div class="controls">
                                        <input type="text" name="superroleid" id="superroleid" class="input-medium" value="${empty role ? '0':role.superroleid}" data-rule-required="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                 <div class="control-group">
                                    <label for="describe" class="control-label">描述：</label>
                                    <div class="controls">
                                        <input type="text" name="describe" id="describe" class="input-medium"  value="${role.descb}"/><span class="maroon">*</span>
                                    </div>
                                </div>
                               
                                
                                 <div class="control-group">
                                    <label for="email" class="control-label">是否可用：</label>
                                    <div class="controls">
                                    <select name="state" class="state">
      <option value="0" selected="selected">可用</option>
      <option value="1">禁用</option>
      </select>
                                    </div>
                                </div>
                                
                               

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">${role.sysroleid==0?'添加':'修改'}</button>
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