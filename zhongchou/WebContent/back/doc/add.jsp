<%@ taglib prefix="m" uri="http:/www.xiaoyou.tag/mytag/common_lib" %>
<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@page import="com.xiaoyou.dao.*,java.util.*" %>

<%
   BaseDao dao = new BaseDao();
    String pid = request.getParameter("pid");
   Map mcnt = dao.queryone("select count(cid)cnt from wei_common_ctype where showlink=1 and cid='"+pid+"'");
  
   int showlink = Integer.parseInt(mcnt.get("cnt").toString());
   
   request.setAttribute("showlink",showlink);

    Map configs = null;
    configs = new HashMap();
   
    if("25".equals(pid)||"28".equals(pid)){
        configs.put("cont", "0");
		
    }else{
	   configs.put("cont", "1");
	  
	}

	if("27".equals(pid)||"23".equals(pid)||"28".equals(pid)){
        configs.put("img", "0");
    }else{
	    configs.put("img", "1");
	}

	
   
   request.setAttribute("configs",configs);

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
                            <form id="replyform" name="replyform"  action="${pageContext.request.contextPath }/back/doc.do" method="post" class="form-horizontal form-validate" onsubmit="return updateText();">
                            <input type="hidden" name="id" value="${empty doc ? 0: doc.id}" />
                             <input type="hidden" name="pid" value="${pid}" />
                            <input type="hidden" name="m" value="save" />
                                <div class="control-group">
                                    <label for="name" class="control-label">标题：</label>
                                    <div class="controls">
                                        <input type="text" value="${empty doc ? '' : doc.title }" name="title" id="label" class="input-large" data-rule-required="true" data-rule-maxlength="80" />
                                        <span class="maroon">*</span>
                                        <span class="help-inline">80个字以内</span>
                                    </div>
                                </div>
                                
                                   <div class="control-group">
                                    <label class="control-label" for="shopid">所属类别：</label>
                                    <div class="controls">
                                      <m:select property="cid" sql="select id,name from wei_common_type where type='${pid }'  order by sort desc" itemLabel="name" itemValue="id" selectValue="${doc.cid}"/>
										
                                    </div>
                                </div>
                                
                                
                                <div class="control-group">
                                    <label class="control-label" for="shopid">排序号：</label>
                                    <div class="controls">
                                      <select name="pos" id="pos">
                                      <%for(int i=1;i<100;i++){%>
                                      	<option value="<%=i %>"><%=i %></option>
                                      	<%} %>
                                      </select>
										  <span class="help-inline">从小到大</span>
                                    </div>
                                </div>
                                
                                 
                                  <div class="control-group" style="${configs.img=='1' ? '':'display:none;'}">
                                    <label class="control-label" for="pic">图片:</label>
                                    <div class="controls">

									      <img class="shopimg" style="max-height: 100px;" src="${doc.img}" style="${empty doc.img ? 'display:none;':''}"/>

																					<input type="text" id="pic" name="img" value="${doc.img}" class="input-xlarge"  style="${empty doc.img ? '':'display:none;'}" />
										
                                        <span class="help-inline">
                                            <button class="btn select_img" type="button" id="uploadify">选择图片</button>
                                            <script>
                                            $(function(){
                                            	inituplod();
                                            });
                                            </script>
                                         
                                          
                                            </span>
                                       <!--  <span class="help-inline">图片大小(宽度:720,高度:400)</span>-->
                                    </div>
                                </div>
                                
                                
                                 <logic:greaterThan value="0"  name="showlink"  scope="request">
                                  <div class="control-group">
                                    <label for="name" class="control-label">地址：</label>
                                    <div class="controls">
                                        <input type="text" value="${empty doc ? '' : doc.url }" name="url" id="url" class="input-large" data-rule-maxlength="150" />
                                        <span class="maroon">*</span>
                                        <span class="help-inline">请输入链接</span>
                                    </div>
									</div>
                                 </logic:greaterThan>
                               
                                
                                
                                  <div class="control-group " style="${configs.cont=='1' ? '':'display:none;'}">
                                    <label class="control-label" for="detail">内容:</label>
                                    <div class="controls">
                                        <textarea id="info" name="content" style="width: 70%; height:250px" data-rule-required="true">${doc.content}</textarea>

                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button id="bsubmit" type="submit" data-loading-text="保存中..." class="btn btn-primary">保存</button>
                                    <button type="button" class="btn" onclick="Javascript:window.history.go(-1)">取消</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/swfobject.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.uploadify.v2.1.0.min.js"></script>
<script   src="${pageContext.request.contextPath}/editor/kindeditor.js"></script>
 <script charset="utf-8"  src="${pageContext.request.contextPath}/editor/preview.js"></script>
<script type="text/javascript">
var path='${pageContext.request.contextPath}/';
$(function(){
$("#pos").val('${doc.pos}');
});

	function inituplod(){
			
	$("#uploadify").uploadify({
				'uploader'       : path+'js/uploadify.swf',
				'script'         : path+'Upload',
				'cancelImg'      : path+'images/cancel.png',
				'folder'         : 'uploads',
				'queueID'        : 'fileQueue',
				'auto'           : true,
				'fileDesc' 		 : '*.jpg;*.jpeg;*.gif;*.png;*.flv;*.3gp' , 
		        'fileExt'		 : '*.jpg;*.jpeg;*.gif;*.png;*.flv;*.3gp' , 
				'buttonImg': path+'images/upload.jpg', 
				 'width': 87,
                 'height': 34,
                 'sizeLimit': 5 * 1024 * 1024  , //这里是文件最大值5M
				'multi'          : false,
				'onComplete' : function(evt, queueID, fileObj,
										response, data) {
				var jsonstr= eval("(" + response + ")");
				$(".shopimg").attr("src",jsonstr.img);
				
				$("#pic").val(jsonstr.img).hide();
				
									return false;
								},
				'onSelectOnce' : function(event, data) {
									$(".shopimg").remove();
									$("#pic").before('<img class="shopimg" style="max-height: 100px;" src="'+path+'images/upload.gif"/>');
								}

			});
	$("#uploadify2").uploadify({
				'uploader'       : path+'js/uploadify.swf',
				'script'         : path+'upload/aupcover.html',
				'cancelImg'      : path+'images/cancel.png',
				'folder'         : 'uploads',
				'queueID'        : 'fileQueue',
				'auto'           : true,
				'fileDesc' 		 : '*.jpg;*.jpeg;*.gif;*.png;*.flv;*.3gp' , 
		        'fileExt'		 : '*.jpg;*.jpeg;*.gif;*.png;*.flv;*.3gp' , 
				'buttonImg': path+'images/upload.jpg', 
				 'width': 87,
                 'height': 34,
                 'sizeLimit': 5 * 1024 * 1024  , //这里是文件最大值5M
				'multi'          : false,
				'onComplete' : function(evt, queueID, fileObj,
										response, data) {
				var jsonstr= eval("(" + response + ")");
				$(".pic_real").attr("src",jsonstr.img);
				$("#pic_real").val(jsonstr.img).hide();
									return false;
								},
				'onSelectOnce' : function(event, data) {
									$(".pic_real").remove();
									$("#pic_real").before('<img class="pic_real" style="max-height: 100px;" src="'+path+'images/upload.gif"/>');
								}

			});
}
                                    
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
