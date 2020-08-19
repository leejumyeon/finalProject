<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	.managerBtn{
		border:solid 1px black;
		padding: 10px 15px;
		cursor: pointer;
		float:right;
	}
	
	/* .noticeTable, .noticeTable td{
		border:solid 1px black;
		border-collapse: collapse;
		margin:0;
	} */
	
	.tbl_title{
		width: 40%;
		text-align: center;
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
			
		}); // end of $("#datatables").DataTable({})
		
<%-- 		$("#datatabless").DataTable({
			
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
			
		}); // end of $("#datatabless").DataTable({}) 
	--%>
		
	}); // end of $(document).ready(function(){})

</script>


 
<div>
	<div style="display: inline-block;">
	<h3>게시글관리</h3>
	<h4 style="text-align: center;">-신고글 조회-</h4>
	</div>
	
	<div id="content_area">
		<div class ="table_title" style="margin-top:5px;">
			<div class="searchArea" style="display:inline-block; float:right;">
				<div style="border:solid 1px gray; display: inline-block;"><span style="background-color: white; cursor: pointer;" class="icon">아이콘</span><input type="text" size="20" id="boardSearch" name="searchWord" value="" style="border: none;" autocomplete="off"/></div>
				<select name="searchType">
					<option>전체</option>
					<option>작성자</option>
					<option>제목</option>
					<option>내용</option>
				</select>
			</div>
			<h4 style="display: inline-block;">신고 게시글</h4>
		</div>
		<div style="clear:both;"></div>
		
		<table id="datatables" class="table">
			<thead>
				<tr>
					<th>글 종류</th>
					<th>글 번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>작성날짜</th>
					<th>조회수</th>
					<th>신고 적용</th>
				</tr>
			</thead>
			<tbody>	
				<tr>
					<td>글 종류</td>
					<td>글 번호</td>
					<td>작성자</td>
					<td>제목</td>
					<td>작성날짜</td>
					<td>조회수</td>
					<td>적용</td>
					<td>취소</td>
				</tr>
			</tbody>	
		</table>
		
		<div class ="table_title" style="margin-top:5px;">
			<h4 style="display: inline-block;">신고 댓글</h4>
		</div>
		<div style="clear:both;"></div>
<!--  <table id="datatabless" class="table">
			<thead>
				<tr>
					<th>원게시글 제목</th>
					<th>원게시글 종류</th>
					<th>글번호</th>
					<th>작성자</th>
					<th>작성날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>원게시글 제목</td>
					<td>원게시글 종류</td>
					<td>글번호</td>
					<td>작성자</td>
					<td>작성날짜</td>
				</tr>
			</tbody>
		</table> -->
	</div>
</div>