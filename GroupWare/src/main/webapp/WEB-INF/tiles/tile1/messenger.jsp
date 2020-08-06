<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<% String ctxPath = request.getContextPath(); %>

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
		padding: 3px;
	}

	.del { /* 대화방 삭제 */
		cursor: pointer;
	}

	.del:hover { /* 대화방 삭제 */
		-ms-transform: scale(1.1);
   		-webkit-transform: scale(1.1);
   		transform: scale(1.1);
	}

</style>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#message").hide();
	
		// 모든사원정보 불러오기
/* 		$.ajax({
			
			url:"/groupware/allEmployeeView.top",
			type:"GET",
			dataType:"JSON",
			success:function(json){
				
			},
			
			
		}); */
		
		// 대화상대 클릭시 메시지 숨기기
		$("#conversationPerson").click(function(){
			$("#message").hide();
		});
		// 대화목록 클릭시 메시지 숨기기
		$("#conversationList").click(function(){
			$("#message").hide();
		});
		
		
		
	});// end of $(document).ready()----------------------

	
	// 채팅 방 삭제하기
	function roomDelete() {
		
		alert("삭제하시겠습니까?");
		
	}
	
	
	// 채팅 방 생성과 채팅하기 
	function goChatting() {
		alert("채팅하기");
		
		
		
		$("#message").click();
		$("#message").show();
	}
	
</script>

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
      					<th style="color: #1aa3ff">대화 상대</th>			
      				</tr>
      				<tr>
      					<td align="center" style="width: 60px;">
      						<img src="/groupware/resources/msg_images/user2.png" width="40px;" height="40px;" />
      					</td>
      					<td>
      						<div class="divText name">이순신</div>
      						<div class="divText departmentName">&nbsp;┕&nbsp;개발팀</div>
      					</td>
      					<td align="right" style="padding: 10px;"><img src="/groupware/resources/msg_images/chat-box.png" width="30px;" height="30px;" style="cursor: pointer;" onclick="goChatting();" /></td>
      				</tr>
      				<tr>
      					<td align="center" style="width: 60px;">
      						<img src="/groupware/resources/msg_images/user2.png" width="40px;" height="40px;" />
      					</td>
      					<td>
      						<div class="divText name">엄정화</div>
      						<div class="divText departmentName">&nbsp;┕&nbsp;경영팀</div>
      					</td>
      					<td align="right" style="padding: 10px;"><img src="/groupware/resources/msg_images/chat-box.png" width="30px;" height="30px;" style="cursor: pointer;" onclick="goChatting();" /></td>
      				</tr>
      			</table>	
    		</div>
    		<!-- ===###profile end###=== -->
    		
    		
    		<!-- ===###msglist start###=== -->
    		<div id="menu1" class="tab-pane fade"><br/>
      			<table id="msglistTBL">
      				<tr>
      					<th style="color: #1aa3ff">대화목록</th>
      				</tr>
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
      			</table>
    		</div>
    		<!-- ===###msglist end###=== -->
    		
    		
    		<!-- ===###msg start###=== -->
    		<div id="menu2" class="tab-pane fade">
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
				  <p>Nah, I dunno. Play soccer.. or learn more coding perhaps?</p>
				  <span class="time-left">11:05</span>
				</div>
     			
     			<form name="sendMsg">
     				<input type="text" name="content" id="content" /><div id="msgBtn">전송</div>
     				<input type="hidden" name="" value="" />
     			</form>
     			
   			</div>
   			<!-- ===###msg end###=== -->
   			
  	    </div>
   </div>
