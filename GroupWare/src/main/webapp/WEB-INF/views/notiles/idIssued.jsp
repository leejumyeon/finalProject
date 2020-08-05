<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
		
		$(".datepicker").datepicker({});
		
	});
</script>
<div class="row" id="divRegisterFrm">

	<h2>사원 발급</h2>
	
	<form name="registerFrm">
	
		<table id="tblMemberRegister" style="width:700px;">
			<tbody>
			
				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">성명</td>
					<td style="width: 80%; text-align: left;">
					    <input type="text" name="employee_name" required autocomplete="off" /> 
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">아이디</td>
					<td style="width: 80%; text-align: left;">
					    <input type="text" name="employee_id" value="${employee_id}" readonly />
					</td> 
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">비밀번호</td>
					<td style="width: 80%; text-align: left;">
						<input type="text" name="employee_pw" value="${employee_pw}" readonly />
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">이메일</td>
					<td style="width: 80%; text-align: left;">
						<input type="text" name="email"  value="${email}" readonly />
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">핸드폰 번호</td>
					<td style="width: 80%; text-align: left;">
					    <input type="text" name="phone" placeholder="핸드폰 번호는 - 없이 작성해주십시요" autocomplete="off" />
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">우편번호</td>
					<td style="width: 80%; text-align: left;">
					   <input type="text" id="postcode" name="postcode" size="6" maxlength="5" style="width: 130px;" autocomplete="off" />&nbsp;&nbsp;
					   <button type="button" id="zipcodeSearch" style="background-color: #0099ff; border: none; color: #fff; cursor: pointer;">우편주소찾기</button>
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">주소</td>
					<td style="width: 80%; text-align: left;">
					   <input type="text" id="address" name="address" size="40" placeholder="주소" autocomplete="off" /><br/>
					   <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" style="width: 200px;" autocomplete="off" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" style="width: 200px;" autocomplete="off"/> 
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">성별</td>
					<td style="width: 80%; text-align: left;">
					   <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
					   <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
					</td>
				</tr>

				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">생년월일</td>
					<td style="width: 80%; text-align: left;">
					   <input type="text" name="birthday" class="datepicker" style="width: 150px;">
					</td>
				</tr>
				
				<tr>
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">직책명</td>
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
					<td style="width: 20%; font-weight: bold; background-color: #4da6ff; border: solid 0.5px #0059b3; border-right: solid 4px #0059b3;">경력기간</td>
					<td style="width: 80%; text-align: left;">
						From: <input type="text" name="fromDate" class="datepicker" style="width: 150px;">&nbsp;&nbsp;
						To: <input type="text" name="toDate" class="datepicker" style="width: 150px;">
					</td>
				</tr>
			</tbody>
		</table>
		
	</form>
	
	<button type="button" id="btnIssued" class="snip1535">발급하기</button>
</div>