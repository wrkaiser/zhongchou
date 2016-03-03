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
</head>
<body>
	
    <div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">

                    <div class="box">
                        <div class="box-title">
                            <div class="span8">
                                <h3><i class="icon-table"></i>系统菜单管理  </h3>
                            </div>

                        </div>

                        <div class="box-content">
                            <div class="alert">
                                <p>注意：1级菜单,链接地址：#</p>
                                <p>只有保存主菜单后才可以添加子菜单</p>
                                <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                                <p>当您为自定义菜单填写链接地址时请填写以"/"开头，这样可以保证用户手机浏览的兼容性更好</p>
                            </div>
                            <div class="row-fluid">

                                <div class="span8 control-group">
                                    <a href="javascript:void(0)" class="btn" id="add_menu"><i class="icon-plus"></i>添加主菜单</a>
                                </div>

                            </div>

                            <div class="row-fluid dataTables_wrapper">
                                <form action="${pageContext.request.contextPath}/back/menu/save.html"  method="post" class="form-horizontal form-validate">
                                    <table id="listTable" class="table table-bordered table-hover dataTable">

                                        <thead>
                                            <tr>
                                                <th>显示顺序</th>
                                                <th>主菜单名称</th>
                                                <th>链接地址</th>
                                                <th>启用</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
<logic:notEmpty name="menus">
<logic:iterate id="menu" name="menus">
<tr class="ptr">
 <td>
  <input type="hidden" value="${menu.menuid}" name="menuids"  />
          <input type="text" class="input-mini" size="3" value="${menu.sortno}" name="sorts"   data-rule-number="true"/></td>
         <td>
     <input type="text" class="input-medium" size="15" value="${menu.name}"  name="names" data-rule-required="true" data-rule-maxlength="30" />
     <i class="icon-plus cursor_p add" title="添加子菜单" rel="${menu.menuid}"></i>
     
                                            </td>
                                            <td>
                                                <input type="text" class="input-medium type" size="15" value="${menu.keyurl}"  name="keys" data-rule-required="true" data-rule-maxlength="200" />
                                                <input type="hidden" value="${menu.fid}" name="fids"/>
                                                <input type="hidden" class="key_type" value="1" name="types">
                                            </td>
                                            <td>
                                                <input type="checkbox" name="is_shows" value="1" onclick="show(this)"  ${menu.is_show==1?'checked=checked':''}/>
                                                <logic:equal value="0" name="menu" property="is_show">
                                                <input type="checkbox" name="is_shows" style="display:none" value="0"  checked="checked"/>
                                                </logic:equal>
                                                </td>
                                            <td><a href="javascript:G.ui.tips.confirm('您确定要删除此菜单吗?', '${pageContext.request.contextPath}/back/menu/delete/${menu.menuid}.html');">删除</a></td>
</tr>
<logic:notEmpty name="menu" property="cmenus">
<logic:iterate id="cmenu" name="menu"  property="cmenus">
<tr class="ztr">
 <td>
  <input type="hidden" value="${cmenu.menuid}" name="menuids"  />
          <input type="text" class="input-mini" size="3" value="${cmenu.sortno}" name="sorts"   data-rule-number="true"/></td>
         <td>
         <i class='board'></i>
         <input type="text" class="input-medium" size="15" value="${cmenu.name}"  name="names" data-rule-required="true" data-rule-maxlength="30" />
     
                                            </td>
                                            <td>
                                                <input type="text" class="input-medium type" size="15" value="${cmenu.keyurl}"  name="keys" data-rule-required="true" data-rule-maxlength="200" />
                                                <input type="hidden" value="${cmenu.fid}" name="fids"/>
                                                <input type="hidden" class="key_type" value="1" name="types">
                                            </td>
                                            <td>
                                                <input type="checkbox" name="is_shows" value="1" onclick="show(this)" ${cmenu.is_show==1?'checked=checked':''}/>
                                                 <logic:equal value="0" name="cmenu" property="is_show">
                                                <input type="checkbox" name="is_shows" style="display:none" value="0"  checked="checked"/>
                                                </logic:equal>
                                                </td>
                                            <td><a href="javascript:G.ui.tips.confirm('您确定要删除此菜单吗?', '${pageContext.request.contextPath}/back/menu/delete/${cmenu.menuid}.html');">删除</a></td>
</tr>
</logic:iterate>
</logic:notEmpty>
</logic:iterate>
</logic:notEmpty>
										
                                    </table>
                                    <div>
										<input type="hidden" name="aid" id="aid" value="27299">
                                        <button id="bsubmit" type="submit" data-loading-text="提交中..." class="btn btn-primary">保存</button>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                       


                                    </div>
                                </form>
                                
                                
                                	<logic:greaterThan value="1" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/back/menu.do?m=list" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
						         </logic:greaterThan>


                             <script type="text/javascript">
                             function show(obj){
                            	 if(obj.checked){
                            		$(obj).attr("checked","checked");
                            		 $(obj).parent().find("input[type=checkbox]").eq(1).remove();
                            	 }else{
                            		 if($(obj).parent().find("input[type=checkbox]").length<2)
                            		 $(obj).after('<input type="checkbox" name="is_shows" style="display:none" value="0"  checked="checked"/>');
                            	 }
                             }
                                 $().ready(function () {
                                     var $add_menu = $("#add_menu");
                                     var $add_zmenu = $("i.add");
                                     var $menu_index = 0;


                                     $add_menu.click(function (e) {
                                         e.preventDefault();
                                         $menu_index++;
                                         var _menuPtrtmp = '<tr>'
                                  + ' <td>'
                                 + '  <input name="menuids" size="3" type="hidden" value=""  /><input name="sorts" size="3" type="text" value="0" class="input-mini"ata-rule-number="true" /></td>'
                                  + ' <td>'
                                  + '<input name="names" size="15" type="text" class="input-medium" data-rule-required="true" data-rule-maxlength="30" /></td>'
                                  + '<td>'
                                  + ' <input name="keys" size="15" type="text" class="input-medium type" data-rule-required="true" data-rule-maxlength="500" />'
                                  + '   <input type="hidden" name="fids" value="{pid}" />'
                                   + '  <input type="hidden" name="types" class="key_type" value="1" /></td>'
                                  + ' <td>'
                                  + '  <input type="checkbox" name="is_shows" checked="checked" value="1"/></td>'
                                  + ' <td><a href="javascript:void()" class="del">删除</a></td>'
                                   + '</tr> ';
                                         $("#listTable").append(_menuPtrtmp.replace("{pid}", 0));

                                     })
                                     $add_zmenu.click(function myfunction() {
                                         var $pid = $(this).attr("rel");
                                         var $thistr = $(this).parent().parent();
                                         var next = $thistr.nextAll("tr");
                                         $menu_index++;
                                         var _menuPtrtmp = '<tr>'
                                  + ' <td>'
                                 + '  <input name="menuids" size="3" type="hidden" value=""  /><input name="sorts" size="3" type="text" value="0" class="input-mini"ata-rule-number="true" /></td>'
                                  + ' <td>{z}'
                                  + '<input name="names" size="15" type="text" class="input-medium" data-rule-required="true" data-rule-maxlength="30" /></td>'
                                  + '<td>'
                                  + ' <input name="keys" size="15" type="text" class="input-medium type" data-rule-required="true" data-rule-maxlength="500" />'
                                  + '  <input type="hidden" name="fids" value="{pid}" />'
                                 + '  <input type="hidden" name="types" class="key_type" value="1" /></td>'
                                  + ' <td>'
                                  + '  <input type="checkbox" name="is_shows" checked="checked" value="1" /></td>'
                                  + ' <td><a href="javascript:void()" class="del">删除</a></td>'
                                   + '</tr> ';
                                         var tp = _menuPtrtmp.replace("{pid}", $pid).replace("{z}", "<i class='board'></i>  ");
                                         if (next.length > 0) {
                                             next.first().before(tp);

                                         } else {
                                             $("#listTable").append(tp);
                                         }


                                     });
                                     $("#listTable .del").live("click", (function () {
                                         $(this).parents("tr").remove();
                                     }));
                                     $("input.type").live("change", function () {
                                         var $this = $(this);
                                         var $val = $this.val();
                                         var $nex = $this.nextAll("input.key_type");
                                         var re = /^((http|https|ftp):\/\/)?(\w(\:\w)?@)?([0-9a-z_-]+\.)*?([a-z0-9-]+\.[a-z]{2,6}(\.[a-z]{2})?(\:[0-9]{2,6})?)((\/[^?#<>\/\\*":]*)+(\?[^#]*)?(#.*)?)?$/i;
                                         if (re.test($val)) { $nex.val(2) } else { $nex.val(1) };
                                     });

                                 });
                                </script>

                            </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    </div></body>
</html>
