<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	#listArea{
		display: inline-block;
		width: 600px;
		float:left;
	}
	
	.infoArea{
		display: inline-block;
		width: 200px;
	}
	
	.hide{
		display: none;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".pick").each(function(index, item){
			$(item).click(function(){
				$(".infoArea").toggleClass("hide");
			});
		});
			
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
	<h3>인사고과</h3>
	</div>
</div>

<div id="listArea">
	<table id="datatables" class="table">
		<thead>
			<tr>
				<th>부서</th>
				<th>사원</th>
				<th>직책</th>
				<th>근무태도</th>
				<th>출결</th>
				<th>업무성과</th>
				<th>총평</th>
				<th>부서장</th>
				<th>기록날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="tavo" items="${TAList}">
				<tr class="pick">
					<td>${tavo.department_name}</td>
					<td>${tavo.employee_name}</td>
					<td>${tavo.position_name}</td>
					<td>
						<c:choose>
							<c:when test="${Number(tavo.attitude) > 90}">
								A
							</c:when>
							<c:when test="${Number(tavo.attitude) > 80}">
								B
							</c:when>
							<c:when test="${Number(tavo.attitude) > 70}">
								C
							</c:when>
							<c:when test="${Number(tavo.attitude) > 60}">
								D
							</c:when>
							<c:otherwise>
								F
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${Number(tavo.attendance) > 90}">
								A
							</c:when>
							<c:when test="${Number(tavo.attendance) > 80}">
								B
							</c:when>
							<c:when test="${Number(tavo.attendance) > 70}">
								C
							</c:when>
							<c:when test="${Number(tavo.attendance) > 60}">
								D
							</c:when>
							<c:otherwise>
								F
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${Number(tavo.performance) > 90}">
								A
							</c:when>
							<c:when test="${Number(tavo.performance) > 80}">
								B
							</c:when>
							<c:when test="${Number(tavo.performance) > 70}">
								C
							</c:when>
							<c:when test="${Number(tavo.performance) > 60}">
								D
							</c:when>
							<c:otherwise>
								F
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${Number(tavo.attitude) + Number(tavo.attendance) + Number(tavo.performance) > 270}">
								A
							</c:when>
							<c:when test="${Number(tavo.attitude) + Number(tavo.attendance) + Number(tavo.performance) > 240}">
								B
							</c:when>
							<c:when test="${Number(tavo.attitude) + Number(tavo.attendance) + Number(tavo.performance) > 210}">
								C
							</c:when>
							<c:when test="${Number(tavo.attitude) + Number(tavo.attendance) + Number(tavo.performance) > 180}">
								D
							</c:when>
							<c:otherwise>
								F
							</c:otherwise>
						</c:choose>
					</td>
					<td>${tavo.manager}</td>
					<td>${tavo.regDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="infoArea hide">
	<div id="chartArea">
		과거기록 포함 차트 출력
	</div>
	<div id="reasonArea">
		클릭한 기록의 사유 출력
	</div>
</div>
<div style="clear:both;"></div>