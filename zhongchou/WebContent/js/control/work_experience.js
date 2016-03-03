/**
 *  工作经历控件
 */

(function($){
	var tpl = '<div class="source hover clearfix" data-row="<% row %>" style="margin-bottom:5px;">\
		<div class="form-list-sub clearfix">\
			<label>公司名称</label>\
			<div class="inp">\
				<input id="work_company_<% group %>_<% row %>" name="work_company_<% group %>_<% row %>" type="text" value="<% work_company %>" />\
			</div>\
		</div>\
		<div class="form-list-sub clearfix">\
			<label>职位名称</label>\
			<div class="inp">\
				<input id="work_title_<% group %>_<% row %>" name="work_title_<% group %>_<% row %>" type="text" value="<% work_title %>" />\
			</div>\
		</div>\
		<div class="form-list-sub clearfix">\
			<label>工作地点</label>\
			<div class="inp">\
				<input id="work_address_<% group %>_<% row %>" name="work_address_<% group %>_<% row %>" type="text" value="<% work_address %>" />\
			</div>\
		</div>\
		<div class="form-list-sub clearfix">\
			<label>工作时间</label>\
			<div class="inp" style="width:70%;">\
				<select id="work_begin_year_<% group %>_<% row %>" name="work_begin_year_<% group %>_<% row %>"  class="quarter"></select>\
				<select id="work_begin_month_<% group %>_<% row %>" name="work_begin_month_<% group %>_<% row %>" class="quarter"></select>\
				<span  class="quarter">-</span>\
				<select id="work_end_year_<% group %>_<% row %>" name="work_end_year_<% group %>_<% row %>" class="quarter"></select>\
				<select id="work_end_month_<% group %>_<% row %>" name="work_end_month_<% group %>_<% row %>"  class="quarter"></select>\
			</div>\
		</div>\
		<div class="form-list-sub clearfix">\
			<label>工作职责</label>\
			<div class="inp">\
				<textarea name="work_duty_<% group %>_<% row %>" id="work_duty_<% group %>_<% row %>"><% work_duty %></textarea>\
			</div>\
		</div>\
		<div class="del-wrap">\
			<a class="delbtn" data-row=<% row %>>点击此处删除</a>\
		</div>\
	</source>';
	$.fn.work_experience = function(_options){

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
		function add_row(i, rowData){
			var defaults = {	
					row : i,
					group : that.options.group,
					work_title : "",
					work_address : "",
					begin_year: "",
					end_year : "",
					begin_month: "",
					end_month : "",
					work_company :"",
					work_duty : ""
				};
			insert_new_data_row(i);
			var values = $.extend(defaults, rowData);
			
			var row_html = wx.tpl(tpl, values);
			var row_control = $(row_html);
			that.rows.append(row_html);
			add_js(i, row_control, values);			
			
		}
//		
		/* Init controls */
//		init_year(this.beginYearInput);
//		init_year(this.endYearInput);
//		init_month(this.endMonth);
//		init_month(this.beginMonth);
		
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
		
		function getId(name, i){
			return "#" + name + "_" + that.options.group + "_" + i;
		}
		
		function add_js(i, row_control, values){
			var titleInput = $(getId("work_title",i));
			var addressInput = $(getId("work_address",i));
			var beginYearInput = $(getId("work_begin_year", i));
			var endYearInput = $(getId("work_end_year", i));
			var beginMonth = $(getId("work_begin_month", i));
			var endMonth = $(getId("work_end_month", i));
			var dutyInput = $(getId("work_duty",i));
			var companyInput = $(getId("work_company",i));
			var workDutyInput = $(getId("work_duty", i));
			var inputs = [titleInput, addressInput ,beginYearInput, endYearInput, beginMonth, endMonth, dutyInput, companyInput, workDutyInput];
			for(var j = 0; j < inputs.length; j++){
				inputs[j].attr('data-row', i);				
				inputs[j].change(function(){
					value_changed();
				});
			}
			init_year(beginYearInput);
			init_year(endYearInput);
			init_month(endMonth);
			init_month(beginMonth);
			beginYearInput.val(values.begin_year);
			endYearInput.val(values.end_year);
			beginMonth.val(values.begin_month);
			endMonth.val(values.end_month);
			
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
				var titleInput = $(this).find(getId("work_title",i));
				var addressInput = $(this).find(getId("work_address",i));
				var beginYearInput = $(this).find(getId("work_begin_year", i));
				var endYearInput = $(this).find(getId("work_end_year", i));
				var beginMonth = $(this).find(getId("work_begin_month", i));
				var endMonth = $(this).find(getId("work_end_month", i));
				var dutyInput = $(this).find(getId("work_duty" + i));
				var companyInput = $(this).find(getId("work_company",i));
				var workDutyInput = $(this).find(getId("work_duty", i));	
				var d = {
						"work_title" : titleInput.val(),
						"work_address" : addressInput.val(),
						"begin_year" : beginYearInput.val(),
						"end_year" : endYearInput.val(),
						"begin_month" : beginMonth.val(),
						"end_month" : endMonth.val(),
						"duty" : dutyInput.val(),
						'work_company' : companyInput.val(),
						"work_duty" : workDutyInput.val()
					};
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
						work_title : "",
						work_address : "",
						begin_year: "",
						end_year : "",
						begin_month: "",
						end_month : "",
						duty : "",
						work_company : '',
						work_duty : ''
							
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
