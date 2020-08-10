<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	#detailArea{
		margin-left:5px;
	}

	.detailTable, .detailTable td{
		border:solid 1px black;
		border-collapse: collapse;
	}
	
	#contentArea{
		min-height: 100px;
		max-height: 500px;
		border:solid 1px black;
		text-align: left;
		margin-top: 5px;
	}
	
	.detailTable, #contentArea, #otherArea{
		width:80%;
	}
	
	.managerBtn{
		display:inline-block;
		width: 80px;
		padding: 15px 5px;
		cursor: pointer;
		border:solid 1px black;
		text-align: center;
		margin-left: 10px;
	}
</style>  
<div>
	<div style="display: inline-block;">
	<h3>문서함</h3>
	</div>
</div>

<div id="detailArea" align="center">
	<table class="detailTable">
		<tr>
			<td>신청자</td>
			<td>신청자 정보</td>
			<td>결재날짜</td>
			<td>결재날짜 정보</td>
			<td rowspan="2">결재상태</td>
			<td rowspan="2">결재상태 정보</td>
		</tr>
		<tr>
			<td>신청날짜</td>
			<td>신청날짜 정보</td>
			<td>문서종류</td>
			<td>문서종류 정보</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="5">제목 정보</td>
		</tr>
	</table>
	<div id="contentArea">
		결재자 정보<br>
		문서정보
	</div>
	<div id="otherArea" align="left">
		<div>이전문서 |</div>
		<div>다음문서 |</div>
	</div>
	<div id="btnArea" align="right">
		<div class="managerBtn">목록보기</div>
		<div class="managerBtn">문서삭제</div>
	</div>
</div>