<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	.managerBtn{
		width: 90px;
		padding: 10px 0;
		cursor: pointer;
		border:solid 1px black;
		text-align: center;
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
	
	table#datatables {
		vertical-align: middle;
	}
	
</style>

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css"/>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#datatables").DataTable({
		
			"dom" : '<"top"lf>rt<"bottom"ip>', // 페이지바가 우측하단에 위치 함, 검색이 우측 상단에 위치 함 
		  //"dom" : '<"top"lp>rt<"bottom"if>', // 페이지바가 우측상단에 위치 함, 검색이 우측하단에 위치 함
			"paging" : true,				   // 우측 하단에 페이지바를 보여주겠다
		  //"paging" : false,				   // 우측 하단에 페이지바를 숨기겠다
		    "ordering" : true,				   // th에 나오는 값에 따라 오름차순, 내림차순 정렬을 할것인지 말것인지 결정하는 것
		    "info" : false,					   // 좌측 하단에 보여지는 Showing 1 to 10 of 22 entries를 보여줄것인지 말것인지 결정하는 것
		    "filter" : true,				   // 우측 상단에 보여지는 검색을 보여줄것인지 말것인지를 결정하는 것
		    "lengthChange" : true,			   // 좌측상단에 보여지는 한페이지당 행의 갯수를 결정하는 것
		  //"order" : [[0, "desc"]],		   // 기본 컬럼 정령 설정 숫자 0은 첫번쨰 컬럼을 말하며, "asc" 또는 "desc"를 설정할 수 있다.
		    "order" : [[2, "asc"],[0, "desc"]],
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
			
		});
		
		
		
				
	});
</script>


<div>
	<div style="display: inline-block;">
	<h3>사원정보</h3>
	</div>
</div>
<div id="listArea">
	<table id="datatables" class="table">
		<thead>
			<tr>
				<th>사원ID</th>
				<th>사원명</th>
				<th>직책</th>
				<th>부서</th>
				<th>메일</th>
				<th>입사한 날짜</th>
				<th>회원상태</th>
				<th>권한래밸</th>
				<th>수정요청</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="evo" items="${allEmployeeList}">
				<tr>
					<td>${evo.employee_id}</td>
					<td>${evo.employee_name}</td>
					<td>
						<select name="fk_position" style="width: 60px; height: 30px;">
							<c:if test="${evo.fk_position == '1'}">
								<option value="1" selected>사원</option>
								<option value="2">대리</option>
								<option value="3">과장</option>
								<option value="4">부장</option>
								<option value="5">이사</option>
								<option value="6">사장</option>
							</c:if>
							<c:if test="${evo.fk_position == '2'}">
								<option value="1">사원</option>
								<option value="2" selected>대리</option>
								<option value="3">과장</option>
								<option value="4">부장</option>
								<option value="5">이사</option>
								<option value="6">사장</option>
							</c:if>
							<c:if test="${evo.fk_position == '3'}">
								<option value="1">사원</option>
								<option value="2">대리</option>
								<option value="3" selected>과장</option>
								<option value="4">부장</option>
								<option value="5">이사</option>
								<option value="6">사장</option>
							</c:if>
							<c:if test="${evo.fk_position == '4'}">
								<option value="1">사원</option>
								<option value="2">대리</option>
								<option value="3">과장</option>
								<option value="4" selected>부장</option>
								<option value="5">이사</option>
								<option value="6">사장</option>
							</c:if>
							<c:if test="${evo.fk_position == '5'}">
								<option value="1">사원</option>
								<option value="2">대리</option>
								<option value="3">과장</option>
								<option value="4">부장</option>
								<option value="5" selected>이사</option>
								<option value="6">사장</option>
							</c:if>
							<c:if test="${evo.fk_position == '6'}">
								<option value="1">사원</option>
								<option value="2">대리</option>
								<option value="3">과장</option>
								<option value="4">부장</option>
								<option value="5">이사</option>
								<option value="6" selected>사장</option>
							</c:if>
						</select>
					</td>
					<td>
						<select name="fk_department" style="width: 100px; height: 30px;">
							<c:if test="${evo.fk_department == '1'}">
								<option value="1" selected>디자인팀</option>
								<option value="2">개발팀</option>
								<option value="3">영업팀</option>
								<option value="4">인사팀</option>
								<option value="5">경영지원팀</option>
							</c:if>
							<c:if test="${evo.fk_department == '2'}">
								<option value="1">디자인팀</option>
								<option value="2" selected>개발팀</option>
								<option value="3">영업팀</option>
								<option value="4">인사팀</option>
								<option value="5">경영지원팀</option>
							</c:if>
							<c:if test="${evo.fk_department == '3'}">
								<option value="1">디자인팀</option>
								<option value="2">개발팀</option>
								<option value="3" selected>영업팀</option>
								<option value="4">인사팀</option>
								<option value="5">경영지원팀</option>
							</c:if>
							<c:if test="${evo.fk_department == '4'}">
								<option value="1">디자인팀</option>
								<option value="2">개발팀</option>
								<option value="3">영업팀</option>
								<option value="4" selected>인사팀</option>
								<option value="5">경영지원팀</option>
							</c:if>
							<c:if test="${evo.fk_department == '5'}">
								<option value="1">디자인팀</option>
								<option value="2">개발팀</option>
								<option value="3">영업팀</option>
								<option value="4">인사팀</option>
								<option value="5" selected>경영지원팀</option>
							</c:if>
						</select>
					</td>
					<td>${evo.email}</td>
					<td>${evo.hire_date}</td>
					<td>${evo.status_name}</td>
					<td>
						<select name="grade" style="width: 35px;">
							<c:if test="${evo.grade == '1'}">
								<option selected>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</c:if>
							<c:if test="${evo.grade == '2'}">
								<option>1</option>
								<option selected>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</c:if>
							<c:if test="${evo.grade == '3'}">
								<option>1</option>
								<option>2</option>
								<option selected>3</option>
								<option>4</option>
								<option>5</option>
							</c:if>
							<c:if test="${evo.grade == '4'}">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option selected>4</option>
								<option>5</option>
							</c:if>
							<c:if test="${evo.grade == '5'}">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option selected>5</option>
							</c:if>
						</select>
					</td>
					<td><button class="snip1536" type="button" data-toggle="modal" data-target="#employeeUpdate${evo.employee_seq}" data-dismiss="modal">수정</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:forEach var="evo" items="${allEmployeeList}">
	<div class="modal fade" id="employeeUpdate${evo.employee_seq}" role="dialog">
		<div class="modal-dialog" style="width: 900px;">
		  
			    <!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">사원 수정</h4>
				</div>
				<div class="modal-body" style="height: 620px; width: 900px;">
					<div id="addDelivery">
						<iframe style="border: none; width: 100%; height: 600px;" src="<%= request.getContextPath()%>/employeeUpdate.top?employee_seq=${evo.employee_seq}">
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
</div>
