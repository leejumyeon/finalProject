<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/documentStyle.css" />

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="titleSection">동호회 신청서</div>
	
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
		<table style="background: white; border: 1px solid black; width: 800px; color: black; font-family: malgun gothic,dotum,arial,tahoma; font-size: 12px; border-collapse: collapse !important;">
			<tbody>
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">제목</span>
					</td>
					<td class="BCel" colspan="5">
						<input type="text" name="subject" style="border: none; width: 400px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table style="background: white; border: 1px solid black; border-top: none; width: 800px; color: black; font-family: malgun gothic,dotum,arial,tahoma; font-size: 12px; border-collapse: collapse !important;"> 
		
			<tbody>
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">동호회명</span>
					</td>
					<td class="BCel" style="width: 200px;">
						<input type="text" name="club_name" style="width: 200px; height: 30px; border: none;" autocomplete="off"/>
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">회 원 수</span>
					</td>
					<td class="BCel" style="width: 65px;">
						<input type="text" style="width: 40px; height: 30px; border: none;"/>명
					</td>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">신청일자</span>
					</td>
					<td class="BCel">
						<input name="regDate" value="${regDate}" style="border: none; height: 30px;" readonly/>
					</td>
				</tr>
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">동호회 소개글</span>
					</td>
					<td class="BCel" colspan="5">
						<textarea rows="5" cols="115" name="club_info" style="border: none;"></textarea>
					</td>
				</tr>
				<tr>
					<td class="ACel">
						<span style="font-weight: bold; font-size: 11pt;">사유</span>
					</td>
					<td class="BCel" colspan="5">
						<textarea rows="5" cols="115" style="border: none;"></textarea>
					</td>
				</tr>
				<tr>
					<td class="BCel" colspan="6" style="text-align: center;">
						<span style="font-size: 10pt;">위와 같이 동호회를 신청 하고자 하오니 재가 바랍니다.</span><br/>
						<span style="font-size: 10pt;">${regDate}</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
