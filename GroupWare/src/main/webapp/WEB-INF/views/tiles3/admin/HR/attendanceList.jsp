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

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css"/>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
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
				url:"<%= request.getContextPath()%>/getAttendenceInfo.top",
				type:"GET",
				data:{"employee_seq":employee_seq},
				dataType:"JSON",
				success: function(json) {
					
					var html = "";
					
					html += "<table id='datatables' class='table'>"
						 + "<thead>"
						 + "<tr>"
						 + "<th>부서명</th>"
						 + "<th>직위</th>"
						 + "<th>사원명</th>"
						 + "<th>출근</th>"
						 + "<th>퇴근</th>"
						 + "</tr>"
						 + "</thead>"
						 + "<tbody>";
						 
					$.each(json, function(index, item) {
						
						html += "<tr>"
							 + "<td>" + item.department_name + "</td>"
							 + "<td>" + item.position_name + "</td>"
							 + "<td>" + item.employee_name + "</td>"
							 + "<td>" + item.onTime + "</td>";
						if(item.offTime == '0') {
							html += "<td>-</td>"
						}
						else {
							
							html  += "<td>" + item.offTime + "</td>"
						}
						
							
							 
						html +="</tr>";
					})
					html += "</tbody>"
						 + "</table>";
						 
					$("#memberAttInfo").html(html);
					
					$("#datatables").DataTable({
						
						"dom" : '<"top"lf>rt<"bottom"ip>', // 페이지바가 우측하단에 위치 함, 검색이 우측 상단에 위치 함 
					  //"dom" : '<"top"lp>rt<"bottom"if>', // 페이지바가 우측상단에 위치 함, 검색이 우측하단에 위치 함
						"paging" : true,				   // 우측 하단에 페이지바를 보여주겠다
					  //"paging" : false,				   // 우측 하단에 페이지바를 숨기겠다
					    "ordering" : true,				   // th에 나오는 값에 따라 오름차순, 내림차순 정렬을 할것인지 말것인지 결정하는 것
					    "info" : false,					   // 좌측 하단에 보여지는 Showing 1 to 10 of 22 entries를 보여줄것인지 말것인지 결정하는 것
					    "filter" : true,				   // 우측 상단에 보여지는 검색을 보여줄것인지 말것인지를 결정하는 것
					    "lengthChange" : true,			   // 좌측상단에 보여지는 한페이지당 행의 갯수를 결정하는 것
					  //"order" : [[0, "desc"]],		   // 기본 컬럼 정령 설정 숫자 0은 첫번쨰 컬럼을 말하며, "asc" 또는 "desc"를 설정할 수 있다.
					    "order" : [[2, "asc"],[0, "desc"]],
					    "stateSave" : false,
					  //"stateSave" : true,
					  /*
					  	클라이언트 사이드 렌더링의 경우 새로고침 시 페이징 현재 상태가 저장되지 않으나
					  	stateSave를 true로 활성화 할 경우 새로고침 시에도 페이징 되어진 현재 상태가 저장되어 그대로 보여지게 된다.
					  	stateSave를 false로 활성화할 경우 새로고침시에는 초기화되어 처음의 상태로 보여지게 된다.
					  */
					  
					  "pagingType" : "full_numbers"
					  // "full_number","numbers","simple","simple_numbers","full","full_numbers","full_last_numbers"
					  // "scrollX" : false, 	// x축의 스크롤을 활성화 할지의 여부
					  // "scrollY" : "250px",   // y축의 스크롤의 크기
					  // "scrollCollapse" : true
					  /*  y축의 스크롤을 활성화 여부, 당연히 y축의 스크롤이 활성화가 되면 paging이 안일어나게 할수도 있으므로 그렇게하려면
					   "paging"을 false로 바꿀 수 있다. */
						
					});
				},
				error: function(e) {
					
				}
			});
		});
		
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

</script>

<div>
	<div style="display: inline-block;">
	<h3>출근/퇴근내역</h3>
	</div>
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
</div>
 
<div id="memberAttInfo"></div>