<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.managerBtn{
		display: inline-block; 
		text-align: center;
		width: 100px;
		border:solid 1px black;
		padding : 10px 0;
		margin-left:10px;
	}
</style>

<div>
	<div style="display: inline-block;">
	<h3>휴지통</h3>
	</div>
</div>
<div>
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
	</form>
	<form name="workFrm">
		<table class="table" style="text-align: center;">
			<tr>
				<td><input type="checkbox" name="allCheck" /></td>
				<td>신청자</td>
				<td>문서종류</td>
				<td>제목</td>
				<td>최종결재자</td>
				<td>결재날짜</td>
				<td>결재상태</td>
				<td colspan="2">작업</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="selectCheck" /></td>
				<td>신청자</td>
				<td>문서종류</td>
				<td>제목</td>
				<td>최종결재자</td>
				<td>결재날짜</td>
				<td>결재상태</td>
				<td>복구</td>
				<td>영구삭제</td>
			</tr>
		</table>
		<div align="right">
			<div class="managerBtn">선택 복구</div>
			<div class="managerBtn">선택 영구삭제</div>
		</div>
	</form>
</div>