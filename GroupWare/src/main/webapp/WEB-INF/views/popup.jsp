<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class='popup' style='border: solid 1px black; width:300px;'>
		<h3>&nbsp;반려 메일 전송</h3>
		<table>
		<tr>
			<th>&nbsp;제목</th>
		<td><input type='text' id='subject'/></td>
		</tr>
		<tr>
		<th style='vertical-align: top;'>&nbsp;내용</th>
		<td><textarea style='resize: none; width:100%;' rows='5' id='reason'></textarea></td>
		</tr>
		</table><div onclick="goOpener()"><span style='border:solid 1px black; padding:10px 20px; margin:20px; float:right;'>전송</span></div>
		<div style='clear:both;'></div>
	</div>
</body>
<script type='text/javascript'>
	function goOpener(){
	var subject = document.getElementById('subject').value;
	var reason = document.getElementById('reason').value;
	opener.rejectMail(subject, reason);
	window.close();
	}
</script>
</html>