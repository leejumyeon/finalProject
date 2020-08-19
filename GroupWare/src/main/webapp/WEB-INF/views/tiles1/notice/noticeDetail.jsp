<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<% String ctxPath = request.getContextPath(); %>

<meta charset="UTF-8">

<style type="text/css">

	#container {
		width: 1240px;
		margin: 0 auto;
	}	
	
	#in {
		width: 1000px;
		margin: 0 auto;
	}
	
	#detail {
		width: 750px;
		margin: 0 auto;
	}
	
	#detail, #detail th, #detail td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	
	#detail th{
		width: 120px;
		font-size: 11pt;
		background-color: #3399ff;
		height: 40px;
		color: white;
	}
	
	#detail td{
		padding: 10px;
		width: 468px;		
	}
	
	.detailbtn3 {
		border-radius: 0;
		border-style: none;
		background-color: #3399ff;
		padding: 5px;
		float: right;
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
	
	#post {
		margin-right: 30px;
		width: 750px;
		float: right;		
	}	
	
	.comunity {
		padding-top: 18px;
		width: 100px;
		height: 55px;
		margin-left: 30px;
		text-align: center;
		font-weight: bold;		
	}
	
	#side {
		float: left;
	}
	
	p {
		font-size: 11pt;
		font-weight: bold;
	}
	
	#content {
		max-height: 250px;
	}
	
	#commentContent {
		border: solid 1px gray;
		margin-top: 20px;
	}
	
	#commentWrite {
		float: right;
		color: white;
		font-size: 9pt;
    	padding: 5px;
		background-color: #3399ff;
		cursor: pointer;
	}
	
	.ChildCommentWrite {
		width: 58px;
		margin-left: 315px;
		color: white;
		font-size: 9pt;
    	padding: 5px;
		background-color: #3399ff;
		cursor: pointer;
	}
	
	.childCommentContent {
		border: solid 1px gray;
		margin-top: 20px;
	}
	
	#commentViewTbl{
		width: 730px;
	}
	    
	#commentViewTbl, #commentViewTbl tr, #commentViewTbl td {
		border: solid 1px #33adff;
		border-left-style: none;
		border-right-style: none;
		border-collapse: collapse;
	}
	
	/* 답글쓰기 */
	.childCommentBtn {
		cursor: pointer;
		color: gray;
		font-weight: bold;
		font-size: 9pt;
	}
	
	/* 취소 */
	.cancel {
		cursor: pointer;
		color: gray;
		font-weight: bold;
		font-size: 9pt;
	}
	
	#scroll {
		margin-top: 80px;
		width: 750px;
		max-height: 300px;
		overflow-y: scroll;
	}
	
	.move:hover {
		color: blue;
		font-weight: bold;
	}
	
</style>

	<div id="container">
		<div id="in">	
			<div id="side">
				<div class="comunity">공지사항</div>			
				<div class="sidebar2" onclick="javascript:location.href='<%= ctxPath%>/notice.top'">공지사항</div>
				<div class="sidebar2" onclick="javascript:location.href='<%= ctxPath%>">자누묻는질문</div>
			</div>	
		<div id="post">	
			<h3>공지사항 게시판</h3>
			<form>	
				<table id="detail">
					<tbody>
						<tr>
							<th style="text-align: center;">제목</th>
							<td colspan="3">${bvo.subject}</td>
						</tr>
						<tr>
							<th style="text-align: center;">작성자</th>
							<td>${bvo.employee_name}</td>
							<th style="text-align: center;">작성날짜</th>
							<td>${bvo.regDate}</td>
						</tr>
						
						<c:forEach var="attachvo" items="${attachvoList}">
						<tr>
							<th style="text-align: center;">첨부파일</th>
							<td><a href="<%= ctxPath%>/freeboard/download.top?fk_board_seq=${attachvo.fk_board_seq}&fileName=${attachvo.fileName}&orgFileName=${attachvo.orgFileName}">${attachvo.orgFileName}</a></td>
							<th style="text-align: center;">파일크기</th>
							<td>&nbsp;${attachvo.fileSize}byte</td>
						</tr>
						</c:forEach>
						
						<tr>
							<th colspan="5" style="text-align: center;">내용</th>					
						</tr>			
						<tr>
							<td colspan="5" style="width: 1178px;" id="content">${bvo.content}</td>
						</tr>	
					</tbody>				
				</table>
			</form>	
			<br/>
			<div>
				<p>이전글&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='?board_seq=${bvo.previousseq}'" style="cursor: pointer;">${bvo.previoussubject}</span></p>
			</div>
			<div>
				<p>다음글&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='?board_seq=${bvo.nextseq}'" style="cursor: pointer;">${bvo.nextsubject}</span></p>
			</div>
			<div id="button" >
			
				<c:if test="${not empty gobackURL}">
					<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href='<%= ctxPath%>/${gobackURL}'">목록보기</button>
				</c:if>
				<c:if test="${empty gobackURL}">
					<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href='<%= ctxPath%>/freeboard/list.top'">목록보기</button>
				</c:if>
				
			</div>
			
			<div style="clear: both;"></div>
			
		</div>
		</div>
		
		<form name="delFrm">
			<input type="hidden" name="board_seq" value="${bvo.board_seq}" />
		</form>
		
	</div>	