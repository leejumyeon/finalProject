<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	form[name=fileFrm] div:hover{
		text-decoration: underline;
		cursor: pointer;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function fileDownload(filename, orgFilename, file_seq){
		$("input[name=fileName]").val(filename);
		$("input[name=orgFileName]").val(orgFilename);
		$("input[name=file_seq]").val(file_seq);
		
		var frm = document.fileFrm;
		frm.method="post";
		frm.action="<%=request.getContextPath()%>/board/download.top";
		frm.submit();
	}
	
	function goUpdate(){
		location.href="<%=request.getContextPath()%>/manager/board/noticeUpdate.top?board_seq=${board.board_seq}";
	}
	
	function goDelete(){
		location.href="<%=request.getContextPath()%>/manager/board/noticeDelete.top?board_seq=${board.board_seq}";
	}
</script>
    
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-공지사항 상세-</h4>
	</div>
	
	<div style="margin-top: 20px; border:solid 1px blue;">
		<table class="table noticeTable">
			<tr>
				<td>제목</td>
				<td colspan="3">${board.subject}</td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td>${board.regDate}</td>
				<td>조회수</td>
				<td>${board.readCnt}</td>
			</tr>
			<tr>
				<td style="vertical-align: top;">첨부파일</td>
				<td colspan="3">
					<form name="fileFrm">
					<input type="hidden" name="fileName" />
					<input type="hidden" name="orgFileName" />
					<input type="hidden" name="file_seq" />
					<c:forEach var="file" items="${fileList}">
						<div onclick="fileDownload('${file.fileName}', '${file.orgFileName}', '${file.file_seq}')">${file.orgFileName}</div>
					</c:forEach>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="4">${board.content}</td>
			</tr>
		</table>
		<div>
			<span class="managerBtn" style="float:left" onclick="javascript:location.href='<%=request.getContextPath()%>/manager/board/noticeList.top'">목록 돌아가기</span>
			<span class="managerBtn" onclick="goDelete()">삭제</span>
			<span class="managerBtn" onclick="goUpdate()">수정</span>
		</div>
	</div>
</div>