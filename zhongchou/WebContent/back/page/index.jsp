<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/home/css/bootstrap_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/home/css/bootstrap_responsive_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/home/css/style.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/home/css/todc_bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/home/css/themes.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/home/css/inside.css" media="all">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/home/gw/lib/codemirror.css" />
	
<script type="text/javascript" src="${pageContext.request.contextPath}/home/js/jQuery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/js/bootstrap_min.js"></script></style>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/js/jquery_validate_min.js?2013-11-25-1"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/js/jquery_validate_methods.js?2013-11-25-1"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/js/jquery_form_min.js?2013-11-25-1"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/js/inside.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/gw/lib/codemirror.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/home/gw/mode/xml/xml.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/home/js/plugins/html/zen_codemirror.js"></script>
<title>微哇—国内最大的客户管理系统</title>
<!--[if IE 7]><link href="http://stc.weimob.com/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
</head>
<body>
    <div id="main">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <div class="box">
                        <div class="box-title">
                            <div class="span12">
                                <h3><i class="icon-cog"></i>首页模板设置</h3>
								<a class="btn preview pull-right btn-success" href="javascript:;">预览</a>
								<script type="text/javascript">
									$("a.preview").click(function () {
										if ($.browser.msie) {
											alert("不支持在IE浏览器下预览，建议使用谷歌浏览器或者360极速浏览器或者直接在微信上预览。");
											return;
										}
										var left = ($(window.parent.parent).width() - 450) / 2;
																				window.open("${pageContext.request.contextPath}/back/page/preview.shtml", "我的微官网", "height=650,width=450,top=0,left=" + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no");
									});
								</script>
                            </div>
                        </div>
                        <div class="box-content">
                            <form action="${pageContext.request.contextPath}/back/pageset/saveindex.html" method="post" class="form-horizontal form-validate">
							
								<div class="control-group">
										<textarea id="tj_code" name="temp" class="input-xxlarge" style="width: 100%;height: 400px">${temp}</textarea>
								</div>
                                
                                <div class="form-actions">
                                    <button id="bsubmit" type="submit" data-loading-text="提交中..." class="btn btn-primary">保存</button>
                                    <a id="bsubmit" href="javascript:G.ui.tips.confirm('您确定要生成新的首页吗?', '${pageContext.request.contextPath}/back/pageset/makeindex.html');" data-loading-text="提交中..." class="btn btn-primary">生成首页</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>	<script>
		window.document.onkeydown = function(e) {
			if ('' == document.activeElement.id) {
				var e=e || event;
				var currKey=e.keyCode || e.which || e.charCode;
				if (8 == currKey) {
					return false;
				}
			}
		};
	</script>
	<script type="text/javascript">
		CodeMirror.fromTextArea(document.getElementById("tj_code"), {
			mode : 'text/html',
			syntax: 'html',   /* define Zen Coding syntax */
			profile: 'xhtml', /* define Zen Coding output profile */
			
			// send all key events to Zen Coding
			onKeyEvent: function() {
				return zen_editor.handleKeyEvent.apply(zen_editor, arguments);
			}
		});
	</script>
</html>