<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

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
		cursor: pointer; 
	}
	
	.select{
		background-color: #f5f5f5;
	}
	
	.hide{
		display:none;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".datepicker").datepicker({});
           
	        // 메일 검색 창 포커스 시 함수 실행
			$("#mailSearch").focus(function(){
				$("#searchTypetArea").css({"display":"block","border":"solid 1px yellowgreen"});
				var txtVal = $(this).val();
				func_searchTypeFind(txtVal);
			});
	        
	        $("#mailSearch").blur(function(){
	        	$("#searchTypetArea").css({"display":"none","border":"none"});
	        	
	        });
	        
	        $("#mailSearch").keyup(function(event){
	        	var txtVal = $(this).val();
	        	func_searchTypeFind(txtVal);
	        });
           
	        
	        // 기간 선택
	        $("#mailDay").change(function(){
	        	if($(this).val()!="" && $(this).val()!="direct"){
	        		$(".today").datepicker('setDate', 'today');
		        	
	        		if($(this).val()=="week"){
	        			$(".prevday").datepicker('setDate', '-7D');
	        		}
	        		else if($(this).val()=="month"){
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
	        
	        $(".datepicker").change(function(){
	        	$("#mailDay").val("direct");
	        });
	}); // end of $(document).ready(function())-----------------------------------------------------
	
	function func_searchTypeFind(val){
		var len = val.length;
		console.log(len);
		var html = "";
		if(len>0){
			html += "<ul id='searchTypeList'>";
			html+="<li onclick='goSearch("+val+", all)' class='select'><div>"+val+"-<span style='font-size:8pt; color:gray;'>전체검색</span></div></li>";
			html+="<li onclick='goSearch("+val+", sender)'><div>보낸사람: "+val+"-<span style='font-size:8pt; color:gray;'>보낸사람을 찾기</span></div></li>";
			html+="<li onclick='goSearch("+val+", receiver)'><div>받은사람: "+val+"-<span style='font-size:8pt; color:gray;'>받은사람을 찾기</span></div></li>";
			html+="<li onclick='goSearch("+val+", content)'><div>내용: "+val+"-<span style='font-size:8pt; color:gray;'>제목, 본문내용, 첨부파일을 찾기</span></div></li>";
		}
		else{
			
			html="검색어를 입력하세요";
		}
		
		$("#searchTypetArea").html(html);
	}
	
	function goSearch(val, category){
		location.href = "<%=request.getContextPath()%>/mail/list.top?searchWord="+val+"&type=search&searchType="+category;
	}
</script>
<div style="margin-left:10px;">
	<div id="searchArea">
		<div style="position: relative; display: inline;">
			<div style="border:solid 1px gray; display: inline-block;"><input type="text" size="20" id="mailSearch" style="border: none;"/><span style="background-color: white">아이콘</span></div>
			<span onclick="javascript:$('#termSearch').toggleClass('hide')" style="cursor:pointer">기간</span>&nbsp;&nbsp;<span style="font-weight: bold;">${mailhamType}</span>
			<div id="searchTypetArea"></div>
		</div>
		<div id="termSearch" class="hide">
			<select id="mailDay" name="mailDay">
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
		
		<div id="mailFunctionArea">
			<input type="checkbox" id="allCheck" name="allCheck" style="margin-left:10px;"/>
			<button type="button">기독</button>
			<button type="button">삭제</button>
			<button type="button">전달</button>
			<button type="button">답장</button>
		</div>
		<div id="mailList">
			<table class="table">
			<c:if test="${not empty mailList}">
				<c:if test="${mailhamType == '안 읽은 메일'}">
					<c:forEach var="mail" items="${mailList}">
						<tr style="color:blue;">
							<td><input type="checkbox" name="selectCheck" value="${mail.mail_seq}" /></td>
							<td>${mail.email}</td>
							
							<c:choose>
								<c:when test="${mail.mailStatus eq 0}">
									<td>[휴지통]${mail.subject}</td>
								</c:when>
								<c:when test="${mail.fk_employee_seq eq sessionScope.loginuser.employee_seq}">
									<td>[내게 쓴 메일]${mail.subject}</td>
								</c:when>
								<c:when test="${mail.fk_employee_seq ne sessionScope.loginuser.employee_seq}">
									<td>[받은 메일]${mail.subject}</td>
								</c:when>
							</c:choose>
							
							<td>${mail.regDate}</td>
						</tr>	
					</c:forEach>
				</c:if>
				<c:if test="${mailhamType == '받은메일' or mailhamType == '보낸메일' or mailhamType == '내게 쓴 메일'}">
					<c:forEach var="mail" items="${mailList}">
						<c:if test="${mail.readStatus ne '1' }">
							<tr style="color:blue;">
								<td><input type="checkbox" name="selectCheck" value="${mail.mail_seq}" /></td>
								<td>${mail.email}</td>
								<td>${mail.subject}</td>
								<td>${mail.regDate}</td>
							</tr>	
						</c:if>
						<c:if test="${mail.readStatus eq '1' }">
							<tr>
								<td><input type="checkbox" name="selectCheck" value="${mail.mail_seq}" /></td>
								<td>${mail.email}</td>
								<td>${mail.subject}</td>
								<td>${mail.regDate}</td>
							</tr>	
						</c:if>
						
					</c:forEach>
				</c:if>
			</c:if>
			
			<c:if test="${empty mailList}">
				<tr>
					<td colspan="4"> 받은 메일이 없습니다.</td>
				</tr>	
			
			</c:if>
			</table>
			<div id="pageBar"></div>
		</div>
		
	</div>
	
</div>