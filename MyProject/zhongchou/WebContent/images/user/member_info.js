(function($){
	var tpl = '\
	<div class="member-group" data-row="<% row %>">\
		<div class="form-list">\
			<label for="">上传头像<i>*</i></label>\
			<div class="inp add-list clearfix">\
				<div class="fl">\
					<input wx-upload-type="" type="file" wx-upload="/upload/cover" name="member_avatar<% row %>_wxupload" wx-upload-assign="member_avatar<% row %>=data.fileUrl" wx-upload-set="member_avatar<% row %>_img=data.fileUrl" hidefocus="true">\
					<div class="add-btn"></div>\
				</div>\
				<div class="fl">\
					<em class="tag">＊文件大小请勿超过8MB</em>\
					<input type="hidden" wx-validator-rule="required" class="picarr" name="member_avatar<% row %>" id="member_avatar<% row %>" value="<% photo %>">\
					</div>\
			</div>\
			<div class="picul inp clearfix" id="member_avatar<% row %>_picul">\
				<span id="member_avatar<% row %>_span" style="display:none">\
					<img  id="member_avatar<% row %>_img" src="<% member_avatar %>">\
				</span>\
				<div id="wx-validator-member_avatar<% row %>-required"  style="color:red;display:none;">请上传成员头像</div>\
    		</div>\
		</div>\
\
		<div class="form-list">\
			<label for="">真实姓名<i>*</i></label>\
			<div class="inp">\
				<div class="clearfix">\
					<input wx-validator-rule="required" name="member_name<% row %>" wx-validator-param="" id="member_name<% row %>" type="text" placeholder="" value="<% name %>">\
					<div id="wx-validator-member_name<% row %>-required"  style="color:red;display:none;">真实姓名不能为空</div>\
				</div>\
			</div>\
			<div class="prompt"><i></i><div class="sub"><div>真实姓名</div></div></div>\
		</div>\
		<div class="form-list">\
			<label for="">职位<i>*</i></label>\
			<div class="inp">\
				<div class="clearfix">\
					<input wx-validator-rule="required" name="title<% row %>" wx-validator-param="" id="title<% row %>" type="text" placeholder="" value="<% title %>">\
				</div>\
				<div id="wx-validator-title<% row %>-required"  style="color:red;display:none;">职位不能为空</div>\
			</div>\
			<div class="prompt"><i></i><div class="sub"><div>该成员在创业团队中的职位</div></div></div>\
		</div>\
\
		<div class="form-list">\
			<label for="">所在城市<i></i></label>\
			<div id="member_city_region_selector<% row %>" class="inp clearfix padding-0">           \
			</div>\
		    <input type="hidden" name="member_city<% row %>" id="member_city<% row %>" value="<% city %>">\
		</div>\
\
		<div class="form-list clearfix" id="cstr_education_background<% row %>">\
			<label for="" style="height:20px;line-height:20px">教育经历<i>&nbsp;&nbsp;</i></label>\
			<div class="inp">\
				<div class="rows"></div>\
				<input type=hidden name="education_background<% row %>" id="education_background<% row %>" value=\'<% education_background %>\' />\
				<a id="cstr_education_background<% row %>_add_btn" class="add-btn1 clearfix">增加一行</a>\
			</div>\
		</div>\
		<div class="form-list clearfix" id="cstr_work_experience<% row %>">\
		<label for="" style="height:20px;line-height:20px">工作经历<i>&nbsp;&nbsp;</i></label>\
		<div class="inp">\
			<div class="rows"></div>\
				<input type=hidden name="work_experience<% row %>" id="work_experience<% row %>" value=\'<% work_experience %>\' />\
				<a id="cstr_work_experience<% row %>_add_btn" class="add-btn1 clearfix">增加一行</a>\
			</div>\
		</div>\
		<div class="form-list">\
			<label for="">人员介绍<i>&nbsp;&nbsp;</i></label>\
			<div class="inp">\
				<textarea wx-validator-rule="" name="member_profile<% row %>" wx-validator-param="" id="member_profile<% row %>" type="text" placeholder="" ><% intro %></textarea>\
			</div>\
			<div class="prompt"><i></i><div class="sub"><div>请简要介绍一下成员信息，不要超过500字</div></div></div>\
		</div>\
		<div class="delwrap">\
			<a class="del" data-row=<% row %>>删除此条团队记录</a>\
		</div>\
		<div class="hr" />\
	</div>';
	$.fn.member_info = function(options){
		var that = this;		
		this.rows = $(this).find(".rows");
		this.rowCnt = 1; 
		this.member_num_control = $("#" + options.member_num_control);
		
		/* INIT DATA */
		if(options.jsonData != undefined){
			try{
				this.data = $.parseJSON(options.jsonData);
			}catch(e){
				this.data = undefined;
			}
		}
		if(this.data == undefined){this.data = [];}
		
		/* Insert Rows */
		if(that.data.length == 0){add_row(that.rowCnt++);}
		else{
			for(var i = 1; i <= this.data.length; i++){
				var rowData = this.data[i-1];
				add_row(that.rowCnt++, rowData);
			}
		}
		
		/* Attach Event to Add Button */
		$("#" + options.add_btn).click(function(){
			add_row(that.rowCnt++);
		});
		
		// Add a team member.
		function add_row(i, rowData){
			var defaults = {
				row : i,
				member_avatar : "",
				city : "",
				education_background : "",
				work_experience : "",
				member_name : "",
				title : ""
			};			
			var values = $.extend(defaults, rowData);	
			values.education_background = JSON.stringify(values.education_background);
			values.work_experience = JSON.stringify(values.work_experience);
			var row_html = wx.tpl(tpl, values);
			var row_control = $(row_html);
			that.rows.append(row_control);
			add_js(i, row_control, values); 
			that.member_num_control.val(i);
			if(i != 1){
				row_control.find(".delwrap").show();
			}else{
				row_control.find(".delwrap").hide();
			}
			wx.upload($("input[name='member_avatar" +  i +"_wxupload']"))
			
		}
		
		function add_js(i, row_control, rowData){
			that.find("#cstr_work_experience" + i).work_experience({
				target : "work_experience" + i,
				add_btn : "cstr_work_experience" + i + "_add_btn",
				group : i
			});

			that.find("#cstr_education_background" + i).education_background({
				target : "education_background" + i,
				add_btn : "cstr_education_background" + i + "_add_btn",
				group : i
			});
			
			that.find("#" + "member_city_region_selector" + i).city_selector('member_city' + i, rowData.city);
			window["member_avatar"+i+"_wxupload"] = function(data){
			    if(!data.data) wx.alert(data.usercode);
				$("#member_avatar" + i + "_picul").find("img").attr("src", data.data.fileUrl);
				$("#member_avatar" + i + "_span").show();	            
			};
			if(rowData.member_avatar != ""){
				$("#member_avatar" + i +"_span").show();
			}
			
			that.find(".del").click(function(){
				if($(".member-group").length <= 1){
					wx.alert("至少需要填写一个团队成员(创始人)。");
					return;
				}
				var row = $(this).attr("data-row");
				that.find(".member-group[data-row='" + row +"']").remove();
				value_changed();
			});
		}
		
	};
})(jQuery);

