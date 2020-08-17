<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">
	table, td, th{
		border:solid 1px black;
		border-collapse: collapse;
	}
	
	table{
		width: 800px;
	}
	
	.receive{
		vertical-align: middle;
	}
	
	
	
	.writeBtn{
		display: inline-block;
		text-align: center;
		width: 80px;
		padding: 10px 0;
		background-color: #f2f2f2;
		cursor: pointer;
	}
	
	#inputArea li, #inputArea div{
		display: inline-block;
		padding: 0;
	}
	
	#findEmail{
		position: absolute; 
		width:500px; 
		height:80px; 
		background-color: white;
		overflow: scroll;
	}
	
	.searchEmail{
		margin-top:15px;
		overflow: hidden;
	}
	
	.hide{
		display: none;
	}
	
	.select{
		background-color: pink;
		
	}
	
	.cancle, .cancleFile{
		cursor: pointer;
		padding:3px;
	}
	
	.cancle:hover, .cancleFile:hover{
		font-weight: bold;
		background-color: red;
	}
	
	#addFile{
		width:100%;
		background-color: skyblue;
		cursor: pointer;
		text-align: center;
	}
	
	#attachFile{
		width: 550px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		<%-- === #160. 스마트 에디터 구현 시작 === --%>
		//전역변수
	    var obj = [];
	    var cnt = 0;
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
		<%-- === 스마트 에디터 구현 끝 === --%>
		
		$(document).on("keyup",".searchEmail",function(event){
			var code = event.keyCode;
			var len = $(this).val().trim().length;
			var col = $(this).prop("cols");
			console.log(code); //아래 방향키 : 40 / 위 방향키 : 38
			if(Number(col)-Number(len)<3){
				$(this).prop("cols",Number(col+5));
			}
			
			
			if(code == 13){
				if($("#findEmail").hasClass("hide")==true){
					alert("입력한 사내메일은 없습니다.");
					$(this).val("");
				}
				else{ // 실제 선택한 부분
					var html = "<li id='receive"+cnt+"'><div style='background-color:orange; margin:5px;'>"+$(".select").html().trim()+" <span class='cancle'>X</span></div><input type='hidden' name='receiveSeq' value='"+$(".select .hiddenValue").text().trim()+"' /> </li>";
					$("#inputArea").append(html);
					cnt++;
					$(this).val("");
					
				}
				console.log("엔터");
				$("#findEmail").css("display","none");	
				return;
			}
			else if(code == 40 || code == 38){
				if(!$("#findEmail").hasClass("hide")){
					var currentSelect = $(".select");
					var nextSelect = currentSelect.next();
					var prevSelect = currentSelect.prev();
					
					if(code == 40){
						if(nextSelect.hasClass("searchList")){
							nextSelect.addClass("select");
						}
						else{
							$("#resultEmail > li:first-child").addClass("select");
						}
						currentSelect.removeClass("select");
						
					}else{
						if(prevSelect.hasClass("searchList")){
							prevSelect.addClass("select");
						}
						else{
							$("#resultEmail > li:last-child").addClass("select");
						}
						currentSelect.removeClass("select");
						
					}
				}
				console.log("방향키");
				return;
			}
			else{
				if(len > 0){
					$("#findEmail").css("display","block");
					$.ajax({
						url:"<%= ctxPath%>/mail/searchReceive.top",
						data:{"keyWord":$(this).val().trim()},
						type:"GET",
						dataType:"JSON",
						success:function(json){
							if(json.length > 0){
								$("#findEmail").removeClass("hide");
								var html = "<ul id='resultEmail' style='list-style:none; padding:0;'>"
								$(json).each(function(index, item){
									// 보기 출력 부분
									if(index == 0){
										html+="<li class='select searchList'>"+item.employee_name+" &lt;"+item.position_name+"/"+item.department_name+" &gt;("+item.email+")<div class='hiddenValue hide'>"+item.employee_seq+"</div></li>";
									}
									else{
										html+="<li class='searchList'>"+item.employee_name+" &lt;"+item.position_name+"/"+item.department_name+" &gt;("+item.email+")<div class='hiddenValue hide'>"+item.employee_seq+"</div></li>";
									}
									
								});
								html+="</ul>";
								$("#findEmail").html(html);
							}
							
							else{
								$("#findEmail").addClass("hide");
							}
						},
						error:function(e){
							console.log("오류발생");
						}
					});
				}
				else{
					$("#findEmail").addClass("hide");
				}
				console.log("그외");
				return;
			}
			
			
		}); // end of $(document).on("keyup",".searchEmail",function(event))--------------------------------------------
		
		$(document).on("click",".cancle",function(event){
			$target = $(event.target);
			$target = $target.parent().parent();
			$target.remove();
		});
		
		$(document).on("mouseover","#resultEmail > li",function(event){
			$(this).addClass("select");
		});
		
		$(document).on("mouseout","#resultEmail > li",function(event){
			$(this).removeClass("select");
		});
		
		$(document).on("click","#resultEmail > li",function(event){
			var html = "<li id='receive"+cnt+"'><div style='background-color:orange; margin:5px;'>"+$(this).html().trim()+" <span class='cancle'>X</span></div><input type='hidden' name='receiveSeq' value='"+$(".select .hiddenValue").text().trim()+"' /> </li>";
			$("#inputArea").append(html);
			$(".searchEmail").val("");
			$("#findEmail").addClass("hide");	
		});
		
		$("#addFile").click(function(){
			var len = $("input[name=fileName]").length;
			if(len >= 3){
				alert("메일 1개당 최대 3개까지만 파일첨부가 가능합니다.");
				return;
			}
			var html="<div><input type='file' name='fileName' style='display:inline-block;'/><span class='cancleFile'>X</span></div>";
			$("#attachFile").append(html);
		}); // end of $("#addFile").click()----------------------------------------------------------------
		
		$(document).on("click", ".cancleFile", function(){
			$target = $(this).parent();
			$target.remove();
		});
		
		// 쓰기버튼
		$(".writeBtn").click(function(){
			
			<%-- === 스마트에디터 구현 시작 === --%>
			// id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			<%-- === 스마트에디터 구현 끝 === --%>
			
			// 글제목 유효성 검사
			var subjectVal = $("#subject").val().trim();
			if(subjectVal == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			if("${receive}"==""){
				var receiver = $("#inputArea li").length;
				console.log(receiver);
				if(receiver <= 0){
					alert("받는 사람의 메일을 선택하세요");
					return ;
				}
			}
			else{
				
			}
			
			
			<%-- === 스마트에디터 구현 시작 === --%>
			// 스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("#content").val();
		        
	        // === 확인용 ===
	        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	        // "<p>&nbsp;</p>" 이라고 나온다.
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	        	alert("글내용을 입력하세요!!");
	        	return;
	        }
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	    
	        $("#content").val(contentval);
			// alert(contentval);
			<%-- === 스마트에디터 구현 끝 === --%>
			
			
			
			// 폼(form) 을 전송(submit)
			var frm = document.mailFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/mail/mailSend.top";
			frm.submit();	 		
		}); // end of $(".wirteBtn").click()------------------------------------------------------------
		
	}); // end of $(document).ready()--------------------------------------------------------------------
</script>

<div style="margin-left:10px;" align="left">
<c:choose>
	<c:when test="${empty result}">
		<div id="writeArea">
			<span class="writeBtn">보내기</span>
		</div>
		<div id="frmArea">
			<form name="mailFrm" enctype="multipart/form-data">
				<table>
					<c:if test="${empty(receive)}">
						<tr>
							<th>받는 사람</th>
							<td class="receive" colspan="2">
							<div style="display:inline-block;position:relative;">
								<div style="border:solie 1px black;"><ul id="inputArea" style="list-style: none; padding:0; display:inline-block;"></ul><textarea rows="1" cols="10" class="searchEmail" style="resize: none;"></textarea></div>
								<div style="" id="findEmail" class="hide"></div>
							</div>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td class="receive" colspan="2"><div style="border:solie 1px black;"><input type="text" name="subject" id="subject" /></div></td>
						</tr>
					</c:if>
					
					<c:if test="${not empty(receive) && sessionScope.loginEmployee.employee_seq == receive.employee_seq}">
						<tr>
							<td colspan="3">내게쓰기<input type="hidden" name="receiveSeq" value="${receive.employee_seq}"/><input type="hidden" name="sendType" value="mine"/></td>
						</tr>
						<tr>
							<th>제목</th>
							<td class="receive" colspan="2"><div style="border:solie 1px black;"><input type="text" name="subject" id="subject" /></div></td>
						</tr>
					</c:if>
					
					<tr>
						<th style="vertical-align: top">파일첨부</th>
						<td class="receive" id="attachFile"><div><input type="file" name="fileName" style='display:inline-block;'/><span class='cancleFile'>X</span></div></td>
						<td style="vertical-align: top;"><div id="addFile">추가 업로드</div></td>
					</tr>
					
				</table>
				<div id="contentArea" style="width: 800px;">
					<textarea name="content" id="content" style="width: 800px;"></textarea>
				</div>
			</form>
		</div>
	</c:when>
	<c:otherwise>
		<div id="resultArea" align="center">
			<c:if test="${result}">
				<h3>메일을 성공적으로 보냈습니다.</h3>
			</c:if>
			<c:if test="${not result}">
				<h3>메일을 보내는데 실패했습니다.</h3>
			</c:if>
		</div>
	</c:otherwise>
</c:choose>
	
	
</div>