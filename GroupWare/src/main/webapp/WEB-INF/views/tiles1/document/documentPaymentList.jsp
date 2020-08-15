<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="icon" type="image/png" href="<%= request.getContextPath()%>/resources/table_css/images/icons/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/css/util.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/css/main.css">

<style type="text/css">

	#myContainer {
		margin-left: 40px;
	}
	
	.column3 {
		cursor: pointer;
	}
	
	.snip1535 {
		background-color: #ff4d4d;
		border: none;
		color: #ffffff;
		cursor: pointer;
		display: inline-block;
		font-family: 'BenchNine', Arial, sans-serif;
		font-size: 1em;
		font-size: 10pt;
		line-height: 1em;
		margin: 8px 12px;
		outline: none;
		position: relative;
		text-transform: uppercase;
		font-weight: 700;
		width: 60px;
		height: 20px;
	}
	
	.snip1535:before,
	.snip1535:after {
		border-color: transparent;
		-webkit-transition: all 0.25s;
		transition: all 0.25s;
		border-style: solid;
		border-width: 0;
		content: "";
		height: 15px;
		position: absolute;
		width: 15px;
	}
	
	.snip1535:before {
 		border-color: #ff4d4d;
		border-right-width: 3px;
		border-top-width: 3px;
		right: -5px;
		top: -5px;
	}
	
	.snip1535:after {
		border-bottom-width: 3px;
		border-color: #ff4d4d;
		border-left-width: 3px;
		bottom: -5px;
		left: -5px;
	}
	
	.snip1535:hover {
 		background-color: #ff4d4d;
	}
	
	.snip1535:hover:before,
	.snip1535:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
	.snip1536 {
	  background-color: #0099ff;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 10pt;
	  line-height: 1em;
	  margin: 8px 12px;
	  outline: none;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	  width: 60px;
	  height: 20px;
	}
	
	.snip1536:before,
	.snip1536:after {
	  border-color: transparent;
	  -webkit-transition: all 0.25s;
	  transition: all 0.25s;
	  border-style: solid;
	  border-width: 0;
	  content: "";
	  height: 15px;
	  position: absolute;
	  width: 15px;
	}
	
	.snip1536:before {
	  border-color: #0099ff;
	  border-right-width: 3px;
	  border-top-width: 3px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1536:after {
	  border-bottom-width: 3px;
	  border-color: #0099ff;
	  border-left-width: 3px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1536:hover {
	  background-color: #0099ff;
	}
	
	.snip1536:hover:before,
	.snip1536:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
	.labelDocumentList {
		color: #0099ff;
		border: solid 0.5px #0099ff;
		cursor: pointer;
	}
	
	.labelDocumentListActive {
		color: white;
		background-color: #0099ff;
		cursor: pointer;
	}
	
	.snip1537 {
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
	
	.snip1537:before,
	.snip1537:after {
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
	
	.snip1537:before {
	  border-color: #0099ff;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1537:after {
	  border-bottom-width: 2px;
	  border-color: #0099ff;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1537:hover {
	  background-color: #0099ff;
	}
	
	.snip1537:hover:before,
	.snip1537:hover:after {
	  height: 100%;
	  width: 100%;
	}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("input:radio[name=DocumentList]").hide();
		
		getComDocumentList();
		
		$("#btnWriteDocument").click(function() {
			
			location.href="<%= request.getContextPath()%>/writeDocument.top";
		});
		
		$("input:radio[name=DocumentList]").each(function() {
			
			var bchecked = $(this).prop("checked");
			
			if(bchecked) {
				
				$(this).next().addClass("labelDocumentListActive");
			}
		});
		
		$("input:radio[name=DocumentList]").click(function() {
			
			$(".labelDocumentList").removeClass("labelDocumentListActive");
			
			$(this).next().addClass("labelDocumentListActive");
			
			getComDocumentList();
		});
		
		
		$("#btnRejected").click(function() {

			var documentSeqArr = new Array();
			
			documentSeqArr.push($("input:checkbox[name=documentSeqList]:checked").val());
			
			var documentSeq = documentSeqArr.join(',');
			
			var frm = document.approveDocumentFrm;
			frm.documentSeq.value = documentSeq;
			frm.method = "POST";
			frm.action = "<%= request.getContextPath()%>/documentRejected.top";
			
			if(confirm("정말 결재를 반려하시겠습니까?") == true) {
				
				frm.submit();
			}
			else {
				
				return false;
			}

		});
		
		$("#btnAccepted").click(function() {
			
			var documentSeqArr = new Array();
			
			$("input:checkbox[name=documentSeqList]:checked").each(function() {
				
				documentSeqArr.push($(this).val());
			});

			var documentSeq = documentSeqArr.join(',');
			
			var frm = document.approveDocumentFrm;
			frm.documentSeq.value = documentSeq;
			frm.method = "POST";
			frm.action = "<%= request.getContextPath()%>/documentAccepted.top";
			
			if(confirm("정말 결재를 완료하시겠습니까?") == true) {
				
				frm.submit();
			}
			else {
				
				return false;
			}

		});
		
	});
	
	function getComDocumentList() {
		
		var statusValue = $("input:radio[name=DocumentList]:checked").val();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/comDocumentList.top",
			type:"GET",
			data:{"statusValue":statusValue},
			dataType:"JSON",
			success:function(json) {
				
				var html = "";
				var html2 = "";

				if(json.length != 0) {
					
					$.each(json, function(index, item) {
						
						
						html += '<tr class="row100 tr_body">'
							 +  '<td class="cell100 column1">' + item.groupno + '</td>'
							 +  '<td class="cell100 column2">' + item.category_name + '</td>'
							 +  '<td class="cell100 column3" data-toggle="modal" data-target="#documentContent3' + item.document_seq + '" data-dismiss="modal">' + item.subject + '</td>'
							 +  '<td class="cell100 column4">' + item.employee_name + '</td>'
							 +  '<td class="cell100 column5">' + item.regDate + '</td>'
							 +  '</tr>';

					});

					$.each(json, function(index, item) {
						
						html2 += '<div class="modal fade" id="documentContent3' + item.document_seq + '" role="dialog">'
							  +  '<div class="modal-dialog" style="width: 900px;">'
							  +  '<div class="modal-content">'
							  +  '<div class="modal-header">'
							  +  '<button type="button" class="close myclose" data-dismiss="modal">&times;</button>'
							  +  '<h4 class="modal-title">문서 내용</h4>'
							  +  '</div>'
							  +  '<div class="modal-body" style="height: 620px; width: 900px;">'
							  +  '<div id="addDelivery">'
							  +  '<iframe style="border: none; width: 100%; height: 600px;" src="<%= request.getContextPath()%>/documentContent.top?document_seq=' + item.document_seq + '">'
							  +  '</iframe>'
							  +  '</div>'
							  +  '</div>'
							  +  '<div class="modal-footer">'
							  +  '<button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>'
							  +  '</div>'
							  +  '</div>'
							  +  '</div>'
							  +  '</div>';

					});
					
				}
				else {

					html += '<tr>'
						 + '<td style="text-align: center;">'
						 + '<span style="color: #0099ff; font-style: italic; font-weight: bold; font-size: 15pt;">완료된 결재 문서가 없습니다.</span>';
						 + '</td>'
						 + '</tr>';
				}
			
				$("#ajaxDocumentList").html(html);
				$("#comDocumentModal").html(html2);
			}
		});
	}

</script>

<body>

	<div id="myContainer">
		<h5 style="color: #0099ff">1. 신청한 결재 문서</h5>
		<div class="table100 ver2 m-b-35">
			<div class="table100-head">
				<table>
					<thead>
						<tr class="row100 head">
							<th class="cell100 column1">문 서 번 호</th>
							<th class="cell100 column2">문 서 종 류</th>
							<th class="cell100 column3">제 목</th>
							<th class="cell100 column4">작성자</th>
							<th class="cell100 column5">작성일자</th>
						</tr>
					</thead>
				</table>
			</div>
	
			<div class="table100-body js-pscroll">
				<c:if test="${not empty regDocumentList}">
					<table>
						<tbody>
							<c:forEach var="docuvo" items="${regDocumentList}">
								<tr class="row100 tr_body">
									<td class="cell100 column1">${docuvo.groupno}</td>
									<td class="cell100 column2">${docuvo.category_name}</td>
									<td class="cell100 column3" data-toggle="modal" data-target="#documentContent${docuvo.document_seq}" data-dismiss="modal">${docuvo.subject}</td>
									<td class="cell100 column4">${docuvo.employee_name}</td>
									<td class="cell100 column5">${docuvo.regDate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				<c:if test="${empty regDocumentList}">
					<table>
						<tbody>
							<tr>
								<td style="text-align: center;">
									<span style="color: #0099ff; font-style: italic; font-weight: bold; font-size: 15pt;">신청한 결재 문서가 없습니다.</span>
								</td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>
		
		<h5 style="color: #0099ff; display: inline-block; float: reft; width: 150px;">2. 결재할 결재 문서</h5>
		<button class="snip1535" style="float: right;" id="btnRejected">반려하기</button>
		<button class="snip1536" style="float: right;" id="btnAccepted">결재하기</button>
		<div class="table100 ver2 m-b-35" style="clear: both;">
			<div class="table100-head">
				<table>
					<thead>
						<tr class="row100 head">
							<th class="cell100 column0"></th>
							<th class="cell100 column1">문 서 번 호</th>
							<th class="cell100 column2">문 서 종 류</th>
							<th class="cell100 column3">제 목</th>
							<th class="cell100 column4">작성자</th>
							<th class="cell100 column5">작성일자</th>
						</tr>
					</thead>
				</table>
			</div>
	
			<div class="table100-body js-pscroll">
				<c:if test="${not empty aproDocumentList}">
					<table>
						<tbody>
							<c:forEach var="docuvo" items="${aproDocumentList}">
								<tr class="row100 tr_body">
									<th class="cell100 column0"><input type="checkbox" name="documentSeqList" value="${docuvo.document_seq}"/></th>
									<td class="cell100 column1">${docuvo.groupno}</td>
									<td class="cell100 column2">${docuvo.category_name}</td>
									<td class="cell100 column3" data-toggle="modal" data-target="#documentContent2${docuvo.document_seq}" data-dismiss="modal">${docuvo.subject}</td>
									<td class="cell100 column4">${docuvo.employee_name}</td>
									<td class="cell100 column5">${docuvo.regDate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				<c:if test="${empty aproDocumentList}">
					<table>
						<tbody>
							<tr>
								<td style="text-align: center;">
									<span style="color: #0099ff; font-style: italic; font-weight: bold; font-size: 15pt;">결재할 결재 문서가 없습니다.</span>
								</td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</div>
			
			
		</div>
		
		<h5 style="color: #0099ff; display: inline-block; float: reft; width: 170px;">3. 결재 완료된 결재 문서</h5>
		<input type="radio" id="allComDocumentList" name="DocumentList" value="0" checked/><label for="allComDocumentList" class="labelDocumentList">전체 문서</label>
		<input type="radio" id="senComDocumentList" name="DocumentList" value="1" /><label for="senComDocumentList" class="labelDocumentList">신청한 문서</label>
		<input type="radio" id="recComDocumentList" name="DocumentList" value="2" /><label for="recComDocumentList" class="labelDocumentList">결재한 문서</label>
		<div class="table100 ver2 m-b-35" style="clear: both;">
			<div class="table100-head">
				<table>
					<thead>
						<tr class="row100 head">
							<th class="cell100 column1">문 서 번 호</th>
							<th class="cell100 column2">문 서 종 류</th>
							<th class="cell100 column3">제 목</th>
							<th class="cell100 column4">작성자</th>
							<th class="cell100 column5">작성일자</th>
						</tr>
					</thead>
				</table>
			</div>
	
			<div class="table100-body js-pscroll">
				<table>
					<tbody id="ajaxDocumentList">
					</tbody>
				</table>
			</div>
		</div>
		
		<button type="button" class="snip1537" id="btnWriteDocument">작성하기</button>
	</div>

	<%-- *** 문서 내용  modal1 *** --%>
	<c:forEach var="docuvo" items="${regDocumentList}">
	<div class="modal fade" id="documentContent${docuvo.document_seq}" role="dialog">
		<div class="modal-dialog" style="width: 900px;">
		  
			    <!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">문서 내용</h4>
				</div>
				<div class="modal-body" style="height: 620px; width: 900px;">
					<div id="addDelivery">
						<iframe style="border: none; width: 100%; height: 600px;" src="<%= request.getContextPath()%>/documentContent.top?document_seq=${docuvo.document_seq}">
						</iframe>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
				</div>
			</div>
		    
		</div>
	</div>
	</c:forEach>
	
	<%-- *** 문서 내용  modal2 *** --%>
	<c:forEach var="docuvo" items="${aproDocumentList}">
	<div class="modal fade" id="documentContent2${docuvo.document_seq}" role="dialog">
		<div class="modal-dialog" style="width: 900px;">
		  
			    <!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">문서 내용</h4>
				</div>
				<div class="modal-body" style="height: 620px; width: 900px;">
					<div id="addDelivery">
						<iframe style="border: none; width: 100%; height: 600px;" src="<%= request.getContextPath()%>/documentContent.top?document_seq=${docuvo.document_seq}">
						</iframe>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
				</div>
			</div>
		    
		</div>
	</div>
	</c:forEach>
	
	<%-- *** 문서 내용  modal3 *** --%>
	<div id="comDocumentModal">
	</div>
	
	<form name="approveDocumentFrm">
		<input type="text" name="documentSeq"/>
	</form>
</body>