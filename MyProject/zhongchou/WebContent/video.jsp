<%@page import="com.xiaoyou.util.JsonUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.xiaoyou.dao.BaseDao"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String proid=request.getParameter("proid");//所传入的课件id
String sql="";
BaseDao dao=new BaseDao();
sql="select * from sp_video_ppt where proid="+proid+" order by pageno asc";
List ddlist=dao.getList(sql);
request.setAttribute("ddlist", ddlist);
request.setAttribute("ddlistjson", JsonUtils.listToJson(ddlist));
request.setAttribute("proid", proid);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="${pageContext.request.contextPath}/" />
<link rel="stylesheet" href="back/css/style.css" />
<link href="css/common.css?v=20141112" rel="stylesheet" type="text/css">
<link href="back/css/prog_public.css" rel="stylesheet" type="text/css" />
<title>视频播放预览</title>
<script type="text/javascript" src="js/jquery-1.8.2.js"></script>
<script src="js/wx.js?v=20141112"></script>
<script src="js/wx.config.js?v=20141112"></script>
<script type="text/javascript" src="js/jsrender.js" charset="utf-8"></script>
<script type="text/javascript" src="ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript" src="js/swfobject/swfobject.js"></script>
		<script type="text/javascript" src="js/flexpaper_flash.js"></script>
<script type="text/javascript" src="back/js/qdynic.js"></script>
 
</head>
<body class="bggreen">
<div class="tpsbanner">
 <div class="areaa mauto">
  <div class="tp_infos">
    <A href="#" class="index_0">首页</A><span class="usinfo">高一三班 王刚同学</span>
  </div>
  <div class="tp_bner">
     <ul>
       <li><A href="#">本课首页</A></li>
       <li><A href="#">课程公告</A></li>
       <li class="set"><A href="#">网上学堂</A></li>
       <li><A href="#">测试作业</A></li>
       <li><A href="#">讨论交流</A></li>
       <li><A href="#">调查评价</A></li>
       <li><A href="#">我的课程</A></li>
     </ul>
     
   </div>  
                                                                                    
  </div>
</div>
<div class="imgbg"><div class="areab mauto"></div></div>
<div class="wrap_all">
   
   <div class="wrap_Con">
     <div class="w_tplnk">
         <A href="#" class="dzjc">电子教材</A><A href="#" class="dzja">电子教案</A><A href="#" class="zxtw">在线提问</A>
     </div>
     
     <div class="w_ttitle">
       <h1>计算机-VB语言的应用</h1>
     </div>
     
     <div class="doc-main " style="position:relative; height:480px; width:960px;">
    <div style=" position:absolute; width:960px; height:2px; background:#333; overflow:hidden; bottom:0; left:0; z-index:99999999;"></div>
    <div style=" position:absolute; width:1px; height:480px; background:#ddd; overflow:hidden; top:0; left:0; z-index:99999999;"></div>
    <div id="starthideendshow" style=" position:absolute; width:1px; height:580px; background:#ddd; overflow:hidden; right:360px; top:0; z-index:9999999;"></div>
    <div style=" position:absolute; width:1px; height:480px; background:#ddd; overflow:hidden; right:0; top:0; z-index:99999999;"></div>
    
    
    <div id="leftid"  class="doc-l" style=" position:absolute; left:0; top:0;width:600px;height:480px;">
    <div id="flashContent">
    
    </div>
    </div>
    <div class="doc-r">
        <div id="topid" style="position:absolute;right:0;top:0;width:360px;height: 240px;">
          <div id="mvideo"  >加载中...</div>
        </div>
        <div id="iframeParent" style="position:absolute;right:0;top:240px;width:360px;height: 240px;overflow: auto;">
             <div  style="height: auto;width: 100%">
                 <div class="mn_lstin" >
                   <table class="lsttable lsttable1 dglist" cellpadding="0" cellspacing="0">
                   <thead> <tr class="ntt"><td width="90" align="center">开始时间</td><td>知识索引点</td></tr></thead>
                   <tbody>
                   <logic:notEmpty name="ddlist">
                    <logic:iterate id="dd" name="ddlist" indexId="i"> 
                   <tr><td width="90" class="dtime"  title="双击定位到播放位置">${dd.dtime}</td><td><span class="sy myinput"  data="info">${dd.info}</span></td></tr>
                   </logic:iterate>
                   </logic:notEmpty>
                   </tbody>
                  </table>
                 </div>
             </div>
        </div>
        </div>
        <div class="rotate" onclick="changelocation()"></div>
    <script type="text/javascript">
       

        $(function () {
           
        })

        function gotovedio(page, sec) {
            //changeImageIndex('go', page);
            for (var i = 1; i < Video2Image.length; i++) {
                if (Video2Image[i].StartTime >= sec && Video2Image[i - 1].StartTime <= sec) {
                    //alert('if(Video2Image[i].StartTime > sec && Video2Image[i - 1].StartTime < sec) {');
                    document.getElementById("dimg").src = imgList[Video2Image[i - 1].imageindex];
                    showImageIndex = Number(Video2Image[i - 1].imageindex);
                    var o = $("#" + window.playerSetting.PlayerId).get(0).getPlayInfo();
                    $("#" + window.playerSetting.PlayerId).get(0).playback(o.program, Video2Image[i].StartTime, -1);
                    break;
                }
            }
        }



      



        var iscanclick = true;
        var changelocation_leftid = "leftid";
        var changelocation_topid = "topid";
        var changelocation_bottomid = "iframeParent";
        function changelocation() {
            if (!iscanclick) { return; }
            iscanclick = false;

            var lw = $("#" + changelocation_leftid).width();
            var lh = $("#" + changelocation_leftid).height();
            var tw = $("#" + changelocation_topid).width();
            var th = $("#" + changelocation_topid).height();
            var bw = $("#" + changelocation_bottomid).width();
            var bh = $("#" + changelocation_bottomid).height();

            var lwt = tw;
            var lht = th;
            var tleftt = lwt;
            var ttopt = th;
            var bwt = lw;
            var bht = lh;
            var btopt = 0;
            var bleftt = 0;
            iscancilcklist = [1, 1, 1, 1, 1, 1, 1];

            $("#" + changelocation_leftid).css("top", "0px").css("right", bw + "px").css("left", "auto").css("bottom", "auto");
            $("#" + changelocation_topid).css("right", "0px").css("top", "0px").css("bottom", "auto").css("left", "auto");
            $("#" + changelocation_bottomid).css("bottom", "0px").css("right", "0px").css("left", "auto").css("top", "auto");
            //return;
            var t = window.setInterval('changelocation_tick("' + changelocation_leftid + '","width",' + lw + ',' + lwt + ',0)', 10);
            $("#" + changelocation_leftid).data("intervalwidth", t);

            t = window.setInterval('changelocation_tick("' + changelocation_leftid + '","height",' + lh + ',' + lht + ',1)', 10);
            $("#" + changelocation_leftid).data("intervalheight", t);

            t = window.setInterval('changelocation_tick("' + changelocation_leftid + '","right",' + bw + ',' + 0 + ',2)', 10);
            $("#" + changelocation_leftid).data("intervalright", t);

            t = window.setInterval('changelocation_tick("' + changelocation_topid + '","top",' + 0 + ',' + th + ',3)', 10);
            $("#" + changelocation_topid).data("intervaltop", t);

            t = window.setInterval('changelocation_tick("' + changelocation_bottomid + '","width",' + bw + ',' + lw + ',4)', 10);
            $("#" + changelocation_bottomid).data("intervalwidth", t);

            t = window.setInterval('changelocation_tick("' + changelocation_bottomid + '","height",' + bh + ',' + lh + ',5)', 10);
            $("#" + changelocation_bottomid).data("intervalheight", t);

            t = window.setInterval('changelocation_tick("' + changelocation_bottomid + '","right",' + 0 + ',' + bw + ',6)', 10);
            $("#" + changelocation_bottomid).data("intervalright", t);

            var tmp = changelocation_leftid;
            changelocation_leftid = changelocation_bottomid;
            changelocation_bottomid = changelocation_topid;
            changelocation_topid = tmp;
        }
        function changelocation_tick(id, attr, fromv, tov, ind) {
            var step = 18;
            if (fromv > tov) { step = -18; }
            var tmp = parseFloat($("#" + id).css(attr));
            tmp += step;
            $("#" + id).css(attr, tmp + "px");
            if (step < 0 && tmp < tov) {
                $("#" + id).css(attr, tov + "px");
                window.clearInterval($("#" + id).data("interval" + attr));
                iscancilcklist[ind] = 0;
                checkstatus();
            }
            else if (step > 0 && tmp > tov) {
                $("#" + id).css(attr, tov + "px");
                window.clearInterval($("#" + id).data("interval" + attr));
                iscancilcklist[ind] = 0;
                checkstatus();
            }
            var tw = $("#topid").width();
            var th = $("#topid").height();
            var bw = $("#iframeParent").width();
            var bh = $("#iframeParent").height();
            var lw = $("#leftid").width();
            var lh = $("#leftid").height();
//alert($("#mvideo").find("object").width());
            $("#mvideo").find("object").attr("width",tw).attr("height",th);
            $("#mvideo").find("embed").attr("width",tw).attr("height",th);
            $("#leftid").find("object").width(lw).height(lh);
            if(lw<380){
            	getDocViewer().setZoom(0.5);
            }else{
            	getDocViewer().setZoom(0.8);
            }
            //document.getElementById("mvideo").updateSize(tw, th);
            //$("#iframe23").width(bw).height(bh);
           // document.getElementById("iframe23").contentWindow.window.resizechanged();
          //  $("#content_2").width(lw).height(lh);
            $("#dimg").width(lw - 20).height(lh);
        }
        
        function checkstatus() {
            for (var i = 0; i < iscancilcklist.length; i++) {
                if (iscancilcklist[i] == 1) { return; }
            }
            iscanclick = true;
        } 

    </script>
         
        </div>
     
     
     
   </div>
  
</div>
<div class="bddown">
  <div class="bddownin">
    
  </div>
</div>
<script>
var options={ppt:'back/images/test.swf',//ppt路径
		video:'images/test.mp4',//视频路径
		proid:'${proid}',ddlist:'${ddlistjson}'};
$(function(){
	$(".main_dler").dd_info(options);
})
</script>
</body>
</html>
