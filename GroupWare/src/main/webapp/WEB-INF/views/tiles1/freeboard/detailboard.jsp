<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<% String ctxPath = request.getContextPath(); %>

<meta charset="UTF-8">

<style type="text/css">

	#container {
		width: 1240px;
		margin: 0 auto;
	}	
	
	#in {
		width: 1000px;
		margin: 0 auto;
	}
	
	#detail {
		width: 750px;
		margin: 0 auto;
	}
	
	#detail, #detail th, #detail td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	
	#detail th{
		width: 120px;
		font-size: 11pt;
		background-color: #3399ff;
		height: 40px;
		color: white;
	}
	
	#detail td{
		padding: 10px;
		width: 468px;		
	}
	
	.detailbtn3 {
		border-radius: 0;
		border-style: none;
		background-color: #3399ff;
		padding: 5px;
		float: right;
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
	
	p {
		font-size: 11pt;
		font-weight: bold;
	}
	
	#content {
		max-height: 250px;
	}
	
	#commentContent {
		border: solid 1px gray;
		margin-top: 20px;
	}
	
	#commentWrite {
		float: right;
		color: white;
		font-size: 9pt;
    	padding: 5px;
		background-color: #3399ff;
		cursor: pointer;
	}
	
	.ChildCommentWrite {
		width: 58px;
		margin-left: 315px;
		color: white;
		font-size: 9pt;
    	padding: 5px;
		background-color: #3399ff;
		cursor: pointer;
	}
	
	.childCommentContent {
		border: solid 1px gray;
		margin-top: 20px;
	}
	
	#commentViewTbl{
		width: 750px;
	}
	    
	#commentViewTbl, #commentViewTbl tr, #commentViewTbl td {
		border: solid 1px #33adff;
		border-left-style: none;
		border-right-style: none;
		border-collapse: collapse;
	}
	
	/* 답글쓰기 */
	.childCommentBtn {
		cursor: pointer;
		color: gray;
		font-weight: bold;
		font-size: 9pt;
	}
	
	/* 취소 */
	.cancel {
		cursor: pointer;
		color: gray;
		font-weight: bold;
		font-size: 9pt;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 댓글 내용(페이징처리 x) 보여주기
		goReadComment();
		
	});


	// 삭제 버튼 클릭 시 
	function goDelete() {
		
		if (confirm("정말 삭제하시겠습니까?") == true){
			var frm = document.delFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/freeboard/del.top";
			frm.submit();
		}
		else{
			return;
		}
		
	}
	
	// 댓글 쓰기 버튼 클릭시 
	function goCommentWrite(board_seq) {
		
		var commentContent = $("#commentContent").val();
		
		if(commentContent.trim() == ""){
			alert("댓글 내용을 입력하세요.");
			return;
		}
		
		alert(commentContent);
		
		$.ajax({
			
			url:"<%= ctxPath%>/freeboard/goCommentWrite.top",
			data:{"board_seq":board_seq,"commentContent":commentContent},
			type:"POST",
			dataType:"JSON",
			success:function(json) {
				if(json.n == 1){
					goReadComment(); // 댓글 내용(페이징처리 x) 보여주기
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		}); 
	}
	
	
	// 댓글 내용(페이징처리 x) 보여주기
	function goReadComment() {
		
		$.ajax({
			
			url:"<%= ctxPath%>/freeboard/goReadComment.top",
			data:{"fk_board_seq":"${bvo.board_seq}"},
			dataType:"JSON",
			success:function(json) {
				
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += "<tr>";
					//	html += "<td style='text-align: center;'>"+(index+1)+"</td>";
					
					if(item.depthno == 0){
							
						html += "<td style='padding: 12px;'>"+item.employee_name+item.regDate+"&nbsp;&nbsp;<span class='childCommentBtn' onclick='goChildComment("+index+","+item.fk_board_seq+","+item.comment_seq+","+item.depthno+");'>답글쓰기&nbsp;/</span>"+"&nbsp;<span class='cancel' onclick='goCancel("+index+")'>취소</span>"+        
						        	"<div style='color:black; margin-top: 3px;'>"+item.content+"</div>"+
						        	"<div id='commentWriteDiv"+index+"'></div>"+
						        "</td>";
					}
					else{
							
						html += "<td style='padding: 12px;'>"+item.employee_name+item.regDate+"&nbsp;&nbsp;<span class='childCommentBtn' onclick='goChildComment("+index+","+item.fk_board_seq+","+item.comment_seq+","+item.depthno+");'>답글쓰기&nbsp;/</span>"+"&nbsp;<span class='cancel' onclick='goCancel("+index+")'>취소</span>"+        
						        	"<div style='color:black; margin-top: 3px;'>"+item.content+"</div>"+
						        	"<div id='commentWriteDiv"+index+"'></div>"+
						        "</td>";	
					}
						
						
					//	html += "<td style='text-align: center;'>"+item.employee_name+"</td>";
					//	html += "<td style='text-align: center;'>"+item.regDate+"</td>";
						html += "</tr>";
					});
				}
				else {
					html += "<tr>";
					html += "<td colspan='4' style='text-align: center;'>댓글이 없습니다.</td>";
					html += "</tr>";
				}
					$("#commentView").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		}); 
		
	}
	
	
	// 답글쓰기 버튼 클릭 시 
	function goChildComment(index, fk_board_seq, parent_seq, depthno) {
		
	//	alert(index+" , "+fk_board_seq+" , "+parent_seq);
		
		var html = "";
		html += "<textarea rows='2' cols='50' name='childCommentContent' id='childCommentContent'"+index+" class='childCommentContent' ></textarea>";
		html += "<div class='ChildCommentWrite' onclick='goChildCommentWrite("+index+","+fk_board_seq+","+parent_seq+","+depthno+")'>답글쓰기</div>";
		html += "<div style='clear:both;'></div>"
		$("#commentWriteDiv"+index).html(html);
		
	}
	
	
	// 답변쓰기 취소 클릭시
	function goCancel(index) {
		$("#commentWriteDiv"+index).empty();
	}
	
	
	// 답글쓰기를 눌렀을 시 댓글테이블에 insert(계층형 답글쓰기) 
	function goChildCommentWrite(index, fk_board_seq, parent_seq, depthno) {
		
		var childCommentContent = $(".childCommentContent").val();
			
		if(childCommentContent.trim() == ""){
			alert("답글 내용을 입력하세요.");
			return;
		} 
		
	//	alert(fk_board_seq + " , " + parent_seq + " , " + childCommentContent + " , " + depthno);
	
		$.ajax({
			url:"<%= ctxPath%>/freeboard/goChildCommentWrite.top",
			data:{"fk_board_seq":fk_board_seq,"parent_seq":parent_seq,"childCommentContent":childCommentContent,"depthno":depthno},
			type:"POST",
			dataType:"JSON",
			success:function(json) {
				if(json.n == 1){
					goReadComment(); // 댓글 내용(페이징처리 x) 보여주기
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); 
			
	}
	
	
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
			<form>	
				<table id="detail">
					<tbody>
						<tr>
							<th style="text-align: center;">제목</th>
							<td colspan="3">${bvo.subject}</td>
						</tr>
						<tr>
							<th style="text-align: center;">작성자</th>
							<td>${bvo.employee_name}</td>
							<th style="text-align: center;">작성날짜</th>
							<td>${bvo.regDate}</td>
						</tr>
						
						<c:forEach var="attachvo" items="${attachvoList}">
						<tr>
							<th style="text-align: center;">첨부파일</th>
							<td><a href="<%= ctxPath%>/freeboard/download.top?fk_board_seq=${attachvo.fk_board_seq}&fileName=${attachvo.fileName}&orgFileName=${attachvo.orgFileName}">${attachvo.orgFileName}</a></td>
							<th style="text-align: center;">파일크기</th>
							<td>&nbsp;${attachvo.fileSize}byte</td>
						</tr>
						</c:forEach>
						
						<tr>
							<th colspan="5" style="text-align: center;">내용</th>					
						</tr>			
						<tr>
							<td colspan="5" style="width: 1178px;" id="content">${bvo.content}</td>
						</tr>	
					</tbody>				
				</table>
			</form>	
			<br/>
			<div>
				<p><span class="move" onclick="javascript:location.href='?board_seq=${bvo.previousseq}'" style="cursor: pointer;">이전글&nbsp;:&nbsp;${bvo.previoussubject}</span></p>
			</div>
			<div>
				<p><span class="move" onclick="javascript:location.href='?board_seq=${bvo.nextseq}'" style="cursor: pointer;">다음글&nbsp;:&nbsp;${bvo.nextsubject}</span></p>
			</div>
			<div id="button" >
				<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href=''">목록보기</button>
				<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href='<%= ctxPath%>/freeboard/editView.top?board_seq=${bvo.board_seq}'">수정</button>
				<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="goDelete();">삭제</button>
			</div>
			
			<div style="clear: both;"></div>
			
			<%-- 댓글 보여지는 곳 --%>
			<table id="commentViewTbl" style="margin-top: 80px;">
		   <!-- <thead>
				<tr>
				    <th style="width: 10%; text-align: center;">번호</th>
					<th style="width: 60%; text-align: center;">내용</th>
					<th style="width: 10%; text-align: center;">작성자</th>
					<th style="text-align: center;">작성일자</th>
				</tr>
				</thead> -->
				<tbody id="commentView"></tbody>
			</table>
			
			<%-- 댓글 쓰기  --%>
			<div>
				<textarea rows="3" cols="104" name="commentContent" id="commentContent" ></textarea>
			</div>
			<div id="commentWrite" onclick="goCommentWrite('${bvo.board_seq}')">댓글 쓰기</div>
			<div style="clear: both;"></div>
			
		</div>
		</div>
		
		<form name="delFrm">
			<input type="hidden" name="board_seq" value="${bvo.board_seq}" />
		</form>
		
	</div>	