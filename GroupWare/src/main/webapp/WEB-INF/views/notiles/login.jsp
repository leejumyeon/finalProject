<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=BenchNine:700">
<style>

	#loginContainer {
		width: 500px;
		min-height: 600px;
/* 		border: solid 2px #0099ff; */
/* 		background-color: #cceeff; */
		margin: 0 auto;
		margin-top: 250px;
		text-align: center;
		border-radius: 50px;
	}

	input {
		margin: 10px 0;
		width: 400px;
		height: 40px;
		border-radius: 10px;
	}
	
	label {
		color: #ffffff;
		font-size: 15pt;
		font-style: italic;
		font-weight: bold;
	}
	
	.snip1535 {
	  background-color: #0099ff;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 22px;
	  line-height: 1em;
	  margin: 15px 40px;
	  outline: none;
	  padding: 12px 40px 10px;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.snip1535:before,
	.snip1535:after {
	  border-color: transparent;
	  -webkit-transition: all 0.25s;
	  transition: all 0.25s;
	  border-style: solid;
	  border-width: 0;
	  content: "";
	  height: 24px;
	  position: absolute;
	  width: 24px;
	}
	
	.snip1535:before {
	  border-color: #0099ff;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1535:after {
	  border-bottom-width: 2px;
	  border-color: #0099ff;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1535:hover {
	  background-color: #0099ff;
	}
	
	.snip1535:hover:before,
	.snip1535:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#isLoginFalse").css("display","none");
		
		$("#btnLogin").click(function() {
			
			$.ajax({
				url:"<%= request.getContextPath()%>/loginEnd.top",
				type:"GET",
				data:{"employee_id":$("#employee_id").val()
					, "employee_pw":$("#employee_pw").val()},
				dataType:"JSON",
				success: function(json) {
					
					if(json.isLogin == '0') {
						
						$("#isLoginFalse").css("display","");
						
					}
					else if(json.isLogin == '1') {
						
						window.open('<%= request.getContextPath()%>/main.top', '그룹웨어', 'width = 1050, height = 755, location = yes, left = 200, top = 100');
					}
				}
				
			});
			
		});
		
	});
</script>

<body background="<%= request.getContextPath()%>/resources/images/backgroundImage.png">

	<div id="loginContainer">
		<img src="<%= request.getContextPath()%>/resources/images/logo.png" width="400px">
		<label for="employee_id" style="display:block; margin-top: 50px;">사원ID</label>
		<input type="text" id="employee_id" name="employee_id" autocomplete="off" /><br/>
		<label for="employee_pw">사원비밀번호</label><br/>
		<input type="password" id="employee_pw" name="employee_pw" />
		<div id="isLoginFalse" style="color: red; font-style: italic;">사원ID나 사원비밀번호를 잘못 입력하셨습니다.</div>
		<button type="button" id="btnLogin" class="snip1535">로그인</button>
	</div>
	
</body>