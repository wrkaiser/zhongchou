<%@ page language="java"  pageEncoding="utf-8"%>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_validate_min.js?2013-11-25-1"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_validate_methods.js?2013-11-25-1"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_form_min.js?2013-11-25-1"></script>
<title>管理系统</title>
<!--[if IE 7]><link href="http://stc.weimob.com/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
</head>

	<body class="theme-satgreen">
    <div id="main">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <div class="box">
                        <div class="box-title">
                            <div class="span10">
                                <h3><i class="icon-edit"></i>修改密码</h3>
                            </div>
                            <div class="span2">
                                <a class="btn" href="javascript:window.history.go(-1);">返回</a>
                            </div>
                        </div>
                        <div class="box-content">
                            <form action="${pageContext.request.contextPath}/mem/updatepass.html" method="post" class="form-horizontal form-validate">
                                <div class="control-group">
                                    <label class="control-label" for="old_password">原密码</label>
                                    <div class="controls">
                                        <input type="password" name="ypassword" id="old_password" data-rule-required="true" data-rule-rangelength="[1,16]" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="new_password">新密码</label>
                                    <div class="controls">
                                        <input type="password" name="password" id="new_password" data-rule-required="true" data-rule-rangelength="[6,16]" />
                                        <span class="maroon">*</span><span class="help-inline">6~16</span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="repassword">确认密码</label>
                                    <div class="controls">
                                        <input type="password" name="chkpassword" id="repassword" data-rule-required="true" data-rule-equalto="#new_password">
                                    </div>
                                </div>
                                <div class="form-actions" id="btn_box">
                                    <button id="bsubmit" type="submit" data-loading-text="saving..." class="btn btn-primary">保存</button>
                                    <button class="btn" type="button" onclick="javascript:window.history.go(-1);">取消</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>