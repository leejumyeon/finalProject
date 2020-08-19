<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27. tile1 중 header 페이지 만들기  ======= --%>
<%
	String ctxPath = request.getContextPath();

	// === #165. (웹채팅관련3) === 
	// === 서버 IP 주소 알아오기  (사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) === //
	InetAddress inet = InetAddress.getLocalHost(); 
	String serverIP = inet.getHostAddress();
	
	//System.out.println("serverIP : " + serverIP);
	// serverIP : 192.168.56.50
	
	// serverIP = "192.168.50.47"; 만약 사용중인 ip주소가 고정ip라면  IP주소를 직접입력해주면 된다.	/* 내 IP */
	
	// === 서버 포트번호 알아오기   ===
	int portnumber = request.getServerPort();
	//System.out.println("portnumber : " + portnumber);
	// portnumber : 9090
	
	String serverName = "http://"+serverIP+":"+portnumber; 
	//System.out.println("serverName : " + serverName);
	//serverName : http://192.168.50.65:9090 
%>

<style>

	.snip1537 {
	  background-color: #ff4d4d;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 22px;
	  line-height: 1em;
	  margin: 15px 40px;
	  outline: none;
	  padding: 12px 40px 10px;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.snip1537:before,
	.snip1537:after {
	  border-color: transparent;
	  -webkit-transition: all 0.25s;
	  transition: all 0.25s;
	  border-style: solid;
	  border-width: 0;
	  content: "";
	  height: 24px;
	  position: absolute;
	  width: 24px;
	}
	
	.snip1537:before {
	  border-color: #ff4d4d;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1537:after {
	  border-bottom-width: 2px;
	  border-color: #ff4d4d;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1537:hover {
	  background-color: #ff4d4d;
	}
	
	.snip1537:hover:before,
	.snip1537:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		firstAttendance();
		
		$("#offButton").css("display","none");
		
		setTimeout(function() {
			
			var todayDate = new Date();
			
			var hours = todayDate.getHours();
			
			if(hours == '18' && sessionStorage.getItem("offTime") == null) {
				
				$("#offButton").css("display","");
				
				sessionStorage.setItem("offTime", "1");
				
				window.open("<%= request.getContextPath()%>/getOffTime.top", "퇴근하기", "width = 450, height= 200, top=350, left=500")
				
			}
			
		}, 300000)
	});
	
	function firstAttendance() {
			
		$.ajax({
			url:"<%= request.getContextPath()%>/getIsAttendance.top",
			type:"GET",
			dataType:"JSON",
			success: function(json) {
				
				if(json.employee_seq == null) {
					
					window.open("<%= request.getContextPath()%>/getOnTime.top", "출근하기", "width = 450, height= 200, top=350, left=500")
				}
			},
			error: function(e) {
				
			}
		});
	}
	
	function click_messenger(){
		
		var sw=screen.width;  // 화면 가로길이
		var sh=screen.height; // 화면 세로길이
		var popw=500; 		  // 팝업창 가로길이 
		var poph=800; 		  // 팝업창 세로길이
		var xpos=(sw-popw)/2; 
		var ypos=(sh-poph)/2; 

		var popWin=window.open("<%=request.getContextPath()%>/messenger/popup.top","print","width="+popw+",height="+poph+",top="+ypos+",left="+xpos+",status=yes,scrollbars=yes");
		console.log()
		/* if($("#mymessenger").hasClass("messengerClose")){
			$("#mymessenger").removeClass("messengerClose");
			$("#mymessenger").addClass("messengerOpen");
			
			window.resizeTo(1600,845);
			
		}
		else {
			$("#mymessenger").addClass("messengerClose");
			$("#mymessenger").removeClass("messengerOpen");
			
			window.resizeTo(1220,845);
		}
		console.log($("#mymessenger").prop("class")); */
		<%-- $.ajax({
			url:"<%=request.getContextPath()%>/messenger/open.top",
			data:{"messengerStatus":$("#mymessenger").prop("class")},
			type:"get",
			dataType:"JSON",
			success:function(json){
				console.log("세션업");
			},
			error:function(e){
				
			}
		}); --%>
	}
</script>

<div style="display: inline-block; width:150px; border:solid 0px red; float:left;">
	<a href="<%=ctxPath%>/main.top"><img src="<%=ctxPath%>/resources/images/logo2.png" style=" height:40px;"/></a>
</div>
<div style="display: inline-block; border:solid 0px blue; width:1130px;" align="center">
	<ul class="mynav" style="float:left;">
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#">사내공지<span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="<%=ctxPath%>/index.action">공지사항</a></li>
				<li><a href="<%=ctxPath%>/deliciousStore.action">자주하는 질문</a></li>
			</ul>
		</li>
			
		<li class="dropdown">
			<a href="<%= ctxPath%>/documentPayment.top">문서결재</a>
		</li>
		
		<li class="dropdown">
			<a class="dropdown-toggle" href="<%=ctxPath%>/mail/list.top?type=receive">메일</a>
		</li>
		
		
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#">커뮤니티 <span class="caret"></span></a>
			<ul class="dropdown-menu">
			    <li><a href="<%=ctxPath%>/product/addProduct.action">제품등록</a></li>
				<li><a href="<%=ctxPath%>/product/storeProduct.action">제품입고</a></li>
			</ul>
		</li>
		
		
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#">회사정보 <span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="<%=ctxPath%>/emp/empList.action">직원목록</a></li>
				<li><a href="<%=ctxPath%>/emp/chart.action">통계차트</a></li>
			</ul>
		</li>
	</ul>
	<ul class="mynav" style="float:right;">
		<li class="dropdown" id="offButton">
			<button class="snip1537" onclick="click_off()">퇴근하기</button>
		</li>
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="">마이페이지 <span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="<%=ctxPath%>/viewFullCalendar.top">제품목록</a></li>
			</ul>
		</li>
		<li class="dropdown">
			<div onclick = "click_messenger();">메신저 아이콘 </div>
		</li>
	</ul>
	
</div>
<div style="clear:both;"></div>