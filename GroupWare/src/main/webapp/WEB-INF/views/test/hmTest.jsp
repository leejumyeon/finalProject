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
	
	#sbRooms, #mRooms {
		border: solid 0px maroon;
		display: inline-block;
		width: 90%;
		margin-left: 60px;
	}
	
	.small {
		display: inline-block;
		width: 180px;
		height: 150px;
	}
	
	.medium {
		display: inline-block;
		width: 325px;
		height: 150px;
	}
	
	.big {
		display: inline-block;
		width: 425px;
		height: 150px;
	}
	
	.room {
		border: solid 1px #1187cf;
	}
	
	#road {
		border: solid 1px olive;
		height: 80px;
	}		
	
	#dateAndTime {
		border: solid 1px red;
		display: inline-block;
		width: 40%;
		margin: 10px 0 0 10%;
	}
	
	#info {
		border: solid 1px red;
		display: inline-block;
		width: 39%;
		margin: 10px 10% 0 0;
	}
	
	.rChioce {
		background-color: #eee;
	}
	
	.text {
		text-align: center;
		margin-top: 30px;
	}
	
	#dateAndTime {
		text-align: center;
	}
	
	#time, .th_time, .td_time {
		border: solid 1px gray;
		border-collapse: collapse;
		padding: 10px 15px;
	}
	
	.th_time {
		background-color: #d1eefc;
	}
	
	.times {
		width: 50%;
	}
	
	.ability {
		width: 50%;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

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
			,minDate: "+1D"				// 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		//	,maxDate: "+3Y"				// 최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
        });                    
        
		// 초기값을 오늘 날짜로 설정
		$('#datepicker').datepicker('setDate', 'today');	// (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		
		$(".room").click(function(event){
			$(".room").removeClass("rChioce");
			$(this).addClass("rChioce");
		});
		
	});

</script>

</head>
<body>
	<div id="hm_container">
	
		<div id="map">			
			<h3>회의실 위치</h3>
			<div id="sbRooms">
				<div class="small room" id="room_one">
					<div class="text">소회의실1</div>
					<div class="text">5~10인</div>
				</div>
				<div class="small room" id="room_two">
					<div class="text">소회의실2</div>
					<div class="text">5~10인</div>
				</div>
				<div class="small room" id="room_three">
					<div class="text">소회의실3</div>
					<div class="text">5~10인</div>
				</div>
				<div class="big room" id="room_four">
					<div class="text">대회의실</div>
					<div class="text">15~30인</div>
				</div>
			</div>
			
			<div id="road">
				복도		
			</div>
			
			<div id="mRooms">
				<div class="medium room" id="room_five">
					<div class="text">중회의실A</div>
					<div class="text">10~15인</div>
				</div>
				<div class="medium room" id="room_six">
					<div class="text">중회의실B</div>
					<div class="text">10~15인</div>					
				</div>
				<div class="medium room" id="room_seven">
					<div class="text">중회의실C</div>
					<div class="text">10~15인</div>					
				</div>
			</div>			
		</div>
		
		<div id="dateAndTime">
			<table id="date">
				<tr>
					<td style="width: 10%;">날짜</td>
					<td style="width: 50%; text-align: left;">
						<input type="text" id="datepicker">
					</td>
				</tr>
			</table>
			
			<br/>
			
			<table id="time">
				<tr>
					<th class="th_time times">시간</th>
					<th class="th_time ability">가능여부</th>
				</tr>
				<tr>
					<td class="td_time times">9:00 - 10:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">10:00 - 11:00</td>
					<td class="td_time ability">
						<div>승인 대기중</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">11:00 - 12:00</td>
					<td class="td_time ability">
						<div>예약 불가</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">12:00 - 13:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">13:00 - 14:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">14:00 - 15:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">15:00 - 16:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">16:00 - 17:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr>
					<td class="td_time times">17:00 - 18:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
			</table>
		</div>
		
		<div id="info">
			<table>
				<tr>
					<th>회의실명</th>
					<td><span></span></td>
				</tr>
			</table>
		</div>				
		
	</div>
</body>
</html>