<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag" %>
<%@page import="java.util.*" %>
<%
 
  String pid = (String)request.getParameter("pid");
   Map configs = null;
     configs = new HashMap();
   
    if("18".equals(pid)||"22".equals(pid)||"22".equals(pid)||"23".equals(pid)||"27".equals(pid)){
        configs.put("showdel", "0");
		configs.put("showadd", "0");
    }else{
	 configs.put("showdel", "1");
	   configs.put("showadd", "1");
	}
   
   request.setAttribute("configs",configs);
   
 %>
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
<title>联保管理系统</title>
<!--[if IE 7]><link href="${pageContext.request.contextPath}/back/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
</head>
<body>

<div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">

                    <div class="box">
                       

                        <div class="box-content nozypadding">
						      <logic:equal value="1" name="configs" property="showadd" >
                            <div class="span8 control-group">
                                    <a href="${pageContext.request.contextPath }/back/doc.do?m=detail&pid=${pid}" class="btn"><i class="icon-plus"></i>添加${name }</a>
                            </div>
							</logic:equal>

                            <div class="row-fluid dataTables_wrapper">
                               

                                  <table id="listTable" class="table table-bordered table-hover dataTable">

                                    <thead>
                                        <tr>
                                            <th>标题</th>
                                                <th>分类</th>
 <th>日期</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                     <tbody>
                                     
                                      <logic:notEmpty name="docs">
                                      <logic:iterate id="doc" name="docs">
                                     <tr>
                                        <td>${doc.title}</td>
                                        <td>${doc.cname }</td>
 															 <td>${doc.ctime}</td>
                                        <td class="input-medium">
                                            <a class="btn" href="${pageContext.request.contextPath }/back/doc.do?m=detail&id=${doc.id}&pid=${pid}" title="编辑"><i class="icon-edit"></i></a>

											  <logic:equal value="1" name="configs" property="showdel" >
                                            <a class="btn" href="javascript: G.ui.tips.confirm('你确定要删除吗？','${pageContext.request.contextPath }/back/doc.do?m=delete&id=${doc.id}&pid=${pid}')" title="删除"><i class="icon-remove"></i></a></td>
											 </logic:equal>
                                    </tr>
                                    	</logic:iterate>
                                    	</logic:notEmpty>
									                                </tbody></table>
									                                
									                                
                                	<logic:greaterThan value="1" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/back/doc.do?m=list&pid=${pid}" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
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