<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/documentStyle.css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		$(".datepicker").datepicker({});
		
	});

	function addRow1() {
		
		var countRowNo = Number($(".copyRowNo:last").text()) + 1;
		
		var html = '<tr>'
				 + '<td class="BCel center copyRowNo">' + countRowNo + '</td>'
				 + '<td class="BCel"><input type="text" name="equipment_name" style="width: 300px; height: 30px; border: none;" autocomplete="off"></td>'
				 + '<td class="BCel"><input type="text" name="unit" style="width: 40px; height: 30px; border: none;" autocomplete="off">EA</td>'
				 + '<td class="BCel"><input type="text" name="equipment_price" style="width: 100px; height: 30px; border: none;" autocomplete="off"></td>'
				 + '<td class="BCel"><input type="text" name="equipment_count" style="width: 40px; height: 30px; border: none;" autocomplete="off"></td>'
				 + '<td class="BCel"><input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date1" name="purchaseDate" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/></td>'
				 + '</tr>';
				 
		$("#my_tbody1").append(html);
		
		$(".datepicker").datepicker({});
	}
	
	function deleteRow1() {
	
		if($("#my_tbody1 tr").length < 3) {
			
			return;
		}
		
		$("#my_tbody1 tr:last").remove();
	}
</script>

<div id="divCustomWrapper">
	<div class="titleSection">비품 구매서</div>
	
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
					<td class="ACel">제목</td>
					<td colspan="3" class="BCel">
						<input type="text" name="subject" style="border: none; width: 450px; height: 30px;" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td class="ACel" >
						<span style="font-weight: bold; font-size: 11pt;">소속 부서</span>
					</td>
					<td class="BCel">
						<select name="department_seq" style="width: 170px; height: 30px; border: none;">
							<option value="" selected>==부서를 선택하세요==</option>
							<c:forEach var="departVO" items="${departmentList}">
								<option value="${departVO.department_seq}">${departVO.department_name}</option>
							</c:forEach>
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
		
		<h3>비품 구매 정보</h3>
		<button type="button" onclick="addRow1()" style="background-color: #0099ff; color: white; border: none;">행추가</button>
		<button type="button" onclick="deleteRow1()" style="background-color: #0099ff; color: white; border: none;">행삭제</button>
		<table class="detailSection">
			<tbody id="my_tbody1">
				
				<tr>
					<td class="ACel" style="width: 40px;">NO</td>
					<td class="ACel" style="width: 250px;">비품명</td>
					<td class="ACel" style="width: 60px;">단위</td>
					<td class="ACel" style="width: 100px;">가격</td>
					<td class="ACel" style="width: 60px;">수량</td>
					<td class="ACel" style="width: 120px;">구매날짜</td>
				</tr>
				
				<tr>
					<td class="BCel center copyRowNo">
						1
					</td>
					<td class="BCel">
						<input type="text" name="equipment_name" style="width: 300px; height: 30px; border: none;" autocomplete="off">
					</td>
					<td class="BCel">
						<input type="text" name="unit" style="width: 40px; height: 30px; border: none;" autocomplete="off">EA
					</td>
					<td class="BCel">
						<input type="text" name="equipment_price" style="width: 100px; height: 30px; border: none;" autocomplete="off">
					</td>
					<td class="BCel">
						<input type="text" name="equipment_count" style="width: 40px; height: 30px; border: none;" autocomplete="off">
					</td>
					<td class="BCel">
						<input style="width: 100px; height: 30px; font-size: 11pt; border: none;" type="text" id="date1" name="purchaseDate" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required autocomplete="off"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<br/>
		
		<table style="width: 800px;">
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

</body>