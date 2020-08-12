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
	        	$(this).css("display","none");
	        	$(".noread").css("display","inline-block");
	        });
	        
	        $(".noread").click(function(){
	        	$(this).css("display","none");
	        	$(".read").css("display","inline-block");
	        });
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
		var frm = document.attachFrm;
		$("input[name=fileName]").val(fileName);
		$("input[name=orgFileName]").val(orgFileName);
		$("input[name=status]").val(status);
		
		frm.method="post";
		frm.action="<%=request.getContextPath()%>/mail/download.top";
		frm.submit();
	} 
</script>
<div style="margin-left:10px;">
	<div id="searchArea">
		<div style="position: relative; display: inline;">
			<div style="border:solid 1px gray; display: inline-block;"><input type="text" size="20" id="mailSearch" style="border: none;"/><span style="background-color: white; cursor: pointer;" class="icon">아이콘</span></div>
			<span onclick="javascript:$('#termSearch').toggleClass('hide')" style="cursor:pointer">기간</span>&nbsp;&nbsp;<span style="font-weight: bold;">${mailhamType} / ${total}</span>
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
			<button type="button"class="read">읽음</button>
			<button type="button" class="noread" style="display: none;">안읽음</button>
			<button type="button">삭제</button>
			<button type="button">전달</button>
			<button type="button">답장</button>
		</div>
		<div id="mailList">
			<c:if test="${mailhamType != '첨부파일 있는 메일' }">
				<table class="table">
				
				<c:if test="${not empty mailList}">
					<c:choose>
						<c:when test='${searchWrod == ""}'>
							<c:if test="${mailhamType == '안 읽은 메일' or mailhamType == '휴지통' or mailhamType == '전체메일'}">
								<c:forEach var="mail" items="${mailList}">
									<c:choose>
										<c:when test="${mail.readStatus eq 0 }">
										<tr style="color:blue;">
										</c:when>
										<c:otherwise>
										<tr>
										</c:otherwise>
									</c:choose>
										<c:if test="${(mail.fk_employee_seq ne sessionScope.loginEmployee.employee_seq and (mail.status eq 0 or mail.status eq 1)) or mail.status eq 2}">
											<td><input type="checkbox" name="selectCheck" value="${mail.mail_seq}" /></td>
											<td>${mail.employee_name} (${mail.email})</td>
											
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
										</c:if>
									</tr>	
								</c:forEach>
							</c:if>
							<c:if test="${mailhamType == '받은메일' or mailhamType == '보낸메일' or mailhamType == '내게 쓴 메일'}">
								<c:forEach var="mail" items="${mailList}">
									<c:choose>
										<c:when test="${mail.readStatus eq 0 }">
										<tr style="color:blue;">
										</c:when>
										<c:otherwise>
										<tr>
										</c:otherwise>
									</c:choose>
											<td><input type="checkbox" name="selectCheck" value="${mail.mail_seq}" /></td>
											<td>${mail.employee_name} (${mail.email})</td>
											<td><a href='<%=request.getContextPath()%>/mail/read.top?mail_seq=${mail.mail_seq}'>${mail.subject}</a></td>
											<td>${mail.regDate}</td>
										</tr>	
								</c:forEach>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:forEach var="mail" items="${mailList}">
									<c:choose>
										<c:when test="${mail.readStatus eq 0 }">
										<tr style="color:blue;">
										</c:when>
										<c:otherwise>
										<tr>
										</c:otherwise>
									</c:choose>
										<c:if test="${(mail.fk_employee_seq ne sessionScope.loginEmployee.employee_seq and (mail.status eq 0 or mail.status eq 1)) or mail.status eq 2}">
											<td><input type="checkbox" name="selectCheck" value="${mail.mail_seq}" /></td>
											<td>${mail.employee_name} (${mail.email})</td>
											
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
										</c:if>
									</tr>	
								</c:forEach>
						</c:otherwise>
					</c:choose>
					
				</c:if>
				
				<c:if test="${empty mailList}">
					<tr>
						<td colspan="4"> <h5>메일이 없습니다.</h5></td>
					</tr>	
				
				</c:if>
				</table>
			</c:if>
			<c:if test="${mailhamType == '첨부파일 있는 메일' }">
				<c:if test="${not empty mailList}">
					<form name="attachFrm">
						<input type="hidden" name="fileName" />
						<input type="hidden" name="orgFileName" />
						<input type="hidden" name="status" />
						<c:forEach var="mail" items="${mailList}" varStatus="status">
							<c:if test="${(mail.fk_employee_seq ne sessionScope.loginEmployee.employee_seq and (mail.status eq 0 or mail.status eq 1)) or mail.status eq 2}">
							<div style="display: inline-block; width: 320px; height: 150px; margin:5px; border: solid 1px;">
								<div style="border-bottom: solid 1px #F5F5F5;">
									<div>
									<input type="checkbox" name="selectCheck" value="${mail.mail_seq}"/> ${mail.employee_name}(${mail.email})<span style="float:right;">${mail.regDate}</span>
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
										<div onclick="func_download('${mail.fileName2}','${mail.orgFileName2}','${mail.status}')">${mail.orgFileName2}<span style="float:right">${mail.fileSize2}</span></div>
										<div style="clear:both;"></div>
									</c:if>
									<c:if test="${not empty mail.fileName3}">
										<div onclick="func_download('${mail.fileName2}','${mail.orgFileName3}','${mail.status}')">${mail.orgFileName3}<span style="float:right">${mail.fileSize3}</span></div>
										<div style="clear:both;"></div>
									</c:if>
								</div>
							</div>
							<c:if test="${(status.count % 3) == 0}">
								<br>
							</c:if>
							</c:if>
						</c:forEach>
					</form>
				</c:if>
				
				<c:if test="${empty mailList}">
					<h5>첨부파일이 있는 메일이 없습니다.</h5>
				</c:if>
			</c:if>
			<div id="pageBar">
				${pageBar}
			</div>
		</div>
		
	</div>
	
</div>