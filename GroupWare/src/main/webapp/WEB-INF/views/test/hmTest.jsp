<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	String ctxPath = request.getContextPath();	%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자원 예약</title>

<style type="text/css">
	
	#hm_container {
		border: solid 1px gray;
		width: 80%;
		margin: 0 auto;
	}
	
	#map {
		border: solid 1px blue;
		width: 80%;
		margin: 0 auto;
	}
	
	#sRooms, #bRooms {
		border: solid 0px maroon;
		display: inline-block;
		width: 90%;
		margin-left: 60px;
	}
	
	.small {
		display: inline-block;
		width: 195px;
		height: 120px;
	}
	
	.big {
		display: inline-block;
		width: 330px;
		height: 150px;
	}
	
	#room_one {
		border: solid 1px red;
	}
	
	#room_two {
		border: solid 1px orange;
	}

	#room_three {
		border: solid 1px green;
	}

	#room_four {
		border: solid 1px blue;
	}
	
	#room_five {
		border: solid 1px purple;
	}
	
	#road {
		border: solid 1px olive;
		height: 80px;
	}	
	
	#room_six {
		border: solid 1px pink;
	}

	#room_seven {
		border: solid 1px lime;
	}
	
	#room_eight {
		border: solid 1px cyan;
	}
	
</style>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// === jQuery UI 의 datepicker === //
		$("#datepicker").datepicker({
			 dateFormat: 'yy-mm-dd'		// Input Display Format 변경
			,showOtherMonths: true		// 빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear: true	// 년도 먼저 나오고, 뒤에 월 표시
			,changeYear: true			// 콤보박스에서 년 선택 가능
			,changeMonth: true			// 콤보박스에서 월 선택 가능                
			,showOn: "both"				// button:버튼을 표시하고, 버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고, 버튼을 누르거나 input을 클릭하면 달력 표시  
			,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif"	//버튼 이미지 경로
			,buttonImageOnly: true		// 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
			,buttonText: "선택"			// 버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
			,yearSuffix: "년"			// 달력의 년도 부분 뒤에 붙는 텍스트
			,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12']				// 달력의 월 부분 텍스트
			,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']	// 달력의 월 부분 Tooltip 텍스트
			,dayNamesMin: ['일','월','화','수','목','금','토']										// 달력의 요일 부분 텍스트
			,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']						// 달력의 요일 부분 Tooltip 텍스트
		//	,minDate: "-1M"				// 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		//	,maxDate: "+1M"				// 최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
        });                    
        
		// 초기값을 오늘 날짜로 설정
		$('#datepicker').datepicker('setDate', 'today');	// (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		
	});

</script>

</head>
<body>
	<div id="hm_container">
	
		<div id="map">			
			<h3>회의실 위치</h3>
			<div id="sRooms">
				<div class="small" id="room_one">
					1번
				</div>
				<div class="small" id="room_two">
					2번
				</div>
				<div class="small" id="room_three">
					3번
				</div>
				<div class="small" id="room_four">
					4번
				</div>
				<div class="small" id="room_five">
					5번
				</div>
			</div>
			
			<div id="road">
						
			</div>
			
			<div id="bRooms">
				<div class="big" id="room_six">
					6번
				</div>
				<div class="big" id="room_seven">
					7번
				</div>
				<div class="big" id="room_eight">
					8번
				</div>
			</div>			
		</div>
		
		<div id="dateAndTime">
			<table>
				<tr>
					<td style="width: 20%; font-weight: bold;">날짜</td>
					<td style="width: 80%; text-align: left;">
					   <input type="text" id="datepicker">
					</td>
				</tr>
			</table>
		</div>				
		
	</div>
</body>
</html>