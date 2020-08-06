<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">

	#mainContainer {
		width: 1200px;
		margin-left: 40px;
	}
	
	input[name=documentCategory] {
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

<script type="text/javascript">

	$(document).ready(function() {
		
		$(".documentLabel").click(function() {
			
			var bchecked = $(this).next().prop("checked");
			
			if(bchecked) {
				
				location.reload();
			}
			else {

				$(".documentLabel").removeClass("viewClick");
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
				}
				else if($(this).next().val() == '11') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/clubMemberDocument.top' );
				}
				else if($(this).next().val() == '12') {
					
					$("#documentForm").load( '<%= request.getContextPath()%>/deleteClubDocument.top' );
				}
			}
			
		});
		
		$("#btnWrite").click(function() {
			
			var frm = document.writeDocumentFrm;
			frm.method="GET";
			frm.action="<%= request.getContextPath()%>/documentWriteEnd.top";
			frm.submit();
		});
	});
	
</script>
</head>
<body>
	
	<div id="mainContainer">
		
		<form name="writeDocumentFrm">
			
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
						<td style="height: 550px; border: solid 1px gray; overflow-y: scroll;" ></td>
					</tr>
				</tbody>
			</table>
			
			<div id="documentForm" class="documentChoiced" style="border: solid 1px gray; width: 900px; height: 580px; overflow-y: scroll;">
			</div>
			
		</form>
		
		<button type="button" id="btnWrite" class="snip1535" >작성</button>
	</div>
</body>
</html>