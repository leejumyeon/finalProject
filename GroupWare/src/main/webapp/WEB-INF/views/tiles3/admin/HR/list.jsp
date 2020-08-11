<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	.managerBtn{
		width: 90px;
		padding: 10px 0;
		cursor: pointer;
		border:solid 1px black;
		text-align: center;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
</script>


<div>
	<div style="display: inline-block;">
	<h3>사원정보</h3>
	</div>
</div>
<div id="listArea">
	<div align="right">
		<div class="managerBtn">요청만 보기</div>
	</div>
	<table class="table">
		<tr>
			<td>사원ID</td>
			<td>사원명</td>
			<td>직책</td>
			<td>부서</td>
			<td>메일</td>
			<td>입사한 날짜</td>
			<td>권한명</td>
			<td>수정요청</td>
		</tr>
	</table>
</div>
