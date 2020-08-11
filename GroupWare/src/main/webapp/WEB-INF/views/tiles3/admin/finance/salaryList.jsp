<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	#chartArea{
		display: inline-block;
		border:solid 1px red;
		width: 200px;
		min-height: 200px;
		float:left;
	}
	
	#listArea{
		display: inline-block;
		width: 400px;
	}
	
	#listArea .table, #listArea .table td{
		border:solid 1px black;
		border-collapse: collapse;
	}
	
	.changeBtn{
		cursor: pointer;
		width: 80px;
		text-align: center;
		border:solid 1px blue;
		padding: 5px 0;
	}
</style>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript">
Highcharts.chart('#container', {
	  chart: {
	    plotBackgroundColor: null,
	    plotBorderWidth: null,
	    plotShadow: false,
	    type: 'pie'
	  },
	  title: {
	    text: 'Browser market shares in January, 2018'
	  },
	  tooltip: {
	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	  },
	  accessibility: {
	    point: {
	      valueSuffix: '%'
	    }
	  },
	  plotOptions: {
	    pie: {
	      allowPointSelect: true,
	      cursor: 'pointer',
	      dataLabels: {
	        enabled: true,
	        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
	      }
	    }
	  },
	  series: [{
	    name: 'Brands',
	    colorByPoint: true,
	    data: [{
	      name: 'Chrome',
	      y: 61.41,
	      sliced: true,
	      selected: true
	    }, {
	      name: 'Internet Explorer',
	      y: 11.84
	    }, {
	      name: 'Firefox',
	      y: 10.85
	    }, {
	      name: 'Edge',
	      y: 4.67
	    }, {
	      name: 'Safari',
	      y: 4.18
	    }, {
	      name: 'Sogou Explorer',
	      y: 1.64
	    }, {
	      name: 'Opera',
	      y: 1.6
	    }, {
	      name: 'QQ',
	      y: 1.2
	    }, {
	      name: 'Other',
	      y: 2.61
	    }]
	  }]
	});
</script>

<div>
	<div style="display: inline-block;">
	<h3>급여내역</h3>
	</div>
</div>

<div id="chartArea">
	<div align="right">
		<div class="changeBtn">change</div>
	</div>
	 <div id="container"></div>
</div>
<div id="listArea">
	<table class="table">
		<tr>
			<td>
				<select name="employee_name">
					<option>사원명</option>
				</select>
			</td>
			<td>
				<select name="position_name">
					<option>직책</option>
				</select>
			</td>
			<td>
				<select name="department_name">
					<option>부서명</option>
				</select>
			</td>
			<td>
				<select name="year">
					<option>년도</option>
				</select>
			</td>
			<td>연봉</td>
		</tr>
	</table>
</div>
 
