<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <base target="mainFrame" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/index.css?2013-12-05-1" media="all" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_min.css?2013-12-05-1" media="all" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_responsive_min.css?2013-12-05-1" media="all" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/style.css?2013-12-05-1" media="all" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/themes.css?2013-12-05-1" media="all" />
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jQuery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/application.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/bootstrap_min.js"></script>
<logic:empty name="User">
<script>
 parent.location.href="${pageContext.request.contextPath}/log.shtml";
</script>
</logic:empty>
<title>众筹网后台管理系统</title>
  <!--[if IE 7]>
       <link href="${pageContext.request.contextPath}/back/css/font_awesome_ie7.css" rel="stylesheet" />
  <![endif]-->
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/back/js/excanvas_min.js"></script><![endif]-->
</head>

<body>
	<div id="navigation">
      <jsp:include page="admin_top.jsp"></jsp:include>   
</div>




	<div class="container-fluid" id="content">
		<div id="left">
		       <jsp:include page="left.jsp"></jsp:include>   
		</div>
	

		<div class="right">
			<div class="main">
				<iframe frameborder="0" id="mainFrame" name="mainFrame" src="${pageContext.request.contextPath}/back/welcome.shtml" style="background:url('http://stc.weimob.com/img/loading.gif?=2013-12-05-1') center no-repeat;"></iframe>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			// 绑定菜单提示语切换
			$('#menu-handle').click(function(){
				switchMenu(this);
			});

			// 设置皮肤色
			P.skn();
		});

		// 切换菜单提示语
		function switchMenu(obj){
			if('隐藏菜单' == $(obj).attr('title')){
				$(obj).attr('title', '显示菜单');
			}else{
				$(obj).attr('title', '隐藏菜单');
			}
		}
	</script>
</body>
</html>

