<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!--header static-->
<div class="header">
	<div class="wrap clearfix">		
        <div class="m-left">
          <h1><a alt="众筹平台" class="img-logo" title="众筹平台" href="${pageContext.request.contextPath}/">众筹平台</a></h1>
          <ul class="m-nav clearfix">
          	<li ><a class="z-home"  href="index.html"><span><i class="s-01" ></i></span>首页</a></li>
          	<li ><a href="deal/list.html" ><i class="s-02" ></i>浏览项目</a></li>
          	<li ><a href="center/newdeal.shtml" ><i class="s-03" ></i>发起项目</a></li>   
          </ul>
        </div>
        <div class="m-right clearfix">
        	 <form id="se1" name="se1" action="${pageContext.request.contextPath}/deal.do" method="post" wx-validator>
        	    <input name="m" value="search" type="hidden">
        		<span>
        		 <input wx-validator-notip name="q" type="text" value=""  placeholder="输入关键词" />
        		  <a  type="submit" class="bh-mhnbo"></a>
        		</span>
        	</form>
            <logic:empty name="QUser">
            <!-- 未登陆的效果 -->
            	                 	 <div class="z-Login">	        	
	        	<a class="z-register" href="reg.shtml" class="Js-showRegister">注册</a>
	        	<a id="user_login" class="Js-showLogin" href="javascript:;">登录</a>
            </div> 
            </logic:empty>
            <logic:notEmpty name="QUser">
             <!-- 登陆的效果 -->
                 <div id="Js-header-loginBtn">
              <div class="pull-down">
                <i class="meun-01"></i><em>${QUser.username}</em>               
              </div>
              <div class="menu-down" style="display: none;">
                  <ul id="Js-header-login">
                    <li><a href="${pageContext.request.contextPath}/center/deal.shtml"><i class="down-menu01"></i>个人中心</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/myinfo.shtml"><i class="down-menu02"></i>设置</a></li>
                   <!-- <li><a href="/my/msg"><i class="down-menu03"></i>消息</a></li> --> 
                    <li><a href="${pageContext.request.contextPath}/log.shtml?m=logout"><i class="down-menu04"></i>退出</a></li>
                  </ul>
              </div>
            </div>    
            </logic:notEmpty>  
        </div>
	</div>		
</div>

