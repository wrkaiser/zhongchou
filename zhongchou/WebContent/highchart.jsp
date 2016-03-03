<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--  highcharts -->
<script>
	$(function() {
	//	alert(5);
		Highcharts.setOptions({
			colors : [ '#ff588b', '#55acef', '#69ddf6', '#ffd962', '#84dfa0' ]
		});
	//	alert(6);
		$('#container')
				.highcharts(
						{
							chart : {
								type : 'column'
							},
							title : {
								text : ' '
							},
							subtitle : {
								text : ' '
							},
							xAxis : {
								categories : [ '本年', '上一年', '再上一年度' ]
							},
							yAxis : {
								title : {
									text : ' '
								}
							},
							tooltip : {
								headerFormat : '<span style="font-size:10px">{point.key}</span><table>',
								pointFormat : '<tr><td style="color:{series.color};padding:0">{series.name}: </td>'
										+ '<td style="padding:0"><b>{point.y:.1f} 万元</b></td></tr>',
								footerFormat : '</table>',
								shared : true,
								useHTML : true
							},

							plotOptions : {
								column : {
									pointPadding : 0.2,
									borderWidth : 0
								}
							},
							credits : {
								enabled : false
							},
							series : []
						});
	//	alert(7);
		var chart = $('#container').highcharts();//历史财务数据
		var obj2 = eval('${map.caiwudata}');//历史财务数据
		if (obj2 == null || obj2 == "") {
			$(".lishicaiwu").hide();
		} else {

			var wArray1 = new Array(); //历史财务数据营业收入
			var wArray2 = new Array(); //毛利润
			var wArray3 = new Array(); //净利润
		//	alert(7);
			for ( var k = 0; k < obj2.length; k++) {
		        if(k==0){
				wArray1.push(parseFloat(obj2[k][0]));
				wArray1.push(parseFloat(obj2[k][1]));
				wArray1.push(parseFloat(obj2[k][2]));
		        }else if(k==1){
		        	wArray2.push(parseFloat(obj2[k][0]));
					wArray2.push(parseFloat(obj2[k][1]));
					wArray2.push(parseFloat(obj2[k][2]));	
		        }else{
		        	wArray3.push(parseFloat(obj2[k][0]));
					wArray3.push(parseFloat(obj2[k][1]));
					wArray3.push(parseFloat(obj2[k][2]));	   	
		        }
		        
			}
			var series11 = {
				name : '营业收入',
				data : wArray1
			};
			var series12 = {
				name : '毛利润',
				data : wArray2
			};
			var series13 = {
				name : '净利润',
				data : wArray3
			};
		//	alert(9);
			chart.addSeries(series11);
			chart.addSeries(series12);
			chart.addSeries(series13);

		}

	});
	$(function() {
	//	alert(2);
		/*圆形图*/
		var obj1 = eval('${map.chengbengc}');//成本分析	
		if (obj1 == null || obj1 == "") {
			$(".chengbenfenxi").hide();
		} else {
			var b = 0;
			var tArray = new Array(); //成本分析
			var str = "";
			//var array1=new Array();//成本钱
		   //	var array2=new Array(); //成本比例
		//	alert(obj1[0]['cost-fee']);
			for ( var i = 0; i < obj1.length; i++) {
				if(obj1[i]['cost-fee']==null||obj1[i]['cost-fee']==""){
					b+=0.00;
				}else{
				b += parseFloat(obj1[i]['cost-fee']);
				}
			}		
		//	alert(33 + "--" + b);
			$.each(obj1, function(i, item) {
				if(obj1[i]['cost-fee']==null||obj1[i]['cost-fee']==""){
				   
				}else{
				var num = parseFloat(item['cost-fee']);//字符串变float
				//alert(num);
				//alert(b);
				var tArray1 = new Array();
				
				var c = (num / b) * 100;
				//alert(c);
				var d = c.toFixed(1);
			//	alert(d);
				 str += "<li><i class=''></i> <em>" + item['cost-item']
						+ "</em><span>" + item['cost-fee'] + "万</span>" + d
						+ "%</li>"; 
			   /*  var num1=num.toString();
			    alert(num1);
			    var d1=d.toString();
			    alert(d1);
			    array1.push(num1);
			    array2.push(d1); */
				tArray1.push(item['cost-item']);
				tArray1.push(c);
			//	alert(tArray1);
				tArray.push(tArray1);
				}
			});
		//	alert(array1);
		//	alert(array2);
			$(".cost-info").append(str);
			//alert(444);
		   $('#container1')
				.highcharts(
						{
							chart : {
								plotBackgroundColor : null,
								plotBorderWidth : null,
								plotShadow : false ,
								//marginRight:5
							},
							title : {
								text : ' '
							},
							tooltip : {
								pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
							},
							
							/* legend : {
								layout : 'vertical',
								backgroundColor : '#FFFFFF',
								floating : true,
								align : 'right',
								verticalAlign : 'top',
								x : 90,
								y : 45,
								labelFormatter : function() {
									 return this.name +"  "+ array1[this.index]+"万      "+ array2[this.index]+"%";

								}
							}, */
							plotOptions : {
								pie : {
									allowPointSelect : true,
									cursor : 'pointer',

									dataLabels : {
										enabled : false,
										color : '#000000',
										connectorColor : '#000000',
										format : '<b>{point.name}</b>: {point.percentage:.1f} %'
									},
								//showInLegend: true
								}

							},
							credits : {
								enabled : false
							//禁止显示版权
							},
							series : []
						});
		//alert(2);

		var chart1 = $('#container1').highcharts();//成本分析	
		//var obj1 = eval('${map.chengbengc}');//成本分析		 
		//alert(3);
		
			
			var series = {
				type : 'pie',
				name : '成本',
				data : tArray
			};
			//alert(tArray);
			chart1.addSeries(series);
		}

	});

	$(function() {
		//alert(10);
		$('#container3')
				.highcharts(
						{
							chart : {
								type : 'column'
							},
							title : {
								text : ' '
							},
							subtitle : {
								text : ' '
							},
							xAxis : {
								categories : [ '本年', '下一年', '再下一年度' ]
							},
							yAxis : {
								min : 0,
								title : {
									text : ' '
								}
							},
							tooltip : {
								headerFormat : '<span style="font-size:10px">{point.key}</span><table>',
								pointFormat : '<tr><td style="color:{series.color};padding:0">{series.name}: </td>'
										+ '<td style="padding:0"><b>{point.y:.1f} 万元</b></td></tr>',
								footerFormat : '</table>',
								shared : true,
								useHTML : true
							},
							plotOptions : {
								column : {
									pointPadding : 0.2,
									borderWidth : 0
								}
							},
							credits : {
								enabled : false
							},
							series : []
						});
		//alert(11);
		var chart3 = $('#container3').highcharts();//盈利预测 
		var obj3 = eval('${map.yingliyuce}');//盈利预测 
		if (obj3 == null || obj3 == "") {
			$(".yingliyuce").hide();
		} else {
			var yArray1 = new Array(); //盈利预测 营业收入
			var yArray2 = new Array(); //毛利润
			var yArray3 = new Array(); //净利润
		//	alert(12);
			for ( var k = 0; k < obj3.length; k++) {
		        if(k==0){
				yArray1.push(parseFloat(obj3[k][0]));
				yArray1.push(parseFloat(obj3[k][1]));
				yArray1.push(parseFloat(obj3[k][2]));
		        }else if(k==1){
		        	yArray2.push(parseFloat(obj3[k][0]));
					yArray2.push(parseFloat(obj3[k][1]));
					yArray2.push(parseFloat(obj3[k][2]));	
		        }else{
		        	yArray3.push(parseFloat(obj3[k][0]));
					yArray3.push(parseFloat(obj3[k][1]));
					yArray3.push(parseFloat(obj3[k][2]));	   	
		        }
		        
			}

			var series21 = {
				name : '营业收入',
				data : yArray1
			};
			var series22 = {
				name : '毛利润',
				data : yArray2
			};
			var series23 = {
				name : '净利润',
				data : yArray3
			};
		//	alert(14);
		//	alert(yArray1);
			chart3.addSeries(series21);
			chart3.addSeries(series22);
			chart3.addSeries(series23);
		}
	});
</script>
<div class="pro-bd" style="display: none" id="ylms">
	<div class="profit-model">
		<h3>收入来源</h3>
		<p>${map.revenuedriver }</p>
		<h3>成本分析</h3>
		<div class="chart-wrap clearfix chengbenfenxi">
			<div id="container1" data-highcharts-chart="1"></div>
		   <ul class="cost-info">

			</ul>
		</div>
		<h3>历史财务数据</h3>
		<div class="chart-wrap clearfix lishicaiwu">
			<ul class="history">
				<li class="last">万／时间</li>
			</ul>
			<div id="container" data-highcharts-chart="0"></div>
		</div>
		<h3>盈利预测</h3>
		<div class="chart-wrap clearfix yingliyuce">
			<ul class="history">
				<li class="last">万／时间</li>
			</ul>
			<div id="container3" data-highcharts-chart="2"></div>
		</div>
	</div>
</div>