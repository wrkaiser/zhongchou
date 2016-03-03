<%@page import="com.xiaoyou.util.JsonUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.xiaoyou.dao.BaseDao"%><%@page import="com.xiaoyou.util.EncodeAndDecode"%><%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%><%
%>
<jsp:include page="common.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}</title>
<meta name="keywords" content="${pageinfio.keywords}"/>
<meta name="description" content="${pageinfio.description}"/>
<meta name="renderer" content="webkit"/>
<link rel="stylesheet" type="text/css" href="css/css.css" >
<script type="text/javascript" src="js/2cc0475e1160ea574d0a9b5ebea60136.js?V=1424230480" ></script>                                    
</head>
<body>
<!--header static-->
<jsp:include page="top.jsp"/>

<!--header end-->
<link rel="stylesheet" type="text/css" href="css/54a58051ccf1833f8e04a32cf144a640.css?V=1424230480" >
<!--main static-->
<!--banner static-->
	<div class="m-bannerimg">
		<ul id="slider" class="z-bimg clearfix">
		<logic:notEmpty name="tbads">
		<logic:iterate id="ad" name="tbads">
		<li><a target="_blank" href="${ad.url}"><img
					src="${ad.img}"
					data-src="${ad.img}" /></a></li>
					</logic:iterate>
		</logic:notEmpty>
		</ul>
		<div class="m-mesh">
                <span class="z-meshl"></span>
                <span class="z-meshr"></span>
            </div>      
    </div> 
<!--banner end-->
<!--subnav static-->
<!-- 浮动导航class名 z-subnav -->
<div class="m-subnav" id="nav">
	<div class="wrap">
		<div class="subnav-left Js-cata">
			<a href="${pageContext.request.contextPath }/deal/list.html">全部</a>
			<logic:notEmpty name="cats">
			<logic:iterate id="cat" name="cats">
			<a href="${pageContext.request.contextPath }/deal/list/${cat.id}.html">${cat.name}</a>
			</logic:iterate>
			</logic:notEmpty>
			</div>
		<!-- <div class="subnav-right Js-cata">			
			<a href="http://www.zhongchou.cn/difangzhan">地方站</a>
			<a href="http://www.zhongchou.cn/deals-tags/t-众筹制造">众筹制造</a>
			<a href="http://www.zhongchou.cn/open">合作专区</a>	
			
		</div> -->
	</div>      
</div>
<!--subnav end-->
<div class="wrap m-box">
	<div class="m-headline clearfix">
	    <div class="project-title">
            <span>热门项目</span>
        </div>
	    <a class="z-browse" href="${pageContext.request.contextPath }/deal/list.html">浏览全部</a>
    </div>
		<!--focus static-->
	    <div class="focus-box">
			<ul class="focus-con clearfix">
			<logic:notEmpty name="hotdeals">
			<logic:iterate id="hotdeal" name="hotdeals">
			<li>
    <div class="list-item" style="background: #FFF">
	<a target="_blank" class="item-figure" href="${pageContext.request.contextPath}/deal/proDetail/${hotdeal.proid}.html" >
	<img src="" wx-lz="${hotdeal.proimg}" alt="${hotdeal.bigpoint}" title="${hotdeal.proimg}" />
	</a>
	<div class="z-lump ">						
		<h2><a target="_blank" href="${pageContext.request.contextPath}/deal/proDetail/${hotdeal.proid}.html">${hotdeal.proname}</a></h2>
		<!-- 众筹中 -->
					<p class="z-raising">已筹资<i><fmt:formatNumber type="currency"  value="${hotdeal.cmoney}" maxFractionDigits="0"  />万</i></p>
			<div class="progress-bar">
				<span class="progress bg-yellow" style="width:<fmt:formatNumber type="number" value="${hotdeal.cpercent}" maxFractionDigits="0"/>%;"></span>
			</div>
			<div class="item-rate clearfix">
				<span class="rate1"><fmt:formatNumber type="number" value="${hotdeal.cpercent}" maxFractionDigits="0"/>%</span>
				<!-- <span class="rate2">剩余20天</span>	 -->						
			</div>
		<!-- 已成功 -->
		
    </div>
    <p class="z-assist clearfix">
    	<a class="assist1" target="_blank" title="喜欢数" href="${pageContext.request.contextPath}/deal/proDetail/${hotdeal.proid}.html">${hotdeal.loves}</a>
    	<a class="assist2" target="_blank" title="评论数" href="${pageContext.request.contextPath}/deal/proDetail/${hotdeal.proid}.html">${hotdeal.comms}</a>
    </p>
</div>
</li>
			</logic:iterate>
			</logic:notEmpty>
				
				
								
			</ul>			
		</div>
	<!--focus end-->
</div>
<div class="wrap m-box">
	<div class="m-headline clearfix">
	    <div class="project-title">
            <span>最新项目</span>
        </div>
	    <a class="z-browse" href="${pageContext.request.contextPath}/deal/list.html">浏览全部</a>
    </div>
		<!--focus static-->
	    <div class="focus-box">
			<ul class="focus-con clearfix">
			<logic:notEmpty name="newdeals">
			<logic:iterate id="newdeal" name="newdeals">
			<li>
    <div class="list-item" style="background: #FFF">
	<a target="_blank" class="item-figure" href="${pageContext.request.contextPath}/deal/proDetail/${newdeal.proid}.html" >
	<img src="" wx-lz="${newdeal.proimg}" alt="${newdeal.bigpoint}" title="${newdeal.proimg}" />
	</a>
	<div class="z-lump ">						
		<h2><a target="_blank" href="${pageContext.request.contextPath}/deal/proDetail/${newdeal.proid}.html">${newdeal.proname}</a></h2>
		<!-- 众筹中 -->
					<p class="z-raising">已筹资<i><fmt:formatNumber type="currency"  value="${newdeal.cmoney}" maxFractionDigits="0"  />万</i></p>
			<div class="progress-bar">
				<span class="progress bg-yellow" style="width:<fmt:formatNumber type="number" value="${newdeal.cpercent}" maxFractionDigits="0"/>%;"></span>
			</div>
			<div class="item-rate clearfix">
				<span class="rate1"><fmt:formatNumber type="number" value="${newdeal.cpercent}" maxFractionDigits="0"/>%</span>
				<!-- <span class="rate2">剩余20天</span>	 -->						
			</div>
		<!-- 已成功 -->
		
    </div>
    <p class="z-assist clearfix">
    	<a class="assist1" target="_blank" title="喜欢数" href="${pageContext.request.contextPath}/deal/proDetail/${newdeal.proid}.html">${newdeal.loves}</a>
    	<a class="assist2" target="_blank" title="评论数" href="${pageContext.request.contextPath}/deal/proDetail/${newdeal.proid}.html">${newdeal.comms}</a>
    </p>
</div>
</li>
			</logic:iterate>
			</logic:notEmpty>
				
				
								
			</ul>			
		</div>
	<!--focus end-->
</div>



<jsp:include page="foot.jsp"></jsp:include>
<script type="text/javascript" src="js/b78af158bede6d239fd4c1a45c707572.js?V=1424230480" ></script>
<script>
if(typeof wx !== "undefined" && typeof jQuery !== "undefined"){
	  $.extend(wx.config, {

	    //是否缓存此文件
	    cache : true,

	    //flash文件地址，如未指定将使用baseUrl
	    flashUrl : '',

	    /**
	    路由地址类型
	      0 不解析
	      1 解析格式为：/module-action/param-1
	    */
	    route : 0,

	    //默认上传地址
	    uploadUrl : '',

	    //默认上传类型，全部支持为 *
	    //uploadType : 'jpeg|jpg|png|gif',
	    uploadType : '*',

	    //默认上传文件大小，以MB为单位
	    uploadSize : '2',

	    //懒加载的显示类型，可以是show或者是fadeIn
	    lazyLoadShowType : 'show',

	    //懒加载临界点
	    lazyLoadThreshold : 100,

	    //ajax请求返回数据成功与否的标示字段
	    dataFlag : 'status',

	    //ajax请求返回数据中的描述信息，用于向用户展示
	    dataInfo : 'info',

	    //ajax请求返回数据成功与否的判断数值
	    dataSuccessVal : '1',

	    //ajax请求返回数据中用于定义业务异常展示的数值
	    dataDefaultAlertVal : '5',

	    //ajax请求返回数据中用于获得跳转地址的字段
	    dataJumpFlag : 'jump'
	  });
	}
</script>
                
<div id="gotop" class="go-top"></div>
</body>
</html> 
<div id="fenleiPop" style="display:none;">
  <div class="Js-pop-close" style="width:1140px;position: relative;">
    <img wx-lz="http://zcs6.ncfstatic.com/v3/static/images/index/pop.png?v="/>
    <div style="width: 125px; height: 50px; position: absolute; right: 140px; top: 175px; cursor: pointer; z-index: 20;"></div>
  </div>
</div>
