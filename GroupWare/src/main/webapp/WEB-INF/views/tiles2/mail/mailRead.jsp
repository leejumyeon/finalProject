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
		background-color: #f5f5f5;
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
           
		// 메일 검색 창 포커스 시 함수 실행
		$("#mailSearch").focus(function(){
			$("#searchTypetArea").css({"display":"block","border":"solid 1px yellowgreen"});
			var txtVal = $(this).val();
			func_searchTypeFind(txtVal);
		});
        
         $("#mailSearch").blur(function(){
        	$("#searchTypetArea").css({"display":"none","border":"none"});
        });
        
         // 메일 검색창에 키보드로 값 입력할 때 실행
        $("#mailSearch").keyup(function(event){
        	var txtVal = $(this).val();
        	var code = event.keyCode;
        	console.log(code);
        	if(code == 13){	// enter키 입력했을 경우
				if(txtVal.length>0){
					if($(".select").hasClass("all")){
						goSearch(txtVal, "all");
					}
					else if($(".select").hasClass("send")){
						goSearch(txtVal, "send");
					}
					else if($(".select").hasClass("receive")){
						goSearch(txtVal, "receive");
					}
					else if($(".select").hasClass("content")){
						goSearch(txtVal, "content");
					}
						
				}
			}
        	else if(code == 40 || code == 38){ // 위, 아래 방향키 입력했을 경우
				if(!$("#findEmail").hasClass("hide")){
					var currentSelect = $(".select");
					var nextSelect = currentSelect.next();
					var prevSelect = currentSelect.prev();
					
					if(code == 40){
						if(currentSelect.hasClass("content")){
							$(".all").addClass("select");
						}else{
							nextSelect.addClass("select");
						}
						
						currentSelect.removeClass("select");
						
					}else{
						if(currentSelect.hasClass("all")){
							$(".content").addClass("select");
						}else{
							prevSelect.addClass("select");
						}
						currentSelect.removeClass("select");
					}
				}
				console.log("방향키");
			}
        	else{ // 그 이외의 값을 입력했을 경우
        		func_searchTypeFind(txtVal);
        	}
        	
        });
          
        
        // 검색 아이콘 클릭시 전체검색으로 자동 실행
        $(".icon").click(function(){
        	goSearch( $("#mailSearch").val(),"all");
        });
           
	        
	}); // end of $(document).ready(function())-----------------------------------------------------
	
	// 메일 검색 타입 선택
	function func_searchTypeFind(val){
		var len = val.length;
		console.log(len);
		console.log(val +"/"+ typeof(val));
		var html = "";
		if(len>0){
			html += "<ul id='searchTypeList'>";
			html+="<li onclick='goSearch(\""+val+"\", \"all\")' class='all select'><div>"+val+"-<span style='font-size:8pt; color:gray;'>전체검색</span></div></li>";
			html+="<li onclick='goSearch(\""+val+"\", \"send\")' class='receive'><div>보낸사람: "+val+"-<span style='font-size:8pt; color:gray;'>보낸사람을 찾기</span></div></li>";
			html+="<li onclick='goSearch(\""+val+"\", \"recieve\")' class='send'><div>받은사람: "+val+"-<span style='font-size:8pt; color:gray;'>받은사람을 찾기</span></div></li>";
			html+="<li onclick='goSearch(\""+val+"\", \"content\")' class='content'><div>내용: "+val+"-<span style='font-size:8pt; color:gray;'>제목, 본문내용, 첨부파일을 찾기</span></div></li>";
		}
		else{
			
			html="검색어를 입력하세요";
		}
		
		$("#searchTypetArea").html(html);
	}
	
	// 메일 검색
	function goSearch(val, category){
		console.log(category);
		location.href = "<%=request.getContextPath()%>/mail/list.top?searchWord="+val+"&type="+category;
	}
	
	// 파일 다운로드
	function func_download(fileName, orgFileName, status){
		console.log(fileName+"/"+orgFileName+"/"+status);
		var frm = document.fileFrm;
		/* $("input[name=fileName]").val(fileName);
		$("input[name=orgFileName]").val(orgFileName);
		$("input[name=status]").val(status); */
		frm.fileName.value = fileName;
		frm.orgFileName.value = orgFileName;
		frm.status.value = status;
		frm.method="post";
		frm.action="<%=request.getContextPath()%>/mail/download.top";
		frm.submit();
	}
	
	//메일 삭제(메일함 -> 휴지통)
	function mailDel(){
		//$("input[name=selectCheck]").val("${mail.mail_seq}")
		var frm = mailFrm;
		frm.selectCheck.value = "${mail.mail_seq}";
		frm.action = "<%=request.getContextPath()%>/mail/mailDel.top";
		frm.method = "get";
		frm.submit();
	}
	
	// 읽기페이지 이동(메일함 별로 읽기페이지에서 보여질 다음글 / 이전글 내용 달리 줘야 함)
	function goRead(value){
		//$("input[name=readSeq]").val(value);
		var frm = mailFrm;
		frm.readSeq.value = value;
		frm.action = "<%=request.getContextPath()%>/mail/read.top";
		frm.method = "get";
		frm.submit();
	}
	
	// 전달 페이지 이동
	function mailRelay(){
		var frm = mailFrm;
		frm.readSeq.value = "${mail.mail_seq}";
		frm.secendType.value = "relay";
		frm.action = "<%=request.getContextPath()%>/mail/mailUpdate.top";
		frm.method = "get";
		frm.submit();
		
	}
	
	// 답장 페이지 이동
	function mailReply(){
		var frm = mailFrm;
		frm.readSeq.value = "${mail.mail_seq}";
		frm.secendType.value = "reply";
		frm.action = "<%=request.getContextPath()%>/mail/mailUpdate.top";
		frm.method = "get";
		frm.submit();
	}
</script>
<div style="margin-left:10px;">
	
	<div id="searchArea">
		<div style="position: relative; display: inline;">
			<div style="border:solid 1px gray; display: inline-block;"><input type="text" size="20" id="mailSearch" name="searchWord" value="" style="border: none;" autocomplete="off"/><span style="background-color: white; cursor: pointer;" class="icon">아이콘</span></div>
			&nbsp;&nbsp;
			<c:choose>
				<c:when test="${not empty searchWord}">
					<c:choose>
						<c:when test="${type eq 'receive'}">보낸사람 검색: </c:when>
						<c:when test="${type eq 'send'}">받은사람 검색: </c:when>
						<c:when test="${type eq 'content'}">내용 검색: </c:when>
						<c:when test="${type eq 'all'}">전체 검색 : </c:when>
					</c:choose>
					${searchWord}
				</c:when>
				<c:otherwise>
					<span style="font-weight: bold;">${mailhamType} / ${total}</span>
				</c:otherwise>	
			</c:choose>
			<input type="hidden" name="type" value="${type}" />
			<div id="searchTypetArea"></div>
		</div>
		
		<div id="mailFunctionArea">
			<c:choose>
				<c:when test="${type eq 'del'}">
					<button type="button" onclick = "mailDeletion()">영구삭제</button>
					<button type="button" onclick = "mailRestore()">복구하기</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick = "mailDel()">삭제</button>
					<button type="button" onclick = "mailRelay()">전달</button>
					<c:if test="${type eq 'receive' or (type eq 'all' and mail.status eq '1')}">
						<button type="button" onclick = "mailReply()">답장</button>
					</c:if>
				</c:otherwise>
			</c:choose>
			
		</div>
	</div>
		<div id="mailDetail">
			<div id="subject">
				<h3>${mail.subject}</h3>
			</div>
			<div id="sender">
				<span>보낸사람 : </span> ${sender.employee_name}(${sender.email})
			</div>
			<div id="receiver">
				<span>받은사람 :</span>
				<c:forEach var="receive" items="${receiver}" varStatus="status">
					<c:if test="${status.index == 0}">
						${receive.employee_name}(${receive.email})
					</c:if>
					<c:if test="${status.index != 0 }">
						, ${receive.employee_name}(${receive.email})
					</c:if>
				</c:forEach>
			</div>
			
			<form name="fileFrm">
			<input type="hidden" name="fileName" />
			<input type="hidden" name="orgFileName" />
			<input type="hidden" name="status" />
			<div>
				<div style="display: inline-block;">첨부파일</div>
				<div style="display: inline-block;">
					<c:if test="${not empty mail.fileName1}">
						<div onclick="func_download('${mail.fileName1}','${mail.orgFileName1}','${mail.status}')">${mail.orgFileName1}</div>
					</c:if>	
					<c:if test="${not empty mail.fileName2}">
						<div onclick="func_download('${mail.fileName2}','${mail.orgFileName2}','${mail.status}')">${mail.orgFileName2}</div>
					</c:if>	
					<c:if test="${not empty mail.fileName3}">
						<div onclick="func_download('${mail.fileName3}','${mail.orgFileName3}','${mail.status}')">${mail.orgFileName3}</div>
					</c:if>	
				</div>
			</div>
			</form>
			
			<div id="content">
				${mail.content}
			</div>
		</div>
	<form name="mailFrm" >
		<input type="hidden" name="type" value="${type}" />
		<input type="hidden" name="secendType" value="" />
		<input type="hidden" value="" name="readSeq" />
		<input type="hidden" value="" name="selectCheck" />
		<input type="hidden" name="searchWord" value="${searchWord}" />
		<div id="other">
			<ul>
				<c:if test="${mail.next_seq != null}">
					<li onclick="goRead('${mail.next_seq}')">다음글 | ${mail.next_subject}</li>
				</c:if>
				<c:if test="${mail.prev_seq != null}">
					<li onclick="goRead('${mail.prev_seq}')">다음글 | ${mail.prev_subject}</li>
				</c:if>
			</ul>
		</div>
	</form>
</div>