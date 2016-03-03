<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
Map pageinfio=new HashMap();
pageinfio.put("name", "众筹平台");
pageinfio.put("keywords", "众筹平台");
pageinfio.put("description", "众筹平台");
request.setAttribute("pageinfio", pageinfio);
%>