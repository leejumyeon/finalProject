<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	.p  {padding-left: 2;}
	.pline {padding-bottom: 3px;}
	.c12 {width:12;cursor:hand;border:1px solid;text-align:right;font-size:9; background-color: "#FFFFFF"}
	
	.form11b {
		font-family: "맑은 고딕";
		font-size: 11pt;
		color: #000000;
		text-decoration: none;
		letter-spacing:0px;
		font-weight:bold;
	}
	
	.form11 {
		font-family: "맑은 고딕";
		font-size: 11pt;
		color: #000000;
		text-decoration: none;
		letter-spacing:0px;
	}
	
	.form10b {
		font-family: "맑은 고딕";
		font-size: 10pt;
		color: #000000;
		text-decoration: none;
		letter-spacing:0px;
		font-weight:bold;
	}
	
	.form10 {
		font-family: "맑은 고딕";
		font-size: 10pt;
		color: #000000;
		text-decoration: none;
		letter-spacing:0px;
	}
	
	.form16b {
		font-family: "맑은 고딕";
		font-size: 16pt;
		color: #000000;
		text-decoration: none;
		letter-spacing:0px;
		font-weight:bold;
	}
	
	.form2 {	font-family: "맑은 고딕";
		font-size: 12px;
		color: #000000;
		text-decoration: none;
		letter-spacing:0px;
	}


	A:link {font-family: "맑은 고딕";font-size: 10pt;  text-decoration:none; color: black;}
	A:visited {font-family: "맑은 고딕";font-size: 10pt; text-decoration:none; color: black;}
	A:active {font-family: "맑은 고딕";font-size: 10pt; text-decoration:underline; color: black;}
	A:hover {font-family: "맑은 고딕";font-size: 10pt;color: black; text-decoration:underline;}

</style>

<body>

<table class="form10" align="center">
	<tr valign="middle" bgcolor="white">
		<td width="643" height="93" align="center" class="form16b">
			<div id="title" style="font-size: 18pt">휴가신청서</div>
		</td>
	</tr>
</table>

<table width="644" style="border-collapse:collapse; margin-bottom: 15px;" class="form2" align="center" >
	<tr>
		<td align="right">
			<table border="1" style="border-collapse: collapse;">
				<tr>
					<td width="25" height="100" rowspan="2" align="center" bgcolor="#D9E2F3" class="form10b">결<br>
					<br>
					<br>
					재</td>
					<td width="75" height="25" style="text-align: center;">
						기안자
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

<table width="644" border="1" style="border-collapse: collapse;" align="center" class="form10">
	<tr>
		<td height="40" colspan="3" align="center" bgcolor="#D9E2F3" class="form10b">문서번호</td>
		<td align="center" class="form10"><div id="docno"></div></td>
		<td align="center" bgcolor="#D9E2F3" class="form10b">작성일자</td>
		<td align="center" class="form10"><DIV id="to_date" style="padding:3px;"></DIV></td>
	</tr>

	<tr>
		<td height="40" colspan="3" align="center" bgcolor="#D9E2F3"  class="form10b">이 름</td>
		<td width="182" align="center" class="form10"><div id="username"></div></td>
		<td width="79" align="center" bgcolor="#D9E2F3" class="form10b">직 책</td>
		<td align="center" class="form10"><div id="pp"></div></td>
	</tr>

	<tr>
		<td height="40" colspan="3" align="center" bgcolor="#D9E2F3"  class="form10b">부서(팀)</td>
		<td colspan="3" align="center" class="form10"><div tms_edit id="jic2"></div></td>
	</tr>
	
	<tr>
		<td height="40" colspan="3" align="center" bgcolor="#D9E2F3" class="form10b">제 목</td>
		<td colspan="3" align="left" class="form10"><DIV id="title1" style="padding:3px;">휴가신청서[]</DIV></td>
	</tr>

	<tr>
		<td width="38" rowspan="4" align="center" bgcolor="#D9E2F3"  class="form10b">신<br>
			청<br>
			내<br>
			용
		</td>
		<td width="40" rowspan="2" align="center" bgcolor="#D9E2F3"  class="form10b">휴<br>
			가<br>
			신<br>
			청<br>
			서
		</td>
		<td width="103" height="50" align="center" bgcolor="#D9E2F3"  class="form10b">종류</td>
		<td colspan="3" align="left" class="form10">
			<select ></select>
		</td>
	</tr>
	
	<tr>
		<td height="40" align="center" bgcolor="#D9E2F3" class="form10b">일정</td>
		<td colspan="3" align="left" class="form10">
			<table width="100%" align="center" class="form2" style="border-collapse: collapse;">
				<tr>
					<td width="33%" align="left" class="form2"><div  id="h_sdate" onClick="calendar(this, 'todate1')" style="padding:3px;cursor:hand;"></div></td>
					<td width="6%" align="center" class="form2">~</td>
					<td width="33%" align="left" class="form2"><div  id="h_edate" onClick="calendar(this, 'todate1')" style="padding:3px;cursor:hand;"></div></td>
					<td width="3%" align="left" class="form2">&nbsp;</td>
					<td width="25%" align="left" class="form2"><div tms_edit id="h_caldate" style="padding:3px">()</div></td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td height="200" colspan="2" align="center" bgcolor="#D9E2F3"  class="form10b">신청사유<br>(자세히)</td>
		<td colspan="3" align="left" valign="top" class="form10" onClick="javascript:as2.focus();"><DIV tms_edit id="as2" style="padding:3px;"><DIV></td>
	</tr>
  
	<tr>
		<td height="40" colspan="2" align="center" bgcolor="#D9E2F3"  class="form10b">긴급연락처</td>
		<td colspan="3" align="left"  class="form10" ><div tms_edit id="jic5" style="padding:3px"></div></td>
	</tr>
 
	<tr>
		<td height="60" colspan="3" align="center" bgcolor="#D9E2F3"  class="form10b">참고사항</td>
		<td colspan="3" align="left" class="form10" onClick="javascript:as2.focus();">
			<b><font color=red >&nbsp;1. 수신자에 인사팀, 총무팀 추가 바랍니다.</font></b><br>
			&nbsp;2. 대휴 신청은 휴일/연장 근무 신청서를 반드시 첨부 바랍니다.
		</td>
	</tr>

 <tr>
    <td height="40" colspan="3" align="center" bgcolor="#D9E2F3"  class="form10b" style="cursor:hand;" onClick="javascript:fun('add_file')">첨부파일</td>
    <td colspan="3" align="left" class="form10" onClick="javascript:as3.focus();"><DIV   id="files" style="padding:3px;">
      <DIV></td>
  </tr>
</table>
<table width="700" border="0"  cellspacing="0" cellpadding="0" bordercolor="#ffffff" style="border-collapse:collapse;" class="form16" align="center" >
   	<tr>
        	<td></td>
  </tr>
</table>
</body>
