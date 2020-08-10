<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/documentStyle.css" />

<style>

	button {
		background-color: #0099ff;
		color: white;
		border: none;
	}

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$(".datepicker").datepicker({});
		
	});
	
</script>

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="titleSection">인사고과 결재서</div>
	
	<div class="partition">
		
		<div class="left">
			<table style="width:230px; height:130px;">
				<tbody>
					<tr><td class="ACel">문서번호</td><td class="BCel"><input name="groupno" value="${groupno}" style="border: none;" readonly/></td></tr>
					<tr><td class="ACel">기안일</td><td class="BCel"><input name="regDate" value="${regDate}" style="border: none;" readonly/></td></tr>
					<tr><td class="ACel">기안자부서</td><td class="BCel">${sessionScope.loginEmployee.department_name}</td></tr>
					<tr><td class="ACel">기안자</td><td class="BCel">${sessionScope.loginEmployee.employee_name}</td></tr>
				</tbody>
			</table>
		</div>
		
		<table width="570" style="border-collapse:collapse; margin-bottom: 15px;" class="form2" align="center">
			<tr>
				<td align="right">
					<table border="1" style="border-collapse: collapse; display: inline-block;">
						<tr>
							<td width="25" height="120" rowspan="3" align="center" bgcolor="#D9E2F3">결<br>
							<br>
							<br>
							재</td>
							<td width="100" height="25" style="text-align: center; font-size: 10pt; font-style: italic; font-weight: bold;">
								기안자
							</td>
						</tr>
						<tr>
							<td height="25" style="text-align: center; font-size: 8pt;">
								${sessionScope.loginEmployee.position_name}&nbsp;${sessionScope.loginEmployee.employee_name}
							</td>
						</tr>
						<tr>
							<td height="70">
							</td>
						</tr>
					</table>
					<table border="1" id="approvalList" style="border-collapse: collapse; display: inline-block;">
					</table>
				</td>
			</tr>
		</table>
	</div>

	<div id="documentContents">
		<table class="detailSection">
			<tbody>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">제 목</span>
					</td>
					<td class="BCel" colspan="3">
						<input type="text" name="subject" style="border: none; width: 400px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">날짜</span>
					</td>
					<td class="BCel">
						<input name="regDate" value="${regDate}" style="border: none;" readonly/>
					</td>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">담당자</span>
					</td>
					<td class="BCel" style="width: 200px;">
						<span style="font-weight: bold; font-size: 11pt;">${sessionScope.loginEmployee.position_name}&nbsp;${sessionScope.loginEmployee.employee_name}</span>
					</td>
				</tr>
			</tbody>
		</table>
		
		<h3>인사고과 인원</h3>
		<table class="detailSection">
			<tbody id="my_tbody1">
				<tr id="table_head">
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">사번</span>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">성명</span>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">출결</span>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">근무태도</span>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">업무성과</span>
					</td>
				</tr>
				<tr>
					<td class="BCel">
						<input type="text" name="employee_id" style="border: none; width: 150px; height: 30px;" autocomplete="off"/>
					</td>
					<td class="BCel">
						<input type="text" name="employee_name" style="border: none; width: 150px; height: 30px;" autocomplete="off"/>
					</td>
					<td class="BCel">
						<input type="text" name="attendance" style="border: none; width: 120px; height: 30px;" autocomplete="off"/>
					</td>
					<td class="BCel">
						<input type="text" name="attitude" style="border: none; width: 120px; height: 30px;" autocomplete="off"/>
					</td>
					<td class="BCel">
						<input type="text" name="performance" style="border: none; width: 120px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table class="detailSection">
			<tr>
				<td class="ACel" >
					<span style="font-weight: bold; font-size: 11pt;">사유</span>
				</td>
				<td class="BCel" colspan="3">
					<textarea rows="5" cols="115" name="reason" style="border: none;"></textarea>
				</td>
			</tr>
		</table>
	</div>
</div>