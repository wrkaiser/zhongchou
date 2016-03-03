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
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/zeroclipboard.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/inside.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/chosen_jquery_min.js"></script>
<title>留言管理</title>
<!--[if IE 7]><link href="${pageContext.request.contextPath}/back/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
</head>
<body>

<div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">

                    <div class="box">
                       

                        <div class="box-content nozypadding">
                          
                            <div class="row-fluid dataTables_wrapper">
                               

                                  <table id="listTable" class="table table-bordered table-hover dataTable">

                                    <thead>
                                        <tr>
                                            <th>问题</th>
                                            <th>类型</th>
                                            <th>是否回复</th>
                                             <th>留言人</th>
 <th>咨询时间</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                     <tbody>
                                     
                                      <logic:notEmpty name="msgs">
                                      <logic:iterate id="msg" name="msgs">
                                     <tr>
                                        <td>${msg.content}</td>
                                         <td><a href="${pageContext.request.contextPath }/back/msg.do?m=list&t=${msg.type}">${msg.type}</a></td>
                                         <td>${msg.rescontent!=null&&msg.rescontent!=''?'已回复':'未回复'}</td>
                                         <td>${msg.username }</td>
 															 <td>${msg.addtime}</td>
                                        <td class="input-medium">
                                            <a class="btn" href="${pageContext.request.contextPath }/back/msg/detail/${msg.id}.html" title="编辑"><i class="icon-edit"></i></a>
                                            <a class="btn" href="javascript: G.ui.tips.confirm('确定删除？','${pageContext.request.contextPath }/back/msg.do?m=delete&id=${msg.id}&t=${type}')" title="删除"><i class="icon-remove"></i></a></td>
                                    </tr>
                                    	</logic:iterate>
                                    	</logic:notEmpty>
									                                </tbody></table>
									                                <logic:greaterThan value="1" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/back/msg.do?m=list&t=${type}" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
						         </logic:greaterThan>
									<div class="dataTables_paginate paging_full_numbers"><span>       </span></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
 </body>

</html>