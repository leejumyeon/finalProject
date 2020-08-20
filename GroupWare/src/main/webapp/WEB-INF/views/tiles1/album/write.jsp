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
	#ablwrite {
		width: 750px;
		
	}
	#ablwrite, #ablwrite th, #ablwrite td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	#ablwrite th{
		width: 130px;
		font-size: 11pt;
		background-color: #3399ff;
		color: white;
	}	
	#ablwrite th, #ablwrite td {
		height: 40px;
	} 
	#btnWrite, #btnWrite2 {
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
	#searchType {
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
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            bUseToolbar : true,            
	            bUseVerticalResizer : true,    
	            bUseModeChanger : true,
	        }
	    });
		<%-- === 스마트 에디터 구현 끝 === --%>
		
		// 쓰기버튼
		$("#btnWrite").click(function(){
			
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

			var frm = document.writeFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/album/writeEnd.top";
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
			<form name="writeFrm" enctype="multipart/form-data">
				<table id="ablwrite">
					<tbody>
						<tr>
							<th style="text-align: center;">항목</th>
							<td colspan="3">
								&nbsp;&nbsp;<select name="album_category" id="searchType">
									<c:forEach var="albumMap" items="${albumCategory}">
										<option value="${albumMap.category_num}">${albumMap. category_name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th style="text-align: center;">성명</th>
							<td>&nbsp;&nbsp;${sessionScope.loginEmployee.employee_name}</td>
						</tr>
						<tr>
							<th style="text-align: center;">제목</th>
							<td>&nbsp;&nbsp;<input type="text" name="subject" id="subject" class="long"></td>
						</tr>
						<tr style="height: 400px;">
							<th style="text-align: center;">내용</th>
							<td><textarea rows="10" cols="100" style="width: 95%; height: 412px; display: none;" name="content" id="content"></textarea></td>
						</tr>				
					</tbody>				
				</table>		
				<div style="margin-top: 10px;" id="btn">	
					<div style="clear:both"></div>						
					<button type="button" id="btnWrite" style="color: white;">쓰기</button>
					<button type="button" id="btnWrite2" onclick="javascript:history.back()" style="color: white;">취소</button>
				</div>			
			</form>
			</div>				
		</div>
	</div>	