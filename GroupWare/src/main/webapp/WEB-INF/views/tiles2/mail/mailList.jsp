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
	
	.mailSubject:hover{
		cursor: pointer;
		text-decoration: underline;
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
        
        /*  $("#mailSearch").blur(function(){
        	$("#searchTypetArea").css({"display":"none","border":"none"});
        }); */
        
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
        
        // 읽음 버튼 클릭시 readStatus 1로업데이트
        $(".read").click(function(){
        	if($("input[name=selectCheck]:checked").length  == 0){
        		alert("메일을 선택해주세요!");
        		return false;
        	}
        	
        	$("input[name=read]").val("1");
        	$("input[name=searchWord]").val("${searchWord}");
        	var frm = document.mailFrm;
        	frm.method="get";
        	frm.action="<%=request.getContextPath()%>/mail/readUpdate.top";
        	frm.submit();
        });
        
        // 안읽음 버튼 클릭 시 readStatus 0으로 업데이트
        $(".noread").click(function(){
        	if($("input[name=selectCheck]:checked").length  == 0){
        		alert("메일을 선택해주세요!");
        		return false;
        	}
        	
        	$("input[name=read]").val("0");
        	$("input[name=searchWord]").val("${searchWord}");
        	var frm = document.mailFrm;
        	frm.method="get";
        	frm.action="<%=request.getContextPath()%>/mail/readUpdate.top";
        	frm.submit();
        });
        
        // 체크박스 선택(전체)
        $("#allCheck").click(function(){
        	var bool = $(this).prop("checked");
        	$("input[name=selectCheck]").each(function(index,item){
        		$(item).prop("checked",bool);
        	});
        });
        
        // 체크박스 선택(개별)
        $("input[name=selectCheck]").each(function(index, item){
        	$(item).click(function(){
        		console.log($(this).prop("checked"));
	        	if($(this).prop("checked")){
	        		var len = $("input[name=selectCheck]").length;
	        		var checkLen =  $("input[name=selectCheck]:checked").length;
	        		if(len == checkLen){
	        			$("#allCheck").prop("checked",$(this).prop("checked"));
	        		}
	        	}
	        	else{ // 선택 체크 해제시 전채 선택 체크 해제
	        		$("#allCheck").prop("checked",$(this).prop("checked"));
	        	}
	        });
        });
       
        // 검색리스트 마우스 오버
        $(document).on("mouseenter","#searchTypeList li",function(event){
        	$(this).addClass("select");
        	$(this).siblings().removeClass("select");
        });
        
        // 검색리스트 항목에서 마우스 오버
        $(document).on("mouseleave","#searchTypeList li",function(event){
        	$(this).removeClass("select");
        });
        
        $(document).on("mouseleave","#searchTypeList",function(event){
        	$("#searchTypeList .all").addClass("select");
        });
        
        
        // 페이지 호출하기 전에 전체 선택이 되어있을 시에 페이지 호출 후에도 전체선택 상태로 유지하기
       	var len = $("input[name=selectCheck]").length;
		var checkLen =  $("input[name=selectCheck]:checked").length;
		console.log(len+"/"+checkLen);
		if(len == checkLen && len != 0){
			$("#allCheck").prop("checked",true);
		}
	        
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
			html+="<li onclick='goSearch(\""+val+"\", \"receive\")' class='send'><div>받은사람: "+val+"-<span style='font-size:8pt; color:gray;'>받은사람을 찾기</span></div></li>";
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
		location.href="<%=request.getContextPath()%>/mail/list.top?searchWord="+val+"&type="+category;
	}
	
	// 파일 다운로드
	function func_download(fileName, orgFileName, status){
		console.log(fileName+"/"+orgFileName+"/"+status);
		var frm = document.mailFrm;
		$("input[name=fileName]").val(fileName);
		$("input[name=orgFileName]").val(orgFileName);
		$("input[name=status]").val(status);
		
		frm.method="post";
		frm.action="<%=request.getContextPath()%>/mail/download.top";
		frm.submit();
	}
	
	//메일 삭제(메일함 -> 휴지통)
	function mailDel(){
		if($("input[name=selectCheck]:checked").length <= 0){
			alert("삭제할 메일을 선택해주세요!");
			return false;
		}
		var frm = mailFrm;
		frm.action = "<%=request.getContextPath()%>/mail/mailDel.top";
		frm.method = "get";
		frm.submit();
		
	}
	
	// 메일 삭제(영구삭제)
	function mailDeletion(){
		if($("input[name=selectCheck]:checked").length <= 0){
			alert("삭제할 메일을 선택해주세요!");
			return false;
		}
		var frm = mailFrm;
		frm.action = "<%=request.getContextPath()%>/mail/mailDeletion.top";
		frm.method = "get";
		frm.submit();
	}
	
	// 메일 복구
	function mailRestore(){
		if($("input[name=selectCheck]:checked").length <= 0){
			alert("삭제할 메일을 선택해주세요!");
			return false;
		}
		var frm = mailFrm;
		frm.action = "<%=request.getContextPath()%>/mail/mailRestore.top";
		frm.method = "get";
		frm.submit();
	}
	
	// 읽기페이지 이동(메일함 별로 읽기페이지에서 보여질 다음글 / 이전글 내용 달리 줘야 함)
	function goRead(value){
		$("input[name=readSeq]").val(value);
		var frm = mailFrm;
		frm.action = "<%=request.getContextPath()%>/mail/read.top";
		frm.method = "get";
		frm.submit();
	}
</script>
<div style="margin-left:10px;">
	
	
	<!-- 공통 부분 -->
	
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
					${searchWord} / ${total}
				</c:when>
				<c:otherwise>
					<span style="font-weight: bold;">${mailhamType} / ${total}</span>
				</c:otherwise>	
			</c:choose>
			<div id="searchTypetArea"></div>
		</div>
		
		<div id="mailFunctionArea">
			<input type="checkbox" id="allCheck" style="margin-left:10px;"/>
			<c:if test="${readStatus eq '1'}">
				<button type="button" class="noread">안읽음</button>
			</c:if>
			<c:if test="${readStatus eq '0'}">
				<button type="button" class="read">읽음</button>
			</c:if>
		<c:choose>
			<c:when test="${type eq 'del'}">
				<button type="button" onclick = "mailDeletion()">영구삭제</button>
				<button type="button" onclick = "mailRestore()">복구하기</button>
			</c:when>
			<c:otherwise>
				<button type="button" onclick = "mailDel()">삭제</button>
			</c:otherwise>
		</c:choose>
			
		</div>
		<!-- 공통 부분 -->
	</div>
	<form name="mailFrm">
	<input type="hidden" value="${currentShowPageNo}" name="currentShowPageNo" />
	<input type="hidden" name="read" value="" /><!-- 읽음 / 안읽음 값 저장용 -->
	<input type="hidden" name="type" value="${type}" /> <!-- 메일함 type값 저장용 -->
	<input type="hidden" name="readSeq" value="" /> <!-- 메일 읽기 페이지 이동 값 저장용 --> 
	<input type="hidden" name="searchWord" value="${searchWord}" />
	
		<!-- 첨부파일 강조가 아닌 메일 리스트 -->
		<div id="mailList">
			<c:set var="temp" value="0" />
			<c:set var="cnt" value="0" />
			<c:if test="${mailhamType != '첨부파일 있는 메일' }">
				<table class="table">
					<c:if test="${not empty mailList}">
						<%--검색기능을 사용하지 않은 메일 리스트 시작 --%>
						<c:choose>
							<c:when test='${empty searchWord}'>
								<c:if test="${type == 'noRead' or type == 'del' or type == 'all'}">
								<%--제목에 메일의 종류가 표시되는 메일 리스트 시작 --%>	
									<c:forEach var="mail" items="${mailList}" varStatus="status">
											<c:choose>
												<c:when test="${mail.readStatus eq 0 }">
												<tr style="color:blue;" >
												</c:when>
												<c:otherwise>
												<tr >
												</c:otherwise>
											</c:choose>
											
												<td>
													<c:set var="loop_flag" value="false" />
													<c:forEach var="i" items="${selectCheck}">
														<c:if test="${not loop_flag }">
															 <c:if test="${i eq mail.mail_seq}">
															 
																<c:set var="loop_flag" value="true" />
															</c:if> 
														</c:if>
													</c:forEach>
													<c:if test="${not loop_flag }">
														<input type="checkbox" name="selectCheck" value="${mail.mail_seq}" />
														
													</c:if>
													<c:if test="${loop_flag }">
														<input type="checkbox" name="selectCheck" value="${mail.mail_seq}" checked/>
													</c:if>
												</td>
												<td>${mail.employee_name} (${mail.email})</td>
												
												<c:choose>
													<c:when test="${mail.status eq 2}">
														<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[내게 쓴 메일]${mail.subject}</td>
													</c:when>
													<c:when test="${mail.status eq 1}">
														<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[받은 메일]${mail.subject}</td>
													</c:when>
													<c:when test="${mail.status eq 0}">
														<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[보낸 메일]${mail.subject}</td>
													</c:when>
												</c:choose>
												
												<td>${mail.regDate}</td>
											</tr>
									</c:forEach>
								</c:if>
								<%-- 제목에 메일의 종류가 표시되는 메일 리스트 끝 --%>	
								
								<%-- 제목에 메일의 종류가 표시되지 않는 메일 리스트 시작 --%>
								<c:if test="${type == 'receive' or type == 'send' or type == 'mine'}">
									<c:forEach var="mail" items="${mailList}" varStatus="status">
										<c:choose>
											<c:when test="${mail.readStatus eq 0 }">
											<tr style="color:blue;" >
											</c:when>
											<c:otherwise>
											<tr >
											</c:otherwise>
										</c:choose>
												<td>
													<c:set var="loop_flag" value="false" />
													<c:forEach var="i" items="${selectCheck}">
														<c:if test="${not loop_flag }">
															<c:if test="${i eq mail.mail_seq}">
																<c:set var="loop_flag" value="true" />
															</c:if>
														</c:if>
													</c:forEach>
													<c:if test="${not loop_flag }">
														<input type="checkbox" name="selectCheck" value="${mail.mail_seq}" />					
													</c:if>
													<c:if test="${loop_flag }">
														<input type="checkbox" name="selectCheck" value="${mail.mail_seq}" checked/>
													</c:if>
													
												</td>
												<td>${mail.employee_name} (${mail.email})</td>
												<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">${mail.subject}</td>
												<td>${mail.regDate}</td>
											</tr>
									</c:forEach>
								</c:if>
								<%-- 제목에 메일의 종류가 표시되지 않는 메일 리스트 끝 --%>
								
							</c:when>
							<%-- 검색기능을 사용하지 않은 메일 리스트 끝--%>
							
							<%-- 검색기능을 사용한 메일 리스트 시작 --%>
							<c:otherwise>
								<c:forEach var="mail" items="${mailList}" varStatus="status">
									<c:choose>
										<c:when test="${mail.readStatus eq 0 }">
										<tr style="color:blue;" >
										</c:when>
										<c:otherwise>
										<tr >
										</c:otherwise>
									</c:choose>
										
										<td>
											<c:set var="loop_flag" value="false" />
											<c:forEach var="i" items="${selectCheck}">
												<c:if test="${not loop_flag }">
													 <c:if test="${i eq mail.mail_seq}">
														<c:set var="loop_flag" value="true" />
													</c:if> 
												</c:if>
											</c:forEach>
											<c:if test="${not loop_flag }">
												<input type="checkbox" name="selectCheck" value="${mail.mail_seq}" />
												
											</c:if>
											<c:if test="${loop_flag }">
												<input type="checkbox" name="selectCheck" value="${mail.mail_seq}" checked/>
											</c:if>
										</td>
										<td>${mail.employee_name} (${mail.email}) </td>
										
										<c:choose>
											<c:when test="${mail.status eq 2}">
												<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[내게 쓴 메일]${mail.subject}</td>
											</c:when>
											<c:when test="${mail.status eq 1}">
												<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[받은 메일]${mail.subject}</td>
											</c:when>
											<c:when test="${mail.status eq 0}">
												<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[보낸 메일]${mail.subject}</td>
											</c:when>
										</c:choose>
										
										<td>${mail.regDate}</td>
									</tr>
									</c:forEach>
							</c:otherwise>
							<%-- 검색기능을 사용한 메일 리스트 종료 --%>
							
						</c:choose>
						
					</c:if>
					
					<c:if test="${empty mailList}">
						<tr>
							<td colspan="4"> <h5>메일이 없습니다.</h5></td>
						</tr>	
					
					</c:if>
				</table>
			</c:if>
			<%-- 첨부파일 강조 메일 리스트 시작 --%>
			
			<c:if test="${mailhamType == '첨부파일 있는 메일' }">
				<c:if test="${not empty mailList}">
						<input type="hidden" name="fileName" />
						<input type="hidden" name="orgFileName" />
						<input type="hidden" name="status" />
						
						<c:forEach var="mail" items="${mailList}" varStatus="status">
							<div style="display: inline-block; float:left; width: 320px; height: 150px; margin:5px; border: solid 1px;">
								<div style="border-bottom: solid 1px #F5F5F5;">
									<c:set var="loop_flag" value="false" />
									<c:forEach var="i" items="${selectCheck}">
										<c:if test="${not loop_flag }">
											<c:if test="${i eq mail.mail_seq}">
												<c:set var="loop_flag" value="true" />
											</c:if>
										</c:if>
									</c:forEach>
									<div>
									<c:if test="${not loop_flag}">
										<input type="checkbox" name="selectCheck" value="${mail.mail_seq}"/>
									</c:if>
									<c:if test="${loop_flag}">
										<input type="checkbox" name="selectCheck" value="${mail.mail_seq}" checked/> 
									</c:if>
										<c:choose>
											<c:when test="${mail.readStatus eq 0 }">
											<div style="color:blue">${mail.employee_name}(${mail.email})<span style="float:right;">${mail.regDate}</span></div> 
											</c:when>
											<c:otherwise>
											<div>${mail.employee_name}(${mail.email})<span style="float:right;">${mail.regDate}</span></div> 
											</c:otherwise>
										</c:choose>
									</div>
									
									
									<div style="clear:both;"></div>
									<div>
										<c:choose>
											<c:when test="${mail.status eq 2}">
												<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[내게 쓴 메일]${mail.subject}</td>
											</c:when>
											<c:when test="${mail.status eq 1}">
												<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[받은 메일]${mail.subject}</td>
											</c:when>
											<c:when test="${mail.status eq 0}">
												<td class='mailSubject' onclick="goRead('${mail.mail_seq}')">[보낸 메일]${mail.subject}</td>
											</c:when>
										</c:choose>
									</div>
								</div>
								<div align="left">
									<c:if test="${not empty mail.fileName1}">
										<div style="border:solid 1px black; cursor: pointer;" onclick="func_download('${mail.fileName1}','${mail.orgFileName1}','${mail.status}')">${mail.orgFileName1} <span style="float:right">${mail.fileSize1}</span></div>
										<div style="clear:both;"></div>
									</c:if>
									<c:if test="${not empty mail.fileName2}">
										<div style="border:solid 1px black; margin-top:3px; cursor: pointer;" onclick="func_download('${mail.fileName2}','${mail.orgFileName2}','${mail.status}')">${mail.orgFileName2}<span style="float:right">${mail.fileSize2}</span></div>
										<div style="clear:both;"></div>
									</c:if>
									<c:if test="${not empty mail.fileName3}">
										<div style="border:solid 1px black; margin-top:3px; cursor: pointer;" onclick="func_download('${mail.fileName2}','${mail.orgFileName3}','${mail.status}')">${mail.orgFileName3}<span style="float:right">${mail.fileSize3}</span></div>
										<div style="clear:both;"></div>
									</c:if>
								</div>
							</div>
							<c:if test="${(status.count % 3) == 0}">
								<br>
							</c:if>
						</c:forEach>
				</c:if>
				
				<c:if test="${empty mailList}">
					<h5>첨부파일이 있는 메일이 없습니다.</h5>
				</c:if>
			</c:if>
			<div style="clear:both;"></div>
			<div id="pageBar">
				${pageBar}
			</div>
		</div>
		
	</form>
</div>