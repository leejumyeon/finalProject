<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.managerBtn{
		border:solid 1px black;
		padding: 10px 15px;
		cursor: pointer;
		margin-right:10px;
		display: inline-block;
		margin-top: 10px;
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
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- === #160. 스마트 에디터 구현 시작 === --%>
	//전역변수
    var obj = [];
    
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "content",
        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
        }
    });
	<%-- === 스마트 에디터 구현 끝 === --%>
});
</script>   
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-FAQ 수정-</h4>
	</div>
	
	<div style="margin-top: 20px; border:solid 1px blue;">
		<form name="noticeFrm">
			<table class="table noticeTable">
				<tr>
					<td>제목</td>
					<td colspan="2"><input type="text" name="subject"/>${board.subject}</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">첨부파일</td>
					<td id="FileFrm">
						<div id="attach0"><input type="file" name="attach"/><span class="cancle" id="cancle0">X</span></div></td>
					<td style="vertical-align: top;"><div id="addFileFrm">추가 업로드</div></td>
				</tr>
				<tr>
					<td colspan="3">
						<textarea name="content" id="content" style="width: 800px;">${board.content}</textarea>
					</td>
				</tr>
			</table>
		</form>
		<div align="center">
			<div class="managerBtn">삭제</div>
			<div class="managerBtn">수정</div>
		</div>
	</div>
</div>