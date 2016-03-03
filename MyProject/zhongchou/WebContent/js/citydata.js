function cityinit(){
	var province = '<option value="1">北京</option><option value="2">天津</option><option value="3">上海</option><option value="4">重庆</option><option value="5">河北</option><option value="6">山西</option><option value="7">台湾</option><option value="8">辽宁</option><option value="9">吉林</option><option value="10">黑龙江</option><option value="11">江苏</option><option value="12">浙江</option><option value="13">安徽</option><option value="14">福建</option><option value="15">江西</option><option value="16" selected=selected>山东</option><option value="17">河南</option><option value="18">湖北</option><option value="19">湖南</option><option value="20">广东</option><option value="21">甘肃</option><option value="22">四川</option><option value="23">贵州</option><option value="24">海南</option><option value="25">云南</option><option value="26">青海</option><option value="27">陕西</option><option value="28">广西</option><option value="29">西藏</option><option value="30">宁夏</option><option value="31">新疆</option><option value="32">内蒙古</option><option value="33">澳门</option><option value="34">香港</option><option value="35">国外</option>';
	$("#s1").html(province);
	var city = '<option value="15">滨州</option><option value="54">德州</option><option value="55">东营</option><option value="104">菏泽</option><option value="128">济南</option><option value="129">济宁</option><option value="160">临沂</option><option value="161">聊城</option><option value="177">莱芜</option><option value="213" selected=selected>青岛</option><option value="229">日照</option><option value="266">泰安</option><option value="284">潍坊</option><option value="287">威海</option><option value="322">烟台</option><option value="355">淄博</option><option value="360">枣庄</option>';
	$("#s2").html(city);
	
	
	var town = '<option value="1606">市南区</option><option value="1607">市北区</option><option value="1608">四方区</option><option value="1609">黄岛区</option><option value="1610">崂山区</option><option value="1611">李沧区</option><option value="1612">城阳区</option><option value="1613">近郊</option>';
	$("#s3").html(town);
	
	var proid = $("#provinceid").val();

	if(proid!=null && proid!='0'){
		selectValue("s1",proid);
		
		var cid = $("#cityid").val();
		if(cid!=null  && proid!='0'){
			var ip = parseInt(proid) -1 ;
			getCity(ip,cid);
		}
		
		
		
		var sid = $("#sid").val();
		if(sid!=null  && cid!='0'){
			getTown(cid,sid);
		}
		
	}
	
}

function selectValue(id,val){
	var obj = $("#"+id);
	//$(obj).find("option:selected").removeAttr("selected");
	$(obj).find("option[value='"+val+"']").attr("selected","selected");
}

function getCity(pid,cityid){
	var html = '';
	var sroot = cityjson.results[pid];
	if(sroot==null){
	   return;
	}
	 $.each(sroot.root,function(i,item){
		    	  if(i==0 && cityid==''){
			    	   getTown(item.cityid,'');
			       }
		       if(cityid!='' && cityid==item.cityid){
		    	   html += '<option value="' + item.cityid + '" selected=selected>' + item.cityname  + '</option>';  
		       }else{
		    	   html += '<option value="' + item.cityid + '" >' + item.cityname  + '</option>';  
		       }
			 
		    });
   $("#s2").html(html);  
	
}



function getTown(cityid,areaid){
	$.ajax( {
		data:{
            'm': 'getTowns',
            'cityid':cityid,
            't':Math.random()
        },
		url: path+'back/province.do',
		type : "POST",
		dataType: "json",
		success : function(d) {
			var html="";  
			
		    $.each(d.root,function(i,item){
		    	if(areaid!='' && areaid==item.townid){
		    		html += '<option value="' + item.townid + '" selected=selected>' + item.townname  + '</option>';  
		    	}else{
		    		html += '<option value="' + item.townid + '">' + item.townname  + '</option>';  
		    	}
			  
		    });
		    
		    if(html!='')
			$("#s3").html(html);
	 }});
	
}


