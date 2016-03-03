/* 
 * 成本构成控件
 */


(function($){
    $.fn.multi_input = function(target, rules, title, input_class){
        var that = this;        
        this.input_class = input_class == undefined ? "half" : input_class;
        that.target = $("#" + target);
        that.rules = rules;
        that.title = title;
        
       
        
        that.rows = $('<div class="rows news-wrapper"></div>');
        that.append(that.rows);
        that.append("<div class='clearfix'></div>");
        
        
        var val = that.target.val()
        that.data = [];      
        console.log(that.data);
        if(val != "" && val != null && val != undefined){ that.data = $.parseJSON(val);  }else{that.data = [];  }
        if(that.data == null){
        	that.data = [];
        }
             
        
        that.num = 1;        
        if(that.data.length == 0){
            append_row(that.num++);
            append_row(that.num++);

        }else{
            for(var i = 0; i <that.data.length; i++){
                var dataRow = that.data[i];
                append_row(that.num++, dataRow);
            }
        }

        that.find(".add-records").click(function(){
           append_row(that.num++); 
        });
            
        function append_row(i, dataRow){            
            var row = $('<div style="margin-bottom:5px" class="inp clearfix" data-row=' + i + '></div>');
                        
            for(var j = 1; j <= that.rules.length; j ++){
                var rule = that.rules[j - 1];
                var control = "";
                
                var val = dataRow == undefined || dataRow[rule.name] == undefined ? "" : dataRow[rule.name];
                switch(rule.type){
                    case "text":
                        control = $("<input placeholder='" + rule.placeholder + "' class='multi-input-row " + that.input_class + "' type='text' data-row=" + i+ " data-column=" + j+ " />");                        
                        break;
                    case "money":
                        control = $("<input placeholder='" + rule.placeholder  + "' class='multi-input-row " + that.input_class + "' type='text' data-row=" + i+ " data-column=" + j+ " />");
                        break;
                }
                control.val(val);
                control.change(function(){
                    value_change(this);
                });
                row.append(control);
            }

            that.rows.append(row);            
            
        }                    
        
        function value_change(item){
            var row = $(item).attr("data-row");
            var col = $(item).attr("data-column");
            var val = $(item).val();
            
            if(that.data[row - 1] == undefined){
                var d = {};
                for(var i = 0; i <that.rules.length; i++){                    
                    var rule = that.rules[i];
                    d[rule.name] = "";                    
                }                
                that.data[row-1] = d;
                
            }
            var rule = that.rules[col - 1];
            that.data[row - 1][rule.name] = val;             
            that.target.val(to_json());
        }
        
    
        
        function del_row(i){
            that.find(".row")
        }
        
        
        function to_json(){
            var d = [];
            for(var i = 0; i < that.data.length; i++){
                if(that.data[i] != undefined){
                    d.push(that.data[i]);
                }
            }            
            return JSON.stringify(d);
        }

    };
    
})(jQuery);


