<%@ taglib prefix="m" uri="http:/www.xiaoyou.tag/mytag/common_lib" %>
<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@page import="com.xiaoyou.dao.*,java.util.*" %>

<%
   String proid=request.getParameter("proid");//获取所选项目id
   String  nowstatus=request.getParameter("status"); //获取当前审核状态栏状态
   String  cid=request.getParameter("category");//获取当前分类栏状态
   String  p=request.getParameter("p");//获取当前页数
   request.setAttribute("proid", proid);
   request.setAttribute("nowstatus", nowstatus);
   request.setAttribute("cid", cid);
   request.setAttribute("p", p);
 %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
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
<title>联保网店管理系统</title>
	<link rel="shortcut icon" href="http://stc.weimob.com/img/favicon.ico" />
    <!--[if lte IE 9]><script src="http://stc.weimob.com/src/watermark.js"></script><![endif]-->
	<!--[if IE 7]><link href="http://stc.weimob.com/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
	
</head>
<body>
	
    <div id="main">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <div class="box">
                        <div class="box-title">
                            <div class="span10">
                                <h3>添加</h3>
                            </div>
                            <div class="span2"><a class="btn" href="Javascript:window.history.go(-1)">返回</a></div>
                        </div>
                        <div class="box-content">
                            <form id="replyform" name="replyform"  action="${pageContext.request.contextPath }/back/luyan.do" method="post" class="form-horizontal form-validate" onsubmit="return updateText();">
                            <input type="hidden" name="proid" value="${proid }" />
                            <input type="hidden" name="m" value="addLuYan" />
                            <input type="hidden" name="nowstatus" value="${nowstatus }" />
                            <input type="hidden" name="cid" value="${cid }" />
                             <input type="hidden" name="p" value="${p }" />
                              <div class="control-group " >
                                    <label class="control-label" for="detail">路演内容:</label>
                                        <textarea id="info" name="content" style="width: 70%; height: 250px; display: none;" data-rule-required="true"></textarea>
                                    </div>
                                
                                <div class="form-actions">
                                    <button  type="submit" data-loading-text="保存中..." class="btn btn-primary">保存</button>
                                    <button type="button" class="btn" onclick="Javascript:window.history.go(-1)">取消</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
<script   src="${pageContext.request.contextPath}/editor/kindeditor.js"></script>
 <script charset="utf-8"  src="${pageContext.request.contextPath}/editor/preview.js"></script>
<script type="text/javascript">
 KE.show({
			id : 'info',
			imageUploadJson :path+'editor/jsp/upload_json.jsp',
			fileManagerJson : path+'editor/jsp/file_manager_json.jsp',
			allowFileManager : false,
			resizeMode : 1,
			items : [
				'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons','image','flash', 'media', 'link','|','fullscreen','source']
			});
                                       function updateText(){
                                        if($("select[name='cid']").val()==''){
                                           alert("请选择类别~");
                                           return false;
                                        }
                               			$("#info").html(KE.html("info"));
                               			
                               			return true;
                               		}
                                       function selectvideo(){
                                   		window.open('${pageContext.request.contextPath}/back/doc/videos.shtml',"选择视频",'height=500,width=600,top=100,left=300,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no');
                                   	}

                                    </script>
</body>
</html>
