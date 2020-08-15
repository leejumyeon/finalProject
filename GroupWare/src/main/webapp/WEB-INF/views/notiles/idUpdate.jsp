<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<%= request.getContextPath()%>/resources/datepicker/datepicker.css">
<style>
	
	td {
		line-height: 35px;
	}
	
	input[type=text] {
		height: 35px;
		width: 300px;
	}
	
	.datepicker {
		font-size: 11pt;
	}
	
	.snip1535 {
	  background-color: #0099ff;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 22px;
	  line-height: 1em;
	  margin: 15px 40px;
	  outline: none;
	  padding: 12px 40px 10px;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.snip1535:before,
	.snip1535:after {
	  border-color: transparent;
	  -webkit-transition: all 0.25s;
	  transition: all 0.25s;
	  border-style: solid;
	  border-width: 0;
	  content: "";
	  height: 24px;
	  position: absolute;
	  width: 24px;
	}
	
	.snip1535:before {
	  border-color: #0099ff;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1535:after {
	  border-bottom-width: 2px;
	  border-color: #0099ff;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1535:hover {
	  background-color: #0099ff;
	}
	
	.snip1535:hover:before,
	.snip1535:hover:after {
	  height: 100%;
	  width: 100%;
	}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%= request.getContextPath()%>/resources/datepicker/datepicker.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#zipcodeSearch").click(function(){

			new daum.Postcode({

	            oncomplete: function(data) {

	                var addr = '';
	                var extraAddr = '';

	                if (data.userSelectedType === 'R') {
	                    addr = data.roadAddress;
	                } else {
	                    addr = data.jibunAddress;
	                }

	                if(data.userSelectedType === 'R'){

	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }

	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }

	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }

	                    document.getElementById("extraAddress").value = extraAddr;

	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                document.getElementById("detailAddress").focus();
	            }

	        }).open();

		});
		
		$(".datepicker").datepicker({
			minDate: +1
		});
		
		$("#btnIssued").click(function() {
			
			$(".required").each(function() {
				
				if($(this).val().trim() == "") {
					
					alert("모두 입력하셔야 발급이 가능합니다!!");
					return false;
				}
			});
			
			var frm = document.registerFrm;
			frm.method="POST";
			frm.action="<%= request.getContextPath()%>/idIssued.top";
			frm.submit();
		});
	});
</script>

<div class="row" id="divRegisterFrm">

	<h2>사원 발급</h2>
	
	<form name="registerFrm">
	
		<table id="tblMemberRegister" style="width:700px;">
			<tbody>
			
				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">성명</td>
					<td style="width: 80%; text-align: left;">
					    <input type="text" name="employee_name" class="required" autocomplete="off" /> 
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">아이디</td>
					<td style="width: 80%; text-align: left;">
					    <input type="text" name="employee_id" value="${oneEmployee.employee_id}" readonly />
					</td> 
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">비밀번호</td>
					<td style="width: 80%; text-align: left;">
						<input type="text" name="employee_pw" value="${employee_pw}" readonly />
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">이메일</td>
					<td style="width: 80%; text-align: left;">
						<input type="text" name="email"  value="${email}" readonly />
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">핸드폰 번호</td>
					<td style="width: 80%; text-align: left;">
					    <input type="text" name="phone" class="required" placeholder="핸드폰 번호는 - 없이 작성해주십시요" autocomplete="off" />
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">우편번호</td>
					<td style="width: 80%; text-align: left;">
					   <input type="text" id="postcode" name="postcode" size="6" maxlength="5" style="width: 130px;" autocomplete="off" />&nbsp;&nbsp;
					   <button type="button" id="zipcodeSearch" style="background-color: #0099ff; border: none; color: #fff; cursor: pointer;">우편주소찾기</button>
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">주소</td>
					<td style="width: 80%; text-align: left;">
					   <input type="text" id="address" name="address" size="40" placeholder="주소" autocomplete="off" /><br/>
					   <input type="text" id="detailAddress" name="detailaddress" size="40" placeholder="상세주소" style="width: 200px;" autocomplete="off" />&nbsp;<input type="text" id="extraAddress" name="extraaddress" size="40" placeholder="참고항목" style="width: 200px;" autocomplete="off"/> 
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">성별</td>
					<td style="width: 80%; text-align: left;">
					   <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
					   <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">생년월일</td>
					<td style="width: 80%; text-align: left;">
					   <input type="text" name="birthday" class="datepicker" style="width: 150px;" class="required" autocomplete="off">
					</td>
				</tr>
				
				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">직책명</td>
					<td style="width: 80%; text-align: left;">
						<select name="position_seq" style="width: 60px; height: 30px;">
							<option value="1" selected>사원</option>
							<option value="2">대리</option>
							<option value="3">과장</option>
							<option value="4">부장</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3; color: white;">직책명</td>
					<td style="width: 80%; text-align: left;">
						<select name="department_seq" style="width: 170px; height: 30px;">
							<option value="" selected>==부서를 선택하세요==</option>
							<c:forEach var="departVO" items="${departmentList}">
								<option value="${departVO.department_seq}">${departVO.department_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>

			</tbody>
		</table>
		
	</form>
	
	<button type="button" id="btnIssued" class="snip1535">발급하기</button>
</div>