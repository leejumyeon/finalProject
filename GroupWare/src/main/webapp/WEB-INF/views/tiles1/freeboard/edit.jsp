<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
	#container {
		width: 1240px;
		margin: 0 auto;
	}
	#in {
		width: 1000px;
		margin: 0 auto;
	}
	#abledit {
		width: 750px;
		
	}
	#abledit, #abledit th, #abledit td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	#abledit th{
		width: 130px;
		font-size: 11pt;
		background-color: #3399ff;
		color: white;
	}	
	#abledit th, #abledit td {
		height: 40px;
	} 
	#btnUpdate, #btnUpdate2 {
		border-radius: 0;
		border-style: none;
		background-color: #3399ff;
		padding: 5px;
		width: 50px;		
	}
	#inputname {
		height: 20px;
		border: 1px solid #b3b3b3;
	}
	#subject {
		width: 450px;
	}
	.sidebar2 {
		border: 1px solid white;
		width: 100px;
		height: 52px;
		margin-left: 30px;
		cursor: pointer;
		padding-top: 15px;
		text-align: center;
		background-color: #3399ff;		
		color: white;
	}
	#post {
		margin-right: 30px;
		width: 750px;
		float: right;		
	}	
	.comunity {
		padding-top: 18px;
		width: 100px;
		height: 55px;
		margin-left: 30px;
		text-align: center;
		font-weight: bold;		
	}
	#side {
		float: left;
	}
	#fk_category_num {
		height: 28px;
		vertical-align: middle;
	}
	#btn{
		float: right;
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
	        sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
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
		
		// 쓰기버튼
		$("#btnUpdate").click(function(){
			
			<%-- === 스마트에디터 구현 시작 === --%>
			// id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			<%-- === 스마트에디터 구현 끝 === --%>
			
			// 글제목 유효성 검사
			var subjectVal = $("#subject").val().trim();
			if(subjectVal == "") {
				alert("글제목을 입력하세요!!");
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
	        	alert("글내용을 입력하세요!!");
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
			var frm = document.editFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/freeboard/edit.top";
			frm.submit();	 		
		}); // end of $(".btnUpdate").click() ------------------------------------------------------------
		
		var cnt = 0;
		$("#addFileBtn").click(function(){
			cnt++;
			
			if(cnt > 3){
				return;
			}
			
			$("#addDiv").append("<input type='file' name='attach' margin-left: 7px;' />");
			
		});
		
	});
</script>
	<div id="container">
		<div id="in">
		<div id="side">
			<div class="comunity">커뮤니티</div>			
			<div class="sidebar2" onclick="javascript:location.href='<%= ctxPath%>/list.top'">앨범</div>
			<div class="sidebar2" onclick="javascript:location.href='<%= ctxPath%>/freeboard/list.top'">자유게시판</div>
			<div class="sidebar2" onclick="javascript:location.href=''">동호회신청</div>
		</div>			
			<div id="post">
			<h3>자유게시판</h3>
			<form name="editFrm" enctype="multipart/form-data">
				<table id="abledit">
					<tbody>
						<tr>
							<th style="text-align: center;">항목</th>
							<td colspan="3">
								&nbsp;&nbsp;<select name="fk_category_num" id="fk_category_num">
									<option value="3">자유게시판</option>				
								</select>
							</td>
						</tr>
						<tr>
							<th style="text-align: center;">성명</th>
							<td>&nbsp;&nbsp;${sessionScope.loginEmployee.employee_name}<input type="hidden" name="name" id="inputname" value="${sessionScope.loginEmployee.employee_seq}" /></td>
						</tr>
						<tr>
							<th style="text-align: center;">제목</th>
							<td>&nbsp;&nbsp;<input type="text" name="subject" id="subject" value="${bvo.subject}" ></td>
						</tr>
						<tr>
							<th style="text-align: center;">첨부파일</th>
							<td>
								<span id="addFileBtn" style="border: solid 1px gray; padding: 3px; cursor: pointer">추가하기</span>
								<div id="addDiv"></div>
							</td>
						</tr>
						<tr style="height: 400px;">
							<th style="text-align: center;">내용</th>
							<td>&nbsp;&nbsp;<textarea rows="10" cols="100" style="width: 95%; height: 412px; display: none;" name="content" id="content">${bvo.content}</textarea></td>
						</tr>				
					</tbody>				
				</table>		
				<div style="margin-top: 10px;" id="btn">	
					<div style="clear:both"></div>						
					<button type="button" id="btnUpdate" style="color: white;">수정</button>
					<button type="button" id="btnUpdate2" onclick="javascript:history.back()" style="color: white;">취소</button>
				</div>
				<input type="hidden" name="fk_employee_seq" value="${sessionScope.loginEmployee.employee_seq}" />
				<input type="hidden" name="board_seq" value="${bvo.board_seq}" />			
			</form>
			</div>				
		</div>
	</div>	