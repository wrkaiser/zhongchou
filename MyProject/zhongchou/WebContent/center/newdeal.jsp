<%@page import="com.xiaoyou.util.JsonUtils"%>
<%@page import="com.xiaoyou.util.JsonUtil"%>
<%@page import="com.xiaoyou.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.xiaoyou.util.JedisUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%
Object userinfo=session.getAttribute("QUser");
if(userinfo==null){
 response.sendRedirect(request.getContextPath()+"/log.shtml");
 return;
}
String m=request.getParameter("m");
BaseDao dao=new BaseDao();
if(m!=null){
	Map user=(Map)userinfo;
	String proid=request.getParameter("proid");
	String sql="select * from zh_pros where proid="+proid;
	if("save1".equals(m)){
		String project_name=StringUtil.Html2Text(request.getParameter("project_name"));
		String project_logo=request.getParameter("project_logo");
		String big_point=request.getParameter("big_point");
		String project_stage=request.getParameter("project_stage");
		String team_size=request.getParameter("team_size");
		String[] cats=request.getParameterValues("catebox");
		String province=request.getParameter("province");
		String city=request.getParameter("city");
		String project_logo_wxupload=request.getParameter("project_logo_wxupload");
		try{
			Map pro=dao.queryone(sql);
			if(pro!=null&&pro.size()>=0){
				sql="update zh_pros set proname=?,bigpoint=?,prostage=?,teamsize=?,province=?,city=?,addtime=unix_timestamp(),proimg=? where proid=?";
				Object[] params={project_name,big_point,project_stage,team_size,province,city,project_logo,proid};
				dao.update(sql, params);
			}else{
				sql="insert into zh_pros(proid,proname,bigpoint,prostage,teamsize,province,city,addtime,proimg,userid) values(?,?,?,?,?,?,?,unix_timestamp(),?,?)";
				Object[] params={proid,project_name,big_point,project_stage,team_size,province,city,project_logo,user.get("userid")};
				dao.update(sql, params);
			}
			if(cats!=null&&cats.length>0){
				dao.delete("delete from zh_pro_cat where proid="+proid);
				ArrayList alsql=new ArrayList();
				for(String catid:cats){
					sql="insert into zh_pro_cat(proid,catid,addtime) values("+proid+","+catid+",unix_timestamp())";
					alsql.add(sql);
				}
				dao.updateBatch(alsql);
			}
			out.print("{\"status\":true,\"errno\":0}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
	}else if("save2".equals(m)){
			String upload_bp=request.getParameter("upload_bp");
			String project_video=request.getParameter("project_video");
			String user_demand=request.getParameter("user_demand");
			String solution=request.getParameter("solution");
			String advantage_of_solution=request.getParameter("advantage_of_solution");
			String demand_scenario=request.getParameter("demand_scenario");
			String market_analysis=request.getParameter("market_analysis");
			String development_plan=request.getParameter("development_plan");
			String other=request.getParameter("other");
			String project_album=request.getParameter("project_album");
			String pronews=request.getParameter("project_news");
			
			sql="update  zh_pros set upload_bp=?,projectvideo=?,userdemand=?,solution=?,proyoushi=?,demandscenario=?,marketanalysis=?,developmentplan=?,other=?,pronews=?,project_album=? where proid=?";
			Object[] params={upload_bp,project_video,user_demand,solution,advantage_of_solution,demand_scenario,market_analysis,development_plan,other,pronews,project_album,proid};
			try{
				dao.update(sql, params);
				out.print("{\"status\":true,\"errno\":0}");
			}catch(Exception e){
				out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
			}
			return;
	}else if("save3".equals(m)){
		String revenuedriver=request.getParameter("revenue_driver");
		String cost_structure=request.getParameter("cost_structure");
		String financial_data=request.getParameter("financial_data");
		String profit_forecast=request.getParameter("profit_forecast");
		sql="update  zh_pros set revenuedriver=?,chengbengc=?,caiwudata=?,yingliyuce=? where proid=?";
		Object[] params={revenuedriver,cost_structure,financial_data,profit_forecast,proid};
		try{
			dao.update(sql, params);
			out.print("{\"status\":true,\"errno\":0}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
   }else if("save4".equals(m)){
		String is_company=request.getParameter("is_company");
		sql="update  zh_pros set iscompany=? where proid=?";
		Object[] params={is_company,proid};
		try{
			dao.update(sql, params);
			out.print("{\"status\":true,\"errno\":0}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
  }else if("save5".equals(m)){
		String is_company=request.getParameter("is_company");
		String companyname=request.getParameter("companyname");
		String company_startup_date=request.getParameter("company_startup_date");
		String equity_structure=request.getParameter("equity_structure");
		String registered_capital=request.getParameter("registered_capital");
		String legal_person=request.getParameter("legal_person");
		String bussiness_license=request.getParameter("bussiness_license");
		sql="update  zh_pros set iscompany=?,companyname=?,company_startup_date=?,equity_structure=?,registered_capital=?,legal_person=?,bussiness_license=? where proid=?";
		Object[] params={is_company,companyname,company_startup_date,equity_structure,registered_capital,legal_person,bussiness_license,proid};
		try{
			dao.update(sql, params);
			out.print("{\"status\":true,\"errno\":0}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
   }else if("save6".equals(m)){
		String financial_needs=request.getParameter("financial_needs");
		String transfer_ratio=request.getParameter("transfer_ratio");
		String min_investment=request.getParameter("min_investment");
		String min_startup=request.getParameter("min_startup");
		String allow_exceed=request.getParameter("allow_exceed");
		String capital_usage=request.getParameter("capital_usage");
		String max_overraise=request.getParameter("max_overraise");
		sql="update  zh_pros set financialneeds=?,transferratio=?,mininvestment=?,minstartup=?,allowexceed=?,capitalusage=?,max_overraise=? where proid=?";
		Object[] params={financial_needs,transfer_ratio,min_investment,min_startup,allow_exceed,capital_usage,max_overraise,proid};
		try{
			dao.update(sql, params);
			out.print("{\"status\":true,\"errno\":0}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
  }else if("save7".equals(m)){
		String[] member_avatars=request.getParameterValues("member_avatar");
		String[] member_names=request.getParameterValues("member_name");
		String[] titles=request.getParameterValues("title");
		String[] member_profiles=request.getParameterValues("member_profile");
		String[] provinces=request.getParameterValues("province");
		String[] citys=request.getParameterValues("city");
		try{
			dao.delete("delete from zh_pro_teams where proid="+proid);
			for(int i=0;i<member_avatars.length;i++){
				String member_avatar=member_avatars[i];
				String member_name=StringUtil.Html2Text(member_names[i]);
				String title=StringUtil.Html2Text(titles[i]);
				String member_profile=member_profiles[i];
				String province=provinces[i];
				String city=citys[i];
				sql="insert into zh_pro_teams(title,member_avatar,member_name,province,city,education_background,work_experience,member_profile,proid,addtime) values(?,?,?,?,?,?,?,?,?,unix_timestamp())";
				Object[] params={title,member_avatar,member_name,province,city,request.getParameter("education_background"+(i+1)),request.getParameter("work_experience"+(i+1)),member_profile,proid};
				dao.update(sql, params);
			}
			out.print("{\"status\":true,\"errno\":0}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
 }else if("save8".equals(m)){
	    String agree=request.getParameter("agree");
	    if(agree==null||"".equals(agree)||"0".equals(agree)){
	    	out.print("{status:false,errortext:\"请仔细阅读，并同意《众筹平台融资咨询顾问协议》\"}");
	    	return;
	    }
		try{
			dao.delete("update zh_pros set ischecked=1 where proid="+proid);
			out.print("{\"status\":true,\"url\":\"center/deal.shtml\"}");
		}catch(Exception e){
			out.print("{status:false,errortext:\"系统异常："+e.getMessage()+"\"}");
		}
		return;
 }else if("detail".equals(m)){
	sql="select * from zh_pros where proid="+proid;
	Map pro=dao.queryone(sql);
	if(pro!=null){
		request.setAttribute("pro", pro);
		request.setAttribute("proid", pro.get("proid"));
		sql="select title,member_avatar photo,member_avatar,member_name name,province,city,education_background,work_experience,member_profile intro from zh_pro_teams where proid="+proid+" order by addtime asc";
		List teams=dao.getList(sql);
		request.setAttribute("teams", JsonUtils.bean2json(teams));
		sql="select GROUP_CONCAT(catid) catids from zh_pro_cat where proid="+proid;
		Map cats=dao.queryone(sql);
		request.setAttribute("mycats", cats.get("catids"));
	}
 }
}else{
	String dealid=JedisUtil.getkeyid("zh_pros");
	request.setAttribute("proid", dealid);
}
String sql="select * from wei_common_type where type=18 order by sort desc";
List cats=dao.getList(sql);
request.setAttribute("cats", cats);
%>
<jsp:include page="../common.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_我的项目</title>
<meta name="keywords" content="${pageinfio.keywords}"/>
<meta name="description" content="${pageinfio.description}"/>
<link rel="shortcut icon" href="img/favicon.ico"/>
<!--public js&css start-->
<link href="css/ubase.css?v=20141112" rel="stylesheet" type="text/css">
<link href="css/common.css?v=20141112" rel="stylesheet" type="text/css">
<script src="js/jquery-1.8.2.js?v=20141112"></script>
<script src="js/wx.js?v=20141112"></script>
<script src="js/wx.config.js?v=20141112"></script>
<script src="js/common.js?v=20141112"></script>
<script src="js/json2.js?v=20141112"></script>

</head>

<body>
<!--header static-->
<jsp:include page="../top.jsp"/>
<!--header end--><!--banner static-->
<link rel="stylesheet" type="text/css" href="css/control.css?v=20141112">
<link rel="stylesheet" type="text/css" href="css/launch.css?v=20141112">
<script type="text/javascript" src="js/wx.upload.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/region.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/starpro.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/multi_input.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/multi_input_table.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/education_background.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/work_experience.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/member_info.js?v=20141112" ></script>
<script type="text/javascript" src="js/control/controls.js?v=20141112" ></script>
<script type="text/javascript" src="js/wx.upload.js?v=20141112" ></script>
<!--main content-->
<div class="wrap-1024">
    <ul class="launch-tit" id="launch-tit">
                    <li id="li_basic_info" class="${pro.proname!=null?'selected':''}"><a href="javascript:" class="base">基本信息</a></li>
                    <li id="li_bp" class="${pro.userdemand!=null?'selected':''}"><a href="javascript:" class="business">商业计划</a></li>
                    <li id="li_profit_model" class="${pro.revenuedriver!=null?'selected':''}"><a href="javascript:" class="team">盈利模式</a></li>
                    <li id="li_team_member" class="${teams!=null?'selected':''}"><a href="javascript:" class="company">团队成员</a></li>
                    <li id="li_company_structure" class="${pro.companyname!=null?'selected':''}"><a href="javascript:" class="financing">公司架构</a></li>
                    <li id="li_financial_needs" class="${pro.financialneeds!=null?'selected':''}"><a href="javascript:" class="profit">融资需求</a></li>
                       
    </ul>
    <div class="launch" id="launch">
            <div class="tit clearfix">
                    <h2>填写项目信息</h2>
                   <!--   <div class="btns">
                            <a id="savedraft" class="grey-btn">保存草稿</a><a id="preview" data-href="/deal/detail/dealId/5762/key/d1ab5bc1f7bf4e67bf1e044450619fca" target="_blank" class="grey-btn">预览</a>
                    </div>-->
            </div>
	    <div class="clearfix launch-list-tit close_bg" data-form-id="basic_info">
                基本信息                    <div class="tips"><span><a href=""></a></span></div>
			<div class="switch Js-switch"><i></i>收起</div>
            </div>
            <div class="launch-list" style="display:block;">
                                            
                                
                <div class="form-wrap">
                
                    <form id="basic_info" name="basic_info" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off" wx-validator-noscroll="">                      	<div class="basic_info_errors form-errors">
                      		<ul>
                      		</ul>                        
                        </div>   
                        <input type="hidden" name="m" value="save1">  
                         <input type="hidden" name="proid" value="${proid}">                                                                 
        <div class="form-list form-list-project_name">
        <label for="">项目名称<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required|maxLength" name="project_name" wx-validator-param="|20" id="project_name" type="text" placeholder="请输入不超过20个字符" value="${pro.proname}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-project_name-required">不能为空</div>
                        <div class="validate-msg" id="wx-validator-project_name-maxLength">请输入不超过20个字符</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>一个简短有力的项目名称有助于提升您项目的成功率</div></div></div>
        </div>
		                    <div class="form-list form-list-big_point">
        <label for="">一句话亮点<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required|maxLength" name="big_point" wx-validator-param="|100" id="big_point" type="text" placeholder="一句话简介" value="${pro.bigpoint}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-big_point-required">不能为空</div>
                        <div class="validate-msg" id="wx-validator-big_point-maxLength">请输入不超过100个字符</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>一句话展示项目的特色和亮点，100字以内</div></div></div>
        </div>
		<div class="form-list">
    <label for="">项目阶段<i>＊</i></label>
    <div class="inp">
            <select id="project_stage" name="project_stage" wx-validator-error-value="null" wx-validator-rule="required">
                                                <option value="null">请选择项目阶段</option>
                                                <option value="2">产品研发中</option>
                                                <option value="3">已正式发布</option>
                                                <option value="4">已有收入</option>
                                                <option value="5">已盈利</option>
                                </select>
                        <div class="clearfix"></div>
            <span class="validate-msg" id="wx-validator-project_stage-error" style="color:red;display:none;">请选择项目阶段</span>    
    </div>
                <div class="prompt"><i></i><div class="sub"><div>选择您项目所处阶段</div></div></div>
        </div>
		                    <div class="form-list form-list-team_size">
        <label for="">团队人数<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="digits|required|min|noSymbol|max" name="team_size" wx-validator-param="||1||500" id="team_size" type="text" placeholder="填写人数" value="${pro!=null?pro.teamsize:0}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-team_size-digits">请填写大于零的整数</div>
                        <div class="validate-msg" id="wx-validator-team_size-required">不能为空</div>
                        <div class="validate-msg" id="wx-validator-team_size-min">请填写大于零的整数</div>
                        <div class="validate-msg" id="wx-validator-team_size-noSymbol">不能有符号</div>
                        <div class="validate-msg" id="wx-validator-team_size-max">请输入不大于500的数字</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>当前团队的人数</div></div></div>
        </div>
				<div class="form-list form-list-category">
                        <label for="">所属行业<i>＊</i></label>
			<div class="inp category_category_boxes">
				<div class="clearfix">
	            	    <logic:iterate id="cat" name="cats">
	            	     <div class="industry clearfix">
	            	     
	            	     <input class="catebox" name="catebox" type="checkbox" value="${cat.id}">
	            	     <label class="cateinfo" for="ind_1">${cat.name}</label></div>					                    
	            	    </logic:iterate>                               
                </div>
                                    <div class="validate-msg" id="wx-validator-category-required">不能为空</div>
                                  
			</div>
		</div>
                <script type="text/javascript">
                    (function(target_class, valueStr){
                        var that = this;
                        this.targets = $("." + "category_category_boxes").find("input[type=checkbox]");
                        $("#category").val(valueStr);
                        if(valueStr != undefined && valueStr != ""){
                            var arr = valueStr.split(",");
                            that.targets.each(function(){
                                var val = $(this).val();
                                if(arr.indexOf(val) != -1){
                                    $(this).prop("checked", true);
                                }
                            });
                        }
                        this.targets.change(function(){
                                var allInput = $(this).closest('.category_category_boxes').find('input'),count = 0;
                                for(var i=0;i<allInput.length;i++){
                                    if(allInput.eq(i).prop('checked')){
                                        count+=1;
                                    }
                                }
                        	var valStr = $("#category").val();
                        	if(count > 3){
                            	wx.alert("最多选择3个行业");
                            	$(this).prop("checked",false);
                            	return;
                        	}
                            var values = [];
                            that.targets.each(function(){
                                if($(this).prop("checked")){
                                    values.push($(this).val());
                                }
                            });
                            $("#category").val(values.join(","));
                        
                        });
                    })("category_category_boxes", "${mycats}");
                   
                </script>
            <div class="form-list">
  <label for="">所在城市<i>＊</i></label>
    <div class='inp'>
        <div id="city_region_selector" class="clearfix padding-0">           
        </div>
        <input type='hidden' wx-validator-rule='required' name='city' wx-validator-param=''  id='city' type="text" placeholder="" value='' >
                 
        <div class=''>
            <div class='clearfix'></div>
                                    <div class='validate-msg' id="wx-validator-city-required"  >不能为空</div>
                     
            </div>
        </div>
    </div>
<script>
    $("#" + "city_region_selector").city_selector('city', "${pro.province}${pro!=null?',':''}${pro.city}");
</script>

            	<div class="form-list">
	        <label for="">项目LOGO<i>＊</i></label>
	        <div class="inp add-list-control clearfix">
	                <div class="fl">
	                <input type="file" wx-upload-size="8" wx-upload="Upload" name="project_logo_wxupload" wx-upload-param="type=thumb&amp;" wx-upload-assign="project_logo=data.img" wx-upload-set="project_logo_img=data.img" hidefocus="true">
	                <input type="hidden" wx-validator-rule="required" class="picarr" name="project_logo" id="project_logo" value="${pro.proimg}">
	                        <div class="add-btn"></div>
	                </div>
	                <div class="fl">
	                        
	                        <em class="tag">＊图片大小请勿超过8MB</em>
	                </div>
	        </div>
	        <div class="picul inp clearfix" id="project_logo_picul">	            
	             <span id="project_logo_span" style="display:${pro==null?'none':''}"><img class="imgarr" src="${pro.proimg}"><i class="picul-del">删除</i></span>
	             
	            <div class="clearfix"></div>
    	            	            <div class="validate-msg" id="wx-validator-project_logo-required" style="color:red;display:none;">不能为空</div>
    	        	        </div>
                        	<div class="prompt"><i></i><div class="sub"><div>在此处上传项目LOGO，支持格式png、jpeg、jpg，LOGO尺寸216*135px</div></div></div>
     			                  
	</div>
	<script>
	
	
	function project_logosetVal(){
	    var val = [];
	    $("#project_logo_picul").find("img").each(function(){
	        val.push($(this).attr('src'));
	    });
	    $("#project_logo").val(val.join(","));
	}


	//删除图片
	$("#project_logo_picul").find("span").click(function(){        
		  $(this).remove();
		  project_logosetVal();
	});
	
	

	function project_logo_wxupload(data){
		$("#Js-shadeLayer").remove();
    	$("#Js-pop-body").remove();
	    if(!data.status) wx.alert(data.error);
	    $("#project_logo").val(data.img);
	    if($('#project_logo_picul').find("img").length > 0){
	    	$("#project_logo_picul").find("img").attr("src", data.img);
	    }else{
	        $('#project_logo_picul').append('<span><img src="'+data.img+'" /><i class="picul-del">删除</i></span>');
	    }
	    $("#project_logo_picul").find("span").click(function(){        
			  $(this).remove();
			  project_logosetVal();
		});
		$("#project_logo_span").show();	              
	}
	
	</script>
                        <div class="save-next">
                            <a type="submit" class="btn bg-green1">保存，进行下一步</a>
                        </div>
                        
                     </form>                
                </div>
                            </div>
                    
	    <div class="clearfix launch-list-tit" data-form-id="bp">
                商业计划                    <div class="tips"><span><a href=""></a></span></div>
			<div class="switch Js-switch"><i></i>展开</div>
            </div>
            <div class="launch-list" style="display:none">
                                            
                                
                <div class="form-wrap">
                
                    <form id="bp" name="bp" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off" wx-validator-noscroll="">                      	<div class="bp_errors form-errors">
                      		<ul>
                      		</ul>                        
                        </div>   
                        <input type="hidden" name="m" value="save2">     
                        <input type="hidden" name="proid" value="${proid}">                                                     
                                            
        <div class="form-list bp">
            <label for="">上传商业计划书<i>&nbsp;&nbsp;</i></label>
            <div class="inp add-list-control clearfix">
                    <div class="fl">
                    <input wx-upload-size="40" wx-upload-type="application/msword|vnd.openxmlformats-officedocument.wordprocessingml.document|application/pdf|application/vnd.openxmlformats-officedocument.presentationml.presentation|application/vnd.ms-powerpoint" type="file" wx-upload="upload.do?m=fileupload" name="upload_bp_wxupload" wx-upload-assign="upload_bp=data.fileUrl" wx-upload-set="upload_bp_doc=data.fileUrl" hidefocus="true">
                    <input type="hidden" wx-validator-rule="" class="picarr" name="upload_bp" id="upload_bp" value="${pro.upload_bp}">
                            <div class="add-btn"></div>
                    </div>
                    <div class="fl">

                            <em class="tag" style="line-height:34px">＊文件大小请勿超过40MB</em>
                            <div class="clearfix"></div>
                             <a class="bp-template" target="_blank" href="doc/原始会-商业计划书模板.pptx?v=20141112">下载商业计划书模板</a>
                    </div>
            </div>
            <div class="picul inp clearfix">
            <logic:empty name="pro" >
             <a style="color:#00bd9c;display:none" target="_blank" id="upload_bp_doc" href="#">文件已经上传成功</a>       
           </logic:empty>
             <logic:notEmpty name="pro" >
            <logic:empty name="pro" property="upload_bp">
             <a style="color:#00bd9c;display:none" target="_blank" id="upload_bp_doc" href="#">文件已经上传成功</a>  
            </logic:empty>
             <logic:notEmpty name="pro" property="upload_bp">
              <a style="color:#00bd9c;" target="_blank" id="upload_bp_doc" href="${pro.upload_bp}">文件已经上传成功</a>          
             </logic:notEmpty>
           </logic:notEmpty>
                                    
            </div>
        
                				            <div class="prompt"><i></i><div class="sub"><div>请上传pdf，doc，docx，ppt，pptx格式的商业计划书，相关文档只做备份使用，不会公开显示</div></div></div>
	                                    
        </div>
        
        <script>
            if($("#upload_bp").val()){
            	$("#upload_bp_doc").show();
            }            
            function upload_bp_wxupload(data){
            	$("#Js-shadeLayer").remove();
            	$("#Js-pop-body").remove();
                if(!data.status){
                    wx.alert(data.error);
                }
                $("#upload_bp_doc").show();
                $("#upload_bp_doc").text(data.name);
                $("#upload_bp_doc").attr("href", data.fileUrl);
                wx.alert("上传成功");
            }
            function upload_bp_wxupload_progress(data){
                console.log(data);
            }
        </script>
                                        <div class="form-list form-list-project_video">
        <label for="">项目视频介绍<i>&nbsp;</i></label>
        <div class="inp">
            <input wx-validator-rule="url" name="project_video" wx-validator-param="" id="project_video" type="text" placeholder="" value="${pro.projectvideo}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-project_video-url">请使用正确格式,如：//www.website.com</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>支持土豆、优酷、56网等视频链接，请使用后缀是sfw或flv的链接格式，否则可能会显示失败</div></div></div>
        </div>
		<div class="form-list">
        <label for="" style="line-height: 23px">用户需求<i>＊</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="required" name="user_demand" wx-validator-param="" id="user_demand" type="text" placeholder="请简要说明用户定位及其需求">${pro.userdemand}</textarea>
            <div class="clearfix"></div>
                            <div class="validate-msg" id="wx-validator-user_demand-required" style="color:red;display:none;">不能为空</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>用户定位，即针对哪些用户？解决他们的哪些需求？</div></div></div>
        </div>
		<div class="form-list">
        <label for="" style="line-height: 23px">解决方案<i>＊</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="required" name="solution" wx-validator-param="" id="solution" type="text" placeholder="请详细描述您的项目如何解决以上需求">${pro.solution}</textarea>
            <div class="clearfix"></div>
                            <div class="validate-msg" id="wx-validator-solution-required" style="color:red;display:none;">不能为空</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>针对上述需求，你的解决方案是什么，像用户提供了什么 核心价值？</div></div></div>
        </div>
		<div class="form-list">
        <label for="" style="line-height: 23px">方案优势<i>＊</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="required" name="advantage_of_solution" wx-validator-param="" id="advantage_of_solution" type="text" placeholder="请详细描述您的竞争优势/壁垒">${pro.proyoushi}</textarea>
            <div class="clearfix"></div>
                            <div class="validate-msg" id="wx-validator-advantage_of_solution-required" style="color:red;display:none;">不能为空</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>相比竞争对手，你的解决方案有哪些优势？提供最核心的1-3点。 难以复制的团队？ 技术门槛？ 创新模式？ 特有渠道资源？ 更多…？</div></div></div>
        </div>
		<div class="form-list">
        <label for="" style="line-height: 23px">需求场景<i>&nbsp;&nbsp;</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="" name="demand_scenario" wx-validator-param="" id="demand_scenario" type="text" placeholder="详细描述您项目的需求场景">${pro.demandscenario}</textarea>
            <div class="clearfix"></div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>在什么情景下，用户会非常需要你的产品或服务？最好提供1-2个强需求场景，帮助投资人更好的理解你的产品价值</div></div></div>
        </div>
		<div class="form-list">
        <label for="" style="line-height: 23px">市场分析<i>&nbsp;&nbsp;</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="" name="market_analysis" wx-validator-param="" id="market_analysis" type="text" placeholder="简要阐述对市场的分析">${pro.marketanalysis}</textarea>
            <div class="clearfix"></div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>是否是增量市场，增长空间？什么原因导致市场，即用户基数的增长？习惯改变，行业升级，政策支持？  行业数据未必精确，但却是最有力、直观的工具</div></div></div>
        </div>
		<div class="form-list">
        <label for="" style="line-height: 23px">发展规划<i>&nbsp;&nbsp;</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="" name="development_plan" wx-validator-param="" id="development_plan" type="text" placeholder="项目的短期目标（6-12个月）及实现计划">${pro.developmentplan}</textarea>
            <div class="clearfix"></div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>如何实现，有哪些具体的计划和策略？</div></div></div>
        </div>
		<div class="form-list">
        <label for="" style="line-height: 23px">其他<i>&nbsp;&nbsp;</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="" name="other" wx-validator-param="" id="other" type="text" placeholder="其他重要事项">${pro.other}</textarea>
            <div class="clearfix"></div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>其他重要事项或补充说明</div></div></div>
        </div>
		<div class="form-list">
        <label for="">项目相册<i>＊</i></label>
        <div class="inp add-list-control clearfix">
                <div class="fl">
                <input type="file" wx-upload-size="8" wx-upload="Upload" name="project_album_wxupload" wx-upload-param="type=thumb&amp;" hidefocus="true">
                <input type="hidden" wx-validator-rule="required" class="picarr" name="project_album" id="project_album" value="">
                        <div class="add-btn"></div>
                </div>
                <div class="fl">

                <em class="tag">＊图片大小请勿超过8MB</em>
                </div>
        </div>
        <div class="picul inp clearfix" id="project_album_picul">
        	<div class="clearfix">
        	<script>
        	(function(target_class, valueStr){
                var that = this;
                this.targets = $("#" + target_class);
                $("#project_album").val(valueStr);
                if(valueStr != undefined && valueStr != ""){
                    var arr = valueStr.split(",");
                    for(var i=0;i<arr.length;i++){
                    	that.targets.append('<span><img src="'+arr[i]+'" /><i class="picul-del">删除</i></span>');
                    }
                }
            })("project_album_picul", "${pro.project_album}");
        	</script>
	                        </div>
                        	<div class="validate-msg" id="wx-validator-project_album-required" style="color:red;display:none;">不能为空</div>
                </div>
          
		       		<div class="prompt"><i></i><div class="sub"><div>通过图片展示您的项目，图片尺寸为620*350px</div></div></div>
		                
</div>
<script>


function project_albumsetVal(){
    var val = [];
    $("#project_album_picul").find("img").each(function(){
        val.push($(this).attr('src'));
    });
    $("#project_album").val(val.join(","));
}


//删除图片
$("#project_album_picul").find("span").click(function(){        
	  $(this).remove();
	  project_albumsetVal();
});
function project_album_wxupload(data){
	$("#Js-shadeLayer").remove();
	$("#Js-pop-body").remove();
    if($("#project_album_picul").find("span").length >=9){
        wx.alert("最多上传9张图片");
        return;
    }       

    if(!data.status) wx.alert(data.error);        
    $('#project_album_picul').append('<span><img src="'+data.img+'" /><i class="picul-del">删除</i></span>');
    project_albumsetVal();   

    $("#project_album_picul").find("span").click(function(){        
    	  $(this).remove();
    	  project_albumsetVal();
    });
}
</script>
						<div class="form-list clearfix" >
							<label for="" style="">项目新闻报道<i>&nbsp;&nbsp;</i></label>
							<div class="rows news-wrapper" id="cstr_project_news">
								
							</div>
							<div class="clearfix"></div>
						</div>
						<input type="hidden" name="project_news" id="project_news" value='${pro.pronews}'>
            <script type="text/javascript">
               $("#cstr_project_news").multi_input("project_news", [
                    {
                        'name' : "title",
                        'placeholder': "新闻标题",
                        'type' : "text",
                        'required' :true
                    },{
                        'name' : "url",
                        'placeholder': "新闻链接",
                        'type' : "text",
                        'required' : true
                    }], "新闻"); 

                $("#cstr_project_news").find(".inp").css("width", "100%");
                $("#cstr_project_news").find(".half").css("width", "45%");
            </script>
            
            <input type="hidden" name="dealId" value="5762"><input type="hidden" name="financeId" value="5762"><input type="hidden" name="code" value="">
                        <div class="save-next">
                            <a type="submit" class="btn bg-green1">保存，进行下一步</a>
                        </div>
                        
                     </form>                
                </div>
                            </div>
                    
	    <div class="clearfix launch-list-tit" data-form-id="profit_model">
                盈利模式                    <div class="tips"><span><a href=""></a></span></div>
			<div class="switch Js-switch"><i></i>展开</div>
            </div>
            <div class="launch-list" style="display:none">
                                            
                                
                <div class="form-wrap">
                
                    <form id="profit_model" name="profit_model" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off" wx-validator-noscroll="">                      	<div class="profit_model_errors form-errors">
                      		<ul>
                      		</ul>                        
                        </div>   
                        <input type="hidden" name="proid" value="${proid}">                    
                         <input type="hidden" name="m" value="save3">                                                     
                        <div class="form-list">
        <label for="" style="line-height: 23px">收入来源<i>＊</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="required|minLength|maxLength" name="revenue_driver" wx-validator-param="|1|1000" id="revenue_driver" type="text" placeholder="怎么赚钱？">${pro.revenuedriver}</textarea>
            <div class="clearfix"></div>
                            <div class="validate-msg" id="wx-validator-revenue_driver-required" style="color:red;display:none;">不能为空</div>
                            <div class="validate-msg" id="wx-validator-revenue_driver-minLength" style="color:red;display:none;">请输入不小于1位的数字或字母</div>
                            <div class="validate-msg" id="wx-validator-revenue_driver-maxLength" style="color:red;display:none;">请输入不超过1000个字符</div>
                    
        </div>
        </div>
		            <div class="form-list clearfix" id="cstr_cost_structure">
                    <label for="">成本构成<i>&nbsp;&nbsp;</i></label>
                    <div class="inp">
                        <label class="subtitle">请填写一年内的成本构成</label>
                         <div class="source">
									<div id="cost_structure_table_wrap">
										
										<div>
										</div>
									</div>

									<div style="height:20px; line-height:20px" class="add-row-wrap">
                            <a id="cost_structure_add_btn" class="add-row-btn">增加一行</a>
                        </div>  
                    </div>
                    </div>
                    
                   
                                                       
            </div>
            <input type="hidden" name="cost_structure" id="cost_structure" value='${pro.chengbengc}'>
            <script type="text/javascript">
                $("#cost_structure_table_wrap").multi_input_table({
                    "targetInput" : "cost_structure",
                    columns : [
                               {
                            	   'name' : "cost-item",
                                   'placeholder': "主要成本和费用",
                                   'type' : "text",
                                   "width" : "45%",
                                   'required' :true
                               },
                               {
                            	   'name' : "cost-fee",
                                   'placeholder': "金额",
                                   'type' : "money",
                                   "width" : "45%",
                                   'required' :true
                               }
                    ],
                    add_btn : "cost_structure_add_btn",
                    init_row : 3
                        
                });
            </script>
            
            
                         
<div class="form-list">
    <label for="">财务数据<i>&nbsp;&nbsp;</i></label>
    <div class="inp">
								<div class="source source-earnings"
									id="financial_data_table_wrap">
									
								</div>
							</div>
							<div id="financial_data_error_panel">
								
							</div>
						</div>     
<input type="hidden" name="financial_data" id="financial_data" value='${pro.caiwudata}'>
<script type="text/javascript">
    var d = new Date();
    var year = d.getFullYear();
    var last = year - 1;
    var ll = year - 2;
    $("#financial_data_table_wrap").multi_input_table({
    	targetInput : "financial_data",
    	columns : [
       	    {
          	   'name' : "now",
          	   'title' : "本年度初至今" + "(" + year + ")",
               'placeholder': "请输入金额",
               'type' : "money",
               "width" : "25%",
               'required' :true
    		},
    		{
            	'name' : "last_year",
            	'title' : '上一年度(' + last + ')',
                'placeholder': "请输入金额",
                'type' : "money",
                "width" : "25%",
                'required' :true
      		},
    		{
            	'name' : "the_year_before_last_year",
            	'title' : '再上一年度(' + ll + ')',
                'placeholder': "请输入金额",
                'type' : "money",
                "width" : "25%",
                'required' :false
      		}
    	],
    	rows : 
        	[
    	        {label:""},
    	        {label:"营业收入"},
    	        {label:"毛利润"},
    	        {label:"净利润"}
        	       
    		],
    	error_panel : 'financial_data_error_panel',
    	mode : "array",
    	required :false
    });
</script>
                    
                                 
        <div class="form-list">
            <label for="">盈利预测<i>&nbsp;&nbsp;</i></label>
            <div class="inp">
								<div class="source source-earnings"
									id="profit_forecast_table_wrap">
									
								</div>
							</div>
            <div id="profit_forecast_error_panel"><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_now_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_last_year_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_the_year_before_last_year_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_now_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_last_year_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_the_year_before_last_year_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_now_2-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_last_year_2-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_the_year_before_last_year_2-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_now_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_last_year_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_the_year_before_last_year_1-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_now_2-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_last_year_2-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_the_year_before_last_year_2-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_now_3-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_last_year_3-min">金额不正确或太小</div><div class="valiate-hint" style="color:red;display:none;" id="wx-validator-profit_forecast_table_wrap_the_year_before_last_year_3-min">金额不正确或太小</div></div>
        </div>     
        <input type="hidden" name="profit_forecast" id="profit_forecast" value='${pro.yingliyuce}'>
        <script type="text/javascript">
            var d = new Date();
            var year = d.getFullYear();
            var last = year + 1;
            var ll = year + 2;
            $("#profit_forecast_table_wrap").multi_input_table({
            	targetInput : "profit_forecast",
            	columns : [
               	    {
                  	   'name' : "now",
                  	   'title' : "本年度" + "(" + year + ")",
                       'placeholder': "请输入金额",
                       'type' : "money",
                       "width" : "25%",
                       'required' :true
            		},
            		{
                    	'name' : "last_year",
                    	'title' : '下一年度(' + last + ')',
                        'placeholder': "请输入金额",
                        'type' : "money",
                        "width" : "25%",
                        'required' :true
              		},
            		{
                    	'name' : "the_year_before_last_year",
                    	'title' : '再下一年度(' + ll + ')',
                        'placeholder': "请输入金额",
                        'type' : "money",
                        "width" : "25%",
                        'required' :false
              		}
            	],
            	rows : 
                	[
            	        {label:""},
            	        {label:"营业收入"},
            	        {label:"毛利润"},
            	        {label:"净利润"}
                	       
            		],
            	error_panel : 'profit_forecast_error_panel',
            	mode : "array",
            	required :false
            });
        </script>
                    <input type="hidden" name="dealId" value="5762"><input type="hidden" name="financeId" value="5762"><input type="hidden" name="code" value="">
                        <div class="save-next">
                            <a type="submit" class="btn bg-green1">保存，进行下一步</a>
                        </div>
                        
                     </form>                
                </div>
                            </div>
                    
	    <div class="clearfix launch-list-tit" data-form-id="team_member">
                团队成员                    <div class="tips"><span><a href=""></a></span></div>
			<div class="switch Js-switch"><i></i>展开</div>
            </div>
            <div class="launch-list" style="display:none">
                                            
                                                              
                <form id="team_member" name="team_member" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off" wx-validator-noscroll="">                <div class="form-wrap" id="member_info_wrap">
                    <input type="hidden" name="member_number" id="member_number" value="1">  
                    <input type="hidden" name="proid" value="${proid}">
                    <input type="hidden" name="m" value="save7">
                    <div class="hint">
                    	<p>*第一个团队成员默认是核心创始人，创始人信息为必填项。</p>
                    </div>
                    <div class="hr"></div>
						<div class="rows">
							
						</div>
						<a id="add_team_member">+添加团队信息</a>
                    <div class="save-next">
                        <a type="submit" class="btn bg-green1">保存，进行下一步</a>
                    </div>                    
                </div>
                </form>                            </div>
                    
	    <div class="clearfix launch-list-tit" data-form-id="company_structure">
                公司架构                    <div class="tips"><span><a href=""></a></span></div>
			<div class="switch Js-switch"><i></i>展开</div>
            </div>
            <div class="launch-list" style="display:none">
                                            
                                <div class="form-wrap" id="company-frm1">
                    <form id="company_structure1" name="company_structure1" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off" wx-validator-noscroll="">
                    <input type="hidden" name="proid" value="${proid}">
                    <input type="hidden" name="m" value="save4">
                    <div class="form-list">
                        <label for="">是否已经成立公司<i>&nbsp;&nbsp;</i></label>
                        <div class="inp">
                                <select id="is_company1" name="is_company" wx-validator-error-value="null" wx-validator-rule="">
                                                                    <option value="0" selected="">否</option>
                                                                    <option value="1">是</option>
                                                    </select>
                                            <div class="clearfix"></div>
                                <span class="validate-msg" id="wx-validator-is_company-error" style="color:red;display:none;">请选择是否已经成立公司</span>    
                    </div>
                      <div class="save-next">
                            <a type="submit" style="margin-top:20px" class="btn bg-green1">保存，进行下一步</a>
                        </div>
                    </div>
               </form></div>
               <div class="form-wrap" id="company-frm2" style="display:none">
                                        <form id="company_structure" name="company_structure" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off" wx-validator-noscroll="">                      	<input type="hidden" name="code" value="">
                      <input type="hidden" name="proid" value="${proid}">
                    <input type="hidden" name="m" value="save5">
                      	<div class="company_structure_errors form-errors">
                      		<ul>
                      		</ul>                        
                        </div>                                                        
                        <div class="form-list">
    <label for="">是否已经成立公司<i>&nbsp;&nbsp;</i></label>
    <div class="inp">
            <select id="is_company" name="is_company" wx-validator-error-value="null" wx-validator-rule="">
                                                <option value="0" selected="">否</option>
                                                <option value="1">是</option>
                                </select>
                        <div class="clearfix"></div>
            <span class="validate-msg" id="wx-validator-is_company-error" style="color:red;display:none;">请选择是否已经成立公司</span>    
    </div>
    </div>
                                <div class="form-list form-list-companyname">
        <label for="">公司名称<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required|minLength|maxLength" name="companyname" wx-validator-param="|2|20" id="companyname" type="text" placeholder="注册公司的名称" value="${pro.companyname}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-companyname-required">公司名称不能为空</div>
                        <div class="validate-msg" id="wx-validator-companyname-minLength">请输入不小于2位字母</div>
                        <div class="validate-msg" id="wx-validator-companyname-maxLength">请输入不超过20个字符</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>请填写公司注册时的全称</div></div></div>
        </div>
		                    <div class="form-list form-list-company_startup_date">
        <label for="">创立时间<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required" name="company_startup_date" wx-validator-param="" id="company_startup_date" type="text" placeholder="格式:2000-01-01" value="${pro.company_startup_date}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-company_startup_date-required">不能为空</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>公司工商注册时间</div></div></div>
        </div>
		            <div class="form-list clearfix" id="cstr_equity_structure">
                <label for="">股权比例<i>&nbsp;&nbsp;</i></label>   
                <div class="inp clearfix">
								<div class="source" id="equity_structure_table_wrap">
									
									<div>
									</div>
								</div>
								<a id="equity_structure_add_btn" class="add-btn1">增加一行</a>
                </div>                                  
            </div>
            <input type="hidden" name="equity_structure" id="equity_structure" value='${pro.equity_structure}'>
            <script type="text/javascript">
                $("#equity_structure_table_wrap").multi_input_table({
                    columns : [{
                            'name' : "shareholder",
                            'placeholder': "股东姓名",
                            'type' : "text",
                            "width" : "20%",
                            'required' :true
                        },{
                            'name' : "title",
                            'placeholder': "职务",
                            'type' : "text",
                            "width" : "20%",
                            'required' : true
                        },{
                            'name' : "contribution",
                            'placeholder': "实际出资",
                            'type' : "money",
                            "width" : "20%",
                            'required' : true
                        },{
                            'name' : "share",
                            'placeholder': "股份比例",
                            'type' : "percent",
                            "width" : "20%",
                            'required' : true
                        }],
                        targetInput : "equity_structure",
                        add_btn : "equity_structure_add_btn",
                        init_row: 3
                    
                    });
            </script>
            
                                <div class="form-list form-list-registered_capital">
        <label for="">注册资本<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required" name="registered_capital" wx-validator-param="" id="registered_capital" type="text" placeholder="万元" value="${pro.registered_capital}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-registered_capital-required">不能为空</div>
                    
        <span class="wy-hint">万元</span></div>
                    <div class="prompt"><i></i><div class="sub"><div>工商注册资本</div></div></div>
        </div>
		                    <div class="form-list form-list-legal_person">
        <label for="">法人代表<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required" name="legal_person" wx-validator-param="" id="legal_person" type="text" placeholder="法人代表" value="${pro.legal_person}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-legal_person-required">不能为空</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>公司法人代表</div></div></div>
        </div>
			<div class="form-list">
	        <label for="">营业执照<i>&nbsp;&nbsp;</i></label>
	        <div class="inp add-list-control clearfix">
	                <div class="fl">
	                <input type="file" wx-upload-size="8" wx-upload="Upload" name="bussiness_license_wxupload" wx-upload-param="type=thumb&amp;" wx-upload-assign="bussiness_license=data.fileUrl" wx-upload-set="bussiness_license_img=data.fileUrl" hidefocus="true">
	                <input type="hidden" wx-validator-rule="" class="picarr" name="bussiness_license" id="bussiness_license" value="${pro.bussiness_license}">
	                        <div class="add-btn"></div>
	                </div>
	                <div class="fl">
	                        
	                        <em class="tag">＊图片大小请勿超过8MB</em>
	                </div>
	        </div>
	        <div class="picul inp clearfix" id="bussiness_license_picul">	            
	             <span id="bussiness_license_span" style="display:${pro!=null&&pro.bussiness_license!=''?'':'none'}"><img class="imgarr" src="${pro.bussiness_license}"><i class="picul-del">删除</i></span>
	             
	            <div class="clearfix"></div>
    	        	        </div>
                        	<div class="prompt"><i></i><div class="sub"><div>营业执照清晰的照片</div></div></div>
     			                  
	</div>
	<script>
	
	
	function bussiness_licensesetVal(){
	    var val = [];
	    $("#bussiness_license_picul").find("img").each(function(){
	        val.push($(this).attr('src'));
	    });
	    $("#bussiness_license").val(val.join(","));
	}


	//删除图片
	$("#bussiness_license_picul").find("span").click(function(){        
		  $(this).remove();
		  bussiness_licensesetVal();
	});
	
	

	function bussiness_license_wxupload(data){
		$("#Js-shadeLayer").remove();
    	$("#Js-pop-body").remove();
		  if(!data.status) wx.alert(data.error);
	    if($('#bussiness_license_picul').find("img").length > 0){
	    	$("#bussiness_license_picul").find("img").attr("src", data.img);
	    }else{
	        $('#bussiness_license_picul').append('<span><img src="'+data.img+'" /><i class="picul-del">删除</i></span>');
	    }
	    $("#bussiness_license_picul").find("span").click(function(){        
			  $(this).remove();
			  bussiness_licensesetVal();
		});
	    bussiness_licensesetVal();
		$("#bussiness_license_span").show();	            
	}
	
	</script>
	            <input type="hidden" name="dealId" value="5762"><input type="hidden" name="financeId" value="5762"><input type="hidden" name="code" value="">
                        <div class="save-next">
                            <a type="submit" class="btn bg-green1">保存，进行下一步</a>
                        </div>
                        
                     </form>                
                </div>
                            </div>
                    
	    <div class="clearfix launch-list-tit" data-form-id="financial_needs">
                融资需求                    <div class="tips"><span><a href=""></a></span></div>
			<div class="switch Js-switch"><i></i>展开</div>
            </div>
            <div class="launch-list" style="display:none">
                                            
                                
                <div class="form-wrap">
                
                    <form id="financial_needs" name="financial_needs" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off" wx-validator-noscroll="">                      	<div class="financial_needs_errors form-errors">
                      		<ul>
                      		</ul>                        
                        </div>   
                        <input type="hidden" name="proid" value="${proid}">  
                        <input type="hidden" name="m" value="save6">                                                     
                                            <div class="form-list form-list-financial_needs">
        <label for="">融资需求<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required|min" name="financial_needs" wx-validator-param="|1" id="financial_needs" type="text" placeholder="万元" value="${pro!=null?pro.financialneeds:0}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-financial_needs-required">不能为空</div>
                        <div class="validate-msg" id="wx-validator-financial_needs-min">最少输入1万元</div>
                    
        <span class="wy-hint">万元</span></div>
                    <div class="prompt"><i></i><div class="sub"><div>6~12个月达到项目发展里程碑所需要的资金</div></div></div>
        </div>
		                    <div class="form-list form-list-transfer_ratio">
        <label for="">出让股份<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required|min|max" name="transfer_ratio" wx-validator-param="|1|100" id="transfer_ratio" type="text" placeholder="%" value="${pro!=null?pro.transferratio:0}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-transfer_ratio-required">不能为空</div>
                        <div class="validate-msg" id="wx-validator-transfer_ratio-min">不小于1%</div>
                        <div class="validate-msg" id="wx-validator-transfer_ratio-max">请输入不大于100%的数字</div>
                    
        <span class="percent-hint">%</span></div>
                    <div class="prompt"><i></i><div class="sub"><div>建议初次融资，不要出让超过30%的股权比例</div></div></div>
        </div>
		<div class="form-list">
        <label for="">项目估值<i>＊</i></label>
        <div class="inp">
            <label id="valuation"></label>            
        </div>
             
</div>
		                    <div class="form-list form-list-min_investment">
        <label for="">每人最低投资金额<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required|min" name="min_investment" wx-validator-param="|1" id="min_investment" type="text" placeholder="万元" value="${pro!=null?pro.mininvestment:0}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-min_investment-required">不能为空</div>
                        <div class="validate-msg" id="wx-validator-min_investment-min">不能少于1万元</div>
                    
        <span class="wy-hint">万元</span></div>
                    <div class="prompt"><i></i><div class="sub"><div>建议不超过150人，因此最低融资额为目标融资额除以150</div></div></div>
        </div>
		                    <div class="form-list form-list-min_startup">
        <label for="">项目启动最低门槛<i>＊</i></label>
        <div class="inp">
            <input wx-validator-rule="required" name="min_startup" wx-validator-param="" id="min_startup" type="text" placeholder="项目启动最低门槛" value="${pro!=null?pro.minstartup:0}">
            <div class="clearfix"></div>
                        <div class="validate-msg" id="wx-validator-min_startup-required">不能为空</div>
                    
        <span class="wy-hint">万元</span></div>
                    <div class="prompt"><i></i><div class="sub"><div>最低募资需要，达到即可启动项目</div></div></div>
        </div>
		<div class="form-list">
    <label for="">是否允许超募<i>＊</i></label>
    <div class="inp">
            <select id="allow_exceed" name="allow_exceed" wx-validator-error-value="null" wx-validator-rule="required">
                                                <option value="1">是</option>
                                                <option value="0" selected="">否</option>
                                </select>
                        <div class="clearfix"></div>
            <span class="validate-msg" id="wx-validator-allow_exceed-error" style="color:red;display:none;">请选择是否允许超募</span>    
    </div>
    </div>
		                    <div class="form-list form-list-max_overraise" style="display: none;">
        <label for="">超募金额<i>&nbsp;</i></label>
        <div class="inp">
            <input wx-validator-rule="" name="max_overraise" wx-validator-param="" id="max_overraise" type="text" placeholder="万元" value="${pro!=null?pro.max_overraise:0}">
            <div class="clearfix"></div>
                    
        <span class="wy-hint">万元</span></div>
                    <div class="prompt"><i></i><div class="sub"><div>允许最终融资超出目标融资的金额，建议超募不要超过目标融资额的20%</div></div></div>
        </div>
		<div class="form-list">
        <label for="">融资计划<i>＊</i></label>
        <div class="inp">
            <label id="financial_plan"><table><tbody><tr><td>最低融资目标:</td><td id="min_investment_label">万元</td></tr><tr><td>当前融资目标:</td><td id="financial_needs_label">万元</td></tr><tr><td>最高融资目标:</td><td id="max_label">万元</td></tr></tbody></table></label>            
        </div>
             
</div>
		<div class="form-list">
        <label for="" style="line-height: 23px">融资用途<i>＊</i></label>
        <div class="inp">
                        <textarea wx-validator-rule="required" name="capital_usage" wx-validator-param="" id="capital_usage" type="text" placeholder="请详细描述您的融资用途">${pro.capitalusage}</textarea>
            <div class="clearfix"></div>
                            <div class="validate-msg" id="wx-validator-capital_usage-required" style="color:red;display:none;">不能为空</div>
                    
        </div>
                    <div class="prompt"><i></i><div class="sub"><div>建议使用500字以上进行描述</div></div></div>
        </div>
		
                        <div class="save-next">
                            <a type="submit" class="btn bg-green1">保存，进行下一步</a>
                        </div>
                        
                     </form>                
                </div>
                            </div>
               <form id="submitall" name="submitall" wx-validator="" wx-validator-ajax="" action="center/newdeal.shtml" method="post" autocomplete="off">
                <input type="hidden" name="proid" value="${proid}">
                <input type="hidden" name="m" value="save8">
                <div class="pt20 tc">
                        <a type="submit"  class="btn bg-orange wait-approval">提交项目，等待审批</a>
                        <p class="approval-arg">
<input type="checkbox" name="agree" id="agree" value="1">阅读并同意<a target="_blank" href="deal/docList/45471.html">《项目发起规范》</a></p>
                        <p class="approval-time">工作人员会在48小时内审核，如有问题将和您联系</p>
                </div>
            </form>
                </div>
</div>
<script type="text/javascript">
$("#member_info_wrap").member_info({
	"jsonData" : '${teams}',
	"add_btn"  : "add_team_member",
	"member_num_control" : "member_number"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
});

(function(){
	var forms = ["basic_info", "bp", "company_structure", "company_structure1", "profit_model", "financial_needs", "team_member"];
	for(var i = 0; i < forms.length ;i++){
		(function(t){window[forms[i]] = function(data){
			if(data.errno!=0){
				wx.alert(data.error);	
				return;	
			}	
			$("#li_" + forms[t]).addClass("selected");
			if(forms[t] == 'company_structure1'){
				slide_next("company_structure");
			}else{
			    slide_next(forms[t]);
			}			
		};
		})(i);
	}
})();


function submitall_before(){
	/* if(!wx.validator.basic_info.valid()){
		wx.alert("项目「基本信息」部分存在错误，请填写完成后再提交。");
		return;
	}
	if(!wx.validator.bp.valid()){
		wx.alert("项目「商业计划」部分存在错误，请填写完成后再提交。");
		return;
	}
	if(!wx.validator.profit_model.valid()){
		wx.alert("项目「盈利模式」部分存在错误，请填写完成后再提交。");
		return;
	}
	if(!wx.validator.team_member.valid()){
		wx.alert("项目「团队成员」部分存在错误，请填写完成后再提交。");
		return;
	}

	

// 	if(!wx.validator.team_member.valid()){
// 		wx.alert("项目「公司架构」部分存在错误，请填写完成后再提交。");
// 		return;
// 	}
	
	if(!wx.validator.financial_needs.valid()){
		wx.alert("项目「融资信息」部分存在错误，请填写完成后再提交。");
		return;
	} */

	launch_f_needs.check();
	if(launch_f_needs.hasError()){
		wx.alert("项目「融资信息」部分存在错误，请填写完成后再提交。");
		return false;
	}
    
    return true;
    
	
}

function submitall(data){
	if(!data.status){
		wx.alert(data.errortext);
		return false;
	}
    var msg = "尊敬的项目发起人，您项目已成功提交，请耐心等待我们的审核。";
   
	wx.alert(msg, function(){
		window.location.href = "center/deal.shtml";
	});    
}


$("#savedraft").click(function(){
	save_draft();
});
$("#preview").click(function(){
	var url = $(this).attr("data-href");
	save_draft();
	window.open(url, "_blank") ;
});


function save_draft(){
	
	var frms = ['basic_info', 'bp', 'profit_model', 'team_member', "company_structure", "financial_needs"];
	var vals = {};
	for(var i = 0; i < frms.length ; i++){
		  var frm_id = frms[i];
		  vals[frm_id] = {};
		  find_frm_vals(frm_id);
	}
	var d = {dealId:'5762', "financeId" : '5762'};
	vals = $.extend(vals, d);
	
    
	$.post("/newdeal/savedealdraft", vals, function(data){
		data = JSON.parse(data);
		if(data.errno!=0){
			wx.alert(data.error);
		}
		else{
			wx.alert("已保存");
		}
	});
	function find_frm_vals(frm_id){
		$("#" + frm_id).find("input").each(function(){
			var name = $(this).attr("name");
			vals[frm_id][name] = $(this).val();
		});
		$("#" + frm_id).find("select").each(function(){
			var name = $(this).attr("name");
			vals[frm_id][name] = $(this).val();
		});

		$("#" + frm_id).find("textarea").each(function(){
			var name = $(this).attr("name");
			vals[frm_id][name] = $(this).val();
		});
		var d = {dealId:'5762', "financeId" : '5762'};
		vals[frm_id].dealId = d.dealId;
		vals[frm_id].$financeId = d.$financeId;
	}

}







function max_overraise_slide(){
	if($("select[name='allow_exceed']").val() == 0){
		$(".form-list-max_overraise").slideUp();
	}else{
		$(".form-list-max_overraise").slideDown();
	}	
	
}
$(document).ready(function(){
    $("#project_stage").val('${pro.prostage}');
    $("#is_company1").val('${pro.iscompany}');
    $("#allow_exceed").val('${pro.allowexceed}');
    if($("#is_company1").val() == 1){
		$("#company-frm1").hide();
		$("#company-frm2").show();
		$("#is_company").val(1);
	}
    max_overraise_slide();
    $("select[name='is_company']").change(function(){
        //cs_slide();
    });
    $("select[name='allow_exceed']").change(function(){
    	max_overraise_slide();
    });
    
});




</script>
<script type="text/javascript" src="js/launch/launch.js?v=20141112"></script>

<script src="js/user.js?v=20141112"></script>
<!--footer static-->
<jsp:include page="../foot.jsp"/>
<!--footer end-->


</body>
</html> 



    