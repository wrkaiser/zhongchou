/**
 *  教育背景控件
 */

(function($){
	var tpl = '<div class="source hover clearfix" data-row="<% row %>" style="margin-bottom:5px;">\
		<div class="form-list-sub clearfix">\
			<label>专业名称</label>\
			<div class="inp">\
				<input id="major_<% group %>_<% row %>" name="major_<% group %>_<% row %>" value="<% major %>" type="text" />\
			</div>\
		</div>\
		<div class="form-list-sub clearfix">\
			<label>学校名称</label>\
			<div class="inp">\
				<input id="school_<% group %>_<% row %>" name="school_<% group %>_<% row %>" value="<% school %>" type="text" />\
			</div>\
		</div>\
		<div class="form-list-sub clearfix">\
			<label>就读时间</label>\
			<div class="inp" style="width:70%;">\
				<select id="begin_year_<% group %>_<% row %>" name="begin_year_<% group %>_<% row %>"  class="quarter"></select>\
				<select id="begin_month_<% group %>_<% row %>" name="begin_month_<% group %>_<% row %>" class="quarter"></select>\
				<span  class="quarter">-</span>\
				<select id="end_year_<% group %>_<% row %>" name="end_year_<% group %>_<% row %>" class="quarter"></select>\
				<select id="end_month_<% group %>_<% row %>" name="end_month_<% group %>_<% row %>"  class="quarter"></select>\
			</div>\
		</div>\
		<div class="form-list-sub clearfix">\
			<label>学历</label>\
			<div class="inp">\
				<select class="third" name="education_<% group %>_<% row %>"  id="education_<% group %>_<% row %>">\
					<option>博士</option>\
					<option>硕士</option>\
					<option>本科</option>\
					<option>大专</option>\
					<option>大专以下</option>\
				</select>\
			</div>\
		</div>\
		<div class="del-wrap">\
			<a class="delbtn" data-row=<% row %>>点击此处删除</a>\
		</div>\
	</source>';
	$.fn.education_background = function(_options){

		var defaults = {
			target : "",
			add_btn : "",
			data : ""
		};
		var that = this;
		this.options = $.extend(defaults, _options);
		
		
		
		/* Assign controls */
		this.targetInput = $("#" + this.options.target);
		this.add_btn = $("#" + this.options.add_btn);
		this.rows = $(this).find(".rows");
		/* INIT DATA */
		var val = this.targetInput.val();
		if(val != undefined && val != ""){
			this.data  = $.parseJSON(val);
		}
		if(!(that.data instanceof Array)){
			this.data = [];
		}
		
		
		this.add_btn.click(function(){			
			add_row(that.data.length + 1);
		});
		
		/* Insert Rows */
		if(this.data.length == 0){add_row(that.data.length + 1);}
		else{
			for(var i = 1; i <= that.data.length; i++){
				var rowData = this.data[i-1];
				add_row(i, rowData);
			}
		}
		

		
		function init_year(control){
			var d = new Date();
			for(var i = d.getFullYear(); i >= 1949; i--){
				control.append("<option value=" + i +">" +i+ "</option>");
			}
		}
		
		function init_month(control){
			var d = new Date();
			for(var i = 1; i <= 12; i++){
				control.append("<option value=" + i +">" +i + "月" + "</option>");
			}
		}
		
		function add_row(i, rowData){
			var defaults = {	
					row : i,
					group : that.options.group,
					school : "",
					major : "",
					begin_year: "",
					end_year : "",
					begin_month: "",
					end_month : "",
					education : ""
				};
			insert_new_data_row(i);
			var values = $.extend(defaults, rowData);
			
			var row_html = wx.tpl(tpl, values);
			var row_control = $(row_html);
			that.rows.append(row_html);
			add_js(i, row_control, values);			
			
		}
		function getId(name, i){
			return "#" + name + "_" + that.options.group + "_" + i;
		}
		function add_js(i, row_control, values){
			var schoolInput = $(getId("school", i));
			var majorInput = $(getId("major", i));
			var beginYearInput = $(getId("begin_year", i));
			var endYearInput = $(getId("end_year", i));
			var beginMonth = $(getId("begin_month", i));
			var endMonth = $(getId("end_month", i));
			var educationInput = $(getId("education", i));
			init_year(beginYearInput);
			init_year(endYearInput);
			init_month(endMonth);
			init_month(beginMonth);
			beginYearInput.val(values.begin_year);
			endYearInput.val(values.end_year);
			beginMonth.val(values.begin_month);
			endMonth.val(values.end_month);
			var inputs = [schoolInput, majorInput ,beginYearInput, endYearInput, beginMonth, endMonth, educationInput];
			for(var j = 0; j < inputs.length; j++){
				inputs[j].attr('data-row', i);				
				inputs[j].change(function(){
					value_changed(i, this);
				});
			}
			that.find(".delbtn").click(function(){
				var row = $(this).attr("data-row");
				that.find(".source[data-row='" + row +"']").remove();
				value_changed();
			});
		}
		
		function getValues(){
			var data = [];
			$(that).find(".source").each(function(){
				var i = $(this).attr('data-row');
				var schoolInput = $(this).find(getId("school", i));
				var majorInput = $(this).find(getId("major", i));
				var beginYearInput = $(this).find(getId("begin_year", i));
				var endYearInput = $(this).find(getId("end_year", i));
				var beginMonth = $(this).find(getId("begin_month", i));
				var endMonth = $(this).find(getId("end_month", i));
				var educationInput = $(this).find(getId("education", i));
				var d = {
					"school" : schoolInput.val(),
					"major" : majorInput.val(),
					"begin_year" : beginYearInput.val(),
					"end_year" : endYearInput.val(),
					"begin_month" : beginMonth.val(),
					"end_month" : endMonth.val(),
					"education" : educationInput.val()
				}
				data.push(d);
			});
			return data;
			
		}
		
		function value_changed(){
			that.targetInput.val(JSON.stringify(getValues()));
		}
		
        function insert_new_data_row(row){
        	if(that.data[row - 1] == undefined){	        	
	            that.data[row-1] = {	
						school : "",
						major : "",
						begin_year: "",
						end_year : "",
						begin_month: "",
						end_month : "",
						education : ""
					};
        	}
        }
        
        function setValue(){
        	that.targetInput.val(JSON.stringify(that.data));
        }
		
		function validate(){
			
		}
	};
})(jQuery);
