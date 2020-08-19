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
	
	.hide{
		display: none;
	}
	
</style> 
<script type="text/javascript">
$(document).ready(function(){	
	<%-- === #160. 스마트 에디터 구현 시작 === --%>
	//전역변수
    var obj = [];
    var cnt = 0;
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
		if(cnt < 4) {	
			cnt++;
			console.log("파일첨부 값:"+cnt);
			var html = "<div style='margin-top:3px;' id='attach"+cnt+"'><input type='file' name='attach'/><span class='cancle' id='cancle"+cnt+"'>X</span></div>";
			$("#FileFrm").append(html);
		}		
		else{
			alert("첨부파일은 5개까지 가능합니다.");
		}
	});
	
	// 파일 업로드 폼 삭제
	$(document).on("click",".cancle",function(){		
		var idValue = $(this).prop("id");
		var idx = idValue.substr(6);
		$("#attach"+idx).remove();
		cnt--;		
	});
	
	// 분류 바꿨을 때
	$("#fk_category_num").bind("change", function(){
		if($("#fk_category_num").val() == '1') {
			$("#plusFile").removeClass('hide');
		}
		else {
			$("#plusFile").addClass('hide');
		}
	});
	
	// 쓰기버튼
	$("#write").click(function(){
		
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
		var frm = document.writeFrm;
		frm.method = "POST";
		frm.action = "<%= request.getContextPath()%>/manager/board/noticeInsert.top";
		frm.submit();
		
	});// end of $("#write").click(function(){})
	
});
</script>   
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-공지글 작성-</h4>
	</div>
	
	<div style="margin-top: 20px; border-top:solid 0px gray;">
		<form name="writeFrm" enctype="multipart/form-data">
			<select id="fk_category_num" name="fk_category_num" style="height: 25px;">
				<option value="1">공지사항</option>
				<option value="2">FAQ</option>
			</select>
			<table class="table noticeTable">
				<tr>
					<td>제목</td>
					<td colspan="2">
						<input type="text" id="subject" name="subject"/>
					</td>
				</tr>
				<tr id="plusFile">
					<td style="vertical-align: top;">첨부파일</td>
					<td id="FileFrm">
						<div id="attach0">
							<input type="file" name="attach"/>
							<span class="cancle" id="cancle0">X</span>
						</div>
					</td>
					<td style="vertical-align: top;">
						<div id="addFileFrm">추가 업로드</div>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<textarea name="content" id="content" style="width: 800px;"></textarea>
					</td>
				</tr>
			</table>
		</form>
		<div align="center">
			<div id="return" class="managerBtn" onClick="history.go(-1)">취소</div>
			<div id="write" class="managerBtn">작성</div>
		</div>
	</div>
</div>