<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/sankey.js"></script>
<script src="https://code.highcharts.com/modules/organization.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<style type="text/css">

	#walfareContainer {
		width: 975px;
		margin: 0 auto;
	}
	#img {
		width: 80px;
		height: 80px;
	}
	#boktbl th {
		text-align: left;
		padding-left: 20px;
	}
	#boktbl td {
		text-align: left;
		padding-left: 20px;
	}
	#imgdiv {
		float: left;
		margin: 10px 0 0 15px;
	}
	#h3 {
		margin-left: 20px;
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
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		getComChart();
		
	});
	
	function getComChart() {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/getAllEmployee.top",
			type:"GET",
			data:{"image":"/groupware/resources/msg_images/user2.png"},
			dataType:"JSON",
			success: function(json) {
				
				Highcharts.chart('container', {
				    chart: {
				        height: 600,
				        inverted: true
				    },

				    title: {
				        text: 'Highcharts Org Chart'
				    },

				    accessibility: {
				        point: {
				            descriptionFormatter: function (point) {
				                var nodeName = point.toNode.name,
				                    nodeId = point.toNode.id,
				                    nodeDesc = nodeName === nodeId ? nodeName : nodeName + ', ' + nodeId,
				                    parentDesc = point.fromNode.id;
				                return point.index + '. ' + nodeDesc + ', reports to ' + parentDesc + '.';
				            }
				        }
				    },
				    series: [{
				        type: 'organization',
				        name: 'Highsoft',
				        keys: ['from', 'to'],
				        data: [
				            ['6', '5'],
				            ['5', '4'],
				            ['4', '3'],
				            ['3', '2'],
				            ['2', '1'],
				        ],
				        levels: [{
				            level: 0,
				            color: '#33adff',
				            dataLabels: {
				                color: 'black'
				            },
				            height: 25
				        }, {
				            level: 2,
				            color: '#99d6ff'
				        }, {
				            level: 4,
				            color: '#d9d9d9'
				        }],
				        nodes: json,
				        colorByPoint: false,
				        color: '#007ad0',
				        dataLabels: {
				            color: 'white'
				        },
				        borderColor: 'white',
				        nodeWidth: 65
				    }],
				    tooltip: {
				        outside: true
				    },
				    exporting: {
				        allowHTML: true,
				        sourceWidth: 600,
				        sourceHeight: 600
				    }
				});
				    
			},
			error: function(e) {
				
			}
		});
	}

</script>

<div id="walfareContainer">
	<h3 id="h3">근무환경</h3>
	<div id="imgdiv">
		<img id="img" src="<%= request.getContextPath()%>/resources/images/pngwave.png" title="나무" alt="사진안나올떄 나오는 것" />
	</div>
	<table id="boktbl">		
		<tbody>		
			<tr>
				<th>복리후생</th>
				<th>연금/보험</th>	
				<td>국민연금,고용보험,산재보험,건강보험,퇴직연금</td>	
			</tr>
			<tr>
				<th></th>
				<th>휴무/휴가/행사</th>
				<td>연차,출산 휴가,노동절 휴무,남성 출산 휴가</td>
			</tr>
			<tr>
				<th></th>
				<th>보상/수당/지원</th>
				<td>야근수당,명절 귀향비 지급,성과급 지급,자녀 학자금지급</td>
			</tr>
			<tr>
				<th></th>
				<th>사내시설/장애인지원</th>
				<td>1인 1명 주차장지원</td>
			</tr>
		</tbody>
	</table>
</div>
<div id="chartContainer">
	<figure class="highcharts-figure">
	    <div id="container"></div>
	</figure>
</div>