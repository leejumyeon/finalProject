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

	<div class="titleSection">프로젝트 신청 기안서</div>
	
	<div class="partition">
		
		<div class="left">
			<table style="width:270px; height:131px;">
				<colgroup><col width="65"><col width="270"></colgroup>
				<tbody>
					<tr><td class="ACel">문서번호</td><td class="BCel"><span data-dsl="{{label:docNo}}"></span></td></tr>
					<tr><td class="ACel">기안일</td><td class="BCel"><span data-dsl="{{label:draftDate}}"></span></td></tr>
					<tr><td class="ACel">기안자 부서</td><td class="BCel"><span data-dsl="{{label:draftDept}}"></span></td></tr>
					<tr><td class="ACel">기안자</td><td class="BCel"><span data-dsl="{{label:draftUser}}"></span></td></tr>
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
							<td width="90" height="25" style="text-align: center; font-size: 10pt; font-style: italic; font-weight: bold;">
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

<h3>1. 일반사항</h3>
<table class="detailSection">
	<tbody>
		<tr>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">문서 제목</span>
			</td>
			<td class="BCel" colspan="3">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">프로젝트명</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">거래처명</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">프로젝트 시작날짜</span>
			</td>
			<td class="BCel" style="text-align: left;">
				<input style="width: 80px; height: 20px; font-size: 9pt;" type="text" id="date1" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required />
			</td>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">프로젝트 기간</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">관리자</span>
			</td>
			<td class="BCel" style="text-align: left;">
				<input style="width: 80px; height: 20px; font-size: 9pt;" type="text" id="date1" class="datepicker" size="20" placeholder="기간선택" maxlength="10" required />
			</td>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">인원</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">프로젝트 내용</span>
			</td>
			<td class="BCel" colspan="3">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
	</tbody>
</table>

<br/>

<h3>2. 비용</h3>
<table class="detailSection">
	<tbody>
		<tr>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">계약금</span>
			</td>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">중도금</span>
			</td>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">완료금</span>
			</td>
			<td class="ACel" style="width: 150px;">
				<span style="font-weight: bold; font-size: 11pt;">합계</span>
			</td>
		</tr>
		<tr>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
	</tbody>
</table>

<h3>2. 프로젝트 인원</h3>
<table class="detailSection">
	<tbody id="dynamic_table2">
		<tr>
			<td class="ACel" rowspan="2">
				<span style="font-weight: bold; font-size: 11pt;">프로젝트 인원</span>
			</td>
			<td class="ACel">
				<span style="font-weight: bold; font-size: 11pt;">부서</span>
			</td>
			<td class="ACel">
				<span style="font-weight: bold; font-size: 11pt;">직위</span>
			</td>
			<td class="ACel">
				<span style="font-weight: bold; font-size: 11pt;">성명</span>
			</td>
		</tr>
		<tr class="copyRow2">
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
	</tbody>
</table>
</div>