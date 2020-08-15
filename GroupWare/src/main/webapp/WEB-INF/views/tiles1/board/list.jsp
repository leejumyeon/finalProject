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
	table, th, td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	th {
		font-size: 11pt;
		background-color: #3399ff;
		color: white;
	}
	th, td {
		height: 27px;
	}
	#searchType {
		height: 28px;
		vertical-align: middle;
	}
	#searchWord {
		vertical-align: middle;
		height: 28px;
	}
	button {
		height: 28px;
		vertical-align: middle;
		color: white;
		background-color: #3399ff;
		border: none;
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
	.comunity {
		padding-top: 18px;
		width: 100px;
		height: 55px;
		margin-left: 30px;
		text-align: center;
		font-weight: bold;		
	}
	#post {
		margin-right: 30px;
		width: 750px;
		float: right;		
	}	
	#btnS {
		margin-left: -44px;
	}
	#btnW {
		float: right;
		width: 70px;
	}
	#side {
		float: left;
	}
</style>
<script type="text/javascript">
	
</script>
	<div id="container">
		<div id="in">
		<div id="side">
			<div class="comunity">커뮤니티</div>			
			<div class="sidebar2" onclick="javascript:location.href=''">앨범</div>
			<div class="sidebar2" onclick="javascript:location.href=''">자유게시판</div>
			<div class="sidebar2" onclick="javascript:location.href=''">동호회신청</div>
		</div>						
			<div id="post">	
				<h3>앨범게시판</h3>
				<form>
					<select name="searchType" id="searchType">
						<option value="all">전체</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="writer">작성자</option>
						<option value="readCnt">조회수</option>						
					</select>	
					<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" />
					<button style="color: white;" id="btnS" type="button" onclick="goSearch()">검색</button>
					<button style="color: white;" id="btnW" type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/write.top?seq=${board.seq}'">글쓰기</button>		
				</form>
				<div style="margin-top: 15px;">
					<table>
						<tbody>
							<tr>
								<th style="height: 40px; text-align: center;" align="center" width="80px">글번호</th>
								<th style="text-align: center;" width="80px">작성자</th>
								<th style="text-align: center;" width="360px">제목</th>
								<th style="text-align: center;" width="155px">작성날짜</th>
								<th style="text-align: center;" width="80px">조회수</th>
							</tr> 
								<!-- td 들어갈곳 -->				
						</tbody>					
					</table>
					<div id="pagebar">
						<!-- 페이지바들어갈곳 -->
					</div>
					<div style="clear:both"></div>
				</div>
			</div>
		</div>
	</div>