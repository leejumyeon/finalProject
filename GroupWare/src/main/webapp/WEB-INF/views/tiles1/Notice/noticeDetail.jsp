<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>


<title>공지사항</title>

<style type="text/css">
	
	
	
	.frame{
	
		width: 800px;
		margin: 0 auto;
		border: 1px solid red;
	
	}
	.container{
	
		overflow: hidden;
	
	}
	.nav{
		
		display : inline-block;
		float: left;
		width: 150px;
		/*background: #333;*/
		color: red;
		margin-right: 50px;
	
	}
	.nav-list{
		border: 1px solid blue;
		list-style:none;
		margin-top: 50px;
		padding: 10px 0;
	
	}
	
	.nav-item{
	
		margin: 4px 0;
		border: 1px solid red;
	
	}
	.nav-link{
	
		display: block;
		text-decoration: none;
		padding: 4px 10px;
		color: #fff;
	
	}
	.content{
	
		display : inline-block;	 
		border: 1px solid red;
		margin-top: 50px;
		width:800px;
		/* margin-left: 300px;  */
		/*padding: 200px;*/
	
	}
	
	.content table{
		width: 800px;
	}
	
	.content table, .content table td{
		border: solid 1px black;
		border-collapse: collapse;
	}
	
	#contentArea{
		margin-top: 5px;
		width: 800px;
		min-height: 400px;
		border:solid 1px blue;
	}

	.boardBtn{
		width: 80px;
		text-align: center;
		border:solid 1px black;
		margin-right: 5px;
		padding: 10px 0;
		cursor: pointer;
	}

</style>


	
<div class="fralme">
	<div class="container">
		<div class="nav">
			<h2>사내공지</h2>
			<ul class="nav-list">
				<li class="nav-item"><h2>공지사항</h2></li>
			</ul>				
			<ul class="nav-list">
				<li class="nav-item"><h2>자주묻는질문</h2></li>
			</ul>
		</div>
		<div class="content">
			<h3>공지사항</h3>
			<table>
				<tr>
					<td>제목</td>
					<td colspan="3">제목의 내용</td>
				</tr>
				<tr>
					<td>작성날짜</td>
					<td>작성날짜의 내용</td>
					<td>조회수</td>
					<td>조회수 내용</td>
				</tr>
			</table>
			<div id="contentArea">게시글 내용</div>
			<div id="otherArea">
				<div class="prevNotice">이전글 |<span>OOOOO</span></div>
				<div class="nextNotice">다음글 |<span>XXXXX</span></div>
			</div>
			<div align="right">
				<div class="boardBtn">목록보기</div>
			</div>
		</div>
	</div>
	
</div>

