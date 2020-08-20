<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
	.changeBtn{
		cursor: pointer;
		width: 80px;
		text-align: center;
		border:solid 1px blue;
		padding: 5px 0;
	}
	
	.highcharts-figure, .highcharts-data-table table {
	    min-width: 360px; 
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	.highcharts-data-table table {
		font-family: Verdana, sans-serif;
		border-collapse: collapse;
		border: 1px solid #EBEBEB;
		margin: 10px auto;
		text-align: center;
		width: 100%;
		max-width: 500px;
	}
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	.highcharts-data-table th {
		font-weight: 600;
	    padding: 0.5em;
	}
	.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
	    padding: 0.5em;
	}
	.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	
	.hide{
		display:none;
	}
</style>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		func_salesChart();
		func_profitChart();
		$(".changeBtn").click(function(){
			if($("#saleContainer").hasClass("hide")){
				$("#saleContainer").removeClass("hide");
				$("#profitContainer").addClass("hide");
				func_profitChart();
			}
			else{
				$("#profitContainer").removeClass("hide");
				$("#saleContainer").addClass("hide");
				func_salesChart();
			}
		});
		
		// 매출 테이블 그리기
		$.ajax({
			
		});
	});
	
function func_salesChart(){
	$.ajax({
		url:"<%=request.getContextPath()%>/manager/finance/salesChart.top",
		dataType:"JSON",
		success:function(json){
			console.log(json);
			var project_value = new Array;
			var maintain_value = new Array;
			var laborCost_value = new Array;
			var category_value = new Array;
			$.each(json.projectChartList, function(index, item) {
				var comma = (index > 0) ? "," : "";
				project_value.push(Number(item.project_value));
				maintain_value.push(Number(item.maintain_value));
				laborCost_value.push(Number(item.laborCost_value));
				category_value.push(item.category);
			});
			
			console.log(project_value);
			Highcharts.chart('saleContainer', {

				 chart: {
				        type: 'column'
				    },
				    title: {
				        text: 'Monthly Average Rainfall'
				    },
				    subtitle: {
				        text: 'Source: WorldClimate.com'
				    },
				    xAxis: {
				        categories:category_value,
				        crosshair: true
				    },
				    yAxis: {
				        min: 0,
				        title: {
				            text: 'Rainfall (mm)'
				        }
				    },
				    tooltip: {
				        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
				            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
				        footerFormat: '</table>',
				        shared: true,
				        useHTML: true
				    },
				    plotOptions: {
				        column: {
				            pointPadding: 0.2,
				            borderWidth: 0
				        }
				    },
				    series: [{
				        name: 'project_value',
				        data: project_value

				    }, {
				        name: 'laborCost_value',
				        data: laborCost_value

				    }, {
				        name: 'maintain_value',
				        data: maintain_value
				        
				    }]

			});
		},error:function(e){
			
		}
	});
}

function func_profitChart(){
	$.ajax({
		url:"<%=request.getContextPath()%>/manager/finance/profitChart.top",
		dataType:"JSON",
		success:function(json){
			var project_value = new Array;
			var category_value = new Array;
			$.each(json.profitChartList, function(index, item) {
				project_value.push(Number(item.project_value));
				category_value.push(item.category);
			});
			Highcharts.chart('profitContainer', {

			    title: {
			        text: '순이익 차트'
			    },

			    subtitle: {
			        text: 'Source: thesolarfoundation.com'
			    },

			    yAxis: {
			        title: {
			            text: 'Number of Employees'
			        }
			    },

			    xAxis: {
			        accessibility: {
			            rangeDescription: category_value
			        }
			    },

			    legend: {
			        layout: 'vertical',
			        align: 'right',
			        verticalAlign: 'middle'
			    },

			    plotOptions: {
			        series: {
			            label: {
			                connectorAllowed: false
			            },
			            pointStart: 2010
			        }
			    },

			    series: [{
			        name: 'profit',
			        data: project_value
			    }],

			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            chartOptions: {
			                legend: {
			                    layout: 'horizontal',
			                    align: 'center',
			                    verticalAlign: 'bottom'
			                }
			            }
			        }]
			    }

			});

		},
		error:function(e){
			
		}
	});
}
</script>
<div>
	<div style="display: inline-block;">
	<h3>매출내역</h3>
	</div>
</div>
<div id="chartArea">
	<div id="saleContainer">
	
	</div>
	<div id="profitContainer" class="hide">
	
	</div>
	<div align="right">
		<div class="changeBtn">change</div>
	</div>
</div>
<div id="listArea" style="height:300px; overflow: scroll;">
	<table class="table">
		<thead>
			<tr>
				<th>매출년도</th>
				<th>매출부서</th>
				<th>매출금액</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="sales" items="${salesList}">
			<tr>
				<td>${sales.regDate}</td>
				<td>${sales.department_name}</td>
				<td><fmt:formatNumber value="${sales.sales_total}" pattern="#,###" /></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>