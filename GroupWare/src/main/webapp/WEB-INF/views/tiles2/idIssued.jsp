<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row" id="divRegisterFrm">
	<div class="col-md-12" align="center">
	<form name="registerFrm">
	
	<table id="tblMemberRegister">
		<thead>
		<tr>
			<th colspan="2" id="th">::: 사원발급 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::</th>
		</tr>
		</thead>
		<tbody>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" name="name" id="name" required /> 
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" name="userid" id="userid" readonly />&nbsp;&nbsp;
			</td> 
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
				<input type="text" name="pwd" id="pwd" class="requiredInfo" />
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
				<input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" /> 
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">연락처</td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" id="hp1" name="hp1" size="6" maxlength="7" value="010" />&nbsp;-&nbsp;
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">우편번호</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
			   <img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" />
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">주소</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="address" name="address" size="40" placeholder="주소" /><br/>
			   <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">성별</td>
			<td style="width: 80%; text-align: left;">
			   <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
			   <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">생년월일</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="datepicker">
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">직책명</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="datepicker">
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">재직기간</td>
			<td style="width: 80%; text-align: left;">
				From: <input type="text" id="fromDate">&nbsp;&nbsp; 
				To: <input type="text" id="toDate">
			</td>
		</tr>
		</tbody>
	</table>
	</form>
	</div>
</div>