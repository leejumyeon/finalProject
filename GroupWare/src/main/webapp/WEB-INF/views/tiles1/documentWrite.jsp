<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">

	table, tr, td, th {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	input {
		border: none
	}
</style>

</head>
<body>

	<table>
		<tr>
			<th>문서번호</th>
			<td><input type="text" name="groupNo" value="" readonly/></td>
		</tr>
		<tr>
			<th><label for="subject">제목</label></th>
			<td><input type="text" name="subject" id="subject" required autofocus/></td>
		</tr>
		<tr>
			<th>기안자</th>
			<td><input type="text" name=fk_employee_seq value="" readonly></input></td>
		</tr>
		<tr>
			<th>기안자 부서</th>
			<td></td>
		</tr>
		<tr>
			<th>서류종류</th>
			<td>
				<select name="document_category_seq">
					<option></option>
					<option></option>
					<option></option>
					<option></option>
					<option></option>
					<option></option>
				</select>
			</td>
		</tr>
	</table>
	
	<table>
		<tr>
			<th>결재선 선택</th>
		</tr>
		<tr>
			<td>
				<c:forEach items="">
					<div onclick="">부서명</div>
					<div>부서 사람</div>
				</c:forEach>
			</td>
		</tr>
	</table>
	
	<div id="documentContainer">
	
		<h2 id="document_category" style="float: left;"></h2>
		
		<div id="approverList" style="float: right;"></div>
		
		<div id="documentContnet" style="clear: both;">
		</div>
	</div>
</body>
</html>