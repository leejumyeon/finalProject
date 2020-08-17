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
	
	.hide{
		display:none;
	}
	
	#managerBtn{
		width: 80px;
		padding: 15px 5px;
		cursor: pointer;
		border:solid 1px black;
		text-align: center;
	}
</style>

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css"/>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		//데이터테이블
        $("#datatables").DataTable({
    		
			"dom" : '<"top"lf>rt<"bottom"ip>', // 페이지바가 우측하단에 위치 함, 검색이 우측 상단에 위치 함 
		  //"dom" : '<"top"lp>rt<"bottom"if>', // 페이지바가 우측상단에 위치 함, 검색이 우측하단에 위치 함
			"paging" : true,				   // 우측 하단에 페이지바를 보여주겠다
		  //"paging" : false,				   // 우측 하단에 페이지바를 숨기겠다
		    "ordering" : true,				   // th에 나오는 값에 따라 오름차순, 내림차순 정렬을 할것인지 말것인지 결정하는 것
		    "info" : false,					   // 좌측 하단에 보여지는 Showing 1 to 10 of 22 entries를 보여줄것인지 말것인지 결정하는 것
		    "filter" : true,				   // 우측 상단에 보여지는 검색을 보여줄것인지 말것인지를 결정하는 것
		    "lengthChange" : true,			   // 좌측상단에 보여지는 한페이지당 행의 갯수를 결정하는 것
		    "order" : [[0, "desc"]],		   // 기본 컬럼 정령 설정 숫자 0은 첫번쨰 컬럼을 말하며, "asc" 또는 "desc"를 설정할 수 있다.
		    "stateSave" : false,
		  //"stateSave" : true,
		  /*
		  	클라이언트 사이드 렌더링의 경우 새로고침 시 페이징 현재 상태가 저장되지 않으나
		  	stateSave를 true로 활성화 할 경우 새로고침 시에도 페이징 되어진 현재 상태가 저장되어 그대로 보여지게 된다.
		  	stateSave를 false로 활성화할 경우 새로고침시에는 초기화되어 처음의 상태로 보여지게 된다.
		  */
		  
		  "pagingType" : "full_numbers"
		  // "full_number","numbers","simple","simple_numbers","full","full_numbers","full_last_numbers"
		  // "scrollX" : false, 	// x축의 스크롤을 활성화 할지의 여부
		  // "scrollY" : "250px",   // y축의 스크롤의 크기
		  // "scrollCollapse" : true
		  /*  y축의 스크롤을 활성화 여부, 당연히 y축의 스크롤이 활성화가 되면 paging이 안일어나게 할수도 있으므로 그렇게하려면
		   "paging"을 false로 바꿀 수 있다. */
			
		}); // end of $("#datatables").DataTable({})
		
        $("#managerBtnDelete").click(function() {
        	
        	var groupnoArr = new Array();
        	
			$("input:checkbox[name=delCheck]:checked").each(function() {
				
				groupnoArr.push($(this).val());
			});
        	
        	var groupno = groupnoArr.join(",");
        	
        	var frm = document.approveDocumentFrm;
        	frm.groupno.value = groupno;
        	frm.method = "GET";
        	frm.action = "<%= request.getContextPath()%>/updateStatusDocumentDelete.top";
        	frm.submit();
        });
	}); // end of $(document).ready(function())-----------------------------------------------------
	
	
</script>

<div>
	<div style="display: inline-block;">
	<h3>문서함</h3>
	</div>
</div>

<div>
	<table id="datatables" class="table">
		<thead>
			<tr>
				<th>문서번호</th>
				<th>신청자부서</th>
				<th>신청자직위</th>
				<th>신청자</th>
				<th>결재종류</th>
				<th>제목</th>
				<th>신청날짜</th>
				<th>결제날짜</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="document" items="${allComDocumentList}">	
				<tr data-toggle="modal" data-target="#documentContent${docuvo.document_seq}" data-dismiss="modal" style="cursor: pointer;">
					<td>${docuvo.groupno}</td>
					<td>${document.department_name}</td>
					<td>${document.position_name}</td>
					<td>${document.employee_name}</td>
					<td>${document.category_name}</td>
					<td>${document.subject}</td>
					<td>${document.regDate}</td>
					<td>${document.approveDate}</td>
					<td><input type="checkbox" name="delCheck" value="${document.groupno}"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div align="right">
		<div id="managerBtnDelete">선택삭제</div>
	</div>
</div>

<form name="approveDocumentFrm">
	<input type="text" name="groupno"/>
</form>
	
<%-- *** 문서 내용  modal1 *** --%>
<c:forEach var="docuvo" items="${allComDocumentList}">
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