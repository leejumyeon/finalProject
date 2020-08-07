<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    

<style type="text/css">
	#container {
		width: 1240px;
		margin: 0 auto;
	}	
	table {
		width: 1180px;
		margin: 0 auto;
	}
	table, th, td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	th{
		width: 120px;
		font-size: 11pt;
		background-color: #3399ff;
		height: 40px;
		color: white;
	}
	td{
		padding: 10px;
		width: 468px;
		
	}	
	  
</style>
<script type="text/javascript">

$(document).ready(function() {
    $('#review').on('keyup', function() {
        if($(this).val().length > 500) {
            $(this).val($(this).val().substring(0, 500));
        }
    });
});
</script>
<div id="container" style="margin-top: 100px;">
	<table>
		<tbody>
			<tr>
				<th>제목</th>
				<td colspan="3"></td>
			</tr>
			<tr>
				<th>글번호</th>
				<td></td>
				<th>작성자</th>
				<td></td>
			</tr>
			<tr>
				<th>작성날짜</th>
				<td></td>
				<th>조회수</th>
				<td></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3" style="width: 1158px;"></td>
			</tr>
			<tr>
				<th colspan="5">내용</th>					
			</tr>			
			<tr>
				<td colspan="5" style="width: 1178px;"></td>
			</tr>	
		</tbody>				
	</table>
	<br/>
	<div>
		<p>이전글&nbsp;:&nbsp;</p>
		<span class="move" onclick="javascript:location.href=''"></span>
	</div>
	<div>
		<p>다음글&nbsp;:&nbsp;</p>
		<span class="move" onclick="javascript:location.href=''"></span>
	</div>
	<br/>
		<button type="button" onclick="javascript:location.href=''">목록보기</button>
		<button style="margin-right: 10px;" type="button" onclick="javascript:location.href=''">수정</button>
		<button style="margin-right: 10px;" type="button" onclick="javascript:location.href=''">삭제</button>
		<button style="margin-right: 10px;" type="button" onclick="javascript:location.href=''">답변글쓰기</button>		
	<h3>댓글</h3>
	<p id="border" style="width: 1180px; margin: 0 auto;"></p>
	<p>등록된 내용이 없습니다.</p>
	<br/>
	<div style="margin-left: 30px;">
		<h4>덧글쓰기</h4>
		<p style="width: 1000px; margin: 0; display: inline-block;">500자까지 입력할 수 있습니다.</p>
	</div>
	<form style="text-align: center;">
		<textarea id="review" name="review" rows="5" cols="100" maxlength="500" autofocus="autofocus" required style="width: 1174px; height: 94px;"></textarea>
	</form>
	<button style="margin-top: 5px;" type="button" onclick="javascript:location.href=''">등록하기</button>	
</div>