<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	table {
		border-collapse: collapse;
	}
	
	tr.thead, th {
		border-bottom: solid 1px #ccc;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#btnWriteDocument").click(function() {
			
			location.href="<%= request.getContextPath()%>/writeDocument.top";
		});
	});

</script>

</head>
<body>

	<div class="container">
		<h2>내가 신청한 문서결제</h2>
		
		<table>
			<tr class="thead">
				<th>Firstname</th>
				<th>Lastname</th>
				<th>Email</th>
			</tr>
			<tr>
				<td>John</td>
				<td>Doe</td>
				<td>john@example.com</td>
			</tr>
			<tr>
				<td>Mary</td>
				<td>Moe</td>
				<td>mary@example.com</td>
			</tr>
			<tr>
				<td>July</td>
				<td>Dooley</td>
				<td>july@example.com</td>
			</tr>
		</table>
		
		<h2>내가 결재해야 할 문서결재</h2>
		
		<table>
			<tr class="thead">
				<th>Firstname</th>
				<th>Lastname</th>
				<th>Email</th>
			</tr>
			<tr>
				<td>John</td>
				<td>Doe</td>
				<td>john@example.com</td>
			</tr>
			<tr>
				<td>Mary</td>
				<td>Moe</td>
				<td>mary@example.com</td>
			</tr>
			<tr>
				<td>July</td>
				<td>Dooley</td>
				<td>july@example.com</td>
			</tr>
		</table>
		
		<h2>내가 결재해야 할 문서결재</h2>
		
		<table>
			<tr class="thead">
				<th>Firstname</th>
				<th>Lastname</th>
				<th>Email</th>
			</tr>
			<tr>
				<td>John</td>
				<td>Doe</td>
				<td>john@example.com</td>
			</tr>
			<tr>
				<td>Mary</td>
				<td>Moe</td>
				<td>mary@example.com</td>
			</tr>
			<tr>
				<td>July</td>
				<td>Dooley</td>
				<td>july@example.com</td>
			</tr>
		</table>
		
		<button type="button" id="btnWriteDocument">작성하기</button>
	</div>

</body>
</html>