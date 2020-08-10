<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.managerBtn{
		border:solid 1px black;
		padding: 10px 15px;
		cursor: pointer;
		float:right;
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
	<h4 style="text-align: center;">-신고글 조회-</h4>
	</div>
	
	<div id="content_area">
		<div class ="table_title" style="margin-top:5px;">
			<div class="searchArea" style="display:inline-block; float:right;">
				<input type="text" name="searchWord" />
				<select name="searchType">
					<option>전체</option>
					<option>작성자</option>
					<option>제목</option>
					<option>내용</option>
				</select>
			</div>
			<h4 style="display: inline-block;">신고 게시글</h4>
		</div>
		<div style="clear:both;"></div>
		<table class="table">
			<tr>
				<td>글 종류</td>
				<td>글 번호</td>
				<td>작성자</td>
				<td>제목</td>
				<td>작성날짜</td>
				<td>조회수</td>
				<td colspan="2">신고 적용</td>
			</tr>
			<tr>
				<td>글 종류</td>
				<td>글 번호</td>
				<td>작성자</td>
				<td>제목</td>
				<td>작성날짜</td>
				<td>조회수</td>
				<td>적용</td>
				<td>취소</td>
			</tr>
		</table>
		
		<div class ="table_title" style="margin-top:5px;">
			<h4 style="display: inline-block;">신고 댓글</h4>
		</div>
		<div style="clear:both;"></div>
		<table class="table">
			<tr>
				<td>원게시글 제목</td>
				<td>원게시글 종류</td>
				<td>글번호</td>
				<td>작성자</td>
				<td>작성날짜</td>
			</tr>
		</table>
	</div>
</div>