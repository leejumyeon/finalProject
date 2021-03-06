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

<script type="text/javascript">

	function click_messenger(){
		
		var sw=screen.width;  // 화면 가로길이
		var sh=screen.height; // 화면 세로길이
		var popw=500; 		  // 팝업창 가로길이 
		var poph=800; 		  // 팝업창 세로길이
		var xpos=(sw-popw)/2; 
		var ypos=(sh-poph)/2; 

		var popWin=window.open("<%=request.getContextPath()%>/messenger/popup.top","print","width="+popw+",height="+poph+",top="+ypos+",left="+xpos+",status=yes,scrollbars=yes");

	}
</script>

<div style="display: inline-block; width:150px; border:solid 0px red; float:left;">
	<a href="<%=ctxPath%>/main.top"><img src="<%=ctxPath%>/resources/images/logo2.png" style=" height:40px;"/></a>
</div>
<div style="display: inline-block; border:solid 0px blue; width:1130px;" align="center">
	<ul class="mynav" style="float:left;">
		<li class="dropdown"><a href="<%= ctxPath%>/notice.top">공지사항</a>
		</li>

		<li class="dropdown">
			<a href="<%= ctxPath%>/documentPayment.top">문서결재</a>
		</li>
		
		<li class="dropdown">
			<a class="dropdown-toggle" href="<%=ctxPath%>/mail/list.top?type=receive">메일</a>
		</li>

		<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"
			href="#">커뮤니티 <span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="<%= request.getContextPath()%>/list.top">앨범 게시판</a></li>
				<li><a href="<%= request.getContextPath()%>/freeboard/list.top">자유게시판</a></li>
			    <li><a href="<%= request.getContextPath()%>/clubRequest.top">동호회신청</a></li>
			</ul>
		</li>

		<li class="dropdown"><a href="<%= ctxPath%>/veiwCompany.top">회사정보 </a>
		</li>
	</ul>
	<ul class="mynav" style="float:right;">
		<li class="dropdown"><a href="<%= ctxPath%>/viewFullCalendar.top"><img src="<%=ctxPath%>/resources/mainPage_images/mypage.png" width="30px;" height="30px;"/></a>
		</li>	
		<li class="dropdown">
			<a href="#" onclick = "click_messenger()"><img src="<%=ctxPath%>/resources/msg_images/messenger.png" width="30px;" height="30px;"/></a>
		</li>
	</ul>
	
</div>
<div style="clear:both;"></div>