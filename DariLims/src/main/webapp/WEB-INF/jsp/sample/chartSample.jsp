<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 필요한 라이브러리만 등록  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	/***************************************************************************************
	 * 시스템명 		: 
	 * 업무명 		: 
	 * 파일명 		: chartSample.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.06.01
	 * 설  명			: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.06.01    윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>

<!-- 스크립트 -->
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/flot/flot.css'/>" />
<style type="text/css">
#menu {
		position: absolute;
		top: 20px;
		left: 625px;
		bottom: 20px;
		right: 20px;
		width: 200px;
	}

#menu button {
		display: inline-block;
		width: 200px;
		padding: 3px 0 2px 0;
		margin-bottom: 4px;
		background: #eee;
		border: 1px solid #999;
		border-radius: 2px;
		font-size: 16px;
		-o-box-shadow: 0 1px 2px rgba(0,0,0,0.15);
		-ms-box-shadow: 0 1px 2px rgba(0,0,0,0.15);
		-moz-box-shadow: 0 1px 2px rgba(0,0,0,0.15);
		-webkit-box-shadow: 0 1px 2px rgba(0,0,0,0.15);
		box-shadow: 0 1px 2px rgba(0,0,0,0.15);
		cursor: pointer;
	}
</style>

<script type="text/javascript" src="<c:url value='/script/flot/jquery.flot.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/flot/jquery.flot.categories.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/flot/jquery.flot.pie.js'/>"></script>
<script type="text/javascript">
$(function() {

	fn_tabAct1();
	
	$('#tabs').tabs({
		create : function(event, ui) {
		},
		activate : function(event, ui) {
			var TabNo = $('#tabs').tabs('option', 'active');
			TabNo ++;
			window["fn_tabAct"+TabNo]();
		}
	});
	
	
	
	
});
function fn_tabAct1(){
	// We use an inline data source in the example, usually data would
	// be fetched from a server

	var data = [],
		totalPoints = 300;

	function getRandomData() {

		if (data.length > 0)
			data = data.slice(1);

		// Do a random walk

		while (data.length < totalPoints) {

			var prev = data.length > 0 ? data[data.length - 1] : 50,
				y = prev + Math.random() * 10 - 5;

			if (y < 0) {
				y = 0;
			} else if (y > 100) {
				y = 100;
			}

			data.push(y);
		}

		// Zip the generated y values with the x values

		var res = [];
		for (var i = 0; i < data.length; ++i) {
			res.push([i, data[i]])
		}

		return res;
	}

	// Set up the control widget

	var updateInterval = 100;
	$("#updateInterval").val(updateInterval).change(function () {
		var v = $(this).val();
		if (v && !isNaN(+v)) {
			updateInterval = +v;
			if (updateInterval < 1) {
				updateInterval = 1;
			} else if (updateInterval > 2000) {
				updateInterval = 2000;
			}
			$(this).val("" + updateInterval);
		}
	});

	var plot = $.plot("#chart1", [ getRandomData() ], {
		series: {
			shadowSize: 0	// Drawing is faster without shadows
		},
		yaxis: {
			min: 0,
			max: 100
		},
		xaxis: {
			show: false
		}
	});

	function update() {

		plot.setData([getRandomData()]);

		// Since the axes don't change, we don't need to call plot.setupGrid()

		plot.draw();
		setTimeout(update, updateInterval);
	}

	update();
}


function fn_tabAct2(){
	var d1 = [];
	for (var i = 0; i < 20; ++i) {
		d1.push([i, Math.sin(i)]);
	}
	var data = [{ data: d1, label: "Pressure", color: "#333" }];
	var markings = [
		{ color: "#f6f6f6", yaxis: { from: 1 } },
		{ color: "#f6f6f6", yaxis: { to: -1 } },
		{ color: "#000", lineWidth: 1, xaxis: { from: 2, to: 2 } },
		{ color: "#000", lineWidth: 1, xaxis: { from: 8, to: 8 } }
	];
	var placeholder = $("#chart2");
	var plot = $.plot(placeholder, data, {
		bars: { show: true, barWidth: 0.5, fill: 0.9 },
		xaxis: { ticks: [], autoscaleMargin: 0.02 },
		yaxis: { min: -2, max: 2 },
		grid: { markings: markings }
	});
	var o = plot.pointOffset({ x: 2, y: -1.2});
	// Append it to the placeholder that Flot already uses for positioning
	placeholder.append("<div style='position:absolute;left:" + (o.left + 4) + "px;top:" + o.top + "px;color:#666;font-size:smaller'>Warming up</div>");
	o = plot.pointOffset({ x: 8, y: -1.2});
	placeholder.append("<div style='position:absolute;left:" + (o.left + 4) + "px;top:" + o.top + "px;color:#666;font-size:smaller'>Actual measurements</div>");
	// Draw a little arrow on top of the last label to demonstrate canvas
	// drawing
	var ctx = plot.getCanvas().getContext("2d");
	ctx.beginPath();
	o.left += 4;
	ctx.moveTo(o.left, o.top);
	ctx.lineTo(o.left, o.top - 10);
	ctx.lineTo(o.left + 10, o.top - 5);
	ctx.lineTo(o.left, o.top);
	ctx.fillStyle = "#000";
	ctx.fill();
}


function fn_tabAct3(){
	
	var d1 = [];
	for (var i = 0; i < Math.PI * 2; i += 0.25) {
		d1.push([i, Math.sin(i)]);
	}
	var d2 = [];
	for (var i = 0; i < Math.PI * 2; i += 0.25) {
		d2.push([i, Math.cos(i)]);
	}
	var d3 = [];
	for (var i = 0; i < Math.PI * 2; i += 0.1) {
		d3.push([i, Math.tan(i)]);
	}
	$.plot("#chart3", [
		{ label: "sin(x)", data: d1 },
		{ label: "cos(x)", data: d2 },
		{ label: "tan(x)", data: d3 }
	], {
		series: {
			lines: { show: true },
			points: { show: true }
		},
		xaxis: {
			ticks: [
				0, [ Math.PI/2, "\u03c0/2" ], [ Math.PI, "\u03c0" ],
				[ Math.PI * 3/2, "3\u03c0/2" ], [ Math.PI * 2, "2\u03c0" ]
			]
		},
		yaxis: {
			ticks: 10,
			min: -2,
			max: 2,
			tickDecimals: 3
		},
		grid: {
			backgroundColor: { colors: [ "#fff", "#eee" ] },
			borderWidth: {
				top: 1,
				right: 1,
				bottom: 2,
				left: 2
			}
		}
	});
	
}


function fn_tabAct4(){
	
	// jquery.flot.categories.js
	var data = [ ["January", 10], ["February", 8], ["March", 4], ["April", 13], ["May", 17], ["June", 9] ];

	$.plot("#chart4", [ data ], {
		series: {
			bars: {
				show: true,
				barWidth: 0.6,
				align: "center"
			}
		},
		xaxis: {
			mode: "categories",
			tickLength: 0
		}
	});
	
}
function fn_tabAct5(){
	
	var sin = [],
	cos = [];

	for (var i = 0; i < 14; i += 0.5) {
		sin.push([i, Math.sin(i)]);
		cos.push([i, Math.cos(i)]);
	}
	
	var plot = $.plot("#chart5", [
		{ data: sin, label: "sin(x)"},
		{ data: cos, label: "cos(x)"}
	], {
		series: {
			lines: {
				show: true
			},
			points: {
				show: true
			}
		},
		grid: {
			hoverable: true,
			clickable: true
		},
		yaxis: {
			min: -1.2,
			max: 1.2
		}
	});
	
	$("<div id='tooltip'></div>").css({
		position: "absolute",
		display: "none",
		border: "1px solid #fdd",
		padding: "2px",
		"background-color": "#fee",
		opacity: 0.80
	}).appendTo("body");
	
	$("#chart5").bind("plothover", function (event, pos, item) {
	
		if ($("#enablePosition:checked").length > 0) {
			var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
			$("#hoverdata").text(str);
		}
	
		if ($("#enableTooltip:checked").length > 0) {
			if (item) {
				var x = item.datapoint[0].toFixed(2),
					y = item.datapoint[1].toFixed(2);
	
				$("#tooltip").html(item.series.label + " of " + x + " = " + y)
					.css({top: item.pageY+5, left: item.pageX+5})
					.fadeIn(200);
			} else {
				$("#tooltip").hide();
			}
		}
	});
	
	$("#chart5").bind("plotclick", function (event, pos, item) {
		if (item) {
			$("#clickdata").text(" - click point " + item.dataIndex + " in " + item.series.label);
			plot.highlight(item.series, item.datapoint);
		}
	});
		
}
function fn_tabAct6(){
	var d1 = [];
	for (var i = 0; i < 14; i += 0.5) {
		d1.push([i, Math.sin(i)]);
	}
	var d2 = [[0, 3], [4, 8], [8, 5], [9, 13]];
	// A null signifies separate line segments
	var d3 = [[0, 12], [7, 12], null, [7, 3.5], [12, 2.5]];
	$.plot("#chart6", [ d1, d2, d3 ]);
}

function fn_tabAct7(){
	// jquery.flot.pie.js
	$("#chart7").attr('width','500px');
	
	var data = [],
	series = Math.floor(Math.random() * 6) + 3;

	for (var i = 0; i < series; i++) {
		data[i] = {
			label: "Series" + (i + 1),
			data: Math.floor(Math.random() * 100) + 1
		}
	}
	
	var placeholder = $("#chart7");
	
	
	$("#example-1").click(function() {
	
		placeholder.unbind();
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true
				}
			}
		});
	
	});
	
	$("#example-2").click(function() {
	
		placeholder.unbind();
	
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-3").click(function() {
	
		placeholder.unbind();
	
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 1,
						formatter: labelFormatter,
						background: {
							opacity: 0.8
						}
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-4").click(function() {
	
		placeholder.unbind();
	
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 3/4,
						formatter: labelFormatter,
						background: {
							opacity: 0.5
						}
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-5").click(function() {
	
		placeholder.unbind();
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 3/4,
						formatter: labelFormatter,
						background: { 
							opacity: 0.5,
							color: "#000"
						}
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-6").click(function() {
	
		placeholder.unbind();
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius: 3/4,
					label: {
						show: true,
						radius: 3/4,
						formatter: labelFormatter,
						background: { 
							opacity: 0.5,
							color: "#000"
						}
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-7").click(function() {
	
		placeholder.unbind();
	
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 2/3,
						formatter: labelFormatter,
						threshold: 0.1
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-8").click(function() {
	
		placeholder.unbind();
	
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					combine: {
						color: "#999",
						threshold: 0.05
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-9").click(function() {
	
		placeholder.unbind();
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius: 500,
					label: {
						show: true,
						formatter: labelFormatter,
						threshold: 0.1
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-10").click(function() {
	
		placeholder.unbind();
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius: 1,
					tilt: 0.5,
					label: {
						show: true,
						radius: 1,
						formatter: labelFormatter,
						background: {
							opacity: 0.8
						}
					},
					combine: {
						color: "#999",
						threshold: 0.1
					}
				}
			},
			legend: {
				show: false
			}
		});
	
	});
	
	$("#example-11").click(function() {
	
		placeholder.unbind();
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					innerRadius: 0.5,
					show: true
				}
			}
		});
	});
	
	$("#example-12").click(function() {
	
		placeholder.unbind();
	
	
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true
				}
			},
			grid: {
				hoverable: true,
				clickable: true
			}
		});
	
	
		placeholder.bind("plothover", function(event, pos, obj) {
	
			if (!obj) {
				return;
			}
	
			var percent = parseFloat(obj.series.percent).toFixed(2);
			$("#hover").html("<span style='font-weight:bold; color:" + obj.series.color + "'>" + obj.series.label + " (" + percent + "%)</span>");
		});
	
		placeholder.bind("plotclick", function(event, pos, obj) {
	
			if (!obj) {
				return;
			}
	
			percent = parseFloat(obj.series.percent).toFixed(2);
			alert(""  + obj.series.label + ": " + percent + "%");
		});
	});
	
	// Show the initial default chart
	
	//$("#example-1").click();
	
}

function labelFormatter(label, series) {
	return "<div style='font-size:8pt; text-align:center; padding:2px; color:white;'>" + label + "<br/>" + Math.round(series.percent) + "%</div>";
}

//



function fn_tabAct8(){
	
}

function fn_tabAct9(){
	
}

function fn_tabAct10(){
	
}



</script>

<!-- 화면  -->	
<body>
<div>	
	<form name="chartSampleForm" id="chartSampleForm" > 
	<!-- form 네이밍규칙 화면명+Form  
		name과 id는 동일하게 구성
	-->
	
     	
<%-- 	<div class="sub_purple_01 w100p" style="margin-top: 0px;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					샘플 목록
				</td>
				<td>
					<span class="button white mlargep" id="btn_search" onclick="btn_search();">
				   		<button type="button"><spring:message code="button.search"/></button>
				   	</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.insert"/></button>
					</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.update"/></button>
					</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.delete"/></button>
					</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.save"/></button>
					</span>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<th>
					샘플일련번호
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
				<th>
					샘플명
				</th>
				<td>
					<input type="text" name="sample_nm" id="sample_nm" value="">
				</td>
				<th>
					샘플번호
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
			</tr>
			<tr>
				<th>
					사용여부
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
				<th>
					생성일
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
				<th>
					작성자
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
			</tr>
		</table>
	</div> --%>
	
	<div id="tabs">
		<ul>
			<li id="tab1">
				<a href="#tabDiv1">chart1</a>
			</li>
			<li id="tab2">
				<a href="#tabDiv2">chart2</a>
			</li>
			<li id="tab3">
				<a href="#tabDiv3">chart3</a>
			</li>
			<li id="tab4">
				<a href="#tabDiv4">chart4</a>
			</li>
			<li id="tab5">
				<a href="#tabDiv5">chart5</a>
			</li>
			<li id="tab6">
				<a href="#tabDiv6">chart6</a>
			</li>
			<li id="tab7">
				<a href="#tabDiv7">chart7</a>
			</li>
			<li id="tab8">
				<a href="#tabDiv8">chart8</a>
			</li>
			<li id="tab9">
				<a href="#tabDiv9">chart9</a>
			</li>
			<li id="tab10">
				<a href="#tabDiv10">chart10</a>
			</li>

		</ul>
		<div id="tabDiv1">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart1" class="demo-placeholder"></div>
					<p>You can update a chart periodically to get a real-time effect by using a timer to insert the new data in the plot and redraw it.</p>

					<p>Time between updates: <input id="updateInterval" type="text" value="" style="text-align: right; width:5em"> milliseconds</p>
				</div>
			</div>
		</div>
		<div id="tabDiv2">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart2" class="demo-placeholder"></div>
				</div>
			</div>
		</div>
		<div id="tabDiv3">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart3" class="demo-placeholder"></div>
				</div>
			</div>
		</div>
		<div id="tabDiv4">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart4" class="demo-placeholder"></div>
				</div>
			</div>
		</div>
		<div id="tabDiv5">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart5" class="demo-placeholder"></div>
					<p>One of the goals of Flot is to support user interactions. Try pointing and clicking on the points.</p>

					<p>
						<label><input id="enablePosition" type="checkbox" checked="checked"></input>Show mouse position</label>
						<span id="hoverdata"></span>
						<span id="clickdata"></span>
					</p>
			
					<p>A tooltip is easy to build with a bit of jQuery code and the data returned from the plot.</p>
			
					<p><label><input id="enableTooltip" type="checkbox" checked="checked"></input>Enable tooltip</label></p>
				</div>
			</div>
		</div>
		<div id="tabDiv6">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart6" class="demo-placeholder"></div>
					
				</div>
			</div>
		</div>
		<div id="tabDiv7">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart7" class="demo-placeholder"></div>
					<div id="menu">
						<span class="button white mlargep" id="example-1">
					   		<button type="button">Default Options</button>
					   	</span>
					   	<span class="button white mlargep" id="example-2">
					   		<button type="button">Without Legend</button>
					   	</span>
					   	<span class="button white mlargep" id="example-3">
					   		<button type="button">Label Formatter</button>
					   	</span>
					   	<span class="button white mlargep" id="example-4">
					   		<button type="button">Label Radius</button>
					   	</span>
					   	<span class="button white mlargep" id="example-5">
					   		<button type="button">Label Styles #1</button>
					   	</span>
					   	<span class="button white mlargep" id="example-6">
					   		<button type="button">Label Styles #2</button>
					   	</span>
					   	<span class="button white mlargep" id="example-7">
					   		<button type="button">Hidden Labels</button>
					   	</span>
					   	<span class="button white mlargep" id="example-8">
					   		<button type="button">Combined Slice</button>
					   	</span>
					   	<span class="button white mlargep" id="example-9">
					   		<button type="button">Rectangular Pie</button>
					   	</span>
					   	<span class="button white mlargep" id="example-10">
					   		<button type="button">Tilted Pie</button>
					   	</span>
					   	<span class="button white mlargep" id="example-11">
					   		<button type="button">Donut Hole</button>
					   	</span>
					   	<span class="button white mlargep" id="example-12">
					   		<button type="button">Interactivity</button>
					   	</span>
					</div>
					
					<p id="description"></p>
					
				</div>
			</div>
		</div>
		<div id="tabDiv8">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart8" class="demo-placeholder"></div>
					
				</div>
			</div>
		</div>
		<div id="tabDiv9">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart9" class="demo-placeholder"></div>
					
				</div>
			</div>
		</div>
		<div id="tabDiv10">
			<div id="chartcontent">
				<div class="demo-container">
					<div id="chart10" class="demo-placeholder"></div>
					
				</div>
			</div>
		</div>
	</div>

	</form>
</div>
</body>