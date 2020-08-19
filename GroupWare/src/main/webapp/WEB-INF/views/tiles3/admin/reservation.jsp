<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	.hide {
		display: none;
	}

</style>

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css"/>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

<script type="text/javascript">  
	data={};
	$(document).ready(function(){		
			
		waitingReservation();	
		resultReservation();		
		
		// 아코디언
		$(".panel").addClass("hide");
		
		$(document).on("click", ".accordion", function(){
			
			var $targetNext = $(this).next();
		//	var targetNextDisplayProperty = $targetNext.css('display');
			
			if($targetNext.hasClass('hide')) {
				$(".panel").addClass("hide");
				$targetNext.removeClass("hide");
			}		
			else {
				$targetNext.addClass("hide");
			}
			
		});		
		
		
		$("#wPlaceType").bind("change", function(){
			waitingReservation();
		});
		
		$("#resultType").bind("change", function(){
			resultReservation();
		});
		
		$("#rPlaceType").bind("change", function(){
			resultReservation();
		});
		
		
		var reservation_seq = "";
		// 승인 버튼 눌렀을 때
		$(document).on("click", "#approve_btn", function(event){	
			if (confirm("정말 승인하시겠습니까?") == true){		// 확인	
				
				reservation_seq = $(this).parent().parent().prev().children(".rsvt_seq").text();
				$("#reservation_seq").val(reservation_seq);
				var employee_seq = $(this).parent().find("input[name=employee_seq]").val();
				var employee_name = $(this).parent().find("input[name=employee_name]").val();
				var position_name = $(this).parent().find("input[name=position_name]").val();
				var department_name = $(this).parent().find("input[name=department_name]").val();
				var roomName = $(this).parent().find("input[name=roomName]").val();
				var startDate = $(this).parent().find("input[name=startDate]").val();
				var endDate = $(this).parent().find("input[name=endDate]").val();
				
				console.log(employee_seq);
				
				 $.ajax({
					url:"<%=request.getContextPath()%>/mail/requestMail.top",
					data:{"type":"reservation", "value":"true", "receive":employee_seq
						  ,"receive_name":employee_name
						  ,"receive_position":position_name
						  ,"receive_department":department_name
						  ,"receive_room":roomName
						  ,"startDate":startDate
						  ,"endDate":endDate},
					type:"get",
					dataType:"JSON",
					success:function(json){
						if(json.result == true){
							var frm = document.btnFrm;
							frm.method = "POST";
							frm.action = "<%= request.getContextPath()%>/manager/approveRoom.top";
							frm.submit();
						}
						 
					},
					error:function(e){
						
					}
				});					
			}
			
			
			else{		//취소
				return false;
			} 
		});
		
		
		// 반려 버튼 눌렀을 때
		$(document).on("click", "#reject_btn", function(){
			reservation_seq = $(this).parent().parent().prev().children(".rsvt_seq").text();
			$("#reservation_seq").val(reservation_seq);
			var employee_seq = $(this).parent().find("input[name=employee_seq]").val();
			var employee_name = $(this).parent().find("input[name=employee_name]").val();
			var position_name = $(this).parent().find("input[name=position_name]").val();
			var department_name = $(this).parent().find("input[name=department_name]").val();
			var roomName = $(this).parent().find("input[name=roomName]").val();
			var startDate = $(this).parent().find("input[name=startDate]").val();
			var endDate = $(this).parent().find("input[name=endDate]").val();
			
			data = {"type":"reservation", "value":"false", "receive":employee_seq,"receive_name":employee_name,
					"receive_position":position_name, "receive_department":department_name, "receive_room":roomName,
					"startDate":startDate, "endDate":endDate};
			
			if (confirm("정말 반려하시겠습니까?") == true){		// 확인
				goReject($(this), data);
			}
			else{		//취소
				return false;
			}
		});
		
	}); //end of $(document).ready(function(){})---------------------------------
	
	
	// === 예약 신청 현황 조회(관리자)(Ajax) === //
	function waitingReservation() {
		$.ajax({			
			url:"<%=request.getContextPath()%>/manager/waitingReservation.top",
			type:"GET",
			data:{wPlaceType:$("#wPlaceType").val()},
			dataType : "JSON",
			success : function(json) {
				var html = "";
				if (json.length > 0) {
					$.each(json, function(index, item) {
						html += "<tr class='accordion' style='cursor: pointer;'>";																					
						html += 	"<td class='rsvt_seq'>" + item.reservation_seq + "</td>";
						html += 	"<td>" + item.employee_name + "</td>";
						html += 	"<td>" + item.roomName + "</td>";
						html += 	"<td>" + item.startDate + "</td>";
						html += 	"<td>" + item.endDate + "</td>";
						html += 	"<td>" + item.memberCount + "</td>";
						html += 	"<td>" + item.regDate + "</td>";
						html += "</tr>";	
						html += "<tr class='panel hide'>";	
						html += 	"<td colspan='7' style='text-align: left;'>" +
										"신청자 : " + item.employee_name + " &lt;" + item.department_name + "/" + item.position_name + "&gt;<br/>" +
										"대표자 : " + item.head_name + " &lt;" + item.head_department + "/" + item.head_position + "&gt;<br/>" +
										"사유 : " + item.reason + "<br/>" +
										"<input type='button' id='approve_btn' value='승인'/>&nbsp;&nbsp;" +
										"<input type='button' id='reject_btn' value='반려'/>" +
										"<input type='hidden' name='employee_seq' value='"+item.fk_employee_seq+"' />"+
										"<input type='hidden' name='employee_name' value='"+item.employee_name+"' />"+
										"<input type='hidden' name='department_name' value='"+item.department_name+"' />"+
										"<input type='hidden' name='position_name' value='"+item.position_name+"' />"+
										"<input type='hidden' name='roomName' value='"+item.roomName+"' />"+
										"<input type='hidden' name='startDate' value='"+item.startDate+"' />"+
										"<input type='hidden' name='endDate' value='"+item.endDate+"' />"+
									"</td>";		
						html += "</tr>";									
					});

				} else {
					html += "<tr>";
					html += 	"<td colspan='7' style='text-align: center;'>예약 신청 내역이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("#waitingDisplay").html(html);
				
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "+ request.responseText + "\n" + "error: "+ error);
			}
		});
	}
	
	
	// 반려 메일 전송 팝업 띄우기
	function goReject(elem, obj) {
		var sw=screen.width;  // 화면 가로길이
		var sh=screen.height; // 화면 세로길이
		var popw=322; 		  // 팝업창 가로길이 
		var poph=300; 		  // 팝업창 세로길이
		var xpos=(sw-popw)/2; 
		var ypos=(sh-poph)/2; 

		var popWin=window.open("<%=request.getContextPath()%>/reservation/popup.top","print","width="+popw+",height="+poph+",top="+ypos+",left="+xpos+",status=yes,scrollbars=yes"); 				
		// 일단 내용이 없는 팝업창을 만든다
		
			
				
	}// end of function goPrint(title)-----------------------------------
	
	
	// === 예약 결과 현황 조회(관리자)(Ajax) === //
	function resultReservation() {
		$.ajax({			
			url:"<%=request.getContextPath()%>/manager/resultReservation.top",
			type:"GET",
			data:{resultType:$("#resultType").val(),
				  rPlaceType:$("#rPlaceType").val()},
			dataType : "JSON",			
			success : function(json) {
				var html = "";
				if (json.length > 0) {
					$.each(json, function(index, item) {
						html += "<tr style='cursor: pointer;'>";																					
						html += 	"<td>" + item.reservation_seq + "</td>";
						html += 	"<td>" + item.employee_name + "</td>";
						html += 	"<td>" + item.head_name + "</td>";
						html += 	"<td>" + item.roomName + "</td>";
						html += 	"<td>" + item.startDate + "</td>";
						html += 	"<td>" + item.endDate + "</td>";
						html += 	"<td>" + item.memberCount + "</td>";
						html += 	"<td>" + item.regDate + "</td>";
						html += 	"<td>";						
						if(item.status == 1) {
							html += "승인완료</td>";
						}
						else if(item.status == 2) {
							html += "반려</td>";
						}
						html += "</tr>";										
					});

				} else {
					html += "<tr>";
					html += 	"<td colspan='9' style='text-align: center;'>예약 결과 내역이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("#resultDisplay").html(html);
				
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "+ request.responseText + "\n" + "error: "+ error);
			}
		});
	}	
	
	function rejectMail(subject, reason){
		console.log(subject, reason);
		console.log(data);
		data.subject = subject;
		data.reason = reason;
		
		 $.ajax({
				url:"<%=request.getContextPath()%>/mail/requestMail.top",
				data:data,
				type:"get",
				dataType:"JSON",
				success:function(json){
					if(json.result == true){
						var frm = document.btnFrm;
						frm.method = "POST";
						frm.action = "<%= request.getContextPath()%>/manager/rejectRoom.top";
						frm.submit();
					}
					 
				},
				error:function(e){
					
				}
			});					
	}
	
</script>    
    
<h3>예약관리</h3>
<br/>
<div id="content_area">
	<div class ="table_title" style="margin-top:5px;">
		<div class="searchArea" style="display:inline-block; float:right;">
			장소분류 : 
			<select name="wPlaceType" id="wPlaceType" style="height: 25px;">
				<option value="all">전체</option>
				<option value="small">소회의실</option>
				<option value="medium">중회의실</option>
				<option value="big">대회의실</option>
			</select>
		</div>
		<h4 style="display: inline-block;">● 예약 신청 현황</h4>
	</div>
	<div style="clear:both;"></div>
	
	<div style="height: 270px; overflow-y: scroll;">
	<form name='btnFrm'>
	<input type='hidden' id='reservation_seq' name='reservation_seq'/>
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
	</form>
	</div>
	
	<br/><br/>
	
	<div class ="table_title" style="margin-top:5px;">
		<div class="searchArea" style="display:inline-block; float:right;">
			승인상태 : 
			<select name="resultType" id="resultType" style="height: 25px;">
				<option value="all">전체</option>
				<option value="approval">승인</option>
				<option value="disapproval">반려</option>
			</select>
			&nbsp;
			장소분류 : 
			<select name="rPlaceType" id="rPlaceType" style="height: 25px;">
				<option value="all">전체</option>
				<option value="small">소회의실</option>
				<option value="medium">중회의실</option>
				<option value="big">대회의실</option>
			</select>
		</div>
		<h4 style="display: inline-block;">● 예약 결과 현황</h4>
	</div>
	<div style="clear:both;"></div>
	
	<div style="height: 270px; overflow-y: scroll;">
	<table class="resultTb table">
		<thead>
			<tr>
				<th>예약번호</th>
				<th>신청자</th>
				<th>대표자</th>
				<th>장소</th>
				<th>시작시간</th>
				<th>종료시간</th>
				<th>인원수</th>
				<th>신청날짜</th>
				<th>승인상태</th>
			</tr>
		</thead>
		<tbody id="resultDisplay">		
		</tbody>
	</table>
	</div>
</div>