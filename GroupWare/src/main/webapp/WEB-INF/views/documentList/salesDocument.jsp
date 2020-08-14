<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/documentStyle.css" />

<script type="text/javascript">

	var rowNum = 0;

	function addRow1() {
		
		var html = '<tr>'
				 + '<td class="BCel"><input type="text" name="sales_title" style="border: none; width: 200px; height: 30px;" autocomplete="off"/></td>'
				 + '<td class="BCel"><input type="text" name="sales_count" style="border: none; width: 60px; height: 30px;" autocomplete="off"/></td>'
				 + '<td class="BCel"><input type="text" name="price" style="border: none; width: 170px; height: 30px;" autocomplete="off"/></td>'
				 + '</tr>';
				 
		$("#my_tbody1").append(html);
		
		rowNum++;
	}
	
	function deleteRow1() {
	
		if($("#my_tbody1 tr").length < 1) {
			
			return;
		}
		
		$("#my_tbody1 tr:last").remove();
	}
	
	function addRow2() {
		
		var html = '<tr>'
				 + '<td class="BCel"><input type="text" name="sales_title" style="border: none; width: 200px; height: 30px;" autocomplete="off"/></td>'
				 + '<td class="BCel"><input type="text" name="sales_count" style="border: none; width: 60px; height: 30px;" autocomplete="off"/></td>'
				 + '<td class="BCel"><input type="text" name="price" style="border: none; width: 170px; height: 30px;" autocomplete="off"/></td>'
				 + '</tr>';
				 
		$("#my_tbody2").append(html);
	}
	
	function deleteRow2() {
	
		if($("#my_tbody2 tr").length < 1) {
			
			return;
		}
		
		$("#my_tbody2 tr:last").remove();
	}
	
</script>
<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="titleSection">매출 기안서</div>
	
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
		<h3>1.일반사항</h3>				
		<table style="width: 100%; border: 2px solid rgb(0, 0, 0); font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
			<tbody>
				<tr>
					<td class="ACel">
						<span style="font-size: 10pt;">문 서 제 목</span>
					</td>
					<td class="BCel" colspan="3">
						<input type="text" name="subject" style="border: none; width: 400px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel">
						<span style="font-size: 10pt;">매 출 부 서</span>
					</td>
					<td class="BCel" colspan="3" style="height: 30px;">
						<select name="department_seq" style="width: 170px; height: 30px; border: none;">
							<option value="" selected>==부서를 선택하세요==</option>
							<c:forEach var="departVO" items="${departmentList}">
								<option value="${departVO.department_seq}">${departVO.department_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="ACel">
						<span style="font-size: 10pt;">매 출 명</span>
					</td>
					<td class="BCel">
						<input type="text" name="sales_subject" style="border: none; width: 250px; height: 30px;" autocomplete="off"/>
					</td>
					<td class="ACel">
						<span style="font-size: 10pt;">거 래 처</span>
					</td>
					<td class="BCel">
						<input type="text" style="border: none; width: 250px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel">
						<span style="font-size: 10pt;">담 당 자</span>
					</td>
					<td class="BCel">
						${sessionScope.loginEmployee.position_name}&nbsp;${sessionScope.loginEmployee.employee_name}
					</td>
					<td class="ACel">
						<span style="font-size: 10pt;">거래처 담당자</span>
					</td>
					<td class="BCel">
						<input type="text" style="border: none; width: 250px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<br/>
		
		<h3>2.수익 정보(금액은 +로 작성하셔야 합니다.)</h3>
		<button type="button" onclick="addRow1()" style="background-color: #0099ff; color: white; border: none;">행추가</button>
		<button type="button" onclick="deleteRow1()" style="background-color: #0099ff; color: white; border: none;">행삭제</button>
		<table style="border: 2px solid rgb(0, 0, 0); width: 800px; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; border-collapse: collapse;">
			<tbody>
				<tr>
					<td class="ACel">
						<span style="font-size: 10pt; width: 200px;">제&nbsp;&nbsp;&nbsp;&nbsp;목</span>
					</td>
					<td class="ACel">
						<span style="font-size: 10pt; width: 60px;">수&nbsp;&nbsp;&nbsp;&nbsp;량</span>
					</td>
					<td class="ACel">
						<span style="font-size: 10pt; width: 170px;">수&nbsp;익&nbsp;금&nbsp;액</span>
					</td>
				</tr>
			</tbody>
			<tbody id="my_tbody1">
			</tbody>
		</table>
		 
		<h3>3.지출 정보(금액은 -로 작성하셔야 합니다.)</h3>
		<button type="button" onclick="addRow2()" style="background-color: #0099ff; color: white; border: none;">행추가</button>
		<button type="button" onclick="deleteRow2()" style="background-color: #0099ff; color: white; border: none;">행삭제</button>
		<table style="border: 2px solid rgb(0, 0, 0); width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
			<tbody>
				<tr>
					<td class="ACel">
						<span style="font-size: 10pt;">제&nbsp;&nbsp;&nbsp;&nbsp;목</span>
					</td>
					<td class="ACel">
						<span style="font-size: 10pt;">수&nbsp;&nbsp;&nbsp;&nbsp;량</span>
					</td>
					<td class="ACel">
						<span style="font-size: 10pt;">지&nbsp;출&nbsp;금&nbsp;액</span>
					</td>
				</tr>
			</tbody>
			<tbody id="my_tbody2">
			</tbody>
		</table>
		
		<h3>4. 사유</h3>
		<table style="border: 2px solid rgb(0, 0, 0); width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
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