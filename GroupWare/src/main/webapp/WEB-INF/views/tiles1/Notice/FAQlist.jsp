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
	
	.hide{
		display:none;
	}

</style>

<script type="text/javascript">
	$(document).ready(function(){
		$(".accodion").click(function(){
			$target = $(this).next();
			$target.toggleClass("hide");
		});
	});
</script>
	
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
			<h3>FAQ</h3>
			<table class="table">
				<tr>
					<td>글번호</td>
					<td>제목</td>
					<td>작성날짜</td>
				</tr>
				<tr class="accodion">
					<td>글번호</td>
					<td>제목</td>
					<td>작성날짜</td>
				</tr>
				<tr class="pannel hide">
					<td colspan="3">내용</td>
				</tr>
			</table>
			<div id="pageBar">
			
			</div>
			<div id="searchArea">
				<label for="typeSubject">제목</label><input type="checkbox" name="searchType" id="typeSubject" value="subject" checked />
				<label for="typeContent">내용</label><input type="checkbox" name="searcyType" id="typeContent" value="content" />
				<div id="searchWordArea" style="display: inline-block; width: 230px; margin-right:10px; border:solid 1px black; float:right;">
					<input type="text" name="searchWord" style="border:none;"/>
					<span>아이콘</span>
				</div>
			</div>
			<div style="clear:both;"></div>
		</div>
	</div>
	
</div>

