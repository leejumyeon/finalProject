<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	#container {
		width: 1240px;
		margin: 0 auto;
	}
	
	#in {
		width: 1000px;
		margin: 0 auto;
	}
	
	#abl, #abl th, #abl td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	
	#abl th {
		font-size: 11pt;
		background-color: #3399ff;
		color: white;
	}
	
	#abl th, #abl td {
		height: 27px;
	}
	
	#searchType {
		height: 28px;
		vertical-align: middle;
	}
	
	#searchWord {
		vertical-align: middle;
		height: 28px;
	}
	
	#btnS, #btnW  {
		height: 28px;
		vertical-align: middle;
		color: white;
		background-color: #3399ff;
		border: none;
	}
	
	.sidebar2 {
		border: 1px solid white;
		width: 100px;
		height: 52px;
		margin-left: 30px;
		cursor: pointer;
		padding-top: 15px;
		text-align: center;
		background-color: #3399ff;		
		color: white;
	}
		
	.comunity {
		padding-top: 18px;
		width: 100px;
		height: 55px;
		margin-left: 30px;
		text-align: center;
		font-weight: bold;		
	}
	
	#post {
		margin-right: 30px;
		width: 750px;
		float: right;		
	}
		
	#btnS {
		margin-left: -44px;
	}
	
	#btnW {
		float: right;
		width: 70px;
	}
	
	#side {
		float: left;
		
	}
	
	#pageBarUl {
		margin-top: 11px;
	}
	
</style>

<script type="text/javascript">
	
	
	$(document).ready(function(){
		
		$("#searchWord").keydown(function(event) {
			 if(event.keyCode == 13) {
				 // 엔터를 했을 경우
				 goSearch();
			 }
		});
		
		
		if(${paraMap != null}) {
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		}
		
		
	});
	
	
	// 게시글 상세보기 페이지로 이동
	function goDetailView(board_seq) {
		
	//	alert(board_seq);
		
		var frm = document.detailViewFrm;
		frm.board_seq.value = board_seq;
		
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/detailNotice.top";
		frm.submit();
		
	}
	
	// 검색어에 따른 글 보여주기
	function goSearch() {
		
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/notice.top";
		frm.submit();
		
	}
	
</script>
	<div id="container">
		<div id="in">
		<div id="side">
			<div class="comunity">사내공지</div>
			<div class="sidebar2" onclick="javascript:location.href='<%= ctxPath%>/notice.top'">공지사항</div>
		</div>						
			<div id="post">	
				<h3>공지사항</h3>
				<form name="searchFrm">
					<select name="searchType" id="searchType">
						<option value="all">전체</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="employee_name">작성자</option>					
					</select>	
					<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" />
					<button style="color: white;" id="btnS" type="button" onclick="goSearch()">검색</button>	
				</form>
				<div style="margin-top: 15px;">
					<table id="abl">
						<tbody>
							<tr>
								<th style="height: 40px; text-align: center;" align="center" width="80px">글번호</th>
								<th style="text-align: center;" width="80px">작성자</th>
								<th style="text-align: center;" width="360px">제목</th>
								<th style="text-align: center;" width="155px">작성날짜</th>
								<th style="text-align: center;" width="80px">조회수</th>
							</tr> 
								<!-- td 들어갈곳 -->
							<c:forEach var="bvo" items="${boardList}" varStatus="status">	
							<tr>
								<td style="height: 40px; text-align: center;" align="center" width="80px">${status.count}</td>
								<td style="text-align: center;" width="80px">${bvo.employee_name}</td>
								
								<c:if test="${bvo.commentCnt > 0}">
								<td style="text-align: center; cursor: pointer;" width="360px" onclick="goDetailView('${bvo.board_seq}');">${bvo.subject}[<span style="font-family: italic; font-size: 9pt; color: red; font-weight: bold;">${bvo.commentCnt}</span>]</td>
								</c:if>
								<c:if test="${bvo.commentCnt == 0}">
								<td style="text-align: center; cursor: pointer;" width="360px" onclick="goDetailView('${bvo.board_seq}');">${bvo.subject}</td>
								</c:if>
								
								<td style="text-align: center;" width="155px">${bvo.regDate}</td>
								<td style="text-align: center;" width="80px">${bvo.readCnt}</td>
						   </tr>
						   </c:forEach>			
						   		
						</tbody>					
					</table>
					<div id="pagebar" style="text-align: center;">
						<!-- 페이지바들어갈곳 -->
						${pageBar}
					</div>
					<div style="clear:both"></div>
				</div>
			</div>
		</div>
		
		<form name="detailViewFrm">
			<input type="hidden" name="board_seq"/>
			<input type="hidden" name="gobackURL" value="${gobackURL}" />
		</form>
		
	</div>