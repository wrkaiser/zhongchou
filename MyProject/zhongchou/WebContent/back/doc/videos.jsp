<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html"%>
<%@ page import="java.util.*,java.util.regex.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.json.simple.*" %>

<%
class DirFilter implements FilenameFilter {
 
    private Pattern pattern;
 
    public DirFilter(String regex) {
        pattern = Pattern.compile(regex);
    }
 
    public boolean accept(File dir, String name) {
        return pattern.matcher(name).matches();
    }
}

%>
<%
try{
String key = request.getParameter("key");
String p = request.getParameter("p");
if(p==null||p.isEmpty()){
	p = "";
}
File f = new File(request.getRealPath("")+"/video/"+p);
System.out.print(request.getRealPath("")+"/video/"+p);
File[] fs = null;
String postFix = "";
if(key!=null&&!key.isEmpty()){
	if(key.indexOf(".mp4")<0){
		postFix = ".mp4";
	}
	fs = f.listFiles(new DirFilter(key+postFix));
	
}else{
	fs = f.listFiles();
	key = "";
}
	


List list = new ArrayList();
String path = "";
if(fs!=null)
for(File ff:fs){
    int s=ff.getAbsolutePath().indexOf("gonghui");
	path = ff.getAbsolutePath().substring(s+8).replaceAll("\\\\", "\\/");;
	Map map = new HashMap();
	map.put("name",ff.getName());
	map.put("path", request.getContextPath()+"/"+path);
	if(ff.isDirectory()){
		map.put("dir", "1");
		map.put("path", path);
	}else{
		map.put("dir", "0");
	}
	list.add(map);
}
request.setAttribute("list", list);
request.setAttribute("key", key);
request.setAttribute("p", p);
}catch(Exception e){
e.printStackTrace();
	out.println(e.getMessage());
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head><title>视频列表</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_responsive_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/style.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/todc_bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/themes.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/inside.css" media="all">
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jQuery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/bootstrap_min.js"></script></style>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/zeroclipboard.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/inside.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/chosen_jquery_min.js"></script>

<script>

 function selectmenu(val,name){
	 
	 alert(val+name);
	 $("input[id=video]",window.opener.document).val(val);

	 window.close();
 }
</script>
</head>
<body>
  <div  class="box-content nozypadding">
   <div class="span8 control-group">
   	  <span style="float:left;">
   	      <form action="${pageContext.request.contextPath }/back/doc/videos.shtml" method="post">
   	      <input type="hidden" name="p" value="${p }" />
	    		 <label>请输入要查询的视频:</label><input type="text" name="key" value="${key }" class="input-xlarge">&nbsp;&nbsp;<input type="submit" class="btn" value="查询 " />
	    		<input type="button"  value="根目录 " onclick="go('news/select.shtml')" class="btn"/>
	    </form>
   	  </span>
	   
	</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="listTable" class="table table-bordered table-hover dataTable">
			 <tbody> <tr class="tit">
			    <td width="30%">类型</td>
				<td width="50%">名称</td>
                <td width="20%">操作</td>
			</tr>
		
		
		
        <logic:notEmpty name="list">
  <logic:iterate id="v" name="list">
    <tr>
    <td>${v.dir=='1' ? '目录':'视频' }</td>
    <td>
    <logic:equal value="1" name="v" property="dir">
    <a href="${pageContext.request.contextPath }/back/news/select.shtml?key=${key}&p=${v.path}">${v.name}</a>
    </logic:equal>
    <logic:equal value="0" name="v" property="dir">
    <font color="#0199DA">${v.name}</font>
    </logic:equal>
    </td>

	<td>
	<logic:equal value="0" name="v" property="dir">
     <a href="javascript:void(0)" onclick="selectmenu('${v.path }','${v.name}');" >选择</a>
     </logic:equal>
     <logic:equal value="1" name="v" property="dir">
      <a href="${pageContext.request.contextPath }/back/news/select.shtml?key=${key}&p=${v.path}">进入</a>
     </logic:equal>
     </td>
    </tr>
    </logic:iterate>
    </logic:notEmpty>

		 </tbody>
		</table>
	
  
</div>

</body>
</html>
