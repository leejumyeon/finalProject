<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	#listArea{
		display: inline-block;
		width: 600px;
		float:left;
	}
	
	.infoArea{
		display: inline-block;
		width: 200px;
	}
	
	.hide{
		display: none;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".pick").each(function(index, item){
			$(item).click(function(){
				$(".infoArea").toggleClass("hide");
			});
		});
	});
</script>


<div>
	<div style="display: inline-block;">
	<h3>인사고과</h3>
	</div>
</div>
<div id="listArea">
	<table class="table">
		<tr>
			<td>부서</td>
			<td>사원</td>
			<td>직책</td>
			<td>근무태도</td>
			<td>출결</td>
			<td>업무성과</td>
			<td>결과</td>
			<td>부서장</td>
			<td>기록날짜</td>
		</tr>
		<tr class="pick">
			<td>부서</td>
			<td>사원</td>
			<td>직책</td>
			<td>근무태도</td>
			<td>출결</td>
			<td>업무성과</td>
			<td>결과</td>
			<td>부서장</td>
			<td>기록날짜0</td>
		</tr>
		<tr class="pick">
			<td>부서</td>
			<td>사원</td>
			<td>직책</td>
			<td>근무태도</td>
			<td>출결</td>
			<td>업무성과</td>
			<td>결과</td>
			<td>부서장</td>
			<td>기록날짜1</td>
		</tr>
	</table>
</div>
<div class="infoArea hide">
	<div id="chartArea">
		과거기록 포함 차트 출력
	</div>
	<div id="reasonArea">
		클릭한 기록의 사유 출력
	</div>
</div>
<div style="clear:both;"></div>