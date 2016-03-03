/**
 * 发起项目的js
 */

/* 融资需求部分的JS */
function f_needs(){
		
	var that = this;
	this.errors = [];
	this.init = function (){
		
		//需要验证的input
		that.inputs = ["team_size", "registered_capital", "financial_needs", "allow_exceed", "min_investment", "min_startup", "max_overraise", "transfer_ratio"];
		
		// 特殊输入框处理
		var w_inputs = {
				financial_needs : "wy-hint",  
				min_investment : "wy-hint", 
				min_startup : "wy-hint" , 
				max_overraise: "wy-hint", 
				transfer_ratio : "percent-hint",
				registered_capital : "wy-hint"
				};		
		
		var add_input_hint = function(){
			for(var key in w_inputs){
				var input = $("input[name='" + key + "']");			
				var p = input.parent();
				
				if(w_inputs[key] == "wy-hint"){
					var hint = $("<span class='wy-hint'>万元</span>");
					
					p.append(hint);	
				}else{
					var hint = $("<span class='percent-hint'>%</span>");
					
					p.append(hint);
				}
				
			}
		};
		add_input_hint();
		_change();
		for(var i = 0; i < that.inputs.length; i++){
			var name = that.inputs[i];
			$("input[name='" + name + "']").keyup(function(){
				_change();
			});
			$("select[name='" + name + "']").change(function(){
				_change();
			});
		}
	}
	
	
	function _change(){
		var values = getVals();
		var valuation = calc_valuation(values);
		$("#valuation").text(valuation);
		set_label_value("min_investment_label", values.min_startup);
		set_label_value("financial_needs_label", values.financial_needs);
		if(values.allow_exceed == 1){
			set_label_value("max_label", values.financial_needs + values.max_overraise);
		}else{
			set_label_value("max_label", values.financial_needs);
		}
		setVals(values);
		
		if(that.errors.length > 0){
			that.check();
		}
	}

	this.check = function(){
		that.errors = [];
		var values = getVals();
		if(values.min_startup >= values.financial_needs){
			that.errors.push({msg:"项目启动最低门槛，应该小于融资需求", input:"min_startup"});
		}
		if(values.transfer_ratio < 1 || values.transfer_ratio > 70){
			that.errors.push({msg:"出让股份不应当小于1%,不能超过70%", input:"transfer_ratio"});
		}
		if(values.min_startup < 1){
			that.errors.push({msg:"项目启动最低门槛不能小于1万元", input:"min_startup"});
		}	
		if(values.min_investment >= values.financial_needs){
			that.errors.push({msg:"每人最低投资金额不能大于融资需求", input:"min_investment"});
		}
		if(values.allow_exceed == 1){
			if(values.max_overraise < 1){
				that.errors.push({msg:"超募金额最少1万元", input:"max_overraise"});
			}
			//if(values.max_overraise + values.financial_needs > 10000){errors.push({msg:"超募金额+融资需求不能超过1亿元", input:"max_overraise"});}
		}
		
		//if(values.financial_needs > 10000){errors.push({msg:"融资需求不能超过1亿元", input:"financial_needs"});}
		//if(values.min_startup > 10000){errors.push({msg:"目启动最低门槛不能超过一医院", input:"min_startup"});}

	
		showErrors();
		setVals(values);
	}
	
	this.hasError = function(){
		return that.errors.length > 0;
	}
	
	function set_label_value(id, val){
		if(val == 0){
			$("#" + id).text("");
		}else{
			$("#" + id).text(val + "万元");
		}
	}
	
	function calc_valuation(values){
		if(values.transfer_ratio == 0){
			return "";			
		}else{
			return Math.round(Number(100 * values.financial_needs / values.transfer_ratio)) + "万元"
		}
	}
	
	function showErrors(){
		$("span.validate-msg1").remove();
		for(var i = 0; i < that.errors.length; i++){
			var err = that.errors[i];
			
			var span = $("<span class='validate-msg1'></span>");
			span.text(err.msg);
			span.show();
			$("input[name='" + err.input + "']").parent().append(span);					
		}
		
		
	}
	
	function setVals(arr){
		for(var key in arr){
			setValByName(key, arr[key]);
		}
	}
	
	
	function getVals(){
		return {
			"financial_needs" : getMoneyFromInput("financial_needs"),
			"min_investment"  : getMoneyFromInput("min_investment"),
			"min_startup"     : getMoneyFromInput("min_startup"),
			"max_overraise"   : getMoneyFromInput("max_overraise"),
			"team_size"       : getMoneyFromInput("team_size"),
			"transfer_ratio"  : getRatioFromInput("transfer_ratio"),
			"allow_exceed"    : getSelectValue("allow_exceed"),
			"registered_capital" : getMoneyFromInput("registered_capital")
		};
	}
	
	function getSelectValue(id){
		var val = $("select[name='" + id + "']").val();
		return val;
	}
	
	function getMoneyFromInput(id){
		var val = getValByName(id);
		val = Number(val);
		if(isNaN(val)){val = 0;}		
		return val;
	}
		
	function getRatioFromInput(id){
		var val = getValByName(id);
		val = Number(val);
		if(isNaN(val)){val = 0;}
		if(val < 0){return 0;}else if(val > 100) return 100;
		return val;
	}
	
	function getValByName(name){return $("input[name='" + name + "']").val();}
	function setValByName(name, val){$("input[name='" + name + "']").val(val);}
}

launch_f_needs = new f_needs();
launch_f_needs.init();

function financial_needs_before(){
	launch_f_needs.check();
	if(launch_f_needs.hasError()){
		return false;
	}
	return true;
}

function profit_model_before(){
	v1 = (function(){
		var json = $("#financial_data").val();
		if(json == 'null' || json == ''){
			return true;
		}
		var data = JSON.parse(json);
		for(var i = 0; i < 3; i++){
			var inputed = 0;
			for(var j = 0; j < 3; j++){
				if(data[j][i] != ""){
					inputed ++;
				}
			}
			for(var j = 0; j < 3; j++){
				if(inputed != 0 && inputed != 3){
					wx.alert("请把「财务数据」第" + (i+1) + "列填写完整");
					return false;
				}
				
			}
		}
		return true;
	})();
	
	
	v2 = (function(){
		var json = $("#profit_forecast").val();
		if(json == 'null' || json == ''){
			return true	;
		}
		var data = JSON.parse(json);
		
		for(var i = 0; i < 3; i++){
			var inputed = 0;
			for(var j = 0; j < 3; j++){
				if(data[j][i] != ""){
					inputed ++;
				}
			}
			for(var j = 0; j < 3; j++){
				if(inputed != 0 && inputed != 3){
					wx.alert("请把「盈利预测」第" + (i+1) + "列填写完整");
					return false;
				}
				
			}
		}
		return true;
	})();
	
	return v1 && v2;

}

function company_structure_before(){
	var company_startup_date = $("#company_startup_date").val();
	var d =new Date(Date.parse(company_startup_date.replace(/-/g,   "/")));  
	var d2 = new Date();
	if($("#is_company1").val() == 1){
		if(d.getFullYear() < 1949 || d.getFullYear() > d2.getFullYear()){
			wx.alert("请输入合法日期");
			return false;
		}
		if(d == 'Invalid Date'){
			wx.alert("请输入合法日期");
			return false;
		}
	}
	var check =false;
	$("#equity_structure_table_wrap table input").each(function(){
		if(check){return;}
		if($(this).val() != "" && $(this).val() != undefined){
			check = true;
		}
	});
	
	if(check){
		var inputs = $("input[data-group='share_group']");
		var sum = 0;
		inputs.each(function(){
			var p = $(this).val();
			p = Number(p);
			if(isNaN(p)){
				p = 0;
			}
			sum += p;
		});
		
		if(sum > 100){
			wx.alert("「股权比例」之和不能大于100%");
			return false;
		}
	}
	
	return true;
}

$(document).ready(function(){
	$("#is_company1").change(function(){
		if($(this).val() == 1){
			$("#company-frm1").hide();
			$("#company-frm2").show();
			$("#is_company").val(1);
		}
	});
	
	$("#is_company").change(function(){
		if($(this).val() == 0){
			$("#is_company1").val(0);
			$("#company-frm1").show();
			$("#company-frm2").hide();
		}
	});
});