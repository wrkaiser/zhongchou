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
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/zeroclipboard.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/inside.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/chosen_jquery_min.js"></script>
<title>汇鑫—国内最大的客户管理系统</title>
<!--[if IE 7]><link href="${pageContext.request.contextPath}/back/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
</head>
<body>

<div id="main">
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">

                    <div class="box">
                       

                        <div class="box-content nozypadding">
                            <div class="span8 control-group">
                                    <a href="${pageContext.request.contextPath }/back/commonctype/detail.html" class="btn"><i class="icon-plus"></i>添加分类</a>
                            </div>

                            <div class="row-fluid dataTables_wrapper">
                               

                                  <table id="listTable" class="table table-bordered table-hover dataTable">

                                    <thead>
                                        <tr>
                                           <th>ID</th>
                                           <th>类型</th>
                                            <th>分类名称</th>
                                            <th>子分类</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                     <tbody>
                                     
                                      <logic:notEmpty name="list">
                                      <logic:iterate id="l" name="list">
                                     <tr>
                                       <td>${l.cid }</td>
                                       <td>${l.ctype==0 ? '默认' : l.ctype==1 ? '其它':'其它2' }</td>
                                        <td>${l.cname }</td>
 										<td><a href="${pageContext.request.contextPath }/back/commontype.do?m=list&id=${l.cid}">查看</a></td>					
                                        <td class="input-medium">
                                            <a class="btn" href="${pageContext.request.contextPath }/back/commonctype/detail/${l.cid}.html" title="编辑"><i class="icon-edit"></i></a>
                                            <a class="btn" href="javascript: G.ui.tips.confirm('确定删除？','${pageContext.request.contextPath }/back/commonctype.do?m=del&id=${l.cid }')" title="删除"><i class="icon-remove"></i></a></td>
                                    </tr>
                                    	</logic:iterate>
                                    	</logic:notEmpty>
									                                </tbody></table>
									<div class="dataTables_paginate paging_full_numbers"><span>       </span></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>



    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="icon-copy"></i>复制菜品 <small>最多一次复制到3个门店</small></h4>
                </div>
                <div class="modal-body" style="overflow: visible">
                    <div class="row-fluid">
                        <span class="stores_name"></span>
                        <select name="stores_to" id="stores_to" class="input-xxlarge"  multiple="multiple" data-placeholder="请选择要复制到的门店">
                            <option value="3681">2</option>

                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="copy_stores">确定</button>
                    <button class="btn" data-dismiss="modal" aria-hidden="true">取消 </button>
                </div>
                <input type="hidden" id="stores_for_id" />
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                    $("a.copy-on").click(function (e) {
                        e.preventDefault();
                        var $id = $(this).data("id"), $name = $(this).data("name"), $text = $("span.stores_name");
                        $("#stores_for_id").val($id);
                        $text.text("复制[ {0} ]的菜品到".format($name));
                        $("#stores_to option").each(function () {
                            if ($(this).val() == $id) { $(this).attr('disabled', true); }else{$(this).attr('disabled', false); }
                            $(this).attr("selected", false);
                        });
                        $("#stores_to_chzn").remove();
                        $("#stores_to").removeClass("chzn-done");
                        $("#stores_to").chosen({max_selected_options:3,disable_search_threshold:999999,no_results_text:"找不到"});
                        $('#myModal').modal('show');

                    });
                    $("#copy_stores").click(function () {
                        var $stores_to = $("#stores_to").val(), $this = $(this);
                        if ($stores_to) {
                            $this.text("复制中...").addClass("disabled").attr("disabled", "disabled");
                            $.ajax({
                                url: "/spfood/copy?aid=23567",
                                type: "post",
                                dataType: "json",
                                data: {
                                    "stores_for_id": $("#stores_for_id").val(),
                                    "stores_to": $stores_to
                                },
                                success: function (data) {
                                    alert(data.error);
                                    $this.text("确定").removeClass("disabled").removeAttr("disabled");
                                    $('#myModal').modal('hide');

                                },
                                error: function () {
                                    alert("复制失败....");
                                    $this.text("重新复制").removeClass("disabled").removeAttr("disabled");
                                 }
                            });
                        } else {
                            alert("请选择需要复制的门店");
                        }
                    });
                })
            </script>
        </div>

    </div></body>

</html>