<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/documentStyle.css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		$(".datepicker").datepicker({});
		
	});
	
</script>

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt;">

	<div class="titleSection">휴가 신청 기안서</div>
	
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
		<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;">
			<tbody>
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">문서 제목</span>
					</td>
					<td class="BCel" colspan="3">
						<input type="text" name="subject" style="border: none; width: 400px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" colspan="4">
						<span style="font-weight: bold; font-size: 11pt;">신청인</span>
					</td>
				</tr>
				<tr>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">소속 부서</span>
					</td>
					<td class="BCel" colspan="3">
						<select name="department_seq" style="width: 170px; height: 30px; border: none;">
							<option value="" selected>==부서를 선택하세요==</option>
							<c:forEach var="departVO" items="${departmentList}">
								<option value="${departVO.department_seq}">${departVO.department_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">직위</span>
					</td>
					<td class="BCel" style="width: 350px;">
						<select name="position_seq" style="width: 190px; height: 30px; border: none;">
							<option value="" selected>== 직위를 선택하십시오 ==</option>
							<option value="1">사원</option>
							<option value="2">대리</option>
							<option value="3">과장</option>
							<option value="4">부장</option>
						</select>
					</td>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">성명</span>
					</td>
					<td class="BCel">
						<input style="border: none; height: 30px;" name="employee_name" autocomplete="off"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;">
			<tbody>
				<tr>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">휴가종류</span>
					</td>
					<td class="BCel" colspan="3">
						<select name="trip_category" style="width: 230px; height: 30px; border: none;">
							<option value="" selected>== 휴가 종류를 선택하십시오 ==</option>
							<c:forEach var="tripCatMap" items="${tripCatList}">
								<option value="${tripCatMap.category_num}">${tripCatMap.category_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">휴가기간</span>
					</td>
					<td class="BCel" colspan="3">
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date1" name="trip_start" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
						<span>&nbsp;~&nbsp;</span>
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date2" name="trip_end" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
					</td>
				</tr>
				
				<tr>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">사유</span>
					</td>
					<td class="BCel" colspan="3">
						<textarea rows="5" cols="115" name="reason" style="border: none;"></textarea>
					</td>
				</tr>
				
				<tr>
					<td style="border-width: medium 1px 1px; border-style: none solid solid; border-color: currentColor black black; padding: 5px; height: 100px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; vertical-align: middle; background-color: rgb(255, 255, 255);" colspan="4" class="dext_table_border_t">
						<span style="font-weight: bold; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">휴가기준 제 13조에 의거 휴가를 신청하오니 허락하여 주시기 바랍니다.</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
