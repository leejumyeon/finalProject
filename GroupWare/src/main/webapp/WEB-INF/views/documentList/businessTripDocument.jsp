<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/documentStyle.css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		$(".datepicker").datepicker({});
		
	});
	
</script>

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="titleSection">출장 신청 기안서</div>
	
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
						<span style="font-weight: bold; font-size: 11pt;">문서 제목</span>
					</td>
					<td class="BCel" colspan="6">
						<input type="text" name="subject" style="border: none; width: 350px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="BCel" colspan="8" style="font-style: italic; font-weight: bold; text-align: center;">
						<span style="font-size: 10pt;">아래와 같이 출장계를 제출합니다.</span>
					</td>
				</tr>
			</tbody>
			<tbody>
				<tr>
					<td class="ACel" rowspan="2">
						<span style="font-weight: bold; font-size: 11pt;">출장자</span>
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
				<tr class="copyRow1">
					<td class="BCel" style="width: 170px; height: 30px;">
						${sessionScope.loginEmployee.department_name}
					</td>
					<td class="BCel" style="width: 150px; height: 30px;">
						${sessionScope.loginEmployee.podition_name}
					</td>
					<td class="BCel" style="width: 150px; height: 30px;">
						${sessionScope.loginEmployee.employee_name}
					</td>
				</tr>
			</tbody>
			<tbody>
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">출장종류</span>
					</td>
					<td class="BCel" colspan="3">
						<select name="trip_category" style="width: 230px; height: 30px; border: none;">
							<option value="" selected>== 출장 종류를 선택하십시오 ==</option>
							<c:forEach var="tripCatMap" items="${tripCatList}">
								<option value="${tripCatMap.category_num}">${tripCatMap.category_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">출장기간</span>
					</td>
					<td class="BCel" colspan="3">
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date1" name="trip_start" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
						<span>&nbsp;~&nbsp;</span>
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date2" name="trip_end" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
					</td>
				</tr>
				
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">출장지</span>
					</td>
					<td class="BCel" colspan="3">
						<input type="text" name="triplocatioin" style="border: none; width: 290px; height: 30px;"/>
					</td>
				</tr>
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">출장목적</span>
					</td>
					<td class="BCel" colspan="3">
						<textarea rows="5" cols="115" name="reason" style="border: none;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>