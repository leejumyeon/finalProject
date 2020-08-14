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
        	var code = event.keyCode;
        	console.log(code);
        	if(code == 13){	
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
        	else if(code == 40 || code == 38){
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
        	else{
        		func_searchTypeFind(txtVal);
        	}
        	
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
        
        $(".icon").click(function(){
        	goSearch( $("#mailSearch").val(),"all");
        });
        
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
        
        $("#allCheck").click(function(){
        	var bool = $(this).prop("checked");
        	$("input[name=selectCheck]").each(function(index,item){
        		$(item).prop("checked",bool);
        	});
        });
        
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
       
        
        
       	var len = $("input[name=selectCheck]").length;
		var checkLen =  $("input[name=selectCheck]:checked").length;
		console.log(len+"/"+checkLen);
		if(len == checkLen && len != 0){
			$("#allCheck").prop("checked",true);
		}
	        
	}); // end of $(document).ready(function())-----------------------------------------------------
	
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
	
	function goSearch(val, category){
		console.log(category);
		location.href = "<%=request.getContextPath()%>/mail/list.top?searchWord="+val+"&type="+category;
	}
	
	
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
</script>
<div style="margin-left:10px;">
	<form name="mailFrm">
	
	<!-- 공통 부분 -->
	
	<div id="searchArea">
		<input type="hidden" value="${currentShowPageNo}" name="currentShowPageNo" />
		<div style="position: relative; display: inline;">
			<div style="border:solid 1px gray; display: inline-block;"><input type="text" size="20" id="mailSearch" name="searchWord" style="border: none;" autocomplete="off"/><span style="background-color: white; cursor: pointer;" class="icon">아이콘</span></div>
			<span onclick="javascript:$('#termSearch').toggleClass('hide')" style="cursor:pointer">기간</span>&nbsp;&nbsp;<span style="font-weight: bold;">${mailhamType} / ${total}</span>
			<input type="hidden" name="type" value="${type}" />
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
			<input type="checkbox" id="allCheck" style="margin-left:10px;"/>
			<c:if test="${readStatus eq '1'}">
				<button type="button" class="noread">안읽음</button>
				<input type="hidden" name="read" value="0" />
			</c:if>
			<c:if test="${readStatus eq '0'}">
				<button type="button" class="read">읽음</button>
				<input type="hidden" name="read" value="1" />
			</c:if>
			
			<button type="button">삭제</button>
			<button type="button">전달</button>
			<button type="button">답장</button>
		</div>
		<!-- 공통 부분 -->
		
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
										<c:if test="${temp != mail.mail_groupno}">
											${mail.mail_seq}
											<c:set var="temp" value="${mail.mail_groupno }" />
											<c:choose>
												<c:when test="${mail.readStatus eq 0 }">
												<tr style="color:blue;">
												</c:when>
												<c:otherwise>
												<tr>
												</c:otherwise>
											</c:choose>
											
											
											<c:choose>
												<c:when test="${(mail.fk_employee_seq ne sessionScope.loginEmployee.employee_seq and (mail.status eq 0 or mail.status eq 1)) or mail.status eq 2}">
												<td>${mail.mail_seq}
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
												<td>${mail.employee_name} (${mail.email})${mail.mail_groupno }</td>
												
												<c:choose>
													<c:when test="${mail.status eq 2}">
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[내게 쓴 메일]${mail.subject}</a></td>
													</c:when>
													<c:when test="${mail.status eq 1}">
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[받은 메일]${mail.subject}</a></td>
													</c:when>
													<c:when test="${mail.status eq 0}">
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[보낸 메일]${mail.subject}</a></td>
													</c:when>
												</c:choose>
												
												<td>${mail.regDate}</td>
												<c:set var="cnt" value="0" />
												</c:when>
												<c:otherwise>
													<c:set var="temp" value="0" />
												</c:otherwise>
											</c:choose>
											</tr>
										</c:if>
										<c:if test="${temp == mail.mail_groupno}">
											<c:set var="cnt" value="${cnt + 1}" />
										</c:if>
									</c:forEach>
								</c:if>
								<%-- 제목에 메일의 종류가 표시되는 메일 리스트 끝 --%>	
								
								<%-- 제목에 메일의 종류가 표시되지 않는 메일 리스트 시작 --%>
								<c:if test="${type == 'receive' or type == 'send' or type == 'mine'}">
									<c:forEach var="mail" items="${mailList}" varStatus="status">
										<c:if test='${temp != mail.mail_groupno}'>
											<c:set var="temp" value="${mail.mail_groupno}"></c:set>
											<c:choose>
												<c:when test="${mail.readStatus eq 0 }">
												<tr style="color:blue;">
												</c:when>
												<c:otherwise>
												<tr>
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
													<td>${mail.employee_name} (${mail.email}) ${mail.mail_groupno}</td>
													<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>${mail.subject}</a></td>
													<td>${mail.regDate}</td>
												</tr>
										</c:if>	
									</c:forEach>
								</c:if>
								<%-- 제목에 메일의 종류가 표시되지 않는 메일 리스트 끝 --%>
								
							</c:when>
							<%-- 검색기능을 사용하지 않은 메일 리스트 끝--%>
							
							<%-- 검색기능을 사용한 메일 리스트 시작 --%>
							<c:otherwise>
								<c:forEach var="mail" items="${mailList}" varStatus="status">
									<c:if test='${temp != mail.mail_groupno}'>
										<c:set var="temp" value="${mail.mail_groupno}"></c:set>
										<c:choose>
											<c:when test="${mail.readStatus eq 0 }">
											<tr style="color:blue;">
											</c:when>
											<c:otherwise>
											<tr>
											</c:otherwise>
										</c:choose>
											<c:choose>
												<c:when test="${(mail.fk_employee_seq ne sessionScope.loginEmployee.employee_seq and (mail.status eq 0 or mail.status eq 1)) or mail.status eq 2}">
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
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[내게 쓴 메일]${mail.subject}</a></td>
													</c:when>
													<c:when test="${mail.status eq 1}">
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[받은 메일]${mail.subject}</a></td>
													</c:when>
													<c:when test="${mail.status eq 0}">
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[보낸 메일]${mail.subject}</a></td>
													</c:when>
												</c:choose>
												
												<td>${mail.regDate}</td>
												</c:when>
												<c:otherwise>
													<c:set var="temp" value="0" />
												</c:otherwise>
											</c:choose>
										</tr>
										</c:if>	
									</c:forEach>
							</c:otherwise>
							<%-- 검색기능을 사용한 메일 리스트 시작 --%>
							
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
						<c:if test='${temp != mail.mail_groupno}'>
							<c:set var="temp" value="${mail.mail_groupno}"></c:set>
							<c:choose>
								<c:when test="${(mail.fk_employee_seq ne sessionScope.loginEmployee.employee_seq and (mail.status eq 0 or mail.status eq 1)) or mail.status eq 2}">
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
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[내게 쓴 메일]${mail.subject}</a></td>
													</c:when>
													<c:when test="${mail.status eq 1}">
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[받은 메일]${mail.subject}</a></td>
													</c:when>
													<c:when test="${mail.status eq 0}">
														<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>[보낸 메일]${mail.subject}</a></td>
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
								</c:when>
								<c:otherwise>
									<c:set var="temp" value="0"></c:set>
								</c:otherwise>
							</c:choose>
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
		
	</div>
	</form>
</div>