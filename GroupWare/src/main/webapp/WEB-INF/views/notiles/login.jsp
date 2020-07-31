<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지 입니다</title>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#btnLogin").click(function() {
			var frm = document.loginFrm;
			frm.method="POST";
			frm.action="<%= request.getContextPath()%>/login.top";
			frm.submit();
		});
		
	});
</script>
</head>
<body>

	<div id="loginContainer">
		<form name="loginFrm">
			<label for="id">아이디</label><input type="text" id="id" name="id" /><br/>
			<label for="passwd">비밀번호</label><input type="password" id="passwd" name="passwd" />
		</form>
		<button type="button" id="btnLogin">로그인</button>
	</div>
</body>
</html>