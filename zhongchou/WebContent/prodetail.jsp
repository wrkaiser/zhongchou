<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<%@ taglib prefix="mytag" uri="http://www.xiaoyou.tag/mytag"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<jsp:include page="common.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.request.contextPath}/" />
<title>${pageinfio.name}_${map.proname }</title>
<meta name="keywords" content="${map.proname }" />
<meta name="description" content="${map.bigpoint }" />
<link rel="shortcut icon" href="img/favicon.ico" />
<!--public js&css start-->
<link href="css/ubase.css?v=20141112" rel="stylesheet" type="text/css">
<link href="css/common.css?v=20141112" rel="stylesheet" type="text/css">
<script src="js/jquery-1.8.2.js?v=20141112"></script>
<script src="js/wx.js?v=20141112"></script>
<script src="js/wx.config.js?v=20141112"></script>
<script src="js/common.js?v=20141112"></script>
<script src="js/json2.js?v=20141112"></script>
<script type="text/javascript" src="js/deal.js?v=20141112"></script>
</head>
<script>
      $(function(){
    	  
    	  $.get("deal.do?m=isLogin&proid=${map.proid}",function(data){
    		    if(data==1||data=="1"){
    		    	$(".biangen").show();
    		    	$(".yuyue").hide();
    		    }else if(data==2||data=="2"){
    		    	$(".yuyue").show();
    		    	$(".biangen").hide();
    		    	
    		    }else if(data==0||data=="0"){
    		    	$(".biangen").hide();
    		    	$(".yuyue").hide();
    		    }else{
    		    	log();
    		    }
              });
        })
      
      
     
        </script>
<body>
 
	<jsp:include page="top.jsp" />
	<link rel="stylesheet" type="text/css"
		href="css/project.css?v=20141112">
	<div class="project-banner">
		<div class="wrap-1024 banner-light">
			<dl class="banner-left">
				<dt>
					<img
						src="${map.proimg }">
				</dt>
				<dd>
					<span class="fs24">${map.proname }</span> <i
						class="btn btn-thin btn-orange"> <c:if
							test="${map.ischecked==1 }">待审核</c:if> <c:if
							test="${map.ischecked==2 }">预约中</c:if> <c:if
							test="${map.ischecked==3 }">发行中</c:if> <c:if
							test="${map.ischecked==4 }">结束</c:if>
					</i>
					<p class="fs16">${map.bigpoint }</p>
				</dd>
			</dl>
			<div class="banner-right">
				<a id="Js-focus32" onclick="gengxin(${map.proid})"><i></i><span
					class="Js-focus-label">关注</span>(<span class="Js-focus-num">${map.loves
						}</span>)</a>
				<script type="text/javascript">
                 var flag=0;
			     function  gengxin(proid){
			    	 $.get("deal.do?m=clickCollect&proid="+proid,function(status){
			    		
			    		 if(status==-1||status=="-1"){
			    			 wx.alert("请先登录！");
			    			 log();
			    		 }else if(status==99||status=="99"){
                                // alert("1");
			       		     	 if(flag==1){
			       		     	//	alert("2");			       		     	
						    		$("#Js-focus32").css("color","#86a9c7");
						    		if("${map.iscollect}"!==null&&"${map.iscollect}"=="1"){
						    		$(".Js-focus-num").text("${map.loves -1}");
						    		}else{
						    			$(".Js-focus-num").text("${map.loves }");
						    		}
						    		$("#Js-focus32").hover(function(){
						    			$(this).css("color","#ff6633");
						    		},function(){
						    			$(this).css("color","#86a9c7");
						    		});			    		
						     }else if(flag==0){
						    	// alert("3");
						    	 $("#Js-focus32").css("color","#ff6633");
						    	 if("${map.iscollect}"!==null&&"${map.iscollect}"=="1"){
						    			$(".Js-focus-num").text("${map.loves }");
						    	 }else{
						    		 $(".Js-focus-num").text("${map.loves+1 }");
						    	 }
						    	$("#Js-focus32").hover(function(){
					    			$(this).css("color","#86a9c7");
					    		},function(){$(this).css("color","#ff6633");
					    		});
						     }
			    			flag= (flag==1)?0:1;
			    		 }else{
			    			 wx.alert(status);
			    		 }    		
			    	 }); 
			        }
			    
			    $(function(){
			    	if("${map.iscollect}"!==null&&"${map.iscollect}"=="1"){
			    		$("#Js-focus32").css("color","#ff6633");
			    		$("#Js-focus32").hover(function(){
			    			$(this).css("color","#86a9c7");
			    		},function(){$(this).css("color","#ff6633");
			    		});
			    		flag=1;
			    	};
			    })
			</script>
				<span class="bdsharebuttonbox" style="color: #86a9c7;font-size: 14px;line-height: 23px;">
				 <i 
					style="background: none;margin: 0px;padding-left: 0px;line-height: 23px;float: left"> <a class="share bds_more" style="background: url(../images/project/zan.png);background-position: -87px 0;
width: 13px;
height: 16px;
display: inline-block;
vertical-align: middle;padding: 0px;margin-top: 5px;" data-cmd="more"></a> 分享
				</i>
					<i style="float: left">(</i>
	<a class="bds_count" data-cmd="count" style="background: none;width: auto;margin-left: 0px;color: #86a9c7;"></a>
<i style="float: left">)</i>
<script>
	window._bd_share_config = {
		common : {
			bdText : '${map.bigpoint }',	
			bdDesc : '${map.proname }-${map.bigpoint }',	
			bdUrl : 'http://zhongchou.alumninet.net/deal/proDetail/${map.proid}.html', 	
			bdPic : 'http://zhongchou.alumninet.net${map.proimg }'
		},
		share : [{
			"bdSize" : 16
		}],
		slide : [{	   
			bdImg : 0,
			bdPos : "right",
			bdTop : 100
		}],
		image : [{
			viewType : 'list',
			viewPos : 'top',
			viewColor : 'black',
			viewSize : '16',
			viewList : ['qzone','tsina','huaban','tqq','renren']
		}],
		selectShare : [{
			"bdselectMiniList" : ['qzone','tqq','kaixin001','bdxc','tqf']
		}]
	}
	with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
</script>
				
				</span>
			</div>
		</div>
	</div>
	<div class="wrap-1024 clearfix">
		<div class="project-info clearfix"
			style="background: none repeat scroll 0 0 #fff;">
			<ul class="project-info-list w374">
				<li>企业名称<em>${map.companyname }</em></li>
				<li>项目类型 <em>${map.typename }</em>
				</li>
			</ul>
			<div class="line"></div>
			<ul class="project-info-list w240">
				<li class="text-overflow">所在城市<em title="${map.province－${map.city }">${map.province
						}－${map.city }</em></li>
				<li>团队成员<em>${map.teamsize }</em></li>
			</ul>
			<div class="line"></div>
			<ul class="project-info-list">
				<li>成立时间<em>${ map.company_startup_date}</em></li>
				<li>项目阶段<em> <c:if test="${map.prostage==2}">产品研发中</c:if>
						<c:if test="${map.prostage==3 }">已正式发布</c:if> <c:if
							test="${map.prostage==4 }">已有收入</c:if> <c:if
							test="${map.prostage==5}">已盈利</c:if>
				</em></li>
			</ul>
		</div>
		<div class="project-con">
			<ul class="pro-hd">
				<li class="wrk  selected" onclick='showBusinessPlan()'><a >商业计划</a></li>
				<li class="wrk " onclick='showProfitModel()'><a >盈利模式</a></li>
				<li class="wrk"  onclick='showTeam()'><a >项目团队</a></li>
				<li class="wrk"  onclick='showGrow()'><a >路演</a></li>
				<li class="wrk"  onclick='showTalk()'><a >讨论</a></li>
			</ul>
			<script type="text/javascript">
var jiathis_config = {
		title:'我在青岛科技大学创客众筹平台看到创业项目【${map.proname}】很靠谱！火速点击一下链接来关注讨论吧',
		summary :" "
};
</script>
			<script type="text/javascript" src="js/jia.js" charset="utf-8"></script>
			<link href="css/project.css" rel="stylesheet" type="text/css">


			<div class="pro-bd business-plan  " id="syjh">
				<div class="pro-bd-line">
					<h2>项目介绍</h2>

					<dl>
						<dt>用户需求</dt>
						<dd id="yhxq">${map.userdemand }</dd>
					</dl>
					<a href="javascript:void(0)" class="grey-btn grey-btn-margin"
						id="js-yhxq" style="display: none;">展开</a>
					<dl>
						<dt>方案优势</dt>
						<dd id="fays">${map.proyoushi }</dd>
					</dl>
					<a href="javascript:void(0)" class="grey-btn grey-btn-margin"
						id="js-fays" style="display: none;">展开</a>

					<h2>市场分析</h2>

					<dl>
						<dt>需求场景</dt>
						<dd id="xqcj">${map.demandscenario }</dd>
					</dl>
					<a href="javascript:void(0)" class="grey-btn grey-btn-margin"
						id="js-xqcj" style="display: none;">展开</a>
					<dl>
						<dt>市场分析</dt>
						<dd id="scfx">${map.marketanalysis }</dd>
					</dl>
					<a href="javascript:void(0)" class="grey-btn grey-btn-margin"
						id="js-scfx" style="display: none;">展开</a>
					<dl>
						<dt>发展规划</dt>
						<dd id="fzgh">${map.developmentplan }</dd>
					</dl>
					<a href="javascript:void(0)" class="grey-btn grey-btn-margin"
						id="js-fzgh" style="display: none;">展开</a>
					<dl>
						<dt>其他</dt>
						<dd id="qt">${map.other }</dd>
					</dl>
					<a href="javascript:void(0)" class="grey-btn grey-btn-margin"
						id="js-qt" style="display: none;">展开</a>
				</div>
				<div class="pro-bd-line">
					<h2>产品相册</h2>

					<ul class="pro-album-big"
						style="width: 1115%; position: relative; transition-duration: 0s; transform: translate3d(-621px, 0px, 0px);">
						<logic:notEmpty name="list1">
							<logic:iterate id="l1" name="list1">
								<li
									style="float: left; list-style: outside none none; position: relative; width: 621px;"
									calss="bx-clone"><img src="${l1 }"></li>
							</logic:iterate>
						</logic:notEmpty>
					</ul>
					<div id="pro-album-small" class="pro-album-small clearfix">
						<logic:notEmpty name="list1">
							<logic:iterate id="l1" name="list1">
								<a data-slide-index="0"><img src="${l1 }"></a>
							</logic:iterate>
						</logic:notEmpty>
					</div>
				</div>
			</div>
			<script type="text/javascript">
      var flag1=0;
       $(".wrk").click(function()
		 {
	 $(this).addClass("selected").siblings().removeClass("selected");
		 });
     function  showTeam(){
    	 $("#syjh").hide();
	     $("#ylms").hide();
	     $("#xmtd").show();
	     $("#cz").hide();
	     $("#tl").hide();  
	     //  alert("0");
	      // alert(flag1);
	      if(flag1==0){	  
    	  $.get( "deal.do?m=teamList&proid=${map.proid}",function (data){	  
    		  //alert(data);
    	 if(data!=99||data!="99"){
    		 //  alert("2");
    		var d=eval('('+data+')');  //json字符串 ->js对象
    		var obj=d.root;
    		//alert(obj);
    		 var str = "";
    		 
    		for(var i=0;i<obj.length;i++){ 
    		//	alert(obj[i].title+"--"+obj[i].member_name+"--"+obj[i].province+"--"+obj[i].city);
    		str+="<dl class='pro-promoters pro-team clearfix'><dt><a href=''><img src='"+obj[i].member_avatar+"'></a></dt>"+
         		"<dd class='color-grey'>"+obj[i].title+"</dd><dd><b>"+obj[i].member_name+"</b><em>"+obj[i].province+"-"+obj[i].city+
         		"</em></dd><dd><p class='p10'></p>";
         		
         		 var str1="",str2="";
         		 var json1=eval(obj[i].education_background);
         	
         		
         		 for(var j=0;j<json1.length;j++){
         		//	alert(json1[j].begin_year+"--"+json1[j].begin_month+"--"+json1[j].end_year+"--"+json1[j].end_month+"--"+json1[j].school+"--"+json1[j].education);
         			   str1="  <p class='p10'>"+json1[j].begin_year+"年"+json1[j].begin_month+"月~"+
         			  json1[j].end_year+"年"+ json1[j].end_month+"月    "+ json1[j].school+" "+
         			 json1[j].education+"</p><br/>"
         			
         		 }
         		 var json2=eval(obj[i].work_experience);
         		
         		   for(var k=0;k<json2.length;k++){
         			
         			   str2="<p class='p10'>"+json2[k].begin_year+"年"+json2[k].begin_month+"月~"+
         			  json2[k].end_year+"年"+json2[k].end_month+"月    "+json2[k].work_company+" "+
         			 json2[k].work_address+"  "+json2[k].work_duty+"</p><br/>";
         			    
         		   } 
         		
         		      str=str+str1+str2;
         		     str+="<p class='p10'>"+obj[i].member_profile+"</p></dd></dl>";
         		   
    		        }
    		           if('${map.equity_structure}'!=null&&'${map.equity_structure}'!=""){           
                      str+="<h2>股权结构</h2><div class='equity'>"+
            			   "<table><colgroup><col width='25%'><col width='25%'><col width='25%'> <col width='25%'></colgroup>"+
            			   " <thead> <tr> <td>股东姓名</td><td>持股比例</td> <td>实际出资（万）</td> <td>职务</td></tr></thead><tbody>";
    		                var json3=eval('${map.equity_structure}');  
    	         		   $.each(json3,function(n,holder){
            				 if(holder.shareholder!=null&&holder.shareholder!=""){
                	              str+="<tr><td>"+holder.shareholder+"</td><td>"+holder.share+"%</td><td>"+holder.contribution+"</td><td>"+holder.title+"</td></tr>";
            				    }
            				 });            
                         str=str+"</tbody> </table></div>";
    		           }
                         //  alert(str);
                         $("#xmtd ").append(str);               
    		  }else{
    			  wx.alert(data);
    		  };
          });
    	  flag1=1;
         };
        }
     function  convery(commid,username){
   	   // alert("sss");
   	  $("#comm").val(commid);
   	   //alert( $("#comm").val());
   	  $("#content")[0].focus();
   	  $("#content").attr("placeholder","回复"+username+":");  
   	  $(".fr").text("回复"); 	
     }
       function  showBusinessPlan(){
       	    	  $("#syjh").show();
    	    	  $("#ylms").hide();
    	    	  $("#xmtd").hide();
    	    	  $("#cz").hide();
    	    	  $("#tl").hide();
           }
       function  showGrow(){
    	      $("#syjh").hide();
	    	  $("#ylms").hide();
	    	  $("#xmtd").hide();
	    	  $("#cz").show();
	    	  $("#tl").hide();	    	  
       }
       
       function  showTalk(){
    	      $("#syjh").hide();
	    	  $("#ylms").hide();
	    	  $("#xmtd").hide();
	    	  $("#cz").hide();
	    	  $("#tl").show();
	    	  $(".discuss").remove();
	    	  $("#xsqb").remove();
	    	  $.get( "deal.do?m=commList&proid=${map.proid}",function (data){
	    		  if(data!=99||data!="99"){
	    			 // alert(data);
    	              var d=eval('('+data+')');
    	              var obj=d.root;
    	              var totalpage=d.totalpage;
    	           //   alert(totalpage);
    	              var str="";
    	              for(var i=0;i<obj.length;i++){
    	            	  str+="<dl class='pro-promoters pro-team discuss clearfix'><dt>"+ 		
      	          		"<img src="+obj[i].headimg+" height='36' width='36'></dt><dd><b>"+obj[i].username+":</b>"+
      	          		 obj[i].commcontent+"</dd><dd class='discuss-date'>提问于"+obj[i].addtime1+
      	                "<a class='js-comment-reply discuss-reply'  onclick=\"convery('"+obj[i].id+"','"+obj[i].username+"');\" >回复</a></dd>" ;
    	            	  if(obj[i].tocomm!=null&&obj[i].tocomm!=""){
    	            			str=str+"<dd class='bg-grey mt12'></dd><dl class='pro-team discuss discuss-box clearfix'><dt>"+
    	    	    			  "<img src='${map.headimg}' height='26' width='26'></dt><dd><b>"+"${map.username}"+"</b>"+
    	    	    			  obj[i].tocomm+"</dd><dd class='discuss-date'>回复于"+ obj[i].answertime+"</dd></dl></dd></dl>";
    	            	  }else{	 
     	                	 str=str+"</dl>";
     	                 } ; 
    	              }
    	              if(totalpage>1){
    	            	  str=str+"<div id='xsqb' style='color:gray;cursor:pointer;text-align:center;' onclick=\"showAll("+totalpage+")\">显示全部</div>";       	  
    	              }
    	              $(str).insertAfter("#chengzhang");
	    		  }else{
	    			  wx.alert(data);
	    		  };
	    		  
	    	  });
       }
       function showAll(totalpage){
    	   //alert("0");
    	  // alert(totalpage);
    	   for(var j=1;j<totalpage;j++){
    		   var k=++j;
    		  // alert(k);
    		   $.get( "deal.do?m=commList&proid=${map.proid}&p="+k,function (data){
    			 //  alert(data);
 	    		  if(data!=99||data!="99"){
 	    			//  alert("1");
 	    			   // alert(data);
     	              var d=eval('('+data+')');
     	              var obj=d.root;
     	              var str="";
     	              for(var i=0;i<obj.length;i++){
     	            	  str+="<dl class='pro-promoters pro-team discuss clearfix discuss1'><dt>"+ 		
       	          		"<img src="+obj[i].headimg+" height='36' width='36'></dt><dd><b>"+obj[i].username+":</b>"+
       	          		 obj[i].commcontent+"</dd><dd class='discuss-date'>提问于"+obj[i].addtime1+
       	                "<a class='js-comment-reply discuss-reply'  onclick=\"convery('"+obj[i].id+"','"+obj[i].username+"');\" >回复</a></dd>" ;
     	            	  if(obj[i].tocomm!=null&&obj[i].tocomm!=""){
     	            			str=str+"<dd class='bg-grey mt12'></dd><dl class='pro-team discuss discuss-box clearfix'><dt>"+
     	    	    			  "<img src='${map.headimg}' height='26' width='26'></dt><dd><b>"+"${map.username}"+"</b>"+
     	    	    			  obj[i].tocomm+"</dd><dd class='discuss-date'>回复于"+ obj[i].answertime+"</dd></dl></dd></dl>";
     	            	  }else{	 
      	                	 str=str+"</dl>";    	                	
      	                 } ; 
     	              } 
     	             str=str+"<div id='sqpl' style='color:gray;cursor:pointer;text-align:center;' onclick=\"retract()\">收起</div>";
     	             // alert("2");
     	              $(str).insertBefore(".shuruyu");
     	              $("#xsqb").hide();    	               
 	    		  }else{
 	    			  wx.alert(data);
 	    		  };	    		  
 	    	  }); 		   
    	   };   	   
       }
       function retract(){
    	   $(".discuss1").remove();
    	   $("#xsqb").show();
    	   $("#sqpl").remove();
    	   
       }
       function  showProfitModel(){
           $("#syjh").hide();
     	  $("#ylms").show();
     	  $("#xmtd").hide();
     	  $("#cz").hide();
     	  $("#tl").hide();	
       }
     function replay(){
    	 var  commid=$("#comm").val();
    	 var  content=$("#content").val();
    	 $.get("deal.do?m=question&proid=${map.proid}&id="+commid+"&content="+content,function(status){
    		 //alert(status);
    		 if(status!=null&&(status=="0"||status==0)){
    			 wx.alert("请先登录！");
    		 }else if(status!=null&&(status=="1"||status==1)){
    			showTalk();
    			wx.alert("提问成功！");
    			$("#content").val("");
    		 }else if(status!=null&&(status=="2"||status==2)){
    			 showTalk();
    			wx.alert("回复成功！");
    			$("#content").val("");
    		 }else if(status!=null&&(status=="3"||status==3)){
    			wx.alert("只能对自己发起的项目进行回复！");
    		 }else{
    			 log();
    		 }
   	 });
     }
     $(function(){
    	 if('${map.pronews }'!=null&&'${map.pronews }'!=""){
    		 var news =eval('${map.pronews }');
    		 var str="";
    		 $.each(news,function(i,item){
    			str+="<div class='grow-info' style='font-size:17px' ><a href='"+item.url+"' target='_blank'>"+item.title+"</a></div>";
    				
    		 })
    		 $(".pronews").append(str);
    		 
    	 }
     })
  
</script>
			<script src="js/highcharts.js"></script>
			<jsp:include page="highchart.jsp" />
			<div class="pro-bd" style="display: none" id="xmtd"></div>
			<div class="pro-bd" style="display: none" id="cz">
			<div class="grow">
					<h2>项目新闻</h2>
				</div>
				<div class="grow-con">
					<div class="grow-list clearfix pronews">
						
					</div>
				</div>
				<div class="grow">
					<h2>路演动态</h2>
				</div>
				<div class="grow-con">
					<div class="grow-list clearfix">
						<div class="grow-info">${map.luyan }</div>
					</div>
				</div>
			</div>
			<div class="pro-bd" style="display: none" id="tl">
				<div class="grow" id="chengzhang">
					<h2>Q&amp;A</h2>
					<a class="grey-btn add js-comment-add">+&nbsp;新增一个提问</a>
				</div>
				<div class="clearfix shuruyu">
					<input type="hidden" name="id" id="comm" value="">
					<textarea id="content" wx-validator-rule="required" name="content"
						class="replay-box"></textarea>
					<div id="wx-validator-content-required" class="error-text hidden">不能为空</div>
				
					<a class="grey-btn fr js-code-reflash" onclick="replay();">提问</a>

				</div>

			</div>
			<!-- 模块结束 -->
		</div>
		<div id="Js-pop-tpl" class="hidden">
			<form class="add-con" action="/feed/add" wx-validator
				wx-validator-ajax="reload" wx-validator-noscroll>
				<div class="add-list">
					<label>添加图片</label>
					<div class="add-list-r clearfix">
						<input type="file" name="file" wx-upload="/upload/feedcover"
							wx-upload-assign="cover=data.fileUrl"
							wx-upload-set="Js-image=data.fileUrl">
						<div class="add-btn"></div>
						<div class="uploaded-image">
							<img id="Js-image" width="80" height="80" />
						</div>
						<div id="wx-validator-cover-required" class="error-text hidden">请上传图片</div>
						<em class="tag">＊大小请勿超过8MB的jpg,jpeg,png图片</em>
					</div>
					<input name="cover" class="hidden" wx-validator-rule="required">
				</div>
				<div class="add-list clearfix">
					<label>动态描述</label>
					<div class="add-list-r">
						<textarea maxlength="150" name="content"
							wx-validator-rule="required"></textarea>
					</div>
				</div>
				<input name="dealId" value="647" class="hidden"> <a
					class="btn bg-green btn-pop" type="submit" href="javascript:;">发布</a>
			</form>
		</div>


		<div class="project-sideBar">
			<dl class="pro-promoters clearfix">
				<dt>
					<img src="${map.headimg }">
				</dt>
				<dd class="fs14 fb">
					${map.username }<i class="btn btn-small btn-green fn">发起人</i>
				</dd>
				<dd>
					<em>项目开始发起时间</em>${map.addtime }
				</dd>
			</dl>
			<div class="pro-plan">
				<p class="fs16">融资计划</p>
				<p>
					<i class="fs36">${map.financialneeds }</i>万元
				</p>
				<p>
					<em>融资资金</em>
				</p>
			</div>
			<ul class="financing-list clearfix">
				<li class="w80 "><span id="Js-stakes">${map.transferratio
						}</span><i>%</i><em>出让股份</em></li>
				<li class="w73">${map.count==null||map.count==""?0:map.count}<i>人</i><em>预约人数</em></li>
				<li class="w33">${ map.mininvestment}<i>万</i><em>最低投资额</em></li>
			</ul>
			<div class="appointment-money clearfix">
				<p class="fs14">
					<em>预约金额</em><span class="fb">${map.money }万元</span>
				</p>
				<div class="financing-progress">
					<i class="fb" style="width:${map.bili }%"></i>
				</div>
				<p class="financing-info">
					<i class="fl fb">${map.bili }%</i>
				</p>
			</div>
          <div id="Js-action" class="financing-btns  yuyue" data-id="${map.proid }" style="display:none"> 
		        <a href="javascript:void(0);"  data-status="1" class="btn btn-big btn-orange bg-orange last">我要预约</a>
				</div>
				<div id="Js-action" class="financing-btns biangen" data-id="${map.proid }" style="display:none"> 
				<a href="javascript:change();"  data-status="1" class="btn btn-big btn-orange bg-orange last">变更预约</a>
			    <a   href="javascript:void(0);"  data-status="3" class="btn btn-big btn-orange bg-orange last">取消预约</a>
							</div>
			<div class="promoters-tit">投资人列表</div>
			<div class="Js-long">
				<logic:notEmpty name="list">
					<logic:iterate id="l" name="list">
						<dl class="pro-promoters clearfix">
							<dt>
								<img src="${l.headimg==null||l.headimg==''?'images/user/defaultUser1.png?v=20141112':l.headimg }">
							</dt>
							<dd class="fs14 fb"></dd>
							<dd class="fs14 fb">${l.username }</dd>
							<dd>
								<em>预约金额</em><span class="fb">${l.money }万元</span>
							</dd>
							<dd>
								<em>预约时间</em>${l.addtime }
							</dd>
						</dl>
					</logic:iterate>
				</logic:notEmpty>
				<div class="Js-long-btn "
					style="color: gray; cursor: pointer; text-align: center;">显示全部</div>
			</div>

			<input  id="Js-targetFund" class="hidden" data-fund="${map.financialneeds }" />

		<div id="Js-yuyueTpl" style="display:none">
	<form class="add-con" name="lingtoutForm" action="deal.do" wx-validator wx-validator-ajax="reload" wx-validator-error-class="error-text error-margin"  wx-validator-noscroll>
	   	<div class="add-list">
			<label>意向投资金额</label>
			<div class="add-list-r">
				<input type="text" id="001" name="money" class="Js-computFund" wx-validator-rule="required" wx-validator-param="||3" wx-validator-money-min="最低3万元">
				<span class="gray " >*最低投资${ map.mininvestment}万</span>
				<span class="gray money" >万元</span>
			</div>
			<span id="wx-validator-money-required" class="error-text hidden">*不能为空</span>
			</div>
		<div class="add-list clearfix">
			<label>占股比例</label>
			<div class="add-list-r">
				<div class="rate" id="rate1"></div>
			</div>
		</div>
		<div class="add-list clearfix">
			<label>申请说明</label>
			<div class="add-list-r">
				<textarea name="ordercomm"></textarea>
			</div>
		</div>
		<input name="proid" value="${map.proid }" class="hidden">
		<input name="m" value="orderLt" class="hidden">
		
		<a class="btn bg-green btn-pop" type="submit" >提交</a>
	</form>
</div>
	
</div>
		<div class="float-wx">
			<img
				src="images/psb.jpg"
				alt="">
			<p class="join">扫描加入微信群</p>
			<p>与项目方充分沟通</p>
		</div>

		<script type="text/javascript" src="js/jquery.bxslider.js?v=20141112"></script>

		<script type="text/javascript">
function showHide(opt){
	$("#"+opt).addClass("hide");		
    $("#js-"+opt).show();
    $("#js-"+opt).click(function(){
    	if($(this).text()=="展开"){
           $(this).text("收起");
           $("#"+opt).removeClass("hide");
    	}else{
           $(this).text("展开");
           $("#"+opt).addClass("hide");
    	}
    	 
    });
}
    $(function(){
      	if($("#yhxq").height()>96){
      	   showHide("yhxq");
		}
		if($("#fays").height()>96){		
			showHide("fays");
		}
		if($("#xqcj").height()>96){		
			showHide("xqcj");
		}
		
		if($("#scfx").height()>96){		
			showHide("scfx");
		}
		if($("#fzgh").height()>96){		
			showHide("fzgh");
		}
		if($("#qt").height()>96){		
			showHide("qt");
		}
    });

</script>
	</div>
	<jsp:include page="foot.jsp" />
</body>
</html>


