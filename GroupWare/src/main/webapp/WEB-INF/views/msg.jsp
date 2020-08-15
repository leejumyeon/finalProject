<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

	alert("${message}");
	location.href = "${loc}";	//	페이지 이동
	
	parent.closeModal();	// 모달창 닫기
</script>