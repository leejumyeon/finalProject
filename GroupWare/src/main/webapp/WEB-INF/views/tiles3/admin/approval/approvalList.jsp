<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<div style="display: inline-block;">
	<h3>결재현황</h3>
	<h4 style="text-align: center;">-목록-</h4>
	</div>
</div>

<form name="searchFrm">
	<select name="documentType">
		<option>==문서종류==</option>
		<option>휴가신청</option>
		<option>출장신청</option>
		<option>매출</option>
		<option>비품구매</option>
		<option>프로젝트 시작</option>
		<option>프로젝트 중단</option>
		<option>프로젝트 완료</option>
		<option>퇴사</option>
		<option>인사고과</option>
		<option>동호회 신청</option>
		<option>동호회 가입</option>
		<option>동호회 해체</option>
	</select>
	
	<!-- 결재 상태 select로 검색 -->
	<select name="approveStatus">
		<option>==결재상태==</option>
		<option>결재완료</option>
		<option>결재중</option>
		<option>결재신청</option>
	</select>
	
	<div style="display: inline-block; float:right;">
		<input type="text" name="searchWord" />
		<select name="searchType">
			<option>전체</option>
			<option>결재자</option>
			<option>신청자</option>
			<option>제목</option>
			<option>내용</option>
		</select>
	</div>
</form>
<div style="clear:both;"></div>
<div style="margin-top: 15px;">
	<table class="table">
		<tr>
			<td>신청자</td>
			<td>신청날짜</td>
			<td>결재종류</td>
			<td>제목</td>
			<td>결재상태</td>
		</tr>
	</table>
</div>