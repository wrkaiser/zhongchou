<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@page import="java.util.Map"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@page import="com.xiaoyou.data.PageInfo" %>
<%@page import="java.util.List"%>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %> 
   <%
              String sql = "";
              BaseDao dao=new BaseDao(); 
              String m = request.getParameter("m");
              String p = request.getParameter("p");
              PageInfo pageinfo = new PageInfo();
              pageinfo.setPageSize(10);
              pageinfo.setCurrentPage(p);
              if(m!=null&&m.equals("delete")){
              	sql="delete  from zh_pros where proid="+request.getParameter("proid");
              	dao.delete(sql);
              }
              if(m!=null&&m.equals("update"))
              {
              	sql="update zh_pros  set comm='"+request.getParameter("comm")+"',ischecked="+request.getParameter("status")+ ",uptime=unix_timestamp()  where proid="+request.getParameter("proid");
              	dao.update(sql);
              	out.print("{\"errno\":\"0\",\"tip\":\"保存成功\",\"url\":\""+request.getContextPath()+"/back/pro/pros.jsp?p="+p+"\"}");
                //out.print("{status:false,errortext:\"修改成功！\"}");
                return;
              }
              List<Map> list= null;
              if(m!=null&&m.equals("select"))
              {    
            	  String proname = request.getParameter("proname");
            	  String status = request.getParameter("status"); //获取之前条件选择状态栏的状态
            	  String catid = request.getParameter("category");
            	  if(catid!=null&&"0".equals(catid)){
            	  int flag = 0;
            	  if(status!=null&&"1".equals(status)||status!=null&&"0".equals(status)){	  
            		 // sql="select * ,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttime  from zh_users where  ischecked="+status ;
                   list=  dao.getListByPage("zh_pros where  ischecked="+status,"*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(uptime, '%Y-%m-%d') uptime ",pageinfo);  		 

            		 flag = 1;
            	  }
            	  
            	  if(proname!=null&&!proname.isEmpty()){
           
            		  if(flag==1){
            			  //sql="select * ,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttimefrom zh_users where  username like '%"+username+"%' and  ischecked="+status;
              			list=  dao.getListByPage("zh_pros where  proname like '%"+proname+"%' and  ischecked="+status,"*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(uptime, '%Y-%m-%d') uptime ",pageinfo);

            		  }else{
            			  //sql="select *,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(lasttime, '%Y-%m-%d') lasttimefrom zh_users where  username like '%"+username+"%'";
            	   	list=  dao.getListByPage("zh_pros where proname like '%"+proname+"%'","*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(uptime, '%Y-%m-%d') uptime ",pageinfo);  		 
            		  }
            		  flag = 1;
            	  }
            	  if(flag==0){
            		  pageinfo.setQueryStr("zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.type=18  ");
                      list=  dao.getListByPage("zh_pros, zh_pro_cat ,wei_common_type","zh_pros.*,FROM_UNIXTIME(zh_pros.addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(zh_pros.uptime, '%Y-%m-%d') uptime ,wei_common_type.name",pageinfo);
            	  }
            	  request.setAttribute("nowstatus",status);
            	  request.setAttribute("cate","0");
            	  for (Map ma : list) {
                		String proid = (String) ma.get("proid");
                		String financialneeds = (String) ma.get("financialneeds");
                		String g;
                		if (financialneeds == null||financialneeds=="") {
            				g = "0";
            				
            			} else {
            				g=financialneeds;
            			}
  	
            			g = new StringBuilder(g).reverse().toString(); //先将字符串颠倒顺序    
            			String str1 = "";
            			for (int i = 0; i < g.length(); i++) {
            				if (i * 3 + 3 > g.length()) {
            					str1 += g.substring(i * 3, g.length());
            					break;
            				}
            				str1 += g.substring(i * 3, i * 3 + 3) + ",";
            			}
            			if (str1.endsWith(",")) {
            				str1 = str1.substring(0, str1.length() - 1);
            			}
            			
            			g = new StringBuilder(str1).reverse().toString();
            			ma.put("financialneeds", g);
                		try {
                			sql = "select sum(money) as money from  zh_pro_orders where proid="
                					+ proid;
                			Map aa = dao.queryone(sql);
                			String b;
                			double z;
                			String money;
                			if (aa.get("money") == null) {
                				b = "0";
                				z = 0;
                			} else {
                				b = aa.get("money").toString();
                				//System.out.println(money);
                				int t = (int) Float.parseFloat(b);
                				z = Double.parseDouble(b);
                				b = "" + t;
                				//System.out.println(b);
                			}
      	
                			b = new StringBuilder(b).reverse().toString(); //先将字符串颠倒顺序    
                			String str = "";
                			for (int i = 0; i < b.length(); i++) {
                				if (i * 3 + 3 > b.length()) {
                					str += b.substring(i * 3, b.length());
                					break;
                				}
                				str += b.substring(i * 3, i * 3 + 3) + ",";
                			}
                			if (str.endsWith(",")) {
                				str = str.substring(0, str.length() - 1);
                			}
                			//最后再将顺序反转过来    
                			b = new StringBuilder(str).reverse().toString();

                			ma.put("money", b);
                			
                		} catch (Exception e) {
                			out.print("{status:false,errortext:\"系统异常："
                					+ e.getMessage() + "\"}");
                		}
                	}
            	  
              }
              else{
            	  int flag = 0;
            	  if(status!=null&&"1".equals(status)||status!=null&&"0".equals(status)){
            		pageinfo.setQueryStr("zh_pros.proid=zh_pro_cat.proid and zh_pro_cat.catid=wei_common_type.id and wei_common_type.type=18  and zh_pros.ischecked="+status+" and wei_common_type.id="+catid);
                    list=  dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type","zh_pros.*,FROM_UNIXTIME(zh_pros.addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(zh_pros.uptime, '%Y-%m-%d') uptime ,wei_common_type.name",pageinfo); 		 
            		 flag = 1;
            	  }
            	  
            	  if(proname!=null&&!proname.isEmpty()){
            		  if(flag==1){
            			  pageinfo.setQueryStr("zh_pros.proid=zh_pro_cat.proid and zh_pro_cat.catid=wei_common_type.id and wei_common_type.type=18 and  zh_pros.ischecked="+status+" and wei_common_type.id="+catid+" and zh_pros.proname like '%"+proname+"%'");
                          list=  dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type","zh_pros.*,FROM_UNIXTIME(zh_pros.addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(zh_pros.uptime, '%Y-%m-%d') uptime ,wei_common_type.name",pageinfo); 		 
              		//	list=  dao.getListByPage("zh_pros where  proname like '%"+proname+"%' and  ischecked="+status,"*,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(uptime, '%Y-%m-%d') uptime ",pageinfo);

            		  }else{
            			  pageinfo.setQueryStr("zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.type=18  and wei_common_type.id="+catid+" and zh_pros.proname like '%"+proname+"%'");
                          list=  dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type","zh_pros.*,FROM_UNIXTIME(zh_pros.addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(zh_pros.uptime, '%Y-%m-%d') uptime ,wei_common_type.name",pageinfo); 		 
            		  }
            		  flag = 1;
            	  }
            	  if(flag==0){
            		  pageinfo.setQueryStr("zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.type=18 and wei_common_type.id="+catid );
                      list=  dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type","zh_pros.*,FROM_UNIXTIME(zh_pros.addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(zh_pros.uptime, '%Y-%m-%d') uptime ,wei_common_type.name",pageinfo);
            	  }
            	  request.setAttribute("nowstatus",status);
            	  request.setAttribute("cate",catid);
            	   for (Map ma : list) {
                 		String proid = (String) ma.get("proid");
                 		String financialneeds = (String) ma.get("financialneeds");
                 		String g;
                 		if (financialneeds == null||financialneeds=="") {
             				g = "0";
             				
             			} else {
             				g=financialneeds;
             			}
   	
             			g = new StringBuilder(g).reverse().toString(); //先将字符串颠倒顺序    
             			String str1 = "";
             			for (int i = 0; i < g.length(); i++) {
             				if (i * 3 + 3 > g.length()) {
             					str1 += g.substring(i * 3, g.length());
             					break;
             				}
             				str1 += g.substring(i * 3, i * 3 + 3) + ",";
             			}
             			if (str1.endsWith(",")) {
             				str1 = str1.substring(0, str1.length() - 1);
             			}
             			
             			g = new StringBuilder(str1).reverse().toString();
             			ma.put("financialneeds", g);
                 		try {
                 			sql = "select sum(money) as money from  zh_pro_orders where proid="
                 					+ proid;
                 			Map aa = dao.queryone(sql);
                 			String b;
                 			double z;
                 			String money;
                 			if (aa.get("money") == null) {
                 				b = "0";
                 				z = 0;
                 			} else {
                 				b = aa.get("money").toString();
                 				//System.out.println(money);
                 				int t = (int) Float.parseFloat(b);
                 				z = Double.parseDouble(b);
                 				b = "" + t;
                 				//System.out.println(b);
                 			}
       	
                 			b = new StringBuilder(b).reverse().toString(); //先将字符串颠倒顺序    
                 			String str = "";
                 			for (int i = 0; i < b.length(); i++) {
                 				if (i * 3 + 3 > b.length()) {
                 					str += b.substring(i * 3, b.length());
                 					break;
                 				}
                 				str += b.substring(i * 3, i * 3 + 3) + ",";
                 			}
                 			if (str.endsWith(",")) {
                 				str = str.substring(0, str.length() - 1);
                 			}
                 			//最后再将顺序反转过来    
                 			b = new StringBuilder(str).reverse().toString();

                 			ma.put("money", b);
                 			
                 		} catch (Exception e) {
                 			out.print("{status:false,errortext:\"系统异常："
                 					+ e.getMessage() + "\"}");
                 		}
                 	}
              }} else{
             	 
            	  pageinfo.setQueryStr("zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.type=18  ");
                  list=  dao.getListByPage("zh_pros, zh_pro_cat ,wei_common_type","zh_pros.*,FROM_UNIXTIME(zh_pros.addtime, '%Y-%m-%d') addtime ,FROM_UNIXTIME(zh_pros.uptime, '%Y-%m-%d') uptime ,wei_common_type.name",pageinfo);
                  request.setAttribute("nowstatus","2");
                  request.setAttribute("cate","0");
                  for (Map ma : list) {
              		String proid = (String) ma.get("proid");
              		String financialneeds = (String) ma.get("financialneeds");
              		String g;
              		if (financialneeds == null||financialneeds=="") {
          				g = "0";
          				
          			} else {
          				g=financialneeds;
          			}
	
          			g = new StringBuilder(g).reverse().toString(); //先将字符串颠倒顺序    
          			String str1 = "";
          			for (int i = 0; i < g.length(); i++) {
          				if (i * 3 + 3 > g.length()) {
          					str1 += g.substring(i * 3, g.length());
          					break;
          				}
          				str1 += g.substring(i * 3, i * 3 + 3) + ",";
          			}
          			if (str1.endsWith(",")) {
          				str1 = str1.substring(0, str1.length() - 1);
          			}
          			
          			g = new StringBuilder(str1).reverse().toString();
          			ma.put("financialneeds", g);
              		try {
              			sql = "select sum(money) as money from  zh_pro_orders where proid="
              					+ proid;
              			Map aa = dao.queryone(sql);
              			String b;
              			double z;
              			String money;
              			if (aa.get("money") == null) {
              				b = "0";
              				z = 0;
              			} else {
              				b = aa.get("money").toString();
              				//System.out.println(money);
              				int t = (int) Float.parseFloat(b);
              				z = Double.parseDouble(b);
              				b = "" + t;
              				//System.out.println(b);
              			}
    	
              			b = new StringBuilder(b).reverse().toString(); //先将字符串颠倒顺序    
              			String str = "";
              			for (int i = 0; i < b.length(); i++) {
              				if (i * 3 + 3 > b.length()) {
              					str += b.substring(i * 3, b.length());
              					break;
              				}
              				str += b.substring(i * 3, i * 3 + 3) + ",";
              			}
              			if (str.endsWith(",")) {
              				str = str.substring(0, str.length() - 1);
              			}
              			//最后再将顺序反转过来    
              			b = new StringBuilder(str).reverse().toString();

              			ma.put("money", b);
              			
              		} catch (Exception e) {
              			out.print("{status:false,errortext:\"系统异常："
              					+ e.getMessage() + "\"}");
              		}
              	}
              }
              sql="select * from  wei_common_type where type=18";
              List<Map> list1=dao.getList(sql);
              request.setAttribute("list",list);
              request.setAttribute("list1",list1);
              request.setAttribute("pageinfo", pageinfo);
       %> 
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/bootstrap_responsive_min.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/style.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/todc_bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/themes.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/css/inside.css" media="all">
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/jQuery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/bootstrap_min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/zeroclipboard.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/back/js/inside.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/chosen_jquery_min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/plugins/jquery_form_min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/plugins/jquery_validate_min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/plugins/jquery_validate_methods.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/resource.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/back/js/reveal.js"></script>
<script   src="${pageContext.request.contextPath}/editor/kindeditor.js"></script>
 <script charset="utf-8"  src="${pageContext.request.contextPath}/editor/preview.js"></script>

<link rel="stylesheet" type="text/css" href="pro.css" > 
<title>汇鑫—国内最大的客户管理系统</title>
<!--[if IE 7]><link href="${pageContext.request.contextPath}/back/css/font_awesome_ie7.css" rel="stylesheet" /><![endif]-->


<script type="text/javascript">
	 $(function(){
		  $("#cate[name='status']").val('${nowstatus}'); 
		  $("#cate1[name='category']").val('${cate}'); 
	 });
	   function convery(proid,ischecked,comm,tsort){	
			$("#myModal select[name='status']").val(ischecked);
			$("#proid").val(proid);
			$("#label").text(comm);		
			$("#tsort").val(tsort);
		}
</script>
</head>
<body>
<div id="main">
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="box-content nozypadding">
                  <div class="span8 control-group" style="width:100%">
                       <div class="span5" style="width: 60px">
                            <a class="btn" href="javascript:location.reload();"><i class="icon-refresh"></i></a>         
                        </div>
                        <form action="${pageContext.request.contextPath}/back/pro/pros.jsp?m=select" method="post" >
                             <input id="prorname" name="proname" type="text" style="float: left"  style="width:140px"></input>
                             <select name="category" id="cate1" style="float: left;margin-left: 10px"  >
                                <option   value="0" >所有</option>
                                <logic:notEmpty name="list1">
                                    <logic:iterate id="l1" name="list1">
                                    <option   value="${l1.id }">${l1.name }</option>
                                    </logic:iterate> 
                                </logic:notEmpty>
                                     
                             </select>
                             <select name="status" id="cate" style="float: left;margin-left: 10px"  >
                                <option   value="2" >所有</option>
                                 <option   value="0">未审核</option><option value="1">待审核</option>
                                
                             </select>
                             <input type="submit" value="查询"  style="margin:0px 0px 0;float: left;margin-left: 10px" class="btn"> </input>
					   </form>
                 </div>
            </div>
         </div>
         <div class="row-fluid dataTables_wrapper">
             <table id="listTable" class="table table-bordered table-hover dataTable">
                   <thead>
                       <tr>
                         <th>项目编号</th>
                          <th>项目名字</th>
                           <th>项目添加时间</th>
                             <th>项目审核时间</th>
                               <th>项目类型</th>
                                <th>审核状态</th>
                                <th>预约金额/筹资目标(万)</th>
                                 <th>操作</th>
                        </tr> 
                     </thead>
                     <tbody>
                          <logic:notEmpty  name="list">
                           <logic:iterate id="l" name="list">
                              <tr <c:if test="${l.ischecked eq 1}" >
                                        style='background:#EEE685' "
                               </c:if>>
                                       <td>${l.proid}</td>
                                       <td><a href="${pageContext.request.contextPath}/deal/proDetail/${l.proid }.html" target="_blank">${l.proname}</a></td>
                                       <td>${l.addtime}</td>
                                       <td>${l.uptime}</td>
                                       <td>${l.name } </td>
                                       <td>
                                       <c:if test="${l.ischecked==0 }">未发布</c:if>
								       <c:if test="${l.ischecked==1 }">审核中</c:if>
								       <c:if test="${l.ischecked==2 }">预约中</c:if>
								       <c:if test="${l.ischecked==3 }">发行中</c:if>
								       <c:if test="${l.ischecked==4 }">已结束</c:if>
								       <c:if test="${l.ischecked==5 }">未通过</c:if>
								       </td>
								       <td>
								        <c:if test="${l.ischecked==1 }">0/${l.financialneeds }</c:if>
								       <c:if test="${l.ischecked==2 }">${l.money }/${l.financialneeds }</c:if>
								       <c:if test="${l.ischecked==3 }">${l.money }/${l.financialneeds }</c:if>
								       <c:if test="${l.ischecked==4 }">${l.money }/${l.financialneeds }</c:if>
								       <c:if test="${l.ischecked==5 }">0/${l.financialneeds }</c:if>
								      </td>
                                    <td> <%-- <a class="btn" href="update.jsp?proid=${l.proid }&s=${l.ischecked}" title="编辑"><i class="icon-edit"></i></a> --%>
                                         <a class="btn"   title="审核修改" onclick="convery(${l.proid},${l.ischecked },'${l.comm }','${l.tsort }');" data-reveal-id="myModal"> <i class="icon-edit"></i></a>  
                                         <a class="btn"   title="项目资料"  href="detail.jsp?proid=${l.proid}"> 详细</a>     
                                         <a class="btn"   title="添加路演"  href="addluyan.jsp?proid=${l.proid}&status=${nowstatus}&category=${cate}&p=${pageinfo.currentPage}"> 添加路演</a>                                       
                                     </td>
                                     </tr>          
                                </logic:iterate>
                               </logic:notEmpty>
                    </tbody>
   
                    <div id="myModal" class="reveal-modal">
	                                <form id="replyform" name="replyform"  action="${pageContext.request.contextPath}/back/pro/pros.jsp" method="post" class="form-horizontal form-validate" >
                             <input type="hidden" id="proid" name="proid"  />
                                      <input type="hidden" name="m" value="update" />
                                       <input type="hidden" name="p" value="${pageinfo.currentPage}" />
                                 <div class="control-group">
                                    <label class="control-label" for="shopid">审核状态：</label>
                                    <div class="controls">
                                      <select name="status"  >
                                    	<option value="1" >待审核</option>
                                    	<option value="5" >不通过审核</option>
                                    	<option value="2"  >发布预约中</option>
                                    	<option value="3"  >发行中</option>
                                    	<option value="4"  >结束</option>
                                    </select>								
                                    </div>
                                </div>
                                 <div class="control-group">
                                    <label for="name" class="control-label">
                                                                                                    审核介绍：
             
                                    </label>
                                    <div class="controls">
                                        <textarea  name="comm" id="label" class="input-large" data-rule-required="true" data-rule-maxlength="150" ></textarea>
                                      <span class="maroon">*不要超过200字</span>
                                    </div>
                                </div>
                                 <div class="control-group">
                                    <label for="name" class="control-label">
                                                                                                   排    序：
             
                                    </label>
                                    <div class="controls">
                                        <input  name="tsort" id="tsort" class="input-large" data-rule-required="true"  value=""></input><br/>
                                        <span class="maroon"> *输入整数(由大到小排序) , 网站《热门项目》是取序号的前20个 
                                        </span>
                                    </div>
                                </div>
                                <div>
                               
                                </div>
                             <div class="form-actions" style="padding-left:100px">
                                    <button id="bsubmit" type="submit" data-loading-text="提交中..."class="btn btn-primary">保存</button>
                                   <a class="close-reveal-modal">&#215;</a>
                                                                                                  
                                </div>
                            </form>
                            </div>                    
         </table>
         <logic:greaterThan value="1" name="pageinfo" property="totalPages">
						         <mytag:commonpage  currentPage="${pageinfo.currentPage}" totalPages="${pageinfo.totalPages}" totalRows="${pageinfo.totalRows}" url="${pageContext.request.contextPath}/back/pro/pros.shtml?m=select&status=${nowstatus}&category=${cate}" css="dataTables_paginate paging_full_numbers" kbdable="false"/>
						          </logic:greaterThan> 
									<div class="dataTables_paginate paging_full_numbers"><span>       </span></div>                          
                            </div>
           </div>
      </div>            
    </body>
</html>