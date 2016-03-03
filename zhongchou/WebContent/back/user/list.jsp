<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag" %>
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
<title>国内最好用的客户管理系统</title>
<!--[if IE 7]><link href="http://stc.weimob.com/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->


</head>
<body>
	    <div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">

                    <div class="box">
                        <div class="box-title">
                            <div class="span6">
                                <h3><i class="icon-table"></i>管理微信公众帐号</h3>
                            </div>

                        </div>

                        <div class="box-content nozypadding">
                            <div class="row-fluid">
                                <div class="span8 control-group">

                                    <a class="btn" href="${pageContext.request.contextPath}/back/user/detail.html"><i class="icon-plus"></i>添加用户</a>
                                </div>


                            </div>

                            <div class="row-fluid dataTables_wrapper">
                               
                                <form method="post" action="" id="listForm">
                                    <table id="listTable" class="table table-hover table-nomargin table-bordered usertable dataTable">
                                        <thead>
                                            <tr>

                                                <th>用户名</th>
                                                 <th>真实姓名</th>
                                                <th>电话</th>
                                                <th>邮箱</th>
                                                <th>qq</th>
                                                <th>注册时间</th>
                                                <th>ip</th>
                                                <th>角色</th>
                                                <th>操作</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                        <logic:notEmpty name="list">
                                        <logic:iterate id="account" name="list">
										                                            <tr>
                                                <td style="text-align:center;">
                                                    <p>${account.username}</p>
                                                </td>
                                                  <td>
                                                    <p>${account.realname}</p>
                                                </td>
                                                
                                                <td align="center">
                                                <p>${account.telno }</p>
                                                </td>
                                                <td>
                                                    <p>${account.email}</p>
                                                </td>
                                                <td>
                                                    <p>${account.qq }</p>
                                            
                                                </td>
                                                <td>
                                                    <p>${account.regtime }</p>
                                            
                                                </td>
                                                <td>
                                                    <p>${account.logip }</p>
                                            
                                                </td>
                                                <td>
   <p>${account.rolename}</p>
                                                </td>
                                                <td>

                                                    <a href="${pageContext.request.contextPath}/back/user/detail/${account.userid}.html" class="btn" rel="tooltip" title="编辑"><i class="icon-edit"></i></a>
                                                    <a href="javascript:G.ui.tips.confirm('您确定要删除此帐号吗?', '${pageContext.request.contextPath}/back/user/del/${account.userid}.html');" class="btn" rel="tooltip" title="删除"><i class="icon-remove"></i></a>
                                                </td>
                                            </tr>
                                            </logic:iterate>
                                            </logic:notEmpty>
										                                        </tbody>

                                    </table>
                                    </form>
									
									<logic:greaterThan value="0" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/back/user.do?m=list" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
						         </logic:greaterThan>
									
									                         </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


</body></html>