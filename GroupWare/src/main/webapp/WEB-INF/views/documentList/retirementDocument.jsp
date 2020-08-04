<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="titleSection">사직서</div>
	
	<div class="partition">
		
		<div class="left">
			<table style="width:230px; height:131px;">
				<colgroup><col width="65"><col width="200"></colgroup>
				<tbody>
					<tr><td class="ACel">문서번호</td><td class="BCel"><span data-dsl="{{label:docNo}}"></span></td></tr>
					<tr><td class="ACel">기안일</td><td class="BCel"><span data-dsl="{{label:draftDate}}"></span></td></tr>
					<tr><td class="ACel">기안자 부서</td><td class="BCel"><span data-dsl="{{label:draftDept}}"></span></td></tr>
					<tr><td class="ACel">기안자</td><td class="BCel"><span data-dsl="{{label:draftUser}}"></span></td></tr>
					<tr><td class="ACel">공개여부</td><td class="BCel"><span data-dsl="{{label:draftUser}}"></span></td></tr>
					<tr><td class="ACel">보존기간</td><td class="BCel"><span data-dsl="{{label:draftUser}}"></span></td></tr>
				</tbody>
			</table>
		</div>
		
		<table width="644" style="border-collapse:collapse; margin-bottom: 15px;" class="form2" align="center">
			<tr>
				<td align="right">
					<table border="1" style="border-collapse: collapse;">
						<tr>
							<td width="25" height="120" rowspan="3" align="center" bgcolor="#D9E2F3">결<br>
							<br>
							<br>
							재</td>
							<td width="80" height="25" style="text-align: center; font-size: 10pt; font-style: italic; font-weight: bold;">
								기안자
							</td>
						</tr>
						<tr>
							<td height="25" style="text-align: center; font-size: 8pt;">
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
     
<table style="border-bottom: rgb(0,0,0) 1px solid; border-left: 2px solid; margin-top: 10px; width: 800px; border-collapse: collapse; font-family: malgun gothic, dotum, arial, tahoma; border-top: 2px solid; border-right: 2px solid"><!-- user -->  
	<tr>
		<td class="ACel">
			<span style="font-weight: bold; font-size: 11pt;">제 목</span>
		</td>
		<td class="BCel" colspan="5">
			<input>
		</td>
	</tr>
	<tbody>
		<tr>
			<td class="ACel" style="width: 50px;">
				직&nbsp;&nbsp;&nbsp;&nbsp;위
			</td>
			<td class="ACel" style="width: 50px;">
				사&nbsp;&nbsp;&nbsp;&nbsp;번
			</td>
			<td class="ACel" style="width: 50px;">
				성&nbsp;&nbsp;&nbsp;&nbsp;명
			</td>
			<td class="ACel" style="width: 50px;">
				근무기간
			</td>
			<td class="ACel" style="width: 50px;">
				근무부서
			</td>
			<td class="ACel" style="width: 50px;">
				담당업무
			</td>
		</tr>
		<tr>
			<td class="BCel">

			</td>
			<td class="BCel">

			</td>
			<td class="BCel">

			</td>
			<td class="BCel">

			</td>
			<td class="BCel">

			</td>
			<td class="BCel">

			</td>
		</tr>
		<tr>
			<td class="ACel" colspan="6">
				사직사유 (상세히 기술)
			</td>
		</tr>
		<tr>
			<td class="BCel" colspan="6">
				<textarea rows="" cols=""></textarea>
			</td>
		</tr>
		<tr>
			<td class="ACel">
				사직희망일
			</td>
			<td class="BCel" colspan="5">
				<input>
			</td>
		</tr>
		<tr>
			<td class="ACel" colspan="6">
				- 소속 부서 면담 결과 -
			</td>
		</tr>
		<tr>
			<td class="ACel">
				면담 일시
			</td>
			<td class="BCel" colspan="5">
				<input>
			</td>
		</tr>
		<tr>
			<td class="ACel">
				면담 내용<br/>(구체적 기술)
			</td>
			<td class="BCel" colspan="5">
				<textarea rows="" cols=""></textarea>
			</td>
		</tr>
		<tr>
			<td class="ACel">
				처리내용
			</td>
			<td class="BCel" colspan="5">
				<textarea rows="" cols=""></textarea>
			</td>
		</tr>
	</tbody>
</table>
     
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
				<input>
			</td>
		</tr>
		<tr>
			<td class="ACel">
				전화번호
			</td>
			<td class="BCel">
				<input>
			</td>
			<td class="ACel">
				휴대폰 번호
			</td>
			<td class="BCel">
				<input>
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