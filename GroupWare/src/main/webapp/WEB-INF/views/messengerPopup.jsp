<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" />
<style type="text/css">

/* -----------------bootstrap-------------------- */

	div#msgcontainer {
		border: solid 0px red;
		width: 400px;
		margin: 0 auto;
	}

	div.tab {
		display: inline-block;
		border: solid 1px gray;
	}

	.msgcontainer {
	  border: 2px solid #dedede;
	  background-color: #f1f1f1;
	  height: 90px;
	  border-radius: 5px;
	  padding: 10px;
	  margin: 10px 0;
	}
	
	.darker {
	  border-color: #ccc;
	  background-color: #ddd;
	}
	
	.msgcontainer::after {
	  content: "";
	  clear: both;
	  display: table;
	}
	
	.msgcontainer img {
	  float: left;
	  max-width: 60px;
	  width: 100%;
	  margin-right: 20px;
	  border-radius: 50%;
	}
	
	.msgcontainer img.right {
	  float: right;
	  margin-left: 20px;
	  margin-right:0;
	}
	
	.time-right {
	  float: right;
	  color: #aaa;
	}
	
	.time-left {
	  float: left;
	  color: #999;
	}

/* -----------------bootstrap-------------------- */

	table#myProfileTBL{width: 398px;}

	table#myProfileTBL td{
		border: solid 0px gray;
		border-top: solid 1px #e6e6e6;
		border-bottom: solid 1px #e6e6e6;
	}

	table#profileTBL{width: 398px;}

	table#profileTBL td{
		border: solid 0px gray;
		border-top: solid 1px #e6e6e6;
		border-bottom: solid 1px #e6e6e6;
	}

	input#content {
		width: 355px;
		height: 35px;
		border: solid 1px #e6e6e6;
	}
	
	#msgBtn {
		display: inline-block;
		border: solid 0px gray;
		border-style: none;
		color: white;
		background-color: #33adff;
		padding: 7px 7px;
		cursor: pointer;
	}

	#msglistTBL {width: 398px;}

	#msglistTBL td{
		border: solid 0px gray;
		border-top: solid 1px #e6e6e6;
		border-bottom: solid 1px #e6e6e6;
	}

	.msglist:hover {
		background-color: #e6f5ff;
	}
	
	.divText {
		padding-left: 5px;
	}
	
	.name {
		font-weight: bold;
	}
	
	.departmentName, .roomText {
		font-size: 9pt;
	}

	#profileTBL td, #myProfileTBL td, #msglistTBL td {
		padding: 10px;
	}

	.del { /* 대화방 삭제 */
		cursor: pointer;
	}

	.del:hover { /* 대화방 삭제 */
		-ms-transform: scale(1.1);
   		-webkit-transform: scale(1.1);
   		transform: scale(1.1);
	}
	
	#groupchatBtn {
		margin: 12px 0 0 5px;
		float: right;
    	border-style: none;
		color: white;
		background-color: #33adff;
		padding: 7px 7px;
		cursor: pointer;
	}
	
	#inviteBtn {
		float: right;
    	margin-top: 12px;
    	margin-left: 10px;
    	border-style: none;
		color: white;
		background-color: #33adff;
		padding: 7px 7px;
		cursor: pointer;
	}
	
	#resetBtn{
		float: right;
    	margin-top: 12px;
    	border-style: none;
		color: white;
		background-color: #33adff;
		padding: 7px 7px;
		cursor: pointer;
	}
	
	.hide {
		display: none;
	}
	
	
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

</head>
<body>
	<div id="msgcontainer">
  		<img src="/groupware/resources/msg_images/logo.png">

  		<ul class="nav nav-tabs">
	   		<li class="active"><a data-toggle="tab" href="#home" id=conversationPerson>대화상대</a></li>
	   		<li><a data-toggle="tab" href="#menu1" id=conversationList>대화목록</a></li>
	   		<li><a data-toggle="tab" href="#menu2" id=message>메시지</a></li>
  		</ul>

  		<div class="tab-content">
  			<!-- ===###profile start###=== -->
    		<div id="home" class="tab-pane fade in active"><br/>
      			<table id="myProfileTBL" style="margin-bottom: 20px;">
      				<tr>
      					<th style="color: #1aa3ff">내 프로필</th>
      				</tr>
      				<tr>
      					<td align="center" style="width: 60px;">
      						<img src="/groupware/resources/msg_images/user1.png" width="40px;" height="40px;" />
      					</td>
      					<td>
      						<div class="divText name">${sessionScope.loginEmployee.employee_name}</div>
      						<div class="divText departmentName">&nbsp;┕&nbsp;${sessionScope.loginEmployee.department_name}</div>
      					</td>
      				</tr>
      			</table>
      			
      			<table id="profileTBL">
      				<tr>
      					<th style="color: #1aa3ff; width: 60px;">대화 상대</th>		
      				</tr>
      				<tbody id="allEmpInfo">
      				
      				</tbody>
      			</table>
      			<button type="button" id="groupchatBtn">그룹채팅하기</button>
      			<button type="button" id="inviteBtn">초대하기</button>
      			<button type="button" id="resetBtn">취소</button>
      			<div style="clear: both;"></div>	
    		</div>
    		<!-- ===###profile end###=== -->
    		
    		
    		<!-- ===###msglist start###=== -->
    		<div id="menu1" class="tab-pane fade"><br/>
      			<table id="msglistTBL">
      				<tr>
      					<th style="color: #1aa3ff">대화목록</th>
      				</tr>
      				<tbody id="msglistTbody"></tbody>
      				<%-- 
      				<tr class="msglist">
      					<td align="center" style="width: 60px;"><img src="/groupware/resources/msg_images/user2.png" width="40px;" height="40px;" /></td>
      					<td style="cursor: pointer">
      						<div class="divText name">이순신</div>
      						<div class="divText roomText">안녕하세요?</div>
      					</td>
      					<td align="right" style="color: #aaa;">15:00</td>
      					<td><img class="del" onclick="roomDelete();" src="/groupware/resources/msg_images/trash.png" width="28px;" height="28px;" /></td>
      				</tr>
      				<tr class="msglist">
      					<td align="center" style="width: 60px;"><img src="/groupware/resources/msg_images/user2.png" width="40px;" height="40px;" /></td>
      					<td style="cursor: pointer">
      						<div class="divText name">엄정화</div>
      						<div class="divText roomText">오늘 하루도 고생했습니다.</div>
      					</td>
      					<td align="right" style="color: #aaa;">14:00</td>
      					<td><img class="del" onclick="roomDelete();" src="/groupware/resources/msg_images/trash.png" width="28px;" height="28px;" /></td>
      				</tr>
      				<tr class="msglist">
      					<td align="center" style="width: 60px;"><img src="/groupware/resources/msg_images/people.png" width="40px;" height="40px;" /></td>
      					<td style="cursor: pointer">
      						<div class="divText name">강감찬 외 5명</div>
      						<div class="divText roomText">집에 가고 싶다.</div>
      					</td>
      					<td align="right" style="color: #aaa;">13:00</td>
      					<td><img class="del" onclick="roomDelete();" src="/groupware/resources/msg_images/trash.png" width="28px;" height="28px;" /></td>
      				</tr>
      				--%>
      			</table>
    		</div>
    		<!-- ===###msglist end###=== -->
    		
    		
    		<!-- ===###msg start###=== -->
    		<div id="menu2" class="tab-pane fade">
    			<div id="contentList"></div>
    			<%-- 
				<div class="msgcontainer" style="border-color: #e6f5ff; background-color: white; border-radius: 10px;">
				  <figure>
				  	<figcaption style="padding-left: 9px;">이순신</figcaption>
				  	<img src="/groupware/resources/msg_images/user2.png" alt="Avatar" width="40px;" height="40px;" style="width: 100%">
				  </figure>
				  <p>Hello. How are you today?</p>
				  <span class="time-right">11:00</span> 
				</div>
				
				<div class="msgcontainer" style="border-color: #e6f5ff; background-color: #e6f5ff; border-radius: 10px;">
				  <p>Hey! I'm fine. Thanks for asking!</p>
				  <span class="time-left">11:01</span>
				</div>
				
				<div class="msgcontainer" style="border-color: #e6f5ff; background-color: white; border-radius: 10px;">
				  <figure>
				  	<figcaption style="padding-left: 9px;">이순신</figcaption>
				  	<img src="/groupware/resources/msg_images/user2.png" alt="Avatar" width="40px;" height="40px;" style="width: 100%">
				  </figure>
				  <p>Sweet! So, what do you wanna do today?</p>
				  <span class="time-right">11:02</span>
				</div>
				
				<div class="msgcontainer" style="border-color: #e6f5ff; background-color: #e6f5ff; border-radius: 10px;">
				  <p>Nah, I dunno. Play soccer.. or learn more coding perhaps?Nah, I dunno. Play soccer.. or learn more coding perhaps?Nah, I dunno. Play soccer.. or learn more coding perhaps?Nah, I dunno. Play soccer.. or learn more coding perhaps?Nah, I dunno. Play soccer.. or learn more coding perhaps?</p>
				  <span class="time-left">11:05</span>
				</div>
     			--%>
     			
     			<input type="text" name="content" id="content" /><div id="msgBtn">전송</div>
     			<input type="hidden" name="roomNumber" value="" id="roomNumber" />
     		
   			</div>
   			<!-- ===###msg end###=== -->
   			
  	    </div>
   </div>

	
</body>
<script type="text/javascript">

	var timerId = '';
	var timerId2 = '';
	
	$(document).ready(function(){
		
		var sEmployee_seq = "${sessionScope.loginEmployee.employee_seq}";
		
		$("#message").hide();
		
		// 초대하기 버튼 숨기기
		$("#inviteBtn").hide();
		
		// 취소 버튼 숨기기
		$("#resetBtn").hide();
		
		// 그룹채팅하기 버튼 클릭시
		$("#groupchatBtn").click(function(){
			$(".hide").removeClass("hide"); // 체크박스 보여주기
			$(this).hide(); // 그룹채팅하기 버튼 숨김
			$("#inviteBtn").show(); // 초대하기 버튼 보이기
			$("#resetBtn").show(); // 취소버튼 보이기
		});
		
		// 취소 버튼 클릭시
		$("#resetBtn").click(function(){
			$(".gCheck").addClass("hide"); // 체크박스 숨기기
			$("#inviteBtn").hide(); // 초대하기 버튼 숨기기
			$("#resetBtn").hide(); // 취소버튼 숨기기
			$("#groupchatBtn").show(); // 그룹채팅하기 버튼 보이기
		});
		
		// 초대하기 버튼 클릭시
		$("#inviteBtn").click(function(){
			
			var len = $("input:checkbox[name=groupChat]:checked").length;
			if(len == 0 ){
				alert("초대할 상대를 선택해주세요.");
				return;
			}
			else if(len == 1){
				alert("초대할 상대 2명이상 선택해주세요.");
				return;
			}
			
			var arr = new Array();
			var i = 0;
			$(".groupChat").each(function(index,item){
				if($(this).prop("checked") == true){
					console.log($(this).val());
					arr[i] = $(this).val();
					i++;
				}
			});
			
			var allEmpSeq = arr.join(",");
		//	console.log(allEmpSeq);
			
			// 그룹채팅 방 생성
			goGroupChattRoomCreate(allEmpSeq, sEmployee_seq);	
		
		});// end of $("#inviteBtn").click()--------------------
		
		// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
		allEmployeeView();

		// 대화목록 보여주기 
		timerId2 = setInterval(msgRoomListView, 1000);
		
		// 대화상대 클릭시 메시지 숨기기
		$("#conversationPerson").click(function(){
			$("#message").hide();
		});
		// 대화목록 클릭시 메시지 숨기기
		$("#conversationList").click(function(){
			$("#message").hide();
		});
		
		// 글을 쓰고 전송 버튼 클릭 시
		$("#msgBtn").click(function(){
			var content = $("#content").val();
			var roomNumber = $("#roomNumber").val()
		//	var sEmployee_seq = "${sessionScope.loginEmployee.employee_seq}";
			if(content != null && content.trim() != ''){
				goWriteMsg(roomNumber, sEmployee_seq, content);	
			}
			else{
				alert("글을 입력하세요");
			}
		});
		

		// 글을 쓰고 엔터 누를 시
		$("#content").keydown(function (key) {
            if (key.keyCode == 13) {
               $("#msgBtn").click();
            }
         });
		
		
		// 대화상대 클릭 시
		$("#conversationPerson").click(function(){
			clearInterval(timerId);
			$(".gCheck").addClass("hide"); // 체크박스 숨기기
			$("#inviteBtn").hide(); // 초대하기 버튼 숨기기
			$("#resetBtn").hide(); // 취소버튼 숨기기
			$("#groupchatBtn").show(); // 그룹채팅하기 버튼 보이기
			
			$(".groupChat").each(function(index,item){
				if($(this).prop("checked") == true){
					$(this).prop("checked",false);
				}
			});
			
		});
		
		// 대화목록 클릭 시
		$("#conversationList").click(function(){clearInterval(timerId);});
		
	});// end of $(document).ready()----------------------

	
	// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
	function allEmployeeView() {
		
		$.ajax({
				url:"/groupware/allEmployeeView.top",
				async: false,
				type:"GET",
				dataType:"JSON",
				success:function(json){
					
					if(json.length > 0 ){
						var html = "";
						$.each(json,function(index, item){
							
							html += "<tr>" +
										"<td style='width: 20px;' class='hide gCheck' ><input type='checkbox' name='groupChat' class='groupChat ' value='"+item.employee_seq+"' /></td>" +
			            				"<td align='center' style='width: 60px;'>" +
			            					"<img src='/groupware/resources/msg_images/user2.png' width='40px;' height='40px;' />" +
			            				"</td>" +
			            				"<td>" +
			            					"<div class='divText name'>"+item.employee_name+"("+item.position_name+")</div>" +
			            					"<div class='divText departmentName'>&nbsp;┕&nbsp;"+item.department_name+"</div>" +
			            				"</td>" +
			            				"<td align='right' style='padding: 10px;'>"+
			            					"<img src='/groupware/resources/msg_images/chat-box.png' width='30px;' height='30px;' style='cursor: pointer;' onclick='goChatting("+item.employee_seq+");' />" +
			            				"</td>" +
			            			"</tr>";
							
						});
						$("#allEmpInfo").html(html);
					}
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
		});
	}// end of function allEmployeeView()---------------------
	
	
	// 채팅 방 생성하기
	function goChatting(rEmployee_seq) {
		var sEmployee_seq = "${sessionScope.loginEmployee.employee_seq}";
		alert("보내는이 : " + sEmployee_seq + " 받는이 : " + rEmployee_seq);
		
		$.ajax({
			url:"/groupware/goChatting.top",
			async: false,
			data:{"rEmployee_seq":rEmployee_seq,"sEmployee_seq":sEmployee_seq},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				
				var roomNumber = json.roomNumber;
	
				$("#roomNumber").val(roomNumber);
				
				// 1초마다 채팅방 내용 읽어오기
				timerId = setInterval(contentView, 1000, roomNumber, sEmployee_seq);
			//	contentView(roomNumber, sEmployee_seq);
							
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});
			
	}
	
	
	// 채팅방 내용 읽어오기 
	function contentView(roomNumber, sEmployee_seq) {
	//	alert(roomNumber);
		$.ajax({
			url:"/groupware/contentView.top",
			async: false,
			data:{"roomNumber":roomNumber},
			type:"GET",
			dataType:"JSON",
			success:function(json){
				$("#contentList").html("");
				var html = "";
				if(json.length != 0){ // 채팅방이 이미 만들어져 있는 경우
					
					$.each(json,function(index, item){
						
						if(sEmployee_seq == item.fk_employee_seq) { // 로그인 한 사원이 채팅한 내용 인 경우
							
							html += "<div class='msgcontainer' style='border-color: #e6f5ff; background-color: #e6f5ff; border-radius: 10px;'>" +
									"	<p>"+item.content+"</p>" +
									" 	<span class='time-left'>"+item.regDate+"</span>" +
									"</div>";						
						}
						else { // 상대방이 채팅한 내용 인 경우
							
							html += "<div class='msgcontainer' style='border-color: #e6f5ff; background-color: white; border-radius: 10px;'>" +
									"	<figure>" +
									"		<figcaption style='padding-left: 9px;'>"+item.employee_name+"</figcaption>" +
									"		<img src='/groupware/resources/msg_images/user2.png' alt='Avatar' width='40px;' height='40px;' style='width: 100%'>" +
									"	</figure>" +
									"	<p>"+item.content+"</p>" +
									"	<span class='time-right'>"+item.regDate+"</span>" +
									"</div>";
						}	 
					});	
					$("#contentList").html(html);
				}
				else { // 채팅방을 새로 만든경우
					alert("대화내용이 없습니다.");
					clearInterval(timerId);
				}
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		$("#message").show();
		$("#message").click();

	}

	
	// 글을 쓰고 전송 버튼을 클릭했을 시
	function goWriteMsg(roomNumber, sEmployee_seq, content) {
	//	alert("전송:"+content);
		$.ajax({
			url:"/groupware/goWriteMsg.top",
			async: false,
			data:{"roomNumber":roomNumber,"sEmployee_seq":sEmployee_seq, "content":content},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				$("#content").val("");
				contentView(roomNumber, sEmployee_seq);
				msgRoomListView();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
	// 대화목록 보여주기 
	function msgRoomListView() {
		
		var employee_name = "${sessionScope.loginEmployee.employee_name}";
		
		$.ajax({
			url:"/groupware/msgRoomListView.top",
			async: false,
			type:"GET",
			dataType:"JSON",
			success:function(json){
				
				var html = "";
				$.each(json, function(index,item){
					
					if(item.cnt > 2){ // 그룹채팅인 경우
						html += "<tr class='msglist'>" +
									"<td align='center' style='width: 60px;'><img src='/groupware/resources/msg_images/user2.png' width='40px;' height='40px;' /></td>" +
									"<td style='cursor: pointer' onclick='goMsgWriteView("+item.roomNumber+","+${sessionScope.loginEmployee.employee_seq}+")'>" +
										"<div class='divText name'>" + item.employee_name + "외 "+Number(item.cnt-1)+"명 </div>" +
										"<div class='divText roomText'>"+item.content+"</div>" +
									"</td>" +
									"<td align='right' style='color: #aaa;'>"+item.regDate+"</td>" +
									"<td><img class='del' onclick='roomDelete("+item.roomNumber+");' src='/groupware/resources/msg_images/trash.png' width='28px;' height='28px;' /></td>" +
								"</tr>";
					}
					else{ // 1:1 채팅인 경우 또는 혼자
					
						html += "<tr class='msglist'>" +
									"<td align='center' style='width: 60px;'><img src='/groupware/resources/msg_images/user2.png' width='40px;' height='40px;' /></td>" +
									"<td style='cursor: pointer' onclick='goMsgWriteView("+item.roomNumber+","+${sessionScope.loginEmployee.employee_seq}+")'>" +
										"<div class='divText name'>"+item.employee_name+"</div>" +
										"<div class='divText roomText'>"+item.content+"</div>" +
									"</td>" +
									"<td align='right' style='color: #aaa;'>"+item.regDate+"</td>" +
									"<td><img class='del' onclick='roomDelete("+item.roomNumber+");' src='/groupware/resources/msg_images/trash.png' width='28px;' height='28px;' /></td>" +
								"</tr>";
					}		
				});
				
				$("#msglistTbody").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}
	
	
	// 대화목록에서  대화방 클릭시 대화창으로 이동하기
	function goMsgWriteView(roomNumber, sEmployee_seq) {
	//	alert("roomNumber : " + roomNumber + " sEmployee_seq : " + sEmployee_seq);
		$("#roomNumber").val(roomNumber);
		
		// 1초마다 채팅방 내용 읽어오기
		timerId = setInterval(contentView, 1000, roomNumber, sEmployee_seq);
	}
	
	
	// 채팅 방 삭제하기
	function roomDelete(roomNumber) {
		var sEmployee_seq = "${sessionScope.loginEmployee.employee_seq}";
		
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			$.ajax({
				
				url:"/groupware/roomDelete.top",
				async: false,
				data:{"roomNumber":roomNumber, "sEmployee_seq":sEmployee_seq},
				type:"POST",
				dataType:"JSON",
				success:function(json){
					if(json.n == 1){ // 삭제가 된 경우
						alert("삭제가 되었습니다");
						msgRoomListView(); // 대화목록 보여주기
					}
					else { // 삭제가 되지 않은 경우 
						alert("삭제가 안됬습니다.");
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});	
		}else{   //취소

		    return;

		}
		
	}
	
	
	// 그룹채팅 방 생성하기
	function goGroupChattRoomCreate(allEmpSeq, sEmployee_seq){
		
		$.ajax({
			url:"/groupware/goGroupChattRoomCreate.top",
			async: false,
			data:{"allEmpSeq":allEmpSeq, "sEmployee_seq":sEmployee_seq},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				
				if(json.roomNumber != -1 ){
				//	alert("방생성완료");
					
					var roomNumber = json.roomNumber;
					
					$("#roomNumber").val(roomNumber);
					
					// 1초마다 채팅방 내용 읽어오기
					timerId = setInterval(contentView, 1000, roomNumber, sEmployee_seq);
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	}
	
	
</script>
</html>