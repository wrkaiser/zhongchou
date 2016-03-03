<%@ taglib prefix="m" uri="http:/www.xiaoyou.tag/mytag/common_lib" %>
<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@page import="java.util.Map"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@page import="java.util.List"%>
  <%
                    String sql;
                    BaseDao dao=new BaseDao(); 
                    String m = request.getParameter("m");
                    if(m!=null&&m.equals("update"))
                    {
                    	sql="update zh_pros  set proname='"+request.getParameter("proname")+"',ischecked="+request.getParameter("status")+ " where proid="+request.getParameter("proid");
                    	dao.update(sql);
                    	out.print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\""+request.getContextPath()+"/back/pro/pros.jsp"+"\"}");
                    	return;
                    }
                    sql="select * from zh_pros where proid="+request.getParameter("proid");
                    Map map=dao.queryone(sql);
                    request.setAttribute("map",map);
                    
                    %>     
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
                                <h3><i class="icon-edit"></i>修改信息</h3>
                            </div>
                            <div class="span2"><a class="btn" href="Javascript:window.history.go(-1)">返回</a></div>
                        </div>
                  
                      

                        <div class="box-content">
                          <form id="replyform" name="replyform"  action="update.jsp" method="post" class="form-horizontal form-validate" onsubmit="return updateText();">
                            <input type="hidden" name="id" value="${empty detail ? 0: detail.id}" />
                            <input type="hidden" name="m" value="update" />
                                <div class="control-group">
                                    <label for="name" class="control-label">
                                                                                                     项目名称：
             
                                    </label>
                                    <div class="controls">
                                        <input type="text" value="${map.proname}" name="proname" id="label" class="input-large" data-rule-required="true" data-rule-maxlength="150" />
                                        <span class="maroon">*</span>
                                    </div>
                                </div>
                                
                                
                            <!--
                                  <div class="control-group">
                                    <label for="name" class="control-label">会员电话:</label>
                                    <div class="controls">
                                        <input type="text" value="${map.telno }" name="telno" id="name" class="input-large" data-rule-required="true" data-rule-maxlength="200" />
                                        <span class="maroon">*</span>
                                        
                                    </div>
                                </div>
                                  <div class="control-group">
                                    <label class="control-label" for="shopid">省      份:</label>
                                    <div class="controls">
                                     <input type="text" value="${map.province }" name="province" id="name" class="input-large" data-rule-required="true" data-rule-maxlength="200" />
										
                                    </div>
                                </div>   -->   
                                <div class="control-group">
                                    <label class="control-label" for="shopid">审核状态：</label>
                                    <div class="controls">
                                      <select name="status" >
                                    	<option value="1">待审核</option>
                                    	<option value="5">不通过审核</option>
                                    	<option value="2">发布预约中</option>
                                    	<option value="3">发行中</option>
                                    	<option value="4">结束</option>
                                    </select>
										
                                    </div>
                                </div>
                                <input type="hidden" id="name" name="proid" value="${map.proid }" />
                                </div>
                                  
                                </div>
        
                            
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
                        
                        
                                <div class="form-actions" style="padding-left:180px">
                                    <button id="bsubmit" type="submit" data-loading-text="提交中..."class="btn btn-primary">保存</button>
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
