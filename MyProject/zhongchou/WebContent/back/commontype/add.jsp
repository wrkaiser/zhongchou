<%@ taglib prefix="m" uri="http:/www.xiaoyou.tag/mytag/common_lib" %>
<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta content="微哇中心" name="Keywords">
	<meta content="微哇中心" name="Description">
  
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/bootstrap_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/bootstrap_responsive_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/style.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/todc_bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/themes.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/inside.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/resource.css" media="all">
<script type="text/javascript" src="${pageContext.request.contextPath }/back/js/jQuery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/back/js/bootstrap_min.js"></script></style>
<script type="text/javascript" src="${pageContext.request.contextPath }/back/js/inside.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/back/js/plugins/jquery_form_min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/back/js/plugins/jquery_validate_min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/back/js/plugins/jquery_validate_methods.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/back/js/resource.js"></script>

<title>登录-微哇管理平台(微餐饮子系统)</title>
	<link rel="shortcut icon" href="http://stc.weimob.com/img/favicon.ico" />
    <!--[if lte IE 9]><script src="http://stc.weimob.com/src/watermark.js"></script><![endif]-->
	<!--[if IE 7]><link href="http://stc.weimob.com/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
	
	<script type="text/javascript">
		$(function(){
		   $("#showlink").val('${detail.showlink}');
		})
	</script>
</head>
<body>
	
    <div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">
                    <div class="box">
                        <div class="box-title">
                            <div class="span10">
                                <h3><i class="icon-edit"></i>添加分类</h3>
                            </div>
                            <div class="span2"><a class="btn" href="Javascript:window.history.go(-1)">返回</a></div>
                        </div>

                        <div class="box-content">
                            <form id="replyform" name="replyform"  action="${pageContext.request.contextPath }/back/commontype.do" method="post" class="form-horizontal form-validate" onsubmit="return updateText();">
                            <input type="hidden" name="id" value="${empty detail ? 0: detail.id}" />
                            <input type="hidden" name="m" value="update" />
                                <div class="control-group">
                                    <label for="name" class="control-label">
                                    显示名称：
             
                                    </label>
                                    <div class="controls">
                                        <input type="text" value="${empty detail ? '' : detail.label }" name="label" id="label" class="input-large" data-rule-required="true" data-rule-maxlength="150" />
                                        <span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                
                                
                                  <div class="control-group">
                                    <label for="name" class="control-label">标识：</label>
                                    <div class="controls">
                                        <input type="text" value="${empty detail ? '' : detail.name }" name="name" id="name" class="input-large" data-rule-required="true" data-rule-maxlength="200" />
                                        <span class="maroon">*</span>
                                        <span class="help-inline">尽量简单，不要超过200字.</span>
                                    </div>
                                </div>
                                  <div class="control-group">
                                    <label class="control-label" for="shopid">所属类别：</label>
                                    <div class="controls">
                                      <m:select property="type" sql="select ctype,cid,cname from wei_common_ctype order by ctype desc,pos,credate desc" itemLabel="cname" itemValue="cid" selectValue="${empty detail ? '':detail.type }"/>
										
                                    </div>
                                </div>
                               
                                 <input type="hidden" name="type" value="${type}">
                                  <input type="hidden" name="showlink" value="0">
<!-- 
                                <div class="control-group">
                                    <label for="sort" class="control-label">是否显示链接：</label>
                                    <div class="controls">
                                    <select name="showlink" id="showlink">
                                    	<option value="1">是</option>
                                    	<option value="0">否</option>
                                    </select>
                                    </div>
                                </div>

 -->                                 
                                 <input type="hidden" name="type" value="${type}">
                                <div class="control-group">
                                    <label for="sort" class="control-label">显示顺序：</label>
                                    <div class="controls">
                                        <input type="text" id="csort" name="sort" value="${empty detail ? '0':detail.sort }" class="input-mini" data-rule-required="true" data-rule-number="true" /><span class="maroon">*</span>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button id="bsubmit" type="submit" data-loading-text="提交中..." class="btn btn-primary">保存</button>
                                    <button type="button" class="btn" onclick="Javascript:window.history.go(-1)">取消</button>
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
