<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 900px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 750px;}
	.long {width: 470px;}
	.short {width: 120px;}
	
	.move {cursor: pointer;}
	.moveColor {color: #660029; font-weight: bold;}
	
	a {text-decoration: none !important;}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$(".move").hover(function(){
							$(this).addClass("moveColor");
		                 }, 
		                 function(){
		                	 $(this).removeClass("moveColor"); 
		                 }
		);
		
	//	goReadComment(); 	 // 페이징처리 안한 댓글 읽어오기
		goViewComment("1");  // 페이징처리 한 댓글 읽어오기
		
	}); // end of $(document).ready(function(){})----------------
	
	
	// === 댓글쓰기 === //
	function goAddWrite() {
		var frm = document.addWriteFrm;
		var contentVal = frm.content.value.trim();
		if(contentVal=="") {
			alert("댓글 내용을 입력하세요!!");
			return;
		}
		
		var form_data = $("form[name=addWriteFrm]").serialize();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/addComment.top",
			data:form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				if(json.n == 1) {
				//	goReadComment(); 	// 페이징처리 안한 댓글 읽어오기
					goViewComment("1"); // 페이징처리 한 댓글 읽어오기
				}
				else {
					alert("댓글쓰기 실패!!");
				}
				
				frm.content.value = "";
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}// end of function goAddWrite()----------------------
	
	
	// === 페이징처리 안한 댓글 읽어오기  === //
	function goReadComment() {
		$.ajax({
			url:"<%= request.getContextPath()%>/readComment.top",
			data:{"parentSeq":"${boardvo.seq}"},
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += "<tr>";
						html += "<td style='text-align: center;'>"+(index+1)+"</td>";
						html += "<td>"+item.content+"</td>";
						html += "<td style='text-align: center;'>"+item.name+"</td>";
						html += "<td style='text-align: center;'>"+item.regDate+"</td>";
						html += "</tr>";
					});
				}
				else {
					html += "<tr>";
					html += "<td colspan='4' style='text-align: center;'>댓글이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("#commentDisplay").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});	
	}// end of function goReadComment()--------------------
	
	
	// === #125. Ajax로 불러온 댓글내용을 페이징처리 하기  === //
	function goViewComment(currentShowPageNo) {
		$.ajax({
			url:"<%= request.getContextPath()%>/commentList.top",
			data:{"parentSeq":"${boardvo.seq}",
				  "currentShowPageNo":currentShowPageNo},
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += "<tr>";
						html += "<td style='text-align: center;'>"+(index+1)+"</td>";
						html += "<td>"+item.content+"</td>";
						html += "<td style='text-align: center;'>"+item.name+"</td>";
						html += "<td style='text-align: center;'>"+item.regDate+"</td>";
						html += "</tr>";
					});
				}
				else {
					html += "<tr>";
					html += "<td colspan='4' style='text-align: center;'>댓글이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("#commentDisplay").html(html);
				
				// 페이지바 함수 호출
				makeCommentPageBar(currentShowPageNo);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});	
	}// end of function goViewComment(currentShowPageNo)--------------------
	
	
	// === 댓글내용 페이지바 Ajax로 만들기 ===
	function makeCommentPageBar(currentShowPageNo) {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/getCommentTotalPage.top",
			data:{"parentSeq":"${boardvo.seq}",
				  "sizePerPage":"5"},
			type:"GET",
			dataType:"JSON",
			success:function(json){
			
				if(json.totalPage > 0) {
					
					var totalPage = json.totalPage;
					
					var pageBarHTML = "<ul style='list-style:none;'>";
					
					var blockSize = 10;
					
					var loop = 1;
					
					if(typeof currentShowPageNo == "string") {
						currentShowPageNo = Number(currentShowPageNo);
					}
					
					var pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1
					
					if(pageNo != 1) {					
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'>[이전]</a></li>"; // goViewComment(\""+(pageNo-1)+"\") : controller에서 getParamter를 String타입으로 했으므로  String으로 넘겨주어야 한다.
					}
					
					
					while( !( loop > blockSize || pageNo > totalPage)) {
						
						if(pageNo == currentShowPageNo) {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
						}
						else {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
						}
						
						loop++;
						pageNo ++;
					}
					
					if( !(pageNo > totalPage) ) { // 맨 마지막으로 빠져나온것이 아니라면 [다음]을 보인다.
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:goViewComment(\""+(pageNo+1)+"\")'>[다음]</a></li>";
					}
					
					pageBarHTML += "</ul>";
					
					$("#pageBar").html(pageBarHTML);
					pageBarHTML = "";
				}
				else {
					
					$("#pageBar").empty();
				}
			
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}
	
</script>

<div style="padding-left: 10%;">
	
	<table id="table" style="word-wrap: break-word; table-layout: fixed;">
		<tr>
			<th>글번호</th>
			<td>${boardvo.seq}</td>
		</tr>
		<tr>
			<th>성명</th>
			<td>${boardvo.name}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${boardvo.subject}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
			 <p style="word-break: break-all;">${boardvo.content}</p>
			 
			</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${boardvo.readCount}</td>
		</tr>
		<tr>
			<th>날짜</th>
			<td>${boardvo.regDate}</td>
		</tr>
		
		<tr>
			<th>첨부파일</th>
			<td>
				<c:if test="${not empty sessionScope.loginuser}">
					<a href="<%= request.getContextPath()%>/download.top?seq=${boardvo.seq}">${boardvo.orgFilename}</a>
				</c:if>
				
				<c:if test="${empty sessionScope.loginuser}">
					${boardvo.orgFilename}
				</c:if>
			</td>
		</tr>
		<tr>
			<th>파일크기</th>
			<td>
				${boardvo.fileSize}
			</td>
		</tr>
	</table>
	
	<br/>
	
	<div style="margin-bottom: 1%;">이전글&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='view.top?seq=${boardvo.previousseq}'">${boardvo.previoussubject}</span></div>
	<div style="margin-bottom: 1%;">다음글&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='view.top?seq=${boardvo.nextseq}'">${boardvo.nextsubject}</span></div>
	
	<br/>
	
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/list.top'">전체목록보기</button>
	
	<button type="button" onclick="javascript:location.href='${gobackURL}'">목록보기</button>
		
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/edit.top?seq=${boardvo.seq}'">수정</button>
	<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/del.top?seq=${boardvo.seq}'">삭제</button>
	
	<c:if test="${sessionScope.loginuser.gradelevel == 10}">
		<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/add.top?fk_seq=${boardvo.seq}&groupno=${boardvo.groupno}&depthno=${boardvo.depthno}'">답변글쓰기</button>
	</c:if>
	
	<c:if test="${not empty sessionScope.loginuser}">
		<h3 style="margin-top: 50px;">댓글쓰기 및 보기</h3>
		<form name="addWriteFrm" style="margin-top: 20px;">
			      <input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
			성명 : <input type="text" name="name" value="${sessionScope.loginuser.name}" class="short" readonly />  
			&nbsp;&nbsp;
			댓글내용 : <input id="commentContent" type="text" name="content" class="long" /> 
			
			<!-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) -->
			<input type="hidden" name="parentSeq" value="${boardvo.seq}" /> 
			
			<button id="btnComment" type="button" onclick="goAddWrite()">확인</button> 
			<button type="reset">취소</button> 
		</form>
	</c:if>
	<c:if test="${empty sessionScope.loginuser}">
		<h3 style="margin-top: 50px;">댓글보기</h3>
	</c:if>
	
	<table id="table2" style="margin-top: 2%; margin-bottom: 3%;">
		<thead>
		<tr>
		    <th style="width: 10%; text-align: center;">번호</th>
			<th style="width: 60%; text-align: center;">내용</th>
			<th style="width: 10%; text-align: center;">작성자</th>
			<th style="text-align: center;">작성일자</th>
		</tr>
		</thead>
		<tbody id="commentDisplay"></tbody>
	</table>
	
	<div id="pageBar" style="border:solid 0px gray; width: 70%; margin: 10px auto; padding-left: 150px; text-align: center;"></div>
	
</div>





    