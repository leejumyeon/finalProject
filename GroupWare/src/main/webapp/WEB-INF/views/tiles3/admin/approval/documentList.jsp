<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	#searchTypetArea{
		position:absolute; 
		width: 100%;
		height: 100px; 
		background-color: white; 
		display: none;
	}
	
	#searchTypeList{
		list-style:none; 
		padding: 0;
	}
	
	#searchTypeList div{
		margin-left:5px;
	}
	
	#searchTypeList > li:hover{
		background-color: #f5f5f5;
		cursor: pointer; 
	}
	
	.hide{
		display:none;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".prevday").datepicker({});
	    $(".today").datepicker({});   
	        // 기간 선택
	        $("#documentDay").change(function(){
	        	if($(this).val()!="" && $(this).val()!="direct"){
	        		$(".today").datepicker('setDate', '-7D');
		        	
	        		if($(this).val()=="week"){
	        			console.log("1주");
	        			$(".prevday").datepicker('setDate', '-7D');
	        		}
	        		else if($(this).val()=="month"){
	        			console.log("1달");
		        		$(".prevday").datepicker('setDate', '-1M');
		        	}
		        	else if($(this).val()=="threeMonth"){
		        		$(".prevday").datepicker('setDate', '-3M');
		        	}
		        	else if($(this).val()=="sixMonth"){
		        		$(".prevday").datepicker('setDate', '-6M');
		        	}
	        	}
	        	else{
	        		$(".datepicker").val("");
	        		// $(".datepicker").datepicker('setDate', '');
	        		console.log("초기화");
	        	}
	        	
	        });
	        
	}); // end of $(document).ready(function())-----------------------------------------------------
</script>

<div>
	<div style="display: inline-block;">
	<h3>문서함</h3>
	</div>
</div>
<form name="documentFrm">
<div id="searchArea">
	<div style="position: relative; display: inline;">
		<select name="documentType">
			<option>==문서종류==</option>
			<option>휴가신청</option>
			<option>출장신청</option>
			<option>매출</option>
			<option>비품구매</option>
			<option>프로젝트 시작</option>
			<option>프로젝트 중단</option>
			<option>프로젝트 완료</option>
			<option>퇴사</option>
			<option>인사고과</option>
			<option>동호회 신청</option>
			<option>동호회 가입</option>
			<option>동호회 해체</option>
		</select><br/>
		
		<select name="searchType">
			<option>신청자</option>
			<option>결재자</option>
			<option>제목</option>
			<option>내용</option>
		</select>
		<div style="border:solid 1px gray; display: inline-block;"><input type="text" size="20" name="searchWord" style="border: none;"/><span style="background-color: white">아이콘</span></div>
		
		<span onclick="javascript:$('#termSearch').toggleClass('hide')" style="cursor:pointer">기간</span>
	</div>
	<div id="termSearch" class="hide">
			<select id="documentDay" name="documentDay">
				<option value="">전체</option>
				<option value="week">1주</option>
				<option value="month">1개월</option>
				<option value="threeMonth">3개월</option>
				<option value="sixMonth">6개월</option>
				<option value="direct">직접입력</option>
			</select>
		<input type="text" class="datepicker prevday"> - <input type="text" class="datepicker today">
		<button type="button">검색</button>
	</div>
</div>
</form>
<div>
	<table class="table">
		<tr>
			<td>신청자</td>
			<td>신청날짜</td>
			<td>문서항목</td>
			<td>제목</td>
			<td>결제날짜</td>
			<td>삭제</td>
		</tr>
		<tr>
			<td>신청자</td>
			<td>신청날짜</td>
			<td>문서항목</td>
			<td>제목</td>
			<td>결제날짜</td>
			<td><input type="checkbox" name="delCheck" value=""/></td>
		</tr>
	</table>
	<div align="right">
		<div class="manaerBtn">선택삭제</div>
	</div>
</div>