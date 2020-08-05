<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<style type="text/css">
	
	body {
	
		font:14px/1.8 Arial, Helvetica, sans-serif;
		
	
	}
	
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
		/* margin-left: 300px;  */
		width:300px; 
		/*padding: 200px;*/
	
	}
	


</style>

</head>
<body>
	
<div class="fralme">
	<div class="container">
		<div class="nav">
			<ul class="nav-list">
				<li class="nav-item"><h2>공지사항</h2></li>
			</ul>				
			<ul class="nav-list">
				<li class="nav-item"><h2>자주묻는질문</h2></li>
			</ul>
		</div>
		
		<div class="content">
			<h1>Hello World</h1>
			
			<p> 내용이 들어올곳</p>
	
		</div>
	</div>
	
</div>

</body>
</html>