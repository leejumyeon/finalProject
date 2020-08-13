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
		if($("#mymessenger").hasClass("messengerClose")){
			$("#mymessenger").removeClass("messengerClose");
			$("#mymessenger").addClass("messengerOpen");
			
			window.resizeTo(1600,845);
			
		}
		else {
			$("#mymessenger").addClass("messengerClose");
			$("#mymessenger").removeClass("messengerOpen");
			
			window.resizeTo(1220,845);
		}
	}
</script>

<div style="display: inline-block; width:150px; border:solid 0px red; float:left;">
	<a href="<%=ctxPath%>/test.top"><img src="<%=ctxPath%>/resources/images/logo2.png" style=" height:40px;"/></a>
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
			
		<li class="dropdown"><a class=""
			data-toggle="dropdown" href="#">문서결재 <span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="<%=ctxPath%>/list.action">목록보기</a></li>
								
				<c:if test="${sessionScope.loginuser != null}">
					<li><a href="<%=ctxPath%>/add.action">글쓰기</a></li>
				</c:if>
				
				<li><a href="#">Submenu 1-3</a></li>
			</ul>
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
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#">마이페이지 <span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="<%=ctxPath%>/product/listProduct.action">제품목록</a></li>
			</ul>
		</li>	
		<li class="dropdown">
			<a href="#" onclick = "click_messenger()">메신저 아이콘 </a>
		</li>
	</ul>
	
</div>
<div style="clear:both;"></div>