<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	String ctxPath = request.getContextPath();	%>    
<link rel="stylesheet" href="<%= request.getContextPath()%>/resources/datepicker/datepicker.css">

<style type="text/css">
	
	#hm_container {
		border: solid 0px gray;
		background-color: white;
		margin: 0 auto;
		width: 95%;
	}
	
	#title {
		font-size: 20px;	
		display: block;
		padding: 0 0 20px 20px;
		font-weight: bold;
	}
	
	#choice_container {
		width: 60%;
		height: 630px;
		display: inline-block;
		float: left;
		border: solid 0px green;
	}
	
	#info {
		border: solid 1px #ddd;
		border-radius: 10px 10px;
		display: inline-block;
		width: 40%;
		height: 669px;
	}
	
	#map {
		border: solid 1px #ddd;
		display: inline-block;
		width: 90%;
		margin-left: 3%;
		padding: 10px 20px 20px 20px;
		border-radius: 10px 10px;
	}
	
	#sbRooms, #mRooms {
		border: solid 0px maroon;
		display: inline-block;
		width: 500px;
		margin-left: 60px;
	}
	
	.small {
		display: inline-block;
		width: 90px;
		height: 100px;
	}
	
	.medium {
		display: inline-block;
		width: 130px;
		height: 100px;
	}
	
	.big {
		display: inline-block;
		width: 190px;
		height: 100px;
	}
	
	.room {
		border: solid 1px #1187cf;
		background-color: #e7f5fd;
	}
	
	#road {
		border-top: solid 1px olive;
		border-bottom: solid 1px olive;
		height: 50px;	
		padding: 15px 0 0 10px;	
	}		
	
	#dateAndTime {
		border: solid 1px #ddd;
		width: 90%;
		margin: 25px 0 0 3%;
		padding: 10px 20px 20px 20px;
		border-radius: 10px 10px;
	}	
	
	.rChoice {
		background-color: #a1d8f7;
	}
	
	.text {
		text-align: center;
		font-size: 13px;
		margin-top: 20px;
	}
	
	#dateAndTime {
		text-align: center;
	}
	
	#time, .th_time, .td_time {
		border: solid 1px gray;
		border-collapse: collapse;
		padding: 5px 10px;
		text-align: center;
	}
	
	.th_time {
		background-color: #eee;
	}
	
	.times {
		width: 110px;
	}
	
	.ability {
		width: 110px;
		height: 50px;
	}
	
	#info_tb, #info_th, #info_td {
		border: solid 1px gray;
		border-collapse: collapse;
		padding: 3px 5px;
		text-align: center;
		margin: 0 auto;
	}
	
	#info_th {
		width: 120px;
		height: 50px;		
	}
	
	#info_td {
		width: 270px;
		height: 50px;	
	}
	
	#reason {
		resize: none;
	}
	
	#rsvt_btn {
		padding: 10px 20px 8px 20px;
		margin: 20px 0 0 330px; 
		background-color: #eee;
		border: solid 1px gray;
		border-radius: 5px 5px;
		outline: 0;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="<%= request.getContextPath()%>/resources/datepicker/datepicker.js"></script>

<script type="text/javascript">

	$(document).ready(function(){		                    
		
		$("#datepicker").datepicker({ });
		
		// 초기값을 오늘 날짜로 설정
		$('#datepicker').datepicker('setDate', 'today');	// (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		$('#RsvtDateH').text($('#datepicker').val());
		$('#RsvtDate').val($('#datepicker').val());
		
		// 회의실 클릭했을 때
		$(".room").click(function(event){
			
			// 클릭한 회의실의 배경색이 바뀜
			$(".room").removeClass("rChoice");
			$(this).addClass("rChoice");
						
		//	alert($(this).children('.roomName').text());
						
			$("#roomName").text($(this).children('.roomName').text());			
			$("#fk_roomNumber").val($(this).children('.fk_roomNumber').val());
			
			possibleTime();
			
		}); // end of $(".room").click(function(event){})----------------------------
		
		
		// 날짜 변경했을 때
		$("#datepicker").change(function(event){
			
			$("#RsvtDateH").text($("#datepicker").val());
			$('#RsvtDate').val($('#datepicker').val());
			
		});
		
		
		// 시간 선택하기	
		var cnt = 0;
		var start = "";
		var end = "";		

		$(".ability").click(function(event){	// 가능여부 부분 클릭했을 경우
			if(!$(this).hasClass("rChoice")) {		// 배경색이 없을 경우
				$(this).addClass("rChoice");				// 배경색을 바꿈
				start = $(this).children(".startTime").val();	// start에 this의 startTime 값을 넣음
				end = $(this).children(".endTime").val();		// end에 this의  endTime 값을 넣음
			}
			else {		// 배경색이 있을 경우
				start = "";
				end = "";
				console.log("취소");
				$(this).removeClass("rChoice");	// 배경색을 없앰
			}
			
		//	alert(cnt);
			
			var prev = $(this).prev();			
			var prStartTime = prev.children(".startTime").val();
			var prEndTime = prev.children(".endTime").val();
			
			var next = $(this).next();
			var neStartTime = next.children(".startTime").val();
			var neEndTime = next.children(".endTime").val();
			
		//	console.log(prStartTime+", "+prEndTime);
		//	console.log(neStartTime+", "+neEndTime);
			
			if(prev.hasClass("rChoice")) {	// prev에 배경색이 있을 경우
				if(start != null && start != "") {	// start가 공백이 아닐 경우
					start = prStartTime;	// start에 prev의 startTime 값을 넣음
				}
				else {	// start가 공백일 경우
					start = prStartTime;	// start에 prev의 startTime 값을 넣음
					end = prEndTime;		// end에 prev의 endTime 값을 넣음
				}
			}
			else if(next.hasClass("rChoice")) { // next에 배경색이 있을 경우
				if(end != null && end != "") {	// end가 공백이 아닐 경우
					end = neEndTime		// end에 next의 endTime 값을 넣음
				}
				else {	// end가 공백일 경우
					start = neStartTime	// start에 next의 startTime 값을 넣음
					end = neEndTime		// end에 next의 endTime 값을 넣음
				}
			}
			
			console.log(start+", "+end);
			
			$("#startTimeH").val(start);
			$('#startTime').text(start);
			
			$("#endTimeH").val(end);
			$('#endTime').text(end);
					
		});	
		
	}); // end of $(document).ready(function(){})------------------------------------------------
	
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

	  function maxLengthCheck(object){
		    if (object.value.length > object.maxLength){
		      object.value = object.value.slice(0, object.maxLength);
		    }    
		  }
	
</script>

</head>
<body>
	<div id="hm_container">
		<span id="title">회의실 예약</span>
		
		<div id="choice_container">
		<div id="map">					
			<h4 style="margin-bottom: 20px;">1. 회의실 선택</h4>
			<div id="sbRooms">
				<div class="small room" id="room_one">
					<div class="text roomName">소회의실1</div>				
					<div class="text">3~10인</div>
					<input class="fk_roomNumber" type="hidden" value="5" />
				</div>
				<div class="small room" id="room_two">
					<div class="text roomName">소회의실2</div>
					<div class="text">3~10인</div>
					<input class="fk_roomNumber" type="hidden" value="6" />					
				</div>
				<div class="small room" id="room_three">
					<div class="text roomName">소회의실3</div>
					<div class="text">3~10인</div>
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
		<h4 style="margin-bottom: 20px; text-align: left;">2. 예약일시 선택</h4>
			<table id="date">
				<tr>
					<td style="text-align: left; padding-left: 20px; width: 120px;">- 예약일 선택 : </td>
					<td style="text-align: left;">
						<input type="text" id="datepicker" readonly="readonly">
					</td>
				</tr>
			</table>
			
			<br/>
			<span style="margin: 0 0 10px 20px; float: left;">- 예약시간 선택</span>
			<div style="clear: both;"></div>
			<table id="time" style=" margin-left: 30px;">
				<tr>
					<th class="th_time times">시간</th>
					<td class="td_time times time9">9:00 - 10:00</td>
					<td class="td_time times time10">10:00 - 11:00</td>
					<td class="td_time times time11">11:00 - 12:00</td>
					<td class="td_time times time12">12:00 - 13:00</td>									
				</tr>
				<tr>
					<th class="th_time">가능여부</th>
					<td class="td_time ability tdOne time9">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="09:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="10:00" /><!-- hidden -->
					</td>
					<td class="td_time ability tdOne time10">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="10:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="11:00" /><!-- hidden -->
					</td>
					<td class="td_time ability tdOne time11">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="11:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="12:00" /><!-- hidden -->						
					</td>
					<td class="td_time ability tdOne time12">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="12:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="13:00" /><!-- hidden -->						
					</td>								
				</tr>
				
				<tr>
					<th class="th_time times">시간</th>
					<td class="td_time times time14">14:00 - 15:00</td>
					<td class="td_time times time15">15:00 - 16:00</td>
					<td class="td_time times time16">16:00 - 17:00</td>
					<td class="td_time times time17">17:00 - 18:00</td>									
				</tr>
				<tr>
					<th class="th_time">가능여부</th>
					<td class="td_time ability tdTwo time14">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="14:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="15:00" /><!-- hidden -->
					</td>
					<td class="td_time ability tdTwo time15">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="15:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="16:00" /><!-- hidden -->						
					</td>
					<td class="td_time ability tdTwo time16">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="16:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="17:00" /><!-- hidden -->						
					</td>
					<td class="td_time ability tdTwo time17">
						<div>예약 가능</div>
						<input type="hidden" class="startTime" name="startTime" value="17:00" /><!-- hidden -->
						<input type="hidden" class="endTime" name="endTime" value="18:00" /><!-- hidden -->						
					</td>								
				</tr>				
			</table>
		</div>
		<div style="clear: both;"></div>
		</div>		
		
		<div id="info">
			<h4 style="margin: 25px 10px 20px 25px;">3. 예약하기</h4>
			<table id="info_tb">
				<tr id="info_tr">
					<th id="info_th">회의실</th>
					<td id="info_td">
						<span id="roomName"></span>
						<input type="hidden" id="fk_roomNumber" name="fk_roomNumber"/><!-- hidden -->
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">예약일</th>
					<td id="info_td">
						<span id="RsvtDateH"></span>
						<input type="hidden" id="RsvtDate" name="RsvtDate"/><!-- hidden -->
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">시간</th>
					<td id="info_td">
						<span id="startTime"></span> - <span id="endTime"></span>
						<input type="text" id="startTimeH" name="startTimeH"><!-- hidden -->
						<input type="text" id="endTimeH" name="endTimeH"><!-- hidden -->
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">예약 신청자</th>
					<td id="info_td">
						<input type="text" readonly="readonly"/>
						<input type="text" value="fk_employee_seq"/><!-- hidden -->
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">예약 대표자</th>
					<td id="info_td">
						<input type="text" />
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">사용 인원</th>
					<td id="info_td">
						<input type="number" maxlength="2" min="3" max="30" value="3" oninput="maxLengthCheck(this)"/>
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">사유</th>
					<td id="info_td">
						<textarea id="reason" name="reason" cols="40" rows="10"></textarea>
					</td>
				</tr>							

			</table>
			
			<input type="button" id="rsvt_btn" value="예약 신청"/>
			
		</div>				
		<div style="clear: both;"></div>
		
	</div>
</body>