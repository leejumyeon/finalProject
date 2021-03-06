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
		
		$("input[name=memberCount]").blur(function() {
			
			var memberCount = $(this).val();
			
			var numMemberCount = Number(memberCount);
			
			var html = '<tr>'
					 + '<td class="ACel" rowspan="' + (numMemberCount + 1) +'"><span style="font-weight: bold; font-size: 11pt;">프로젝트 인원</span></td>'
					 + '<td class="ACel"><span style="font-weight: bold; font-size: 11pt;">부서</span></td>'
					 + '<td class="ACel"><span style="font-weight: bold; font-size: 11pt;">직위</span></td>'
					 + '<td class="ACel"><span style="font-weight: bold; font-size: 11pt;">성명</span></td>'
					 + '</tr>';
			
			for(var i = 0; i < numMemberCount; i++) {
				
				html += '<tr>'
					 + '<td class="BCel">'
					 + '<select name="department_seq" style="width: 170px; height: 30px; border: none;">'
					 + '<option value="" selected>==부서를 선택하세요==</option>'
					 + '<c:forEach var="departVO" items="${departmentList}">'
					 + '<option value="${departVO.department_seq}">${departVO.department_name}</option>'
					 + '</c:forEach>'
					 + '</select>'
					 + '</td>'
					 + '<td class="BCel">'
					 +	'<select name="position_seq" style="width: 190px; height: 30px; border: none;">'
					 + '<option value="" selected>== 직위를 선택하십시오 ==</option>'
					 + '<option value="1">사원</option>'
					 + '<option value="2">대리</option>'
					 + '<option value="3">과장</option>'
					 + '<option value="4">부장</option>'
					 + '</select>'
					 + '</td>'
					 + '<td class="BCel">'
					 + '<input style="border: none; height: 30px;" name="employee_name" autocomplete="off"/>'
					 + '</td>'
					 + "</tr>";
					  
			}
			
			$("#my_tbody1").html(html);
		});
		
	});
	
</script>

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="titleSection">프로젝트 신청 기안서</div>
	
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
		<h3>1. 일반사항</h3>
		<table class="detailSection">
			<tbody>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">문서 제목</span>
					</td>
					<td class="BCel" colspan="3">
						<input type="text" name="subject" style="border: none; width: 400px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">프로젝트명</span>
					</td>
					<td class="BCel" style="width: 300px;">
						<input type="text" name="project_name" style="border: none; width: 250px; height: 30px;" autocomplete="off"/>
					</td>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">거래처명</span>
					</td>
					<td class="BCel">
						<input type="text" style="border: none; width: 200px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">프로젝트 시작날짜</span>
					</td>
					<td class="BCel" style="text-align: left;">
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" name="startDate" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
					</td>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">프로젝트 기간</span>
					</td>
					<td class="BCel">
						<input type="text" name="term" style="width: 30px; height: 30px; border: none;"/>개월
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">관리자</span>
					</td>
					<td class="BCel" style="text-align: left;">
						${sessionScope.loginEmployee.position_name} ${sessionScope.loginEmployee.employee_name}
					</td>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">인원</span>
					</td>
					<td class="BCel">
						<input type="text" name="memberCount" style="width: 30px; height: 30px; border: none;"/>명
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">프로젝트 내용</span>
					</td>
					<td class="BCel" colspan="3">
						<textarea rows="5" cols="110" name="content" style="border: none;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<br/>
		
		<h3>2. 비용</h3>
		<table class="detailSection">
			<tbody>
				<tr>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">계약금</span>
					</td>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">중도금</span>
					</td>
					<td class="ACel" style="width: 150px;">
						<span style="font-weight: bold; font-size: 11pt;">완료금</span>
					</td>
				</tr>
				<tr>
					<td class="BCel">
						<input type="text" name="downPayment" style="width: 150px; height: 30px; border: none;"/>
					</td>
					<td class="BCel">
						<input type="text" name="middlePayment" style="width: 150px; height: 30px; border: none;"/>
					</td>
					<td class="BCel">
						<input type="text" name="completionPayment" style="width: 150px; height: 30px; border: none;"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<h3>2. 프로젝트 인원</h3>
		<table class="detailSection">
			<tbody id="my_tbody1">
				<tr>
					<td class="ACel" rowspan="2">
						<span style="font-weight: bold; font-size: 11pt;">프로젝트 인원</span>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">부서</span>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">직위</span>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">성명</span>
					</td>
				</tr>
				<tr>
					<td class="BCel">
						<select name="department_seq" style="width: 170px; height: 30px; border: none;">
							<option value="" selected>==부서를 선택하세요==</option>
							<c:forEach var="departVO" items="${departmentList}">
								<option value="${departVO.department_seq}">${departVO.department_name}</option>
							</c:forEach>
						</select>
					</td>
					<td class="BCel">
						<select name="position_seq" style="width: 190px; height: 30px; border: none;">
							<option value="" selected>== 직위를 선택하십시오 ==</option>
							<option value="1">사원</option>
							<option value="2">대리</option>
							<option value="3">과장</option>
							<option value="4">부장</option>
						</select>
					</td>
					<td class="BCel">
						<input style="border: none; height: 30px;" name="employee_name" autocomplete="off"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>