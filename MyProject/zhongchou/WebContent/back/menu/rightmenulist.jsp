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
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_validate_min.js?2013-12-05-2"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_validate_methods.js?2013-12-05-2"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jquery_form_min.js?2013-12-05-2"></script>
<title>汇鑫—国内最大的客户管理系统</title>
    <!--[if lte IE 9]><script src="${pageContext.request.contextPath}/back/js/watermark.js"></script><![endif]-->
	<!--[if IE 7]><link href="${pageContext.request.contextPath}/back/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->


<script type="text/javascript">
    $(function(){
	    $.each(${rights}.root,function(idx,item){ 
		       $("#roleform").find("input[name=fk_shows]").each(function(){
		    	   if($(this).attr("mid")==item.menuid){
		    	   $(this).attr("checked","checked");
		    	    // if($(this).parent().find("input[type=checkbox]").length<2)
                    // $(this).parent().find("input[name='is_shows']").val("0");
                    }
		       });
	         }); 
    });
    
</script>

</head>
<body>
	
    <div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">

                    <div class="box">
                        <div class="box-title">
                            <div class="span8">
                                <h3><i class="icon-table"></i>用户菜单授权  </h3>
                            </div>

                        </div>

                        <div class="box-content">
                           
                           
                            <div class="row-fluid dataTables_wrapper">
                                <form id="roleform" action="${pageContext.request.contextPath}/back/menu/saveright.html"  method="post" class="form-horizontal form-validate">
                                    <table id="listTable" class="table table-bordered table-hover dataTable">

                                        <thead>
                                            <tr>
                                                <th>显示顺序</th>
                                                <th>主菜单名称</th>
                                                <th>启用</th>
                                            </tr>
                                        </thead>
<logic:notEmpty name="menus">
<logic:iterate id="menu" name="menus">
<tr class="ptr">
 <td>
  <input type="hidden" value="${menu.menuid}" name="menuids"  />
          ${menu.sortno}
          </td>
         <td>
     ${menu.name}
     
     
                                            </td>
                                           
                                            <td>
                                               <input fid="0" mid="${menu.menuid}" type="checkbox" name="fk_shows" value="1" onclick="show(this)"  />
                                                <input mid="${menu.menuid}" type="hidden" name="is_shows" value="2" />
                                                </td>
</tr>
<logic:notEmpty name="menu" property="cmenus">
<logic:iterate id="cmenu" name="menu"  property="cmenus">
<tr class="ztr">
 <td>
  <input type="hidden" value="${cmenu.menuid}" name="menuids"  />
          ${cmenu.sortno}
          </td>
         <td>
         <i class='board'></i>
         ${cmenu.name}
     
                                            </td>
                                           
                                            <td>
                                               <input fid="${cmenu.fid }" mid="${cmenu.menuid}" type="checkbox" name="fk_shows" value="1" onclick="show(this)" />
                                                
                                                
                                                <input fid="${cmenu.fid }" mid="${cmenu.menuid}" type="hidden" name="is_shows" value="2" />
                                                
                                           </td>
</tr>
</logic:iterate>
</logic:notEmpty>
</logic:iterate>
</logic:notEmpty>
										
                                    </table>
                                    <div>
										<input type="hidden" name="userid" id="userid" value="${User.userid}">
										<input type="hidden" name="sysroleid" id="sysroleid" value="${sysroleid}">
                                        <button id="bsubmit" type="submit" data-loading-text="提交中..." class="btn btn-primary">保存</button>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                       


                                    </div>
                                </form>
                                
                                
                                  	<logic:greaterThan value="1" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/back/menu.do?m=rightmenulist&touserid=${touserid }&weiid=${weiid }" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
						         </logic:greaterThan>


                             <script type="text/javascript">
                            function show(obj){
                            	 if(obj.checked){
                            		$(obj).attr("checked","checked");
                            		 $(obj).parent().find("input[name='is_shows']").val("1")
                            	 }else{
                            		$(obj).parent().find("input[name='is_shows']").val("0")
                            	 }
                            	 
                            	 if($(obj).attr("fid")==0){
                            	     if(obj.checked){
                            	 	$("input[type='checkbox'][fid='"+$(obj).attr("mid")+"']").attr("checked","checked");
                            	 	$("input[name='is_shows'][fid='"+$(obj).attr("mid")+"']").val("1");
                            	 	
                            	    }else{
                            	    $("input[type='checkbox'][fid='"+$(obj).attr("mid")+"']").parent().find("input[name='is_shows']]").val("0");
                            	    
                            	 }
                             }
                             }
                               
                                </script>

                            </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    </div></body>
</html>
