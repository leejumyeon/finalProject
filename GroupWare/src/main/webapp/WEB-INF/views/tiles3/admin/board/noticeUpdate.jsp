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
		cnt++;
		console.log("파일첨부 값:"+cnt);
		var html = "<div style='margin-top:3px;' id='attach"+cnt+"'><input type='file' name='newAttach' style='display:inline-block;'/><span class='cancle' id='cancle"+cnt+"'>X</span></div>";
		$("#FileFrm").append(html);
	});
	
	<%-- X클릭 했을 때 action --%>
	$(document).on("click",".cancle",function(event){
		$target = $(event.target);
		$target = $target.parent().parent();
		$target.remove();
	});
	
	<%-- 기존에 있는 input type="file"태그 값 변경시 orgFileName변경 --%>
	$("input[name=attach]").each(function(index, item){
		$(item).change(function(){
			var fullpath = $(this).val();
			console.log(index);
			var fileName = fullpath.substring(12);
			if(fileName == ""){
				fileName = orgFileNameArr[index];
			}
			$("input[name=orgFileName]:eq("+index+")").val(fileName);
		});
	});
});
</script>   
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-공지사항 수정-</h4>
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
						<c:forEach var="file" items="${fileList}" varStatus="status">
							<div id="attach${status.index}" style="margin:5px 0;">
								<input type="file" name="attach" style="display: inline-block; width:80px;"/><input type="text" name="orgFileName" value="${file.orgFileName}" style="border:none;"/><span class="cancle" id="cancle${status.index}">X</span>
								<input type="hidden" name="file_seq" value="${file.file_seq}"/>
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
			<div class="managerBtn">수정</div>
		</div>
	</div>
</div>