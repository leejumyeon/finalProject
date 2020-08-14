<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
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
		height: 684px;
	}
	
	#map {
		border: solid 1px #ddd;
		display: inline-block;
		width: 90%;
		margin-left: 3%;
		padding: 10px 20px 20px 20px;
		border-radius: 10px 10px;
	}
	
	#mapIn {
		width: 560px;
		padding-left: 50px;
	}
	
	#sbRooms, #mRooms {
		border: solid 0px maroon;
		display: inline-block;
		width: 500px;
		margin-left: 20px;
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
	
	.room:hover {
		cursor: pointer;
	}
	
	#road {
		border-top: solid 1px gray;
		border-bottom: solid 1px gray;
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
	
	#datepicker:hover {
		cursor: pointer;
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
	
	.td_time {
		background-color: #f2f2f2;
	}
	
	.times {
		width: 110px;
		background-color: white;
	}
	
	.ability {
		width: 110px;
		height: 50px;
		background-color: white;
	}
	
	.ability:hover {
		cursor: pointer;
	}
	
	.rChoice {
		background-color: #a1d8f7;
	}
	
	.th_time {
		background-color: #eee;
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
	
	.hide {
		display: none;
	}
	
	.search:hover {
		font-weight: bold;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="<%= request.getContextPath()%>/resources/datepicker/datepicker.js"></script>

<script type="text/javascript">

	$(document).ready(function(){		                    
		
		$("#datepicker").datepicker({});
		
		// 초기값을 오늘 날짜로 설정
		$('#datepicker').datepicker('setDate', 'today');	// (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		$('#rsvtDateH').text($('#datepicker').val());
		$('#rsvtDate').val($('#datepicker').val());
		
		var people = "";
		var people_min = "";
		var people_max = "";
		
		var flag = false;
		
		// 회의실 클릭했을 때
		$(".room").click(function(event){
			
			flag = true;
			
			// 클릭한 회의실의 배경색이 바뀜
			$(".room").removeClass("rChoice");
			$(this).addClass("rChoice");
						
		//	alert($(this).children('.roomName').text());
					
			$("#roomName").text($(this).children('.roomName').text());			
			$("#fk_roomNumber").val($(this).children('.fk_roomNumber').val());	
						
			people = $(this).children('.people').text();
			people_min = Number(people.substring(0, people.lastIndexOf("~")));
			people_max = Number(people.substring(people.indexOf("~")+1, people.lastIndexOf("인")));
			
		//	alert($(this).children('.people').text());			
			
			showPossibleTime();
			
		}); // end of $(".room").click(function(event){})----------------------------
		
		var fk_roomNumber = $("#fk_roomNumber").text();
		
		// 날짜 변경했을 때
		$("#datepicker").change(function(event){
			
			$("#rsvtDateH").text($("#datepicker").val());
			$('#rsvtDate').val($('#datepicker').val());
			showPossibleTime();
			
		});
		
		
		// 시간 선택하기	
		var start = "";
		var end = "";		

		$(".td_time").click(function(){	// 가능여부 부분 클릭했을 경우
			
			if($(this).hasClass("ability")){	
				if(!$(this).hasClass("rChoice")) {	// 배경색이 없을 경우
					$(this).addClass("rChoice");	// 배경색을 바꿈
					if($(this).hasClass("tdOne")){
						$(".tdTwo").removeClass("ability");
						$(".tdTwo").css("height", "50px");
					}
					if($(this).hasClass("tdTwo")){
						$(".tdOne").removeClass("ability");
						$(".tdOne").css("height", "50px");
					}
				}
				else {
			//		console.log("취소");
					$(this).removeClass("rChoice");	// 배경색을 없앰	
				}
				
				var prev = $(this).prev();			
				var prStartTime = prev.children(".startTime").val();
				var prEndTime = prev.children(".endTime").val();
				
				var next = $(this).next();
				var neStartTime = next.children(".startTime").val();
				var neEndTime = next.children(".endTime").val();
				
			//	console.log(prStartTime+", "+prEndTime);
			//	console.log(neStartTime+", "+neEndTime);
				
				if(prev.hasClass("rChoice")) {	// prev에 배경색이 있을 경우
					if($(this).hasClass("rChoice")) {
						start = prStartTime;
						end = $(this).children(".endTime").val();
						$(this).siblings().removeClass("ability");
						prev.addClass("ability");
					}
					else {	// start가 공백일 경우
						start = prStartTime;	// start에 prev의 startTime 값을 넣음
						end = prEndTime;		// end에 prev의 endTime 값을 넣음
						$(this).siblings().removeClass("ability");
						prev.addClass("ability");
						if(prev.prev().hasClass("td_time")){
							prev.prev().addClass("ability");
						}
					}
				}
				else if(next.hasClass("rChoice")) { // next에 배경색이 있을 경우
					if($(this).hasClass("rChoice")) {
						start = $(this).children(".startTime").val();
						end = neEndTime		// end에 next의 endTime 값을 넣음
						$(this).siblings().removeClass("ability");
						next.addClass("ability");
					}
					else {	// end가 공백일 경우
						start = neStartTime	// start에 next의 startTime 값을 넣음
						end = neEndTime		// end에 next의 endTime 값을 넣음
						$(this).siblings().removeClass("ability");
						next.addClass("ability");
						if(next.next().hasClass("td_time")){
							next.next().addClass("ability");
						}
					}
				}
				else{
					if($(this).hasClass("rChoice")) {
						start = $(this).children(".startTime").val();	// start에 this의 startTime 값을 넣음
						end = $(this).children(".endTime").val();
						$(this).siblings().removeClass("ability");
						prev.addClass("ability");
						next.addClass("ability");
					}
					else{
						start="";
						end="";
						$(this).siblings().each(function(index, item){
							if($(item).hasClass("td_time")){
								$(item).addClass("ability");
							}
							$(".tdOne").removeClass("ability");
							$(".tdTwo").removeClass("ability");
							
							$(".tdOne").addClass("ability");
							$(".tdOne").css("height", "50px");

							$(".tdTwo").addClass("ability");
							$(".tdTwo").css("height", "50px");
						});
					}
				}
				
			//	console.log(start+", "+end);
				
				$("#startTimeH").val(start);
				$('#startTime').text(start);
				
				$("#endTimeH").val(end);
				$('#endTime').text(end);
			//	console.log($(this).siblings());
			}
			else{
				if(!$(this).hasClass("times")){
					alert("선택할 수 없습니다.");
				}
			}
			
		});	
		
		
		<%-- === 검색어 입력 시 자동글 완성하기 2 === --%>
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
								
							//	var index = word.toLowerCase().indexOf( $("#searchHead").val().toLowerCase() );
								// word 값을 전부 소문자로 맞춰준다. // 글자가 위치하는 인덱스 값을 알려준다.(즉, 길이)
							//	console.log("index : " + index);
								
							//	var len = $("#searchHead").val().length;
								
								var result = "";													
								
							//	console.log( word.substr(0,index) );	// 검색어 앞까지의 글자
							//	console.log( word.substr(index,len) );	// 검색어 글자
							//	console.log( word.substr(index+len) );	// 검색어 뒤부터 끝까지의 글자
							
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
						console.log(json);												
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}				
				});
				
			}
			
		});// end of $("#searchHead").keyup()------------------
		
		<%-- === 검색어 입력 시 자동글 완성하기 8 === --%>
		$(document).on("click", ".result", function(){
			var str = $(this).text();
			$(this).addClass("select");
			$("#searchHead").val(str.substring(0, str.lastIndexOf(">")+1)); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			$("#head_seq").val($(".select .hide").text());
			$("#displayList").hide();
		});
		
	}); // end of $(document).ready(function(){})------------------------------------------------
	

	<%-- === 예약 가능한 시간 조회(Ajax) === --%>
	function showPossibleTime() {		
		
		var fk_roomNumber = $("#fk_roomNumber").val();
		var rsvtDate = $("#rsvtDate").val();
		
		$.ajax({
			url:"<%=request.getContextPath()%>/showPossibleTime.top",
			data : {"fk_roomNumber":fk_roomNumber,
					"rsvtDate":rsvtDate},
			dataType : "JSON",
			success:function(json){						
				if(json.length > 0) {
					$.each(json, function(index, item) {
						console.log(item.startDate);
					});
				}
				else {
					console.log("예약내역 없음");
					$(".whether").text("예약가능");
				}						
				
				var html = 	'<table id="time" style="margin-left: 30px;">'+
								 '<tr>'+
									'<th class="th_time times">시간</th>'+
									'<td class="td_time times time9"><span class="start">09:00</span> - <span class="end">10:00</span></td>'+
									'<td class="td_time times time10"><span class="start">10:00</span> - <span class="end">11:00</span></td>'+
									'<td class="td_time times time11"><span class="start">11:00</span> - <span class="end">12:00</span></td>'+
									'<td class="td_time times time12"><span class="start">12:00</span> - <span class="end">13:00</span></td>'+							
								'</tr>'+
					
								'<tr>'+
									'<th class="th_time">가능여부</th>'+
									'<td class="td_time ability tdOne time9">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="09:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="10:00" />'+
									'</td>'+
									'<td class="td_time ability tdOne time10">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="10:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="11:00" />'+
									'</td>'+
									'<td class="td_time ability tdOne time11">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="11:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="12:00" />'+						
									'</td>'+
									'<td class="td_time ability tdOne time12">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="12:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="13:00" />'+					
									'</td>'+
								'</tr>'+
					
								'<tr>'+
									'<th class="th_time times">시간</th>'+
								'<td class="td_time times time14"><span class="start">14:00</span> - <span class="end">15:00</span></td>'+
									'<td class="td_time times time15"><span class="start">15:00</span> - <span class="end">16:00</span></td>'+
									'<td class="td_time times time16"><span class="start">16:00</span> - <span class="end">17:00</span></td>'+
									'<td class="td_time times time17"><span class="start">17:00</span> - <span class="end">18:00</span></td>'+								
								'</tr>'+
								'<tr>'+
									'<th class="th_time">가능여부</th>'+
									'<td class="td_time ability tdTwo time14">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="14:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="15:00" />'+
									'</td>'+
									'<td class="td_time ability tdTwo time15">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="15:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="16:00" />'+					
									'</td>'+
									'<td class="td_time ability tdTwo time16">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="16:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="17:00" />'+						
									'</td>'+
									'<td class="td_time ability tdTwo time17">'+
										'<div><span class="whether"></span></div>'+
										'<input type="hidden" class="startTime" name="startTime" value="17:00" />'+
										'<input type="hidden" class="endTime" name="endTime" value="18:00" />'+						
									'</td>'+								
								'</tr>'+				
							'</table>';
			
				$("#timeWhether").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})		
	}

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
			<h4 style="margin-bottom: 20px;">1. 회의실 및 예약일 선택</h4>
			<span style="margin: 0 0 15px 20px; float: left;">- 회의실 선택</span>
			<div id="mapIn">
				<div id="sbRooms">
					<div class="small room" id="room_one">
						<div class="text roomName">소회의실1</div>				
						<div class="text people">3~10인</div>
						<input class="fk_roomNumber" type="hidden" value="5" />
					</div>
					<div class="small room" id="room_two">
						<div class="text roomName">소회의실2</div>
						<div class="text people">3~10인</div>
						<input class="fk_roomNumber" type="hidden" value="6" />					
					</div>
					<div class="small room" id="room_three">
						<div class="text roomName">소회의실3</div>
						<div class="text people">3~10인</div>
						<input class="fk_roomNumber" type="hidden" value="7" />
					</div>
					<div class="big room" id="room_four">
						<div class="text roomName">대회의실</div>
						<div class="text people">15~30인</div>
						<input class="fk_roomNumber" type="hidden" value="1" />					
					</div>
				</div>
				
				<div id="road">
					복도		
				</div>
				
				<div id="mRooms">
					<div class="medium room" id="room_five">
						<div class="text roomName">중회의실A</div>
						<div class="text people">10~15인</div>
						<input class="fk_roomNumber" type="hidden" value="2" />						
					</div>
					<div class="medium room" id="room_six">
						<div class="text roomName">중회의실B</div>
						<div class="text people">10~15인</div>	
						<input class="fk_roomNumber" type="hidden" value="3" />										
					</div>
					<div class="medium room" id="room_seven">
						<div class="text roomName">중회의실C</div>
						<div class="text people">10~15인</div>	
						<input class="fk_roomNumber" type="hidden" value="4" />										
					</div>
				</div>	
			</div>
			
			<table id="date" style="margin: 30px 0 0 0;" >
				<tr>
					<td style="text-align: left; padding-left: 20px; width: 120px;">- 예약일 선택 : </td>
					<td style="text-align: left;">
						<input type="text" id="datepicker" readonly="readonly">
					</td>
				</tr>
			</table>		
		</div>
		
		<div id="dateAndTime">
		<h4 style="margin-bottom: 20px; text-align: left;">2. 예약시간 선택</h4>
			<div style="clear: both;"></div>
			<div id="timeWhether">
		
<!-- 				<table id="time" style=" margin-left: 30px;">
					<tr>
						<th class="th_time times">시간</th>
						<td class="td_time times time9">09:00 - 10:00</td>
						<td class="td_time times time10">10:00 - 11:00</td>
						<td class="td_time times time11">11:00 - 12:00</td>
						<td class="td_time times time12">12:00 - 13:00</td>									
					</tr>
					<tr>
						<th class="th_time">가능여부</th>
						<td class="td_time ability tdOne time9">
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="09:00" />
							<input type="hidden" class="endTime" name="endTime" value="10:00" />
						</td>
						<td class="td_time ability tdOne time10">
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="10:00" />
							<input type="hidden" class="endTime" name="endTime" value="11:00" />
						</td>
						<td class="td_time ability tdOne time11">
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="11:00" />
							<input type="hidden" class="endTime" name="endTime" value="12:00" />			
						</td>
						<td class="td_time ability tdOne time12">
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="12:00" />
							<input type="hidden" class="endTime" name="endTime" value="13:00" />				
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
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="14:00" />
							<input type="hidden" class="endTime" name="endTime" value="15:00" />
						</td>
						<td class="td_time ability tdTwo time15">
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="15:00" />
							<input type="hidden" class="endTime" name="endTime" value="16:00" />					
						</td>
						<td class="td_time ability tdTwo time16">
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="16:00" />
							<input type="hidden" class="endTime" name="endTime" value="17:00" />				
						</td>
						<td class="td_time ability tdTwo time17">
							<div><span class="whether"></span></div>
							<input type="hidden" class="startTime" name="startTime" value="17:00" />
							<input type="hidden" class="endTime" name="endTime" value="18:00" />				
						</td>								
					</tr>				
				</table> -->

			</div>
		</div>
		<div style="clear: both;"></div>
		</div>		
		
		<div id="info" style="z-index: 1;">
			<h4 style="margin: 33px 10px 20px 25px;">3. 예약하기</h4>
			<table id="info_tb">
				<tr id="info_tr">
					<th id="info_th">회의실</th>
					<td id="info_td">
						<c:if test="${empty fk_roomNumber}">
							<span id="roomName">-</span>
							<input type="hidden" id="fk_roomNumber" name="fk_roomNumber"/><!-- hidden -->
						</c:if>
						<c:if test="${not empty fk_roomNumber}">
							<span id="roomName"></span>
							<input type="hidden" id="fk_roomNumber" name="fk_roomNumber"/><!-- hidden -->
						</c:if>
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">예약일</th>
					<td id="info_td">
						<span id="rsvtDateH"></span>
						<input type="hidden" id="rsvtDate" name="rsvtDate"/><!-- hidden -->
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">시간</th>
					<td id="info_td">
						<span id="startTime"></span> - <span id="endTime"></span>
						<input type="hidden" id="startTimeH" name="startTimeH"><!-- hidden -->
						<input type="hidden" id="endTimeH" name="endTimeH"><!-- hidden -->						
					</td>
				</tr>
				<tr id="info_tr">		
					<th id="info_th">예약 신청자</th>
					<td id="info_td">
						<span id="rsvt_employee">${sessionScope.loginEmployee.employee_name} &lt;${sessionScope.loginEmployee.department_name}/${sessionScope.loginEmployee.position_name}&gt;</span>
						<input type="hidden" style="width:200px;" name="fk_employee_seq" value="${sessionScope.loginEmployee.employee_seq}" /><!-- hidden -->
					</td>
				</tr>
				<tr id="info_tr">
					<th id="info_th">예약 대표자</th>
					<td id="info_td">
						<div style="position: relative;">
							<input type="text" name="searchHead" id="searchHead" autocomplete="off" style="width:200px; text-align:center;" placeholder="성명 <부서명/직위>"/>
							<input type="hidden" name="head_seq" id="head_seq"/><!-- hidden -->
							<%-- === 검색어 입력 시 자동글 완성하기 1 === --%>
							<div id="displayList" style="position: absolute; border:solid 1px gray; border-top:0px; width:200px; height:70px; margin-left:51px; margin-top:0px; padding: 4px; overflow: auto; background-color: #e7f5fd;"></div>
						</div>
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