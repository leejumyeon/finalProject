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
		height: 22px;
	}
	button {
		height: 28px;
		vertical-align: middle;
		color: white;
		background-color: #3399ff;
		border: none;
	}
	.sidebar2 {
		border: 1px solid red;
		width: 100px;
		height: 55px;
		margin-left: 30px;
		cursor: pointer;
	}
	.comunity {
		padding-top: 18px;
		width: 100px;
		height: 55px;
		float: left;
		margin-left: 30px;
		text-align: center;
	}
	#post {
		float: left;
		margin: 0px 30px 0 62px;
	}
	#btnS {
		margin-left: -45px;
	}
	#btnW {
		float: right;
		width: 70px;
	}
</style>

<div id="container" style="margin-top: 100px;">
	<div id="in">
		<div class="comunity">커뮤니티</div>						
		<div id="post">	
			<form>
				<select name="searchType" id="searchType">
					<option value="all">전체</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
					<option value="readCnt">조회수</option>						
				</select>	
				<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" />
				<button id="btnS" type="button" onclick="goSearch()">검색</button>
				<button id="btnW" type="button" onclick="goWrite()">글쓰기</button>		
			</form>
			<div style="margin-top: 15px;">
				<table>
					<tbody>
						<tr>
							<th align="center" width="80px">글번호</th>
							<th align="center" width="80px">작성자</th>
							<th align="center" width="360px">제목</th>
							<th align="center" width="155px">작성날짜</th>
							<th align="center" width="80px">조회수</th>
						</tr> 
							<!-- td 들어갈곳 -->				
					</tbody>					
				</table>
				<div id="pagebar">
					<!-- 페이지바들어갈곳 -->
				</div>
			</div>
		</div>
		<div style="clear:both"></div>
		<div class="sidebar2" onclick="javascript:location.href=''"></div>
		<div class="sidebar2" onclick="javascript:location.href=''"></div>
		<div class="sidebar2" onclick="javascript:location.href=''"></div>	
	</div>
</div>