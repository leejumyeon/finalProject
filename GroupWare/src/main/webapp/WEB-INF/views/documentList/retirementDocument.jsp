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

	<div class="titleSection">사직서</div>
	
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
		<h3>1.직원 정보</h3>
		<table style="border-bottom: rgb(0,0,0) 1px solid; border-left: 2px solid; margin-top: 10px; width: 800px; border-collapse: collapse; font-family: malgun gothic, dotum, arial, tahoma; border-top: 2px solid; border-right: 2px solid"><!-- user -->  
			<tr>
				<td class="ACel" style="width: 120px;">
					<span style="font-weight: bold; font-size: 11pt;">제 목</span>
				</td>
				<td class="BCel" colspan="5">
					<input type="text" name="subject" style="border: none; width: 400px; height: 30px;" autocomplete="off"/>
				</td>
			</tr>
			<tbody>
				<tr>
					<td class="ACel" style="width: 120px;">
						직&nbsp;&nbsp;&nbsp;&nbsp;위
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
					<td class="ACel" style="width: 120px;">
						사&nbsp;&nbsp;&nbsp;&nbsp;번
					</td>
					<td class="BCel">
						<input type="text" name="employee_id" style="border: none; width: 120px; height: 30px;" autocomplete="off"/>
					</td>	
				</tr>
				<tr>
					<td class="ACel" style="width: 120px;">
						성&nbsp;&nbsp;&nbsp;&nbsp;명
					</td>
					<td class="BCel">
						<input type="text" name="employee_name" style="border: none; width: 120px; height: 30px;" autocomplete="off"/>
					</td>
					<td class="ACel" style="width: 120px;">
						근무기간
					</td>
					<td class="BCel">
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date1" name="hire_date" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
						<span>&nbsp;~&nbsp;</span>
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date2" name="fire_date" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 120px;">
						근무부서
					</td>
					<td class="BCel">
						<select name="department_seq" style="width: 170px; height: 30px; border: none;">
							<option value="" selected>==부서를 선택하세요==</option>
							<c:forEach var="departVO" items="${departmentList}">
								<option value="${departVO.department_seq}">${departVO.department_name}</option>
							</c:forEach>
						</select>
					</td>
					<td class="ACel" style="width: 120px;">
						담당업무
					</td>
					<td class="BCel">
						<input type="text" style="border: none; width: 160px; height: 30px;"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" colspan="6">
						사직사유 (상세히 기술)
					</td>
				</tr>
				<tr>
					<td class="BCel" colspan="6">
						<textarea rows="5" cols="135" name="reason" style="border: none;"></textarea>
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 120px;">
						사직희망일
					</td>
					<td class="BCel" colspan="5">
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date1" name="fire_date" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" colspan="6">
						- 소속 부서 면담 결과 -
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 120px;">
						면담 일시
					</td>
					<td class="BCel" colspan="5">
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date1" name="trip_start" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 120px;">
						면담 내용<br/>(구체적 기술)
					</td>
					<td class="BCel" colspan="5">
						<textarea rows="5" cols="115" name="interview_content" style="border: none;"></textarea>
					</td>
				</tr>
				<tr>
					<td class="ACel" style="width: 120px;">
						처리내용
					</td>
					<td class="BCel" colspan="5">
						<textarea rows="5" cols="115" style="border: none;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<h3>2.퇴사 후 정보</h3>
		<table style="border-bottom: 2px solid; border-left: 2px solid; width: 800px; border-collapse: collapse; font-family: malgun gothic, dotum, arial, tahoma; border-top: 0px solid; border-right: 2px solid">
			<tbody>
				<tr>
					<td class="ACel" rowspan="2" style="width: 95px;">
						퇴직 후 <br/>연락처
					</td>
					<td class="ACel">
						현주소
					</td>
					<td class="BCel" colspan="3">
						<input type="text" name="addresss" style="border: none; width: 400px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel">
						전화번호
					</td>
					<td class="BCel">
						<input type="text" style="border: none; width: 200px; height: 40px;" autocomplete="off" placeholder="- 없이 작성해주십시오"/>
					</td>
					<td class="ACel">
						휴대폰 번호
					</td>
					<td class="BCel">
						<input type="text" style="border: none; width: 200px; height: 40px;" autocomplete="off" placeholder="- 없이 작성해주십시오"/>
					</td>
				</tr>
				<tr>
					<td class="BCel" colspan="5" style="font-size: 13pt; font-style: italic; font-weight: bold; text-align: center;">
						상기와 같이 사직하고자 하오니 수리하여 주시기 바랍니다.
					</td>
				</tr>
				<tr>
					<td class="BCel" colspan="5" style="font-weight: bold;">
						■ 참&nbsp;&nbsp;&nbsp;고<br>대여피복, 회사비품 미반납 및 정리사항 미 확인시 퇴직정산이 지연됩니다.
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>