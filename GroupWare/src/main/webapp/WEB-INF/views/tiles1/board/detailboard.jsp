<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<meta charset="UTF-8">
<title>album board</title>
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
				<table id="detail">
					<tbody>
						<tr>
							<th style="text-align: center;">제목</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<th style="text-align: center;">작성자</th>
							<td></td>
							<th style="text-align: center;">작성날짜</th>
							<td></td>
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
			<div>
				<p>이전글&nbsp;:&nbsp;</p>
				<span class="move" onclick="javascript:location.href=''"></span>
			</div>
			<div>
				<p>다음글&nbsp;:&nbsp;</p>
				<span class="move" onclick="javascript:location.href=''"></span>
			</div>
			<div id="button" >
				<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href=''">목록보기</button>
				<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href=''">수정</button>
				<button class="detailbtn3" style="color: white; margin-left: 10px; width: 70px;" type="button" onclick="javascript:location.href=''">삭제</button>
			</div>
			</div>
		</div>
	</div>	