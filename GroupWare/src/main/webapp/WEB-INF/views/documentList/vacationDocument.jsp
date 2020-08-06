<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<style>
#divCustomWrapper { word-break: break-all; font-family: malgun gothic, dotum, arial, tahoma; width:802px !important; }
#divCustomWrapper * { max-width: 800px !important; }
#divCustomWrapper .titleSection { text-align: center; font-size: 20pt; font-weight: bold; margin-bottom: 30px !important; margin-top: 20px !important; }
#divCustomWrapper .detailSection > * { margin-bottom: 10px; }
#divCustomWrapper .detailSection { width:800px !important; clear:both; margin-top: 10px !important; vertical-align: middle; }
#divCustomWrapper table { border-collapse: collapse; word-break:break-all; }
#divCustomWrapper div.partition { display: flex; }
#divCustomWrapper div.partition.left { flex:1; }
#divCustomWrapper div.inaRowRight { flex:1; text-align: right;}
#divCustomWrapper td.BCel { font-size: 9pt !important; height:28px; border: 1px solid black !important; padding: 3px 5px 3px 5px; /*top right bottom left*/}
#divCustomWrapper td.ACel { font-size: 9pt !important; height:28px; width: 115px; border: 1px solid black !important; padding: 3px 5px 3px 5px; text-align: center !important; background: #D9E2F3; font-weight: bold;}
#divCustomWrapper td.noneborder { border: none !important; }
#divCustomWrapper td.center { text-align: center; }
#divCustomWrapper td.right { text-align: right; }
#divCustomWrapper td.editor { height: 300px; vertical-align: top;}
#divCustomWrapper td.area { height: 120px; vertical-align: middle;}
#divCustomWrapper .div_button { word-break:break-all; padding: 3px; margin-top:2px; margin-bottom:2px !important; height: 22px; vertical-align: middle; }
#divCustomWrapper a.button { background: rgb(102, 102, 102); color: rgb(255, 255, 255); padding: 2px 5px; border-radius: 3px; }
p.freeP{font-weight: normal; font-size: 9pt; margin: 3px 1px 3px 5px;}
</style>

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt;">

	<div class="titleSection">휴가 신청 기안서</div>
	
	<div class="partition">
		
		<div class="left">
			<table style="width:230px; height:131px;">
				<colgroup><col width="65"><col width="270"></colgroup>
				<tbody>
					<tr><td class="ACel">문서번호</td><td class="BCel">${groupno}</td></tr>
					<tr><td class="ACel">기안일</td><td class="BCel">${regDate}</td></tr>
					<tr><td class="ACel">기안자 부서</td><td class="BCel">${sessionScope.loginEmployee.department_name}</td></tr>
					<tr><td class="ACel">기안자</td><td class="BCel">${sessionScope.loginEmployee.employee_name}</td></tr>
				</tbody>
			</table>
		</div>
		
		<table width="570" style="border-collapse:collapse; margin-bottom: 15px;" class="form2" align="center">
			<tr>
				<td align="right">
					<table border="1" style="border-collapse: collapse;">
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
							<td>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;">
	<tbody>
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
				<select name="department_seq" style="width: 170px; height: 30px;">
					<option value="" selected>==부서를 선택하세요==</option>
					<c:forEach var="departVO" items="${departmentList}">
						<option value="${departVO.department_seq}">${departVO.department_name}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="ACel" >
				<span style="font-weight: bold; font-size: 11pt;">직책</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
			<td class="ACel" >
				<span style="font-weight: bold; font-size: 11pt;">성명</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
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
				<select></select>
			</td>
		</tr>
		
		<tr>
			<td class="ACel" >
				<span style="font-weight: bold; font-size: 11pt;">휴가기간</span>
			</td>
			<td class="BCel" colspan="3">
				<input style="width: 80px; height: 20px; font-size: 9pt;" type="text" id="date1" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required />
				<span>&nbsp;~&nbsp;</span>
				<input style="width: 80px; height: 20px; font-size: 9pt;" type="text" id="date2" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required />
			</td>
		</tr>
		
		<tr>
			<td class="ACel" >
				<span style="font-weight: bold; font-size: 11pt;">휴가종류</span>
			</td>
			<td class="BCel" colspan="3">
				<textarea rows="5" cols="95" name="contents"></textarea>
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
