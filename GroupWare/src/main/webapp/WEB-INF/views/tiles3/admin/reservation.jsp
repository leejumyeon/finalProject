<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	tr.panel {
		display: none;
	}

</style>

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css"/>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

<script type="text/javascript">  

	$(document).ready(function(){
		
		waitingReservation();		
		
		$("#waitingTb").DataTable({
			"dom": '<"top"lf>rt<"bottom"ip>',		// 페이지바가 우측하단에 위치, 검색이 우측상단에 위치하는 것임.  
		//	"dom": '<"top"lp>rt<"bottom"if>',		// 페이지바가 우측상단에 위치, 검색이 우측하단에 위치하는 것임.  
			"paging"    : true,                		// 우측하단에 페이지바를 보여줄것인지 아닌지를 결정하는 것
		//	"paging"    : false,               		// 우측하단에 페이지바를 보여줄것인지 아닌지를 결정하는 것 
			"ordering"  : true,                		// th에 나오는 값에 따라서 오름차순, 내림차순 정렬을 할것인지 말것인지를 결정하는 것  
			"info"      : true,                		// 좌측하단에 보여지는 Showing 1 to 10 of 22 entries 를 보여줄것인지 말것인지를 결정하는 것       
			"filter"    : true,                		// 우측상단에 보여지는 검색을 보여줄것인지 말것인지를 결정하는 것       
			"lengthChange"   : true,           		// 좌측상단에 보여지는 한페이지당 행의갯수를 결정하는 것  
		//	"order"     : [[0, "asc"]], 			// 기본 컬럼 정렬 설정  숫자 0은 첫번째 컬럼을 말하며, "asc" 또는 "desc"를 설정할 수 있다. 
			"order"     : [[2, "asc"],[0, "desc"]],	// 기본 컬럼 정렬 설정  숫자 0은 첫번째 컬럼을 말하며, "asc" 또는 "desc"를 설정할 수 있다. 
			"stateSave" : false,
		//	"stateSave" : true, 
			/*
			    클라이언트 사이드 렌더링의 경우 새고로침 시 페이징 현재 상태가 저장되지 않으나
                 stateSave를 true로 활성화할 경우 새로고침 시에도 페이징 되어진 현재 상태가 저장되어 그대로 보여지게 된다.
                 stateSave를 false로 활성화할 경우 새로고침 시에는 초기화 되어 처음의 상태로 보여지게 된다.
			*/
			"pagingType" : "full_numbers",  // "numbers" , "simple" , "simple_numbers" , "full" , "full_numbers" , "first_last_numbers" 
		//	"scrollX" : false,   // x 축 스크롤을 활성화 할지의 여부 
		//	"scrollY" : "250px", // y 축의 스크롤의 크기 
		//	"scrollCollapse" : true // y 축의 스크롤을 활성화 여부. 당연히 y축의 스크롤이 활성화 되면 paging이 안 일어나게 할 수도 있으므로  그렇게 하려면 "paging" 을 false로 바꿀수도 있다.  
		});				
		
		// 아코디언		  
		$(document).on("click", ".accordion", function(){						
			
			var $targetNext = $(this).next();
		
			var targetNextDisplayProperty = $targetNext.css('display');				
			
			if(targetNextDisplayProperty == 'none') {
				
				$(".panel").css('display','none');
								
				$targetNext.css('display','');	
			}
			
			else {
				
				$targetNext.css('display','none');	
			}
			
		});
		
	});
	
	// === 예약 신청 현황 조회(관리자)(Ajax) === //
	function waitingReservation() {
		$.ajax({			
			url:"<%=request.getContextPath()%>/manager/waitingReservation.top",
			dataType : "JSON",
			success : function(json) {
				var html = "";
				if (json.length > 0) {
					$.each(json, function(index, item) {
						html += "<tr class='accordion' style='cursor: pointer;'>";																					
						html += 	"<td>" + item.reservation_seq + "</td>";
						html += 	"<td>" + item.employee_name + "</td>";
						html += 	"<td>" + item.roomName + "</td>";
						html += 	"<td>" + item.startDate + "</td>";
						html += 	"<td>" + item.endDate + "</td>";
						html += 	"<td>" + item.memberCount + "</td>";
						html += 	"<td>" + item.regDate + "</td>";		
						html += "</tr>";	
						html += "<tr class='panel'>";	
						html += 	"<td colspan='7' style='text-align: left;'>사유 : "+item.reason+"</td>";
						html += "</tr>";									
					});

				} else {
					html += "<tr>";
					html += 	"<td colspan='7' style='text-align: center;'>예약 신청이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("#waitingDisplay").html(html);
				
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "+ request.responseText + "\n" + "error: "+ error);
			}
		});
	}

</script>    
    
<h3>예약관리</h3>
<div id="content_area">
	<div class ="table_title" style="margin-top:5px;">
		<div class="searchArea" style="display:inline-block; float:right;">
			장소선택 : 
			<select>
				<option>전체</option>
				<option>소회의실</option>
				<option>중회의실</option>
				<option>대회의실</option>
			</select>
		</div>
		<h4 style="display: inline-block;">예약 신청 현황</h4>
	</div>
	<div style="clear:both;"></div>
	<table class="waitingTb table">
		<thead>
			<tr>
				<td>예약번호</td>
				<td>신청자</td>
				<td>장소</td>
				<td>시작시간</td>
				<td>종료시간</td>
				<td>인원수</td>
				<td>신청날짜</td>
			</tr>
		<thead>
		<tbody id="waitingDisplay"></tbody>
	</table>
	
	<div class ="table_title" style="margin-top:5px;">
		<div class="searchArea" style="display:inline-block; float:right;">
			승인상태 : 
			<select>
				<option>전체</option>
				<option>승인</option>
				<option>반려</option>
			</select>
			
			장소선택 : 
			<select>
				<option>전체</option>
				<option>소회의실</option>
				<option>중회의실</option>
				<option>대회의실</option>
			</select>
		</div>
		<h4 style="display: inline-block;">예약 현황</h4>
	</div>
	<div style="clear:both;"></div>
	<table class="table">
		<tr>
			<td>예약번호</td>
			<td>신청자</td>
			<td>장소</td>
			<td>시작시간</td>
			<td>종료시간</td>
			<td>인원수</td>
			<td>신청날짜</td>
			<td>승인상태</td>
		</tr>
	</table>
	
	<div class="popup" style="border: solid 1px black; width:300px;">
		<table>
			<tr>
				<th>받는 사람</th>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<th style="vertical-align: top;">내용</th>
				<td><textarea style="resize: none; width:100%;" rows="5"></textarea></td>
			</tr>
		</table>
		<div>
		<span style="border:solid 1px black; padding:10px 20px; margin:20px; float:right;">전송</span>
		</div>
		<div style="clear:both;"></div>
	</div>
	
</div>