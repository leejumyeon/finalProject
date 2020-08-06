<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.firstCategory > td{
		font-size: 14pt;
		color:white;
		padding:10px;
		cursor: pointer;
	}
	
	.secondCategory{
		color:white;
	}
	
	.firstCategory:hover{
		background-color: skyblue;
	}
	
	.secondCategory > li:hover{
		text-decoration: underline;
		font-size: 12pt;
		color:black;
		font-weight: bold;
		cursor: pointer;
	}
	
	.hide{
		display:none;
	}
	
	.pannel{
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".accodion").each(function(index, item){
			$(item).click(function(){
				var pannel = $(this).next();
				console.log(pannel);
				pannel.toggleClass("hide");
			});
		});
	});
</script>
<div style="width:100%;">
	<table style="width:100%;">
		<tr class="firstCategory">
			<td onclick="javascript:location.href='<%=request.getContextPath()%>/adminMain.top'">1.메인</td>
		</tr>
		<tr class="firstCategory accodion">
			<td>2.인사<span class="caret"></span></td>
		</tr>
		<tr class="pannel hide">
			<td>
				<ul class="secondCategory">
					<li>사원정보</li>
					<li>인사고과</li>
					<li>계정발급</li>
				</ul>
			</td>
		</tr>
		<tr class="firstCategory accodion">
			<td>3.재무<span class="caret"></span></td>
		</tr>
		<tr class="pannel hide">
			<td>
				<ul class="secondCategory">
					<li>매출내역</li>
					<li>급여내역</li>
				</ul>
			</td>
		</tr>
		<tr class="firstCategory accodion">
			<td>4.결재<span class="caret"></span></td>
		</tr>
		<tr class="pannel hide">
			<td>
				<ul class="secondCategory">
					<li>결재현황</li>
					<li>문서함</li>
					<li>휴지통</li>
				</ul>
			</td>
		</tr>
		<tr class="firstCategory accodion">
			<td>5.게시글<span class="caret"></span></td>
		</tr>
		<tr class="pannel hide">
			<td>
				<ul class="secondCategory">
					<li onclick="javascript:location.href='<%=request.getContextPath()%>/manager/board/noticeList.top'">공지사항</li>
					<li>FAQ</li>
					<li>신고글 확인</li>
					<li>공지글 작성</li>
				</ul>
			</td>
		</tr>
		<tr class="firstCategory">
			<td onclick="javascript:location.href='<%=request.getContextPath()%>/manager/reservation.top'">6.예약</td>
		</tr>
	</table>
</div>