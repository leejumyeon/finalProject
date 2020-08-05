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

	<div class="titleSection">동호회 해체 신청서</div>
	
	<div class="partition">
		
		<div class="left">
			<table style="width:270px; height:131px;">
				<colgroup><col width="65"><col width="270"></colgroup>
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
 
<table style="background: white; border: 1px solid black; width: 800px; color: black; font-family: malgun gothic,dotum,arial,tahoma; font-size: 12px; border-collapse: collapse !important;">
	<tbody>
		<tr>
			<td class="ACel">
				<span style="font-weight: bold; font-size: 11pt;">제목</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
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
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="ACel">
				<span style="font-weight: bold; font-size: 11pt;">회 원 수</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="ACel">
				<span style="font-weight: bold; font-size: 11pt;">해체일자</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="ACel">
				<span style="font-weight: bold; font-size: 11pt;">해체사유</span>
			</td>
			<td class="BCel">
				<span style="font-size: 10pt;"></span>
			</td>
		</tr>
		<tr>
			<td class="BCel" colspan="2" style="text-align: center;">
				<span style="font-size: 10pt;">위와 같이 동호회를 해체 하고자 하오니 재가 바랍니다.</span><br/>
				<span style="font-size: 10pt;">날짜</span>
			</td>
		</tr>
	</tbody>
</table>
</div>
