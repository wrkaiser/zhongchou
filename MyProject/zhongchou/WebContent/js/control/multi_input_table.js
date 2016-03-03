/* 
 * 多输入框的表格
 */
(function($){
    $.fn.multi_input_table = function(_options){
    	var that = this;
    	var defaults = {
    		targetInput : "",
    		columns : [],
    		add_btn : "",
    		error_panel : undefined,
    		rows : undefined,
    		mode : "assoc",
    		required : true,
    		init_row : 1
    	};
                
    	/* Init Options */
    	this.options = $.extend(defaults, _options);    
    	this.columns = this.options.columns;
        
        /* Init controls */
    	this.targetInput = $("#" + this.options.targetInput);     	
    	
        this.table_html = "<table><colgroup></colgroup><thead></thead><tbody></tbody></table>";
        this.table = $(this.table_html);
        this.colgroup = this.table.find("colgroup");
        this.thead = this.table.find("thead");
        this.tbody = this.table.find("tbody");
        this.append(this.table);
        if(this.options.error_panel != undefined){
        	this.validators = $("#" + this.options.error_panel);
        }else{
        	this.validators = $("<div></div>");
        	this.append(this.validators);            	
        }
        
        init_col_group();
        init_headers();
        
        /* Init Data */
        this.colnums = this.options.columns.length;        
        this.data = [];
        var val = this.targetInput.val();
        if(val != undefined && val != 'null' && val != ""){
        	this.data = $.parseJSON(val);
        }
        
        /* Binding events. */     
        if(this.options.rows == undefined){
        	this.add_btn = $("#" + this.options.add_btn);
	        this.add_btn.click(function(){
	           append_row(that.data.length + 1); 
	        });
        }
            
        /* Render */
        if(this.data.length == 0){
        	if(this.options.rows != undefined){
        		for(var i = 1; i < this.options.rows.length; i++){
        			append_row(i);		
        		}
        	}else{
        		for(var i =0 ; i < that.options.init_row; i++){
        			append_row(this.data.length + 1);
        		}
        	}
        	
        	
        }else{
        	for(var i = 1; i <= this.data.length; i++){
                var dataRow = this.data[i-1];
                append_row(i, dataRow);
            }
        }
        

        
        /* Insert A row at i */
        function append_row(i, dataRow){
        	insert_new_data_row(i);
        	var row = $("<tr></tr>");
        	if(that.options.rows != undefined){
        		var row_meta = that.options.rows[i];
        		if(row_meta.label != undefined){
        			row.append("<td>" + row_meta.label + "</td>")
        		}
        	}
        	row.attr("data-row", i);
        	for(var j = 0; j < that.columns.length; j++){
        		var td = $("<td style='position:relative'></td>");
        		var column = that.columns[j];
        		td.attr("data-row", i);
        		td.attr("data-column", j+1);
        		var control = undefined;
        		var val = "";
        		if(that.options.mode == 'assoc'){
        			val = that.data[i-1][column.name];	
        		}else{
        			val = that.data[i-1][j];
        		}
        		
        		switch(column.type){        			
        			case "text" : 
        				var control = $("<input />");
        				control.attr("type", "text");
        				control.attr("validate-type", "text");
        				break;
        			case "percent" :
        				var control = $("<input />");
        				control.attr("type", "text");        				
        				control.attr("validate-type", "percent");
        				control.attr("data-group", column.name + "_group");
        				//control.attr("wx-validator-rule", "range|required");
        				//control.attr("wx-validator-param", "0-100");
        				break;
        			case "money" :
        				var control = $("<input />");
        				control.attr("type", "text");        				 
        				control.attr("validate-type", "money");
        				//control.attr("wx-validator-rule", "min|required");
        				//control.attr("wx-validator-param", "1");
        				//control.css("padding-left", "10px");
        				break;
        		}
        		if(dataRow != undefined){
        			if(that.options.mode == "assoc")
        				control.val(dataRow[column.name]);
        			else
        				control.val(dataRow[j]);
        		}
        		control.attr("name", $(that).attr("id") + "_" + column.name + "_" + i);
        		control.attr("placeholder", column.placeholder);
        		control.attr("data-row", i);
        		control.attr("data-column", j+1);
        		control.change(function(){
        			value_change();
        		});
        		td.append(control);
        		if(column.type == 'percent'){
        			td.append("<span class='percent-float' style='position:absolute;right:20px;'>%</span>");
        		}
        		else if(column.type == 'money'){
        			td.append("<span class='wy-float' style='position:absolute;right:28px;'>万元</span>");
        		}
        		row.append(td);
        	}        	 
        	if(that.options.mode == 'assoc'){
        		if(i != 1){
        			row.append("<td><a class='del-row' data-row=" + i + ">删除</a></td>");
        		}else{
        			row.append("<td></td>");	
        		}
        		row.find(".del-row").click(function(){
                	row.remove();
                	value_change();
                });
        	}
            that.tbody.append(row);  
            
            
            /* Append Validators */
            append_validators();
        }
        
        function validate(){
        	that.tbody.find("input[validate-type='percent']").each(function(){
        		var val = $(this).val();
        		if(val <= 0 || val > 100){        			
        			$(this).val("");
        		}    		
        	});
        	that.tbody.find("input[validate-type='money']").each(function(){
        		var val = $(this).val();
//        		if(val <= 0){
//        			$(this).val("");
//        		}       		
        	});
        	that.tbody.find("input[validate-type='text']").each(function(){
        		var val = $(this).val();
        		if(val.length > 10){
        			wx.alert("请不要输入超过10个汉字");$()
        			$(this).val(val.substring(0, 22));
        		}
        	});
        }
        
        function append_validators(){
        	
        	that.find(".valiate-hint").remove();
        	that.tbody.find("input[validate-type='percent']").each(function(){
        		var span =  $('<div class="valiate-hint" style="color:red;display:none;">请填写0-100的数字</div>');
        		span.attr("id", "wx-validator-" + $(this).attr("name") + "-range");
        		that.validators.append(span);
        	});
        	that.tbody.find("input[validate-type='money']").each(function(){
        		var span =  $('<div class="valiate-hint" style="color:red;display:none;">金额不正确或太小</div>');
        		span.attr("id", "wx-validator-" + $(this).attr("name") + "-min");
        		that.validators.append(span);
        	});
        	
        	if(that.options.required){
	        	that.tbody.find("input").each(function(){
	        		var row = $(this).attr("data-row");
	        		var col = $(this).attr("data-column");        		
	        		var msg = "请填写第" + row + "行，第" + col + "列";
	        		var span =  $('<div class="valiate-hint" style="color:red;display:none;">' + msg + '</div>');
	        		span.attr("id", "wx-validator-" + $(this).attr("name") + "-required");
	        		that.validators.append(span);
	        	});
        	}
        	
        }
        
        function init_headers(){
        	var tr = $("<tr></tr>");  
        	if(that.options.rows != undefined){
        		tr.append("<td>" + that.options.rows[0].label + "</td>");
        	}
        	for(var i = 0; i < that.columns.length; i++){
        		var column = that.columns[i];
        		var td = $("<td></td>");
        		td.html(column.title);        		
        		tr.append(td);
        	}
        	that.thead.append(tr);
        	
        }
        
        function init_col_group(){
        	
        	if(that.options.rows != undefined){
        		that.colgroup.append("<col width=12%>");	
        	}
        	
        	for(var i = 0; i < that.columns.length; i++){
        		var column = that.columns[i];
        		var col = $("<col>");
        		col.attr("width", column.width);
        		that.colgroup.append(col);
        	}
        	if(that.options.mode == 'assoc'){        		        	
        		that.colgroup.append("<col width=5%>");
        	}
        	
        }

        function insert_new_data_row(row){
        	if(that.data[row - 1] == undefined){
        		if(that.options.mode == 'assoc'){
        			var d = {};
    	            for(var i = 0; i <that.columns.length; i++){                    
    	                var column = that.columns[i];	                
    	                d[column.name] = "";                    
    	            }   
    	            that.data[row-1] = d;	
        		}else{
        			var d = [];
    	            for(var i = 0; i <that.columns.length; i++){                    
    	                var column = that.columns[i];	                
    	                d[i] = "";                    
    	            }   
    	            that.data[row-1] = d;
        		}
	        	
        	}
        }
        
        function get_new_data_row(){

    		if(that.options.mode == 'assoc'){
    			var d = {};
	            for(var i = 0; i <that.columns.length; i++){                    
	                var column = that.columns[i];	                
	                d[column.name] = "";                    
	            }   
	            return d;
    		}else{
    			var d = [];
	            for(var i = 0; i <that.columns.length; i++){                    
	                var column = that.columns[i];	                
	                d[i] = "";                    
	            }   
	            return d;
    		}

        }
        
        function get_value(){
        	var data = [];
        	$(that).find("tbody tr").each(function(){
        		var rowData = get_new_data_row();        		        		
        		$(this).find("input").each(function(){
                    var row = $(this).attr("data-row");
                    var col = $(this).attr("data-column");
                    var val = $(this).val();    
                    var column = that.columns[col - 1];
                    if(column.type == "money"){
                    	if(val != ''){
	                    	val = Number(val).toFixed(2);
	                    	if(isNaN(val)){
	                    		val = '';
	                    	}
	                    	$(this).val(val);
                    	}
                    }
                    if(that.options.mode == 'assoc'){
                    	rowData[column.name] = val;
                    }else{
                    	rowData[col-1] = val;
                    }
        		});
        		data.push(rowData);
        	});
        	return data;
        }
        
        function value_change(){

            
            validate();
            to_json();
        }

        
        
        function to_json(){     
            var data = get_value();           
            var str = JSON.stringify(data);
            that.targetInput.val(str);
        }
    }; // End Extend function
    
})(jQuery);


