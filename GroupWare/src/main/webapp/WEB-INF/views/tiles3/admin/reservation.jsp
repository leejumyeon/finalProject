<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>예약관리</h3>
<div id="content_area">
	<div class ="table_title" style="margin-top:5px;">
		<div class="searchArea" style="display:inline-block; float:right;">
			장소선택 : 
			<select>
				<option>전체</option>
				<option>소회의실</option>
				<option>중회의실</option>
				<option>대회의실</option>
			</select>
		</div>
		<h4 style="display: inline-block;">예약 신청 현황</h4>
	</div>
	<div style="clear:both;"></div>
	<table class="table">
		<tr>
			<td>예약번호</td>
			<td>신청자</td>
			<td>장소</td>
			<td>시작시간</td>
			<td>종료시간</td>
			<td>인원수</td>
			<td>신청날짜</td>
		</tr>
	</table>
	
	<div class ="table_title" style="margin-top:5px;">
		<div class="searchArea" style="display:inline-block; float:right;">
			승인상태 : 
			<select>
				<option>전체</option>
				<option>승인</option>
				<option>반려</option>
			</select>
			
			장소선택 : 
			<select>
				<option>전체</option>
				<option>소회의실</option>
				<option>중회의실</option>
				<option>대회의실</option>
			</select>
		</div>
		<h4 style="display: inline-block;">예약 현황</h4>
	</div>
	<div style="clear:both;"></div>
	<table class="table">
		<tr>
			<td>예약번호</td>
			<td>신청자</td>
			<td>장소</td>
			<td>시작시간</td>
			<td>종료시간</td>
			<td>인원수</td>
			<td>신청날짜</td>
			<td>승인상태</td>
		</tr>
	</table>
	
	<div class="popup" style="border: solid 1px black; width:300px;">
		<table>
			<tr>
				<th>받는 사람</th>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<th style="vertical-align: top;">내용</th>
				<td><textarea style="resize: none; width:100%;" rows="5"></textarea></td>
			</tr>
		</table>
		<div>
		<span style="border:solid 1px black; padding:10px 20px; margin:20px; float:right;">전송</span>
		</div>
		<div style="clear:both;"></div>
	</div>
	
</div>