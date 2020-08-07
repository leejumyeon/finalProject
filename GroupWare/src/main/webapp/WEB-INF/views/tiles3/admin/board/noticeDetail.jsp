<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.managerBtn{
		border:solid 1px black;
		padding: 10px 15px;
		cursor: pointer;
		float:right;
		margin-right:10px;
	}
	
	.noticeTable, .noticeTable td{
		border:solid 1px black;
		border-collapse: collapse;
		margin:0;
	}
	
	.tbl_title{
		width: 40%;
		text-align: center;
	}
</style>    
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-공지사항 상세-</h4>
	</div>
	
	<div style="margin-top: 20px; border:solid 1px blue;">
		<table class="table noticeTable">
			<tr>
				<td>제목</td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td></td>
				<td>조회수</td>
				<td></td>
			</tr>
			<tr>
				<td style="vertical-align: top;">첨부파일</td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<td colspan="4">내용</td>
			</tr>
		</table>
		<div>
			<span class="managerBtn" style="float:left">목록 돌아가기</span>
			<span class="managerBtn">삭제</span>
			<span class="managerBtn">수정</span>
		</div>
	</div>
</div>