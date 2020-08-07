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
	
	#addFileFrm{
		font-size:12pt;
		text-align: center;
		background-color: blue;
		color:white;
		font-weight: bold;
		cursor: pointer;
	}
	
	input[name='attach']{
		display: inline-block;
	}
	
	.cancle{
		background-color: red;
		font-size: 8pt;
		font-weight: bold;
		cursor: pointer;
		padding:5px;
	}
	
	#FileFrm{
		overflow: auto;
		max-height: 30px;
		width: 400px;
	}
</style> 
<script type="text/javascript">
$(document).ready(function(){
	var cnt = 0;
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
	
	// 파일 업로드 폼 추가
	$("#addFileFrm").click(function(){
		cnt++;
		console.log("파일첨부 값:"+cnt);
		var html = "<div style='margin-top:3px;' id='attach"+cnt+"'><input type='file' name='attach'/><span class='cancle' id='cancle"+cnt+"'>X</span></div>";
		$("#FileFrm").append(html);
	});
	
	$(document).on("click",".cancle",function(){
		var idValue = $(this).prop("id");
		var idx = idValue.substr(6);
		$("#attach"+idx).remove();
		
	});
});
</script>   
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-공지글 작성-</h4>
	</div>
	
	<div style="margin-top: 20px; border:solid 1px blue;">
		<form name="noticeFrm">
			<select name="boardType">
				<option>공지사항</option>
				<option>FAQ</option>
			</select>
			<table class="table noticeTable">
				<tr>
					<td>제목</td>
					<td colspan="2"><input type="text" name="subject"/></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">첨부파일</td>
					<td id="FileFrm"><div id="attach0"><input type="file" name="attach"/><span class="cancle" id="cancle0">X</span></div></td>
					<td style="vertical-align: top;"><div id="addFileFrm">추가 업로드</div></td>
				</tr>
				<tr>
					<td colspan="3">
						<textarea name="content" id="content" style="width: 800px;"></textarea>
					</td>
				</tr>
			</table>
		</form>
		<div align="center">
			<div class="managerBtn">삭제</div>
			<div class="managerBtn">작성</div>
		</div>
	</div>
</div>