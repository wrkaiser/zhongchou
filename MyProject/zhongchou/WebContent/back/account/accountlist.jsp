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
<script type="text/javascript">
  function grantMenu(userid,weiid){
   window.open('${pageContext.request.contextPath}/back/menu.do?m=rightmenulist&touserid='+userid+"&weiid="+weiid,"授权列表",'height=500,width=600,top=100,left=300,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no');
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
                                <h3><i class="icon-table"></i>客户帐号</h3>
                            </div>

                        </div>

                        <div class="box-content nozypadding">
                            <div class="row-fluid">
                                <div class="span8 control-group">

                                    <a class="btn" href="${pageContext.request.contextPath}/back/account/add.html"><i class="icon-plus"></i>添加客户</a>
                                    <a href="http://wpa.qq.com/msgrd?v=3&uin=360611028&site=qq&menu=yes" target="_blank" class="btn btn-warning" style="cursor:pointer">微助手</a>
                                </div>


                            </div>

                            <div class="row-fluid dataTables_wrapper">
                               
                                <form method="post" action="" id="listForm">
                                    <table id="listTable" class="table table-hover table-nomargin table-bordered usertable dataTable">
                                        <thead>
                                            <tr>

                                                <th>名称</th>
                                                  <th>电话</th>
                                                <th>性别</th>
                                                <th>年龄</th>
                                                  <th>创建时间</th>
                                                <th>操作</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                        <logic:notEmpty name="accounts">
                                        <logic:iterate id="account" name="accounts">
										                                            <tr>
                                                <td style="text-align:center;">
                                                    <p>${account.username}</p>
                                                </td>
                                                <td>
                                                    <p>${account.phone}</p>
                                                </td>
                                                <td>
                                                    <p>${account.sex}</p>
                                                </td>
                                                <td>
                                                    <p>${account.age}</p>
                                                </td>
                                                <td>
                                                     <p>${account.credate}</p>
                                                </td>
                                                <td>

                                                   <a href="javascript:G.ui.tips.confirm('您确定要删除此帐号吗?', '${pageContext.request.contextPath}/home/account/delete/${account.weiid}.html');" class="btn" rel="tooltip" title="删除"><i class="icon-remove"></i></a>
                                                </td>
                                            </tr>
                                            </logic:iterate>
                                            </logic:notEmpty>
										                                        </tbody>

                                    </table>
                                    </form>
									
									<logic:greaterThan value="0" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/home/account.do?m=lists" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
						         </logic:greaterThan>
									                          </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


</body></html>