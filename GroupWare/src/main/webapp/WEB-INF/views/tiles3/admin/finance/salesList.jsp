<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	.changeBtn{
		cursor: pointer;
		width: 80px;
		text-align: center;
		border:solid 1px blue;
		padding: 5px 0;
	}
</style>

<div>
	<div style="display: inline-block;">
	<h3>매출내역</h3>
	</div>
</div>
<div id="chartArea">
	<div id="container"></div>
	<div align="right">
		<div class="changeBtn">change</div>
	</div>
</div>
<div id="listArea">
	<table class="table">
		<thead>
			<tr>
				<th>매출번호</th>
				<th>매출내용</th>
				<th>매출금액</th>
				<th>매출날짜</th>
			</tr>
		</thead>
		<tbody>
			
		</tbody>
	</table>
</div>