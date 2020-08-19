<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	#chartArea{
		display: inline-block;
		width: 450px;
		min-height: 200px;
		float:left;
	}
	
	#listArea{
		display: inline-block;
		width: 400px;
		margin-left: 25px;
	}
	
	#listArea .tableInfo, #listArea .tableInfo th, #listArea .tableInfo td{
		border:solid 0.5px gray;
		border-collapse: collapse;
	}
	
	#listArea .tableInfo th {
		background-color: #4db8ff;
		color: white;
		width: 80px;
		height: 45px;
		text-align: center;
		vertical-align: middle;
	}
	
	#listArea .tableInfo td {
		width: 150px;
		text-align: center;
		vertical-align: middle;
		font-size: 12pt;
		font-style: italic;
	}
</style>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#displayList").hide();
		
		$("#searchHead").keyup(function(){
			
			var wordLength = $(this).val().length;
			// 검색어의 길이를 알아온다.			
			
			if(wordLength == 0) {
				$("#displayList").hide();
				// 검색어 입력 후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
			}			
			else {
				
				$.ajax({
					url:"<%= request.getContextPath()%>/headSearchShow.top",
					type:"GET",
					data:{searchHead:$("#searchHead").val()},
					dataType:"JSON",
					success:function(json){
						
						<%-- === 검색어 입력 시 자동글 완성하기 7 === --%>
						
						if(json.length > 0) {
							// 검색된 데이터가 존재하는 경우
							
							var html = "";
							
							$.each(json, function(entryIndex, item){								
								var word = item.word;
								
								var result = "";													
							
								result = "<span class='search' style='color:gray;'>"+item.searchResult+"</span><span class='hide'>"+item.employee_seq+"</span>";	
								
								html += "<span style='cursor:pointer;' class='result'>"+result+"</span><br/>";
							});
				
							$("#displayList").html(html);
							$("#displayList").show();
						}
						else {
							// 검색된 데이터가 존재하지 않는 경우
							$("#displayList").hide();
						}
						
					},					
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}	
					
				});
				
			}	
			
		});
		
		$(document).on("click", ".result", function(){
			var str = $(this).text();
			$(this).addClass("select");
			$("#searchHead").val(str.substring(0, str.lastIndexOf(">")+1)); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			var employee_seq = $(".select .hide").text();
			$("#displayList").hide();
			
			$.ajax({
				url:"<%= request.getContextPath()%>/getEmployeeSalary.top",
				type:"GET",
				data:{"employee_seq":employee_seq},
				dataType:"JSON",
				success: function(json) {
					
					var html = "";
					
					html = "<table class='tableInfo'>"
						 + "<tr>"
						 + "<th>사원명</th>"
						 + "<td colspan='3'>" + json.employee_name + "</td>"
						 + "</tr>"
						 + "<tr>"
						 + "<th>부서명</th>"
						 + "<td>" + json.department_name + "</td>"
						 + "<th>직위</th>"
						 + "<td>" + json.position_name + "</td>"
						 + "<tr>"
						 + "<tr>"
						 + "<th>연봉</th>"
						 + "<td colspan='3'>" + numberWithCommas(Number(json.position_salary)) + "만원</td>"
						 + "</tr>"
						 + "</table>";
						 
					$("#memberSalayInfo").html(html);
				},
				error: function(e) {
					
				}
			});
		});
		
		getDepartmentMenberCnt();
		
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function getDepartmentMenberCnt() {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/getDepartmentMenberCnt.top",
			type:"GET",
			dataType:"JSON",
			success: function(json) {
				Highcharts.chart('container', {
					chart: {
						plotBackgroundColor: null,
						plotBorderWidth: null,
						plotShadow: false,
						type: 'pie'
					},
					title: {
						text: '부서별 인원 통계 자료'
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
						data: json
					}]
				});
			},
			error: function(e) {
				
			}
		});
	}


</script>

<div>
	<div style="display: inline-block;">
	<h3>급여내역</h3>
	</div>
</div>

<div id="chartArea">
	 <div id="container"></div>
</div>
<div id="listArea">
	<table class="table">
		<tr>
			<td>
				<input type="text" name="searchHead" id="searchHead" autocomplete="off" style="width:200px; text-align:center;" placeholder="성명 <부서명/직위>" />
				<input type="hidden" name="head_seq" id="head_seq"/>
				<div id="displayList" style="position: absolute; border:solid 1px gray; border-top:0px; width:200px; height:70px; margin-top:0px; padding: 4px; overflow: auto; background-color: #e7f5fd;"></div>
			</td>
		</tr>
	</table>
	<div id="memberSalayInfo"></div>
</div>
 
