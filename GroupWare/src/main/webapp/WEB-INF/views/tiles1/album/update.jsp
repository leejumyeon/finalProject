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
	<div id="container">
		<div id="in">	
			<div id="side">
				<div class="comunity">커뮤니티</div>			
				<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/list.top?seq=${board.seq}'">앨범</div>
				<div class="sidebar2" onclick="javascript:location.href=''">자유게시판</div>
				<div class="sidebar2" onclick="javascript:location.href=''">동호회신청</div>
			</div>	
		<div id="post">	
			<h3>앨범게시판</h3>
			<form>	
				<table id="ablupdate">
					<tbody>
						<tr>
							<th style="text-align: center;">앨범항목</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<th style="text-align: center;">작성자</th>
							<td></td>
							<th style="text-align: center;">작성날짜</th>
							<td></td>
						</tr>
						<tr>
							<th style="text-align: center;">제목</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<th colspan="5" style="text-align: center;">내용</th>
						</tr>			
						<tr>
							<td colspan="5" style="width: 1178px;" id="content"></td>
						</tr>	
					</tbody>				
				</table>
			</form>	
			<br/>
			<div id="button" style="text-align: center;">
				<button class="updateBtn" style="color: white;" type="button" onclick="javascript:location.href=''">수정</button>
				<button class="updateBtn" style="color: white;" type="button" onclick="javascript:location.href=''">취소</button>
			</div>
			</div>
		</div>
	</div>	