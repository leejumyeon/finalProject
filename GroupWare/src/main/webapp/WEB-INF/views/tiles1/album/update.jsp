<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
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
	#ablupdate {
		width: 750px;
		margin: 0 auto;
	}
	#ablupdate, #ablupdate th, #ablupdate td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	#ablupdate th{
		width: 120px;
		font-size: 11pt;
		background-color: #3399ff;
		height: 40px;
		color: white;
	}
	#ablupdate td{
		padding: 10px;
		width: 468px;		
	}
	.updateBtn {
		border-radius: 0;
		border-style: none;
		background-color: #3399ff;
		padding: 5px;
		width: 70px;
		color: white;
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
	#content {
		height: 250px;
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
	            bUseToolbar : true,            
	            bUseVerticalResizer : true,    
	            bUseModeChanger : true,
	        }
	    });
		<%-- === 스마트 에디터 구현 끝 === --%>
		
		// 쓰기버튼
		$("#btnUpdate").click(function(){
			
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	
	        var contentval = $("#content").val();
		        
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
	
			var frm = document.updateFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/album/updateEnd.top";
			frm.submit();	 		
		}); // end of $(".btnWrite").click() ------------------------------------------------------------
		
	});
</script>

<div id="container">
	<div id="in">	
		<div id="side">
			<div class="comunity">커뮤니티</div>			
			<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/list.top'">앨범</div>
			<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/freeboard/list.top'">자유게시판</div>
			<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/clubRequest.top'">동호회신청</div>
		</div>	
	<div id="post">	
		<h3>앨범게시판</h3>
		<form name="updateFrm">	
			<table id="ablupdate">
				<tbody>
					<tr>
						<th style="text-align: center;">앨범항목</th>
						<td colspan="3">
							<select name="album_category">
								<c:if test="${detailAlbum.album_category == '1'}">
									<option value="1" selected>사내활동</option>
									<option value="2">동호회</option>
									<option value="3">봉사</option>
								</c:if>
								<c:if test="${detailAlbum.album_category == '2'}">
									<option value="1">사내활동</option>
									<option value="2" selected>동호회</option>
									<option value="3">봉사</option>
								</c:if>
								<c:if test="${detailAlbum.album_category == '3'}">
									<option value="1">사내활동</option>
									<option value="2">동호회</option>
									<option value="3" selected>봉사</option>
								</c:if>
							</select>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;">작성자</th>
						<td>${detailAlbum.employee_name}</td>
						<th style="text-align: center;">작성날짜</th>
						<td>${detailAlbum.regDate}</td>
					</tr>
					<tr>
						<th style="text-align: center;">제목</th>
						<td colspan="3"><input type="text" name="subject" value="${detailAlbum.subject}"/></td>
					</tr>
					<tr>
						<th colspan="5" style="text-align: center;">내용</th>
					</tr>			
					<tr>
						<td><textarea rows="10" cols="100" style="width: 95%; height: 412px; display: none;" name="content" id="content">${detailAlbum.content}</textarea></td>
					</tr>	
				</tbody>				
			</table>
			<input type="hidden" name="album_seq" value="${detailAlbum.album_seq}" />
		</form>	
		<br/>
		<div id="button" style="text-align: center;">
			<button class="updateBtn" id="btnUpdate" style="color: white;" type="button">수정</button>
			<button class="updateBtn" style="color: white;" type="button" onclick="javascript:location.href='history.back()'">취소</button>
		</div>
		</div>
	</div>
</div>	