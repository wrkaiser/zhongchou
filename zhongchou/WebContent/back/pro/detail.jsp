<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@page import="java.util.Map"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@page import="com.xiaoyou.data.PageInfo" %>
<%@page import="java.util.List"%>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %> 
<%@ page import="com.xiaoyou.util.JsonUtil" %>
<%
    BaseDao dao=new BaseDao();
    String proid= request.getParameter("proid");
    String sql="select * from zh_pros where proid="+proid;
    Map map=dao.queryone(sql);
    request.setAttribute("map", map);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>项目资料</title>
<link href="${pageContext.request.contextPath}/css/ubase.css?v=20141112" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.2.js?v=20141112"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/style.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/back/css/todc_bootstrap.css" media="all">
</head>
<body>
<style>
   .Sbtitle{background-color: #3d4855;color: #fff;height: 45px;line-height: 45px;margin-bottom: 10px;text-align: center;font-size: 18px;}
   .I_item{padding:9px 0;font-size:16px;background:#efefef;margin-bottom:5px;}
   .I_item label{display:inline-block;width:20%; text-align:right;padding-right:5px; vertical-align:top;}
   .I_item .itips{zoom:1;display:inline-block;width:70%; vertical-align:top;}
   a.download{color:#096;}
   .ImgPrev img{height:50px;border:2px solid #999; cursor:pointer; border-radius:8px;}
   .ttables{width:90%;border-toP:1px solid #ddd; border-right:1px solid #ddd;}
   .ttables td{padding:5px; text-align:center;background:#fff;border-left:1px solid #ddd;border-bottom:1px solid #ddd;}
   .ttables tr.tt td{background-color:#f2f2f2;color:#333;font-weight:bold;}
</style>
<div  style="width:800px; overflow:hidden;margin:0 auto;">
<div class="Sbtitle">项目资料</div>
<div class="Info-list">
    <div class="I_item">
       <label>商业计划书：</label><div class="itips"><A href="upload_bp" class="download" target="_blank">商业计划书downLoad</A></div>
    </div>
    <div class="I_item">
       <label>注册资本：</label><div class="itips">${map.registered_capital }</div>
    </div>
     <div class="I_item">
       <label>法人代表：</label><div class="itips">${map.legal_person }</div>
    </div>
    <div class="I_item">
       <label>营业执照：</label><div class="itips"><span class="ImgPrev"><img src="${map.bussiness_license}" /></span></div>
    </div>
    <script>
        $(function(){
        	var str="";
        	if('${map.equity_structure}'!=null&&'${map.equity_structure}'!=""){
        		str= "<div class='I_item'><label>股权比例：</label><div class='itips'><table cellpadding='0' cellspacing='0' class='ttables'>"+
        		 "<tr class='tt'><td>姓名</td><td>职位</td><td>金额(万元)</td><td>占比</td></tr>";
        		var json=eval('${map.equity_structure}');
        		$.each(json,function(i,item){
        			if(item.shareholder!=null&&item.shareholder!=""){
        		   str+="<tr><td>"+item.shareholder+"</td><td>"+item.title+"</td><td>"+item.contribution+"</td><td>"+item.share+"%</td></tr>";
        			}
        		});
        		 str=str+"</table></div>"
        		$(".Info-list").append(str);
	        }
         });
      
 </script>
                             
</div>        
</div>
   <center> <div class="span2" style="margin-top:20px"><a class="btn" href="Javascript:window.history.go(-1)" style="font-size:20px">返回</a></div> </center>
</body>
</html>
