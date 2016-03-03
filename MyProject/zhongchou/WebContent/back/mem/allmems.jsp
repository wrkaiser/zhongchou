<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<%@page import="java.util.Map"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@page import="com.xiaoyou.data.PageInfo"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %> 
<%
	String sql = "";
              BaseDao dao=new BaseDao(); 
              String m = request.getParameter("m");
              String p = request.getParameter("p");
              PageInfo pageinfo = new PageInfo();
              pageinfo.setPageSize(2);
              pageinfo.setCurrentPage(p);
              if(m!=null&&m.equals("delete")){
              	sql="delete  from zh_users where userid="+request.getParameter("userid");
              	dao.delete(sql);
             
              }
              
              List<Map> list= null;
              if(m!=null&&m.equals("select"))
              {    
            	
            	  String username = request.getParameter("username");
            	  String status = request.getParameter("status");
            	 
            	 int flag = 0;
            	  if(status!=null&&"1".equals(status)||status!=null&&"0".equals(status)){
            		  
            		 // sql="select * ,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttime  from zh_users where  ischecked="+status ;
                   list=  dao.getListByPage("zh_users where  ischecked="+status,"*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttime ",pageinfo);  		 

            		 flag = 1;
            	  }
            	  
            	  if(username!=null&&!username.isEmpty()){
            		  if(flag==1){
            			  //sql="select * ,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttimefrom zh_users where  username like '%"+username+"%' and  ischecked="+status;
              			list=  dao.getListByPage("zh_users where  username like '%"+username+"%' and  ischecked="+status,"*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttime ",pageinfo);

            		  }else{
            			  //sql="select *,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttimefrom zh_users where  username like '%"+username+"%'";
            	   	list=  dao.getListByPage("zh_users where username like '%"+username+"%'","*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttime ",pageinfo);  		 
            		  }
            		  flag = 1;
            	  }
            	 
            	  
            	  if(flag==0){
            			list= dao.getListByPage("zh_users","*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttime ",pageinfo);
            	  }
    			 
    			  
            	  request.setAttribute("nowstatus",status);
              }else{
            	 
               	list=dao.getListByPage("zh_users","*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttime ",pageinfo);
                request.setAttribute("nowstatus","2");
              }
           
              request.setAttribute("list",list);
              request.setAttribute("pageinfo", pageinfo);
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="微哇、微信营销、微信代运营、微信定制开发、微信托管、微网站、微商城、微营销" name="Keywords">
<meta
	content="微哇，国内最大的微信公众智能服务平台，微哇八大微体系：微菜单、微官网、微会员、微活动、微商城、微推送、微服务、微统计，企业微营销必备。"
	name="Description">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/back/css/bootstrap_min.css"
	media="all">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/back/css/bootstrap_responsive_min.css"
	media="all">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/back/css/style.css"
	media="all">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/back/css/todc_bootstrap.css"
	media="all">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/back/css/themes.css"
	media="all">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/back/css/inside.css"
	media="all">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/back/js/jQuery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/back/js/bootstrap_min.js"></script>
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/back/js/zeroclipboard.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/back/js/inside.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/back/js/chosen_jquery_min.js"></script>
<title>汇鑫—国内最大的客户管理系统</title>
<!--[if IE 7]><link href="${pageContext.request.contextPath}/back/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->
<script>
    $(function(){
	  $("select[name='status']").val('${nowstatus}'); 
    });
	function changet(obj) {
		window.location.href = "${pageContext.request.contextPath}/back/commontype.do?m=list&id="
				+ $(obj).val();
	
	}
</script>
</head>
<body>

	<div id="main">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="box-content nozypadding">
					<div class="span8 control-group">
						<div class="span5" style="width: 120px">
							<a href="add.jsp" class="btn"><i class="icon-plus"></i>添加</a> <a
								class="btn" href="javascript:location.reload();"><i
								class="icon-refresh"></i></a>

						</div>
						<form action="allmems.jsp?m=select" method="post">
							<input id="username" name="username" type="text"
								style="float: left" style="width:140px"></input> <select
								name="status" id="cate" style="float: left; margin-left: 10px" >
								<option value="0">未审核</option>
								<option value="1">&nbsp;&nbsp;&nbsp;&nbsp;已审核</option>
								<option value="2">所有</option>
							</select> <input type="submit" value="查询"
								style="margin: 0px 0px 0; float: left; margin-left: 10px"
								class="btn"> </input>
						</form>
					</div>

				</div>
			</div>

			<div class="row-fluid dataTables_wrapper">


				<table id="listTable"
					class="table table-bordered table-hover dataTable">

					<thead>
						<tr>
							<th>会员编号</th>
							<th>会员名字</th>
							<th>会员电话</th>
							<th>省份</th>
							<th>添加时间</th>
							<th>最后一次登录时间</th>
							<th>审核状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<logic:notEmpty name="list">
							<logic:iterate id="l" name="list">
								<tr>
									<td>${l.userid}</td>
									<td>${l.username}</td>
									<td>${l.telno}</td>
									<td>${l.province}</td>
									<td>${l.addtime}</td>
									<td>${l.lasttime}</td>
									<td>
									<c:if test="${l.ischecked==0 }">未审核</c:if>
								       <c:if test="${l.ischecked==1 }">已审核</c:if>
								       <c:if test="${l.ischecked==2 }">全部</c:if>

                                      </td>
									<td><a class="btn" href="update.jsp?userid=${l.userid }"
										title="编辑"><i class="icon-edit"></i></a> <a class="btn"
										href="javascript: G.ui.tips.confirm('确定删除？','${pageContext.request.contextPath }/back/mem/allmems.jsp?m=delete&userid=${l.userid}')"
										title="删除"><i class="icon-remove"></i></a></td>
								</tr>
							</logic:iterate>

						</logic:notEmpty>



					</tbody>
				</table>
				
				
         <logic:greaterThan value="1" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/back/mem/allmems.shtml?m=select&status=${nowstatus }" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
						          </logic:greaterThan> 
			

				<div class="dataTables_paginate paging_full_numbers">
					<span> </span>
				</div>
			</div>
		</div>
	</div>
	



	
</body>

</html>