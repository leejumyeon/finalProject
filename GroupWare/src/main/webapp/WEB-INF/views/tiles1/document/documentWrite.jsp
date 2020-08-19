<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">

	#mainContainer {
		width: 1200px;
		margin-left: 40px;
	}
	
	input[name=documentCategory], input[name=departmentSeq], .departmentEmployees{
	 	display: none;
	}
	
	.viewClick {
		background-color: #0099ff;
		color: white;
		border-radius: 10px;
	}
	
	.documentLabel {
		display: inline-block;
		width: 140px;
		height: 35px;
		text-align: center;
		padding-top: 10px;
		cursor: pointer;
	}
	
	.documentChoiced {
		display: inline-block;
	}
	
	.departmentLabel {
		display: inline-block;
		width: 200px;
		height: 35px;
		border: solid 2px #cce0ff;
		background-color: #0099ff;
		padding-top: 8px;
		padding-left: 10px;
		color: white;
	}
	
	.employeeSeq {
		width: 140px;
		height: 35px;
		text-align: center;
		padding-top: 10px;
		cursor: pointer;
	}
	
	.snip1535 {
	  background-color: #0099ff;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 22px;
	  line-height: 1em;
	  margin: 15px 40px;
	  outline: none;
	  padding: 12px 40px 10px;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.snip1535:before,
	.snip1535:after {
	  border-color: transparent;
	  -webkit-transition: all 0.25s;
	  transition: all 0.25s;
	  border-style: solid;
	  border-width: 0;
	  content: "";
	  height: 24px;
	  position: absolute;
	  width: 24px;
	}
	
	.snip1535:before {
	  border-color: #0099ff;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1535:after {
	  border-bottom-width: 2px;
	  border-color: #0099ff;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1535:hover {
	  background-color: #0099ff;
	}
	
	.snip1535:hover:before,
	.snip1535:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
</style>

<script src="<%= request.getContextPath()%>/resources/html2canvas/html2canvas.js"></script>
<script src="<%= request.getContextPath()%>/resources/html2canvas/html2canvas.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		sessionStorage.removeItem("seq1");
		sessionStorage.removeItem("seq2");
		sessionStorage.removeItem("seq3");
		sessionStorage.removeItem("seq4");
		sessionStorage.removeItem("seq5");
		
		$(".documentChoiced").css("display","none");
		$("#representImage").css("display","none");
		
		$(".documentLabel").click(function() {
			
			var bchecked = $(this).next().prop("checked");
			
			if(bchecked) {
				
				location.reload();
			}
			else {

				$(".documentLabel").removeClass("viewClick");
				$("#representImage").css("display","none");
				$(this).addClass("viewClick");
				
				var html = "";
				
				if($(this).next().val() == '1') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/vacationDocument.top' );
				}
				else if($(this).next().val() == '2') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/businessTripDocument.top' );
				}
				else if($(this).next().val() == '3') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/salesDocument.top' );
				}
				else if($(this).next().val() == '4') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/equipmentDocument.top' );
				}
				else if($(this).next().val() == '5') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/projectStartDocument.top' );
				}
				else if($(this).next().val() == '6') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/projectStopDocument.top' );
				}
				else if($(this).next().val() == '7') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/projectEndDocument.top' );
				}
				else if($(this).next().val() == '8') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/retirementDocument.top' );
				}
				else if($(this).next().val() == '9') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/employeeTADocument.top' );
				}
				else if($(this).next().val() == '10') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/makeClubDocument.top' );
					
					$("#representImage").css("display","");
				}
				else if($(this).next().val() == '11') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/clubMemberDocument.top' );
				}
				else if($(this).next().val() == '12') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/deleteClubDocument.top' );
				}
			}
			
			$(".documentChoiced").css("display","");
			
		});
		
		$("#btnWrite").click(function() {
			
			sessionStorage.removeItem("seq1");
			sessionStorage.removeItem("seq2");
			sessionStorage.removeItem("seq3");
			sessionStorage.removeItem("seq4");
			sessionStorage.removeItem("seq5");
			
			html2canvas($("#documentContents")[0]).then(function(canvas) {
				
				$("#contentImage").val(canvas.toDataURL());
				
			});

			setTimeout(function() {
				if(confirm("정말 작성을 완료하시겠습니까?") == true) {
					var frm = document.writeDocumentFrm;
					frm.method="POST";
					frm.action="<%= request.getContextPath()%>/documentWriteEnd.top";
					frm.submit();
				}
				else {
					
					return false;
				}
			}, 1000)

		});
		
	});
	
	function showMemberByDepartment(seq) {
		
		var bseq = sessionStorage.getItem("seq" + seq);
		
		if(bseq == null) {
			
			$.ajax({
				url:"<%= request.getContextPath()%>/showMemberByDepartment.top",
				type:"GET",
				data:{"seq":seq},
				dataType:"JSON",
				success: function(json) {
					
					var html = "";
					
					$.each(json, function(index, item) {

						html += "<input type='checkbox' name='employeeSeq' id='employeeSeq" + item.employee_seq + "' value='" + item.employee_seq + "' onclick='approvalList()' style='display: none;'/>";
						html += "<label class='employeeSeq' for='employeeSeq" + item.employee_seq + "' style='cursor: pointer;'>" + item.position_name + " " + item.employee_name + "</label>";
						html += "<br/>";

					});
					
					$("#departmentEmployees" + seq).html(html);
					$("#departmentEmployees" + seq).css("display","block");
					
					sessionStorage.setItem("seq" + seq, seq);
				}

			})
		}
		else {
			
			$("#departmentEmployees" + seq).css("display","none");
			sessionStorage.removeItem("seq" + seq, seq);
		}
		
	}
	
	function approvalList() {
		
		$("input:checkbox[name=employeeSeq]").each(function() {
			
			var bChecked = $(this).prop('checked');
			
			if(bChecked) {
				
				$(this).next().addClass("viewClick");
			}
			else {
				
				$(this).next().removeClass("viewClick");
			}
		});
		
		
		
		var seqLen = $("input:checkbox[name=employeeSeq]:checked").length;
		
		var seqArr = new Array();
		
		if(seqLen > 0) {
			
			var i = 0;
			
			$("input:checkbox[name=employeeSeq]").each(function() {
				
				var bchecked = $(this).is(":checked");

				if(bchecked) {
					
					seqArr[i] = $(this).val();
					i++;
				}
			});
			
			var seq = seqArr.join(',');
			
			$("#allEmployeeSeq").val(seq);
			
			$.ajax({
				url:"<%= request.getContextPath()%>/approvalList.top",
				type:"GET",
				data:{"seq":seq},
				dataType:"JSON",
				success: function(json) {
					
					var html = "";
					
					html += "<tr>";
					
					$.each(json, function(index, item) {
						
						html += '<td width="100" height="25" style="text-align: center; font-size: 10pt; font-style: italic; font-weight: bold;">';
						html +=	'	결재자' + (index + 1);
						html +=	'</td>';
					});
					
					html += "</tr>";
					html += "<tr>";
					
					$.each(json, function(index, item) {
						
						html += '<td height="25" style="text-align: center; font-size: 8pt;">';
						html +=		item.position_name + '&nbsp;' + item.employee_name;
						html +=	'</td>';
					});
					
					html += "</tr>";
					html += "<tr>";
					
					$.each(json, function(index, item) {
						
						html += '<td height="70">';
						html +=	'</td>';
					});
					
					html += "</tr>";
					
					$("#approvalList").html(html);
				}
			});
		}
		else {
			
			$("#approvalList").html("");
		}
			
	}
</script>
<body>
	
	<div id="mainContainer">
		
		<form name="writeDocumentFrm" enctype="multipart/form-data">
			
			<table>
				<thead>
					<tr>
						<th style="text-align: center; width:1130px; height: 30px; background-color: #0099ff; color: white;">문서 종류 결정하기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align: center;">
							<c:forEach var="docuCateVO" items="${documentCategoryList}" varStatus="status">
								<label class="documentLabel" for="documentCategory${status.index}">${docuCateVO.category_name} 기안서</label>&nbsp;&nbsp;&nbsp;
								<input type="radio" name="documentCategory" id="documentCategory${status.index}" value="${docuCateVO.document_category_seq}" />
								<c:if test="${status.count%6 == 0}">
									<br/>
								</c:if>
							</c:forEach>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="documentChoiced">
				<thead>
					<tr>
						<th style="text-align: center; width:230px; height: 30px; background-color: #0099ff; color: white; ">결재선 결정하기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="height: 550px; border: solid 1px #0099ff; overflow-y: scroll; vertical-align: top; padding-top: 10px;" >
							<c:forEach var="departVO" items="${departmentList}" varStatus="status">
								<button type="button" class="departmentLabel" onclick="showMemberByDepartment('${departVO.department_seq}')">${departVO.department_name}</button>
								<div class="departmentEmployees" id="departmentEmployees${status.count}">
								</div>
								<br/>
							</c:forEach>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="documentForm" class="documentChoiced" style="border: solid 1px #0099ff; width: 900px; height: 580px; overflow-y: scroll;">
			</div>
			
			<table id="representImage" style="border: solid 1px #0099ff; width: 1135px;">
				<tr style="width:1130px; height: 30px;">
					<td style="text-align: center; background-color: #0099ff; color: white;">대표이미지 파일</td>
					<td><input type="file" name="attach"/></td>
				</tr>
			</table>
			
			<input type="hidden" name="contentImage" id="contentImage">
			<input type="hidden" name="allEmployeeSeq" id="allEmployeeSeq">
		</form>
		
		<div class="documentChoiced">
			<button type="button" id="btnWrite" class="snip1535" >작성</button>
		</div>
	</div>
</body>