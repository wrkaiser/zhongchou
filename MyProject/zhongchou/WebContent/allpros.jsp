<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<jsp:include page="common.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_项目列表</title>
<meta name="keywords" content="${pageinfio.keywords}" />
<meta name="description" content="${pageinfio.description}" />
<link rel="shortcut icon" href="img/favicon.ico" />
<!--public js&css start-->
<link href="css/ubase.css?v=20141112" rel="stylesheet" type="text/css">
<script src="js/jquery-1.8.2.js?v=20141112"></script>
<script src="js/wx.js?v=20141112"></script>
<script src="js/wx.config.js?v=20141112"></script>
<script src="js/common.js?v=20141112"></script>
<script src="js/json2.js?v=20141112"></script>
<link rel="stylesheet" type="text/css"
	href="css/14c4c0d24fba6ed25d8b6758064ef7b8.css?V=1424230480">
<script type="text/javascript"
	src="js/2cc0475e1160ea574d0a9b5ebea60136.js?V=1424230480"></script>
</head>

<body>
	<jsp:include page="top.jsp" />
	<link rel="stylesheet" type="text/css"
		href="css/26238307520063c1bed12d636680a99c.css?V=1424230480">
	<!--subnav static-->
	<div class="m-subnav">
		<div class="wrap">
			<!-- 分类 -->
			<div class="m-nav-left">
				<ul>
					<li class="selected"><a
						href="${pageContext.request.contextPath}/deal/allProsList.html">全部</a></li>
					<logic:notEmpty name="cate">
						<logic:iterate id="c1" name="cate">
							<li><a
								href="${pageContext.request.contextPath}/deal/allProsList/${c1.id}.html">${c1.name
									}</a></li>
						</logic:iterate>
					</logic:notEmpty>

				</ul>
			</div>
		</div>
	</div>
	<!--subnav end-->

	<!--main static-->
	<!--project static-->
	<div class="wrap m-box ">
		<div class="deputy-nav clearfix">
			<div class="m-deputy-left">
				<a class="select"
					href="${pageContext.request.contextPath}/deal/allProsList.html"> <label>所有项目(${count1})</label></a>
				<ul class="ul-slide">
					<li><a href="${pageContext.request.contextPath}/deal/list.html">众筹中(${count})</a></li>
					<li><a href="${pageContext.request.contextPath}/deal/successedList.html">已成功(${count2})</a></li>
					<li class="end"><a
						href="${pageContext.request.contextPath}/deal/willStartList.html">即将开始(${count3})</a></li>
				</ul>
			</div>
			<div class="m-deputy-left">
				<a href="${pageContext.request.contextPath}/deal.do?m=allProsList&c=${c}"><label>
						默认排序</label></a>
				<ul class="ul-slide">
					<li><a
						href="${pageContext.request.contextPath}/deal.do?m=allProsList&c=${c}&x=zxsx">最新上线</a></li>
					<li><a
						href="${pageContext.request.contextPath}/deal.do?m=allProsList&c=${c}&x=zgje">最高目标金额</a></li>
					<li><a
						href="${pageContext.request.contextPath}/deal.do?m=allProsList&c=${c}&x=zdzcrs">最多支持人数</a></li>
					<li class="end"><a
						href="${pageContext.request.contextPath}/deal.do?m=allProsList&c=${c}&x=zdzcje">最多支持金额</a></li>
				</ul>
			</div>
		</div>



		<div class="focus-box">
			<ul class="focus-con clearfix">
				<!-- deal_card - widget -->

				<logic:notEmpty name="list">

					<logic:iterate id="l" name="list">
						<li>
							<div class="list-item" style="background: #FFF">
								<a target="_blank" class="item-figure"
									href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html"> <img src="${l.proimg}" alt=""
									title="${l.bigpoint}" />
								</a>
								<div class="z-lump ">
									<h2>
										<a target="_blank" href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html">${l.proname
											}</a></h2>



										<!-- 众筹中 -->
									<p class="z-raising">
										已筹资<em>￥</em><i>${l.money }万</i>
									</p>
									<div class="progress-bar">
										<span class="progress bg-yellow" style="width: ${l.bili}%;"></span>
									</div>
									<div class="item-rate clearfix">
										<span class="rate1">${l.bili}%</span>

									</div>
									<!-- 已成功 -->


								</div>
								<p class="z-assist clearfix">
									<a class="assist1" target="_blank" title="喜欢数"
										href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html">${l.loves }</a> <a class="assist2"
										target="_blank" title="评论数"
										href="${pageContext.request.contextPath}/deal/proDetail/${l.proid}.html">${l.comms
										}</a>
								</p>
							</div>
						</li>
					</logic:iterate>
				</logic:notEmpty>


			</ul>
		</div>
            
		<logic:greaterThan value="1" name="pageinfo" property="totalPages">
			<mytag:commonpage currentPage="${pageinfo.currentPage}"
				totalPages="${pageinfo.totalPages}"
				totalRows="${pageinfo.totalRows}"
				url="${pageContext.request.contextPath}/deal.do?m=allProsList&x=${x}&c=${c}"
				css="pager" kbdable="false" />
		</logic:greaterThan>

	</div>
	<!--main end-->
	<jsp:include page="foot.jsp" />
</body>
</html>
<script type="text/javascript"
	src="js/a7d1b01d050565d082db3ed5324a6240.js?V=1424230480"></script>
