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
<title>Manager System</title>
<!--[if IE 7]><link href="http://stc.weimob.com/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->

<script type="text/javascript">
var ppath = '${pageContext.request.contextPath}/';
	function grant(val){
	   window.open(ppath+'back/menu.do?m=rightmenulist&sysroleid='+val,"授权列表",'height=500,width=600,top=100,left=300,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no');
 	}
 	
</script>
</head>

<body>
	    <div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">

                    <div class="box">
                        <div class="box-title">
                            <div class="span6">
                                <h3><i class="icon-table"></i>role</h3>
                            </div>

                        </div>

                        <div class="box-content nozypadding">
                          
                            <div class="row-fluid dataTables_wrapper">
                              
                                
                                
                               
                                    <table id="listTable" class="table table-hover table-nomargin table-bordered usertable dataTable">
                                        <thead>
                                            <tr>

                                               <th>角色编号</th>
      <th>角色上级</th>
      <th>角色名称</th>
      <th>描述</th>
      <th>是否可用</th>
      <th>创建时间</th>
         <th>操作</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                         <logic:notEmpty name="rolelist">
  <logic:iterate id="role" name="rolelist">
										                                            <tr>
                                                <td style="text-align:center;">
                                                    <p>
                                                       ${role.sysroleid}
                                                    </p>
                                                </td>
                                                <td align="center">
                                                <p>${role.superroleid}</p>
                                                </td>
                                                <td>
                                                    <p>${role.rolename}</p>
                                                </td>
                                                <td>
                                                    <p>${role.describe}</p>
                                            
                                                </td>
                                                <td>
                                                    <p>${role.state==0?'可用':'禁用'}</p>
                                            
                                                </td>
                                                <td>
                                                    <p>${role.createtime}</p>
                                            
                                                </td>
                                              
                                                <td>

                                                    <a href="${pageContext.request.contextPath}/back/role.do?m=detail&sysRoleid=${role.sysroleid}" class="btn" rel="tooltip" title="编辑"><i class="icon-edit"></i></a>
                                                    <a href="javascript:G.ui.tips.confirm('您确定要删除此帐号吗?', '${pageContext.request.contextPath}/back/role.do?m=delete&sysRoleid=${role.sysroleid}');" class="btn" rel="tooltip" title="删除"><i class="icon-remove"></i></a>
                                                    <a href="javascript:void(0)" class="btn"  onclick="grant(${role.sysroleid});">授权</a>
                                                </td>
                                            </tr>
                                            </logic:iterate>
                                            </logic:notEmpty>
										                                        </tbody>

                                    </table>
									<div class="dataTables_paginate paging_full_numbers"><span>       </span></div>                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


</body></html>