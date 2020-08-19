<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	
%>
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
	
	#FileFrm{
		overflow: auto;
		max-height: 30px;
		width: 400px;
	}
	
	.cancle{
		background-color: red;
		font-size: 8pt;
		font-weight: bold;
		cursor: pointer;
		padding:5px;
	}
</style> 
<script type="text/javascript">
$(document).ready(function(){
	
	
	
	var orgFileNameArr = new Array();
	<c:forEach var="file" items="${fileList}">
		orgFileNameArr.push("${file.orgFileName}");
	</c:forEach>
	
	var cnt = orgFileNameArr.length;
	
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
	
	$("#addFileFrm").click(function(){
		if($("input[name=attach]").length + $("input[name=newAttach]").length >= 5){
			alert("첨부파일은 최대 5개까지만 첨부할 수 있습니다.");
			return false;
		}
		
		var html = "<div style='margin:5px 0;' id='attach"+cnt+"'><input type='file' name='newAttach' style='display:inline-block;'/><span class='cancle' id='cancle"+cnt+"'>X</span></div>";
		$("#FileFrm").append(html);
	});
	
	<%-- X클릭 했을 때 action --%>
	$(document).on("click",".cancle",function(event){
		$target = $(event.target);
		$target = $target.parent();
		$target.remove();
	});
	
	<%-- 기존에 있는 input type="file"태그 값 변경시 orgFileName변경 --%>
	$("input[name=attach]").each(function(index, item){
		$(item).change(function(){
			var fullpath = $(this).val();
			var idx = $(this).prop("id").substr(10);
			console.log(idx);
			var fileName = fullpath.substring(12);
			if(fileName == ""){
				fileName = orgFileNameArr[idx];
			}
			$("#orgFileName"+idx).val(fileName);
		});
	});
	
	// 수정버튼
	$("#updateBtn").click(function(){
		
		<%-- === 스마트에디터 구현 시작 === --%>
		// id가 content인 textarea에 에디터에서 대입
        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		<%-- === 스마트에디터 구현 끝 === --%>
		
		// 글제목 유효성 검사
		var subjectVal = $("#subject").val().trim();
		if(subjectVal == "") {
			alert("제목을 입력하세요.");
			return;
		}
		
		<%-- === 스마트에디터 구현 시작 === --%>
		// 스마트에디터 사용시 무의미하게 생기는 p태그 제거
        var contentval = $("#content").val();
	        
        // === 확인용 ===
        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
        // "<p>&nbsp;</p>" 이라고 나온다.
        
        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
        // 글내용 유효성 검사 
        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
        	alert("내용을 입력하세요.");
        	return;
        }
        
        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
    
        $("#content").val(contentval);
		// alert(contentval);
		<%-- === 스마트에디터 구현 끝 === --%>		
		
		// 폼(form) 을 전송(submit)
		var frm = document.noticeFrm;
		frm.method = "POST";
		frm.action = "<%= request.getContextPath()%>/manager/board/faqUpdate.top";
		frm.submit();
		
	});// end of $("#write").click(function(){})
	
}); // end of $(document).ready()---------------------------------------
</script>   
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-FAQ 수정-</h4>
	</div>
	
	<div style="margin-top: 20px; border:solid 1px blue;">
		<form name="noticeFrm" enctype="multipart/form-data">
			<input type="hidden" name="board_seq" value="${board.board_seq}" />
			<table class="table noticeTable">
				<tr>
					<td>제목</td>
					<td colspan="2"><input type="text" name="subject" id="subject" value="${board.subject}"/></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">첨부파일</td>
					<td id="FileFrm">
						<c:forEach var="file" items="${fileList}" varStatus="status">
							<div id="attach${status.index}" style="margin:5px 0;">
								<input type="file" name="attach" id="attachFile${status.index}" style="display: inline-block; width:80px;"/><input type="text" name="orgFileName" value="${file.orgFileName}" id="orgFileName${status.index}" style="border:none; width:185px;"/><span class="cancle" id="cancle${status.index}">X</span>
								<input type="hidden" name="file_seq" value="${file.file_seq}"/>
								<input type="hidden" name="fileName" value="${file.fileName}" />
								<input type="hidden" name="fileSize" value="${file.fileSize}" />
							</div>
						</c:forEach>
					</td>
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
			<div class="managerBtn" onclick="history.back();">취소</div>
			<div class="managerBtn" id="updateBtn">수정</div>
		</div>
	</div>
</div>