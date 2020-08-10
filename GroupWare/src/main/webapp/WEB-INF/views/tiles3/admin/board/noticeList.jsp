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
	<h4 style="text-align: center;">-공지사항-</h4>
	</div>
	
	<div style="margin-top: 20px; border:solid 1px blue;">
		<div class="searchArea">
			<label for="searchTypeTitle">제목</label><input type="checkbox" name="searchType" id="searchTypeTitle" value="subject"/>
			<label for="searchTypeContent">내용</label><input type="checkbox" name="searchType" id="searchTypeContent" value="content" />
			<div style="display:inline-block; float:right; border:solid 1px black;">
				<input type="text" name="searchWord" style="border: none;"/><span>아이콘</span>
			</div>
		</div>
		<div style="clear:both;"></div>
		<table class="table noticeTable">
			<tr>
				<td><input type="checkbox" name="allSelect" value=""/></td>
				<td>글번호</td>
				<td class="tbl_title">제목</td>
				<td>작성날짜</td>
				<td>조회수</td>
				<td>삭제</td>
			</tr>
		</table>
		<div>
			<span class="managerBtn">선택삭제</span>
		</div>
	</div>
</div>