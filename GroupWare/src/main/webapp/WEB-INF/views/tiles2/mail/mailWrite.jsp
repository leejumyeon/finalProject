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
	
	#receive{
		vertical-align: middle;
	}
	
	
	
	.writeBtn{
		display: inline-block;
		text-align: center;
		width: 80px;
		padding: 10px 0;
		background-color: #f2f2f2;
	}
	
	#inputArea li, #inputArea div{
		display: inline-block;
		padding: 0;
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
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		<%-- === #160. 스마트 에디터 구현 시작 === --%>
		//전역변수
	    var obj = [];
	    
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
			var len = $(this).val().length;
			var col = $(this).prop("cols");
			console.log(code); //아래 방향키 : 40 / 위 방향키 : 38
			if(Number(col)-Number(len)<3){
				$(this).prop("cols",Number(col+5));
			}
			
			
			if(code == 13){
				if($("#findEmail").hasClass("hide")==true){
					var html="<li><div style='background-color:orange; margin-right:5px;'><span>"+$(this).val().trim()+"</span> X</div></li>";
					$("#inputArea").append(html);
					$(this).val("");
				}
				else{
					var html = "<li><div style='background-color:orange; margin-right:5px;'><span>"+$(".select").text().trim()+"</span> X</div></li>";
					$("#inputArea").append(html);
					$(this).val("");
					$("#findEmail").addClass("hide");
				}
				
				return false;
				
			}
			
			else if(code == 40 || code == 38){
				if(!$("#findEmail").hasClass("hide")){
					var currentSelect = $(".select");
					var nextSelect = currentSelect.next();
					var prevSelect = currentSelect.prev();
					
					if(code == 40){
						nextSelect.addClass("select");
						currentSelect.removeClass("select");
					}else{
						prevSelect.addClass("select");
						currentSelect.removeClass("select");
					}
				}
				
				return false;
			}
			
			
			if(len > 0){
				$.ajax({
					url:"<%= ctxPath%>/mail/searchReceive.top",
					data:{"keyWord":$(this).val().trim()},
					type:"GET",
					dataType:"JSON",
					success:function(json){
						if(json.length > 0){
							$("#findEmail").removeClass("hide");
							var html = "<ul style='list-style:none; padding:0;'>"
							$(json).each(function(index, item){
								if(index == 0){
									html+="<li class='select'>"+item.employee_name+" &lt;"+item.position_name+"/"+item.department_name+" &gt;("+item.email+")</li>";
								}
								else{
									html+="<li>"+item.employee_name+" &lt;"+item.position_name+"/"+item.department_name+" &gt;("+item.email+")</li>";
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
			
		});
	});
</script>

<div style="margin-left:10px;" align="left">
	<div id="writeArea">
		<span class="writeBtn">보내기</span> <span class="writeBtn">미리보기</span>
	</div>
	<div id="frmArea">
		<form name="mailFrm">
			<table>
				<tr>
					<th>받는 사람</th>
					<td id="receive">
					<div style="display:inline-block;position:relative;">
						<div style="border:solie 1px black;"><ul id="inputArea" style="list-style: none; padding:0; display:inline-block;"></ul><textarea rows="1" cols="10" class="searchEmail" style="resize: none;"></textarea></div>
						<div style="position: absolute; width:500px; height:50px; background-color: white;" id="findEmail" class="hide"></div>
					</div>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td id="receive"><div style="border:solie 1px black;"><input type="text" name="subject" id="subject" /></div></td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td id="receive"><div><input type="file" name="fileName1" /></div></td>
				</tr>
				
			</table>
			<div id="contentArea" style="width: 800px;">
				<textarea name="content" id="content" style="width: 800px;"></textarea>
			</div>
		</form>
	</div>
	
</div>