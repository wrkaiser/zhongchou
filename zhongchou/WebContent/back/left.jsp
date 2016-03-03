<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>管理页面</title>

<script
	src="${pageContext.request.contextPath}/back/js/prototype.lite.js"
	type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/back/js/moo.fx.js"
	type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/back/js/moo.fx.pack.js"
	type="text/javascript"></script>
<style>
body {
	font: 12px Arial, Helvetica, sans-serif;
	color: #000;
	background-color: #fff;
	margin: 0px;
}

#container {
	width: 182px;
}

H1 {
	font-size: 12px;
	margin: 0px;
	width: 182px;
	cursor: pointer;
	height: 30px;
	line-height: 20px;
}

H1 a {
	display: block;
	width: 182px;
	color: #000;
	height: 30px;
	text-decoration: none;
	moz-outline-style: none;
	background-image:
		url(${pageContext.request.contextPath}/back/images/menu_bgS.gif);
	background-repeat: no-repeat;
	line-height: 30px;
	text-align: center;
	margin: 0px;
	padding: 0px;
}

.content {
	width: 182px;
	height: 26px;
}

.MM ul {
	list-style-type: none;
	margin: 0px;
	padding: 0px;
	display: block;
}

.MM li {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	list-style-type: none;
	display: block;
	text-decoration: none;
	height: 26px;
	width: 182px;
	padding-left: 0px;
}

.MM {
	width: 182px;
	margin: 0px;
	padding: 0px;
	left: 0px;
	top: 0px;
	right: 0px;
	bottom: 0px;
	clip: rect(0px, 0px, 0px, 0px);
}

.MM a:link {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	background-image:
		url(${pageContext.request.contextPath}/back/images/menu_bg1.gif);
	background-repeat: no-repeat;
	height: 26px;
	width: 182px;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	overflow: hidden;
	text-decoration: none;
}

.MM a:visited {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	background-image:
		url(${pageContext.request.contextPath}/back/images/menu_bg1.gif);
	background-repeat: no-repeat;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	height: 26px;
	width: 182px;
	text-decoration: none;
}

.MM a:active {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	background-image:
		url(${pageContext.request.contextPath}/back/images/menu_bg1.gif);
	background-repeat: no-repeat;
	height: 26px;
	width: 182px;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	overflow: hidden;
	text-decoration: none;
}

.MM a:hover {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	font-weight: bold;
	color: #006600;
	background-image:
		url(${pageContext.request.contextPath}/back/images/menu_bg2.gif);
	background-repeat: no-repeat;
	text-align: center;
	display: block;
	margin: 0px;
	padding: 0px;
	height: 26px;
	width: 182px;
	text-decoration: none;
}
</style>
</head>
<body marginwidth="0" marginheight="0">
	<table width="100%" height="280" border="0" cellpadding="0"
		cellspacing="0" bgcolor="#EEF2FB">
		<tbody>
			<tr>
				<td width="182" valign="top"><div id="container">
						<logic:notEmpty name="menus">
							<logic:iterate id="menu" name="menus" indexId="curIndex">
								<h1 class="type">
									<a href="javascript:void(0)">${menu.name }</a>
								</h1>
								<div class="content"
									style="visibility: visible; opacity: 1; overflow: hidden; height: 1%;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tbody>
											<tr>
												<td><img
													src="${pageContext.request.contextPath}/back/images/menu_topline.gif"
													width="182" height="5"></td>
											</tr>
										</tbody>
									</table>
									<ul class="MM">
										<logic:notEmpty name="menu" property="cmenus">
											<logic:iterate id="cm" name="menu" property="cmenus">

												<li><a
													href="${pageContext.request.contextPath}${cm.keyurl}"
													target="mainFrame">${cm.name }</a></li>
											</logic:iterate>
										</logic:notEmpty>
									</ul>
								</div>
							</logic:iterate>
						</logic:notEmpty>







					</div> <script type="text/javascript">
						var contents = document
								.getElementsByClassName('content');
						var toggles = document.getElementsByClassName('type');

						var myAccordion = new fx.Accordion(toggles, contents, {
							opacity : true,
							duration : 400
						});
						myAccordion.showThisHideOpen(contents[1]);
					</script></td>
			</tr>
		</tbody>
	</table>

</body>
</html>

