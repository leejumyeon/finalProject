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
</style>
<script type="text/javascript">

</script>

<div style="margin-left:10px;">
	<span class="writeBtn">보내기</span> <span class="writeBtn">미리보기</span>
</div>