<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="common.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_关于我们</title>
<meta name="keywords" content="${pageinfio.keywords}" />
<meta name="description" content="${pageinfio.description}" />
<link rel="shortcut icon" href="img/favicon.ico" />
<link href="css/about_us.css?v=20150309" rel="stylesheet" type="text/css">
<link href="css/base.css?v=20150309" rel="stylesheet" type="text/css">
<link href="css/common.css?v=20150309" rel="stylesheet" type="text/css">
<script src="js/jquery-1.8.2.js?v=20150309"></script>
<script src="js/wx.js?v=20150309"></script>
<script src="js/wx.config.js?v=20150309"></script>
<script src="js/common.js?v=20150309"></script>
<script src="js/json2.js?v=20150309"></script>
</head>
<body>
	<jsp:include page="top.jsp" />
   <!--header end-->      
<!-- content static -->
<div class="wrap">
    <div class="us-content link-content">
        <h5>${doc.title }</h5>
           ${doc.content }
    </div>
</div>
<!-- content end -->
<jsp:include page="foot.jsp" />
</body>
</html>