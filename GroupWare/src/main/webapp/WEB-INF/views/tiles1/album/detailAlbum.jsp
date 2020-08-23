<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
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
	
</style>
<script type="text/javascript">

	function deleteAlbum(seq) {
		
		if(confirm("정말 삭제을 완료하시겠습니까?") == true) {

			location.herf="<%= request.getContextPath()%>/deleteAlbum.top?album_seq=" + seq;

		}
		else {
			
			return false;
		}
	}
</script>
	<div id="container">
		<div id="in">	
			<div id="side">
				<div class="comunity">커뮤니티</div>			
				<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/list.top'">앨범</div>
				<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/freeboard/list.top'">자유게시판</div>
				<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/clubRequest.top'">동호회신청</div>
			</div>	
		<div id="post">	
			<h3>앨범게시판</h3>
			<form>	
				<table id="detail">
					<tbody>
						<tr>
							<th style="text-align: center;">제목</th>
							<td colspan="3">${detailAlbum.subject}</td>
						</tr>
						<tr>
							<th style="text-align: center;">작성자</th>
							<td>${detailAlbum.employee_name}</td>
							<th style="text-align: center;">작성날짜</th>
							<td>${detailAlbum.regDate}</td>
						</tr>
						<tr>
							<th colspan="5" style="text-align: center;">내용</th>					
						</tr>			
						<tr>
							<td colspan="5" style="width: 1178px;" id="content">
								${detailAlbum.content}
							</td>
						</tr>	
					</tbody>
				</table>
			</form>	
			<br/>
			<div>
				이전글&nbsp;:&nbsp;
				<span class="move" onclick="javascript:location.href='<%= request.getContextPath()%>/detailAlbum.top?album_seq=${detailAlbum.previousseq}'">${detailAlbum.previoussubject}</span>
			</div>
			<div>
				다음글&nbsp;:&nbsp;
				<span class="move" onclick="javascript:location.href='<%= request.getContextPath()%>/detailAlbum.top?album_seq=${detailAlbum.nextseq}'">${detailAlbum.nextsubject}</span>
			</div>
			<div id="button" >
				<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href='history.back()'">목록보기</button>
				<c:if test="${detailAlbum.fk_employee_seq == sessionScope.loginEmployee.employee_seq}">
					<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/updateAlbum.top?album_seq=${detailAlbum.album_seq}'">수정</button>
					<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="deleteAlbum('${detailAlbum.album_seq}')">삭제</button>
				</c:if>
			</div>
			</div>
		</div>
	</div>	