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
		background-color: white;
		width: 90%;
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
	
	#reason {
		resize: none;
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
		$('#RsvtDate').val($('#datepicker').val());
		
		// 회의실 클릭했을 때
		$(".room").click(function(event){
			
			// 클릭한 회의실의 배경색이 바뀜
			$(".room").removeClass("rChioce");
			$(this).addClass("rChioce");
						
		//	alert($(this).children('.roomName').text());
						
			$("#roomName").val($(this).children('.roomName').text());			
			$("#fk_roomNumber").val($(this).children('.fk_roomNumber').val());
			
			possibleTime();
			
		});// end of $(".room").click(function(event){})----------------------------
		
		
		// 날짜 변경했을 때
		$("#datepicker").change(function(event){
			
			$("#RsvtDate").val($("#datepicker").val());
			
		});
		
		
		var cnt = 0;		
		// 시간 클릭했을 때
		$(".tr_time").click(function(event){
		
			if($(this).hasClass("rChioce")) {
				$(this).removeClass("rChioce");
				cnt=cnt-1;
			}
			else{
				if(cnt < 2) {				
					// 클릭한 시간의 배경색이 바뀜
					$(this).addClass("rChioce");
					cnt=cnt+1;
				}
			}
			
		//	alert(cnt);
			
		});	
		
	});// end of $(document).ready(function(){})------------------------------------------------
	
<%-- 	function showPossibleTime() {		
		
		var fk_roomNumber = $("#fk_roomNumber").val();
		var RsvtDate = $("#RsvtDate").val();
		
		$.ajax({
			url:"<%=request.getContextPath()%>/showPossibleTime.top",
			data : {"fk_roomNumber":fk_roomNumber,
					"RsvtDate":RsvtDate},
			dataType : "JSON",
			success:function(json){
				var html = "";
				$.each(json, function(index, item) {
					html += '<tr class="tr_time">';
					html += 	'<td class="td_time times">'+(index + 9)+':00 - '+(index + 10)+':00';
					html += 		'<input type="text" id="startTime" name="fk_roomNumber" value="09:00" />';
					html += 		'<input type="text" id="endTime" name="fk_roomNumber" value="10:00" />';
					html += 	'</td>';
					html += 	'<td class="td_time ability">';
					html += 		'<div>'+item.status+'</div>';
					html +=		'</td>';
					html +=	'</tr>';
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})		
	} --%>

</script>

</head>
<body>
	<div id="hm_container">
	
		<div id="map">			
			<h3>회의실 위치</h3>
			<div id="sbRooms">
				<div class="small room" id="room_one">
					<div class="text roomName">소회의실1</div>				
					<div class="text">5~10인</div>
					<input class="fk_roomNumber" type="hidden" value="5" />
				</div>
				<div class="small room" id="room_two">
					<div class="text roomName">소회의실2</div>
					<div class="text">5~10인</div>
					<input class="fk_roomNumber" type="hidden" value="6" />					
				</div>
				<div class="small room" id="room_three">
					<div class="text roomName">소회의실3</div>
					<div class="text">5~10인</div>
					<input class="fk_roomNumber" type="hidden" value="7" />
				</div>
				<div class="big room" id="room_four">
					<div class="text roomName">대회의실</div>
					<div class="text">15~30인</div>
					<input class="fk_roomNumber" type="hidden" value="1" />					
				</div>
			</div>
			
			<div id="road">
				복도		
			</div>
			
			<div id="mRooms">
				<div class="medium room" id="room_five">
					<div class="text roomName">중회의실A</div>
					<div class="text">10~15인</div>
					<input class="fk_roomNumber" type="hidden" value="2" />						
				</div>
				<div class="medium room" id="room_six">
					<div class="text roomName">중회의실B</div>
					<div class="text">10~15인</div>	
					<input class="fk_roomNumber" type="hidden" value="3" />										
				</div>
				<div class="medium room" id="room_seven">
					<div class="text roomName">중회의실C</div>
					<div class="text">10~15인</div>	
					<input class="fk_roomNumber" type="hidden" value="4" />										
				</div>
			</div>			
		</div>
		
		<div id="dateAndTime">
			<table id="date">
				<tr>
					<td style="width: 10%;">예약일</td>
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
				<tr class="tr_time">
					<td class="td_time times">9:00 - 10:00
						<input type="hidden" id="startTime" name="fk_roomNumber" value="09:00" /><!-- hidden -->
						<input type="hidden" id="endTime" name="fk_roomNumber" value="10:00" /><!-- hidden -->
					</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr class="tr_time">
					<td class="td_time times">10:00 - 11:00
						<input type="hidden" id="startTime" name="fk_roomNumber" value="10:00" /><!-- hidden -->
						<input type="hidden" id="endTime" name="fk_roomNumber" value="11:00" /><!-- hidden -->
					</td>
					<td class="td_time ability">
						<div>승인 대기중</div>
					</td>
				</tr>
				<tr class="tr_time">
					<td class="td_time times">11:00 - 12:00</td>
					<td class="td_time ability">
						<div>예약 불가</div>
					</td>
				</tr>
				<tr class="tr_time">
					<td class="td_time times">12:00 - 13:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr class="tr_time">
					<td class="td_time times">14:00 - 15:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr class="tr_time">
					<td class="td_time times">15:00 - 16:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr class="tr_time">
					<td class="td_time times">16:00 - 17:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
				<tr class="tr_time">
					<td class="td_time times">17:00 - 18:00</td>
					<td class="td_time ability">
						<div>예약 가능</div>
					</td>
				</tr>
			</table>
		</div>
		
		<div id="info">
			<h4>예약하기</h4>
			<table>
				<tr>
					<th>회의실</th>
					<td>
						<input type="text" id="roomName" name="roomName" readonly="readonly"/>
						<input type="text" id="fk_roomNumber" name="fk_roomNumber"/><!-- hidden -->
						</td>
				</tr>
				<tr>
					<th>예약일</th>
					<td><input type="text" id="RsvtDate" name="RsvtDate" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>시간</th>
					<td><input type="text" readonly="readonly"/>-<input type="text" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>신청자</th>
					<td>
						<input type="text" readonly="readonly"/>
						<input type="text" value="fk_employee_seq"/><!-- hidden -->
					</td>
				</tr>
				<tr>
					<th>예약 대표자</th>
					<td>
						<input type="text" />
					</td>
				</tr>
				<tr>
					<th>사용 인원</th>
					<td>
						<input type="text" maxlength="2"/>
					</td>
				</tr>
				<tr>
					<th>사유</th>
					<td>
						<textarea id="reason" name="reason" cols="40" rows="10"></textarea>
					</td>
				</tr>							

			</table>
		</div>				
		
	</div>
</body>
</html>