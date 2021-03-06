<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹웨어</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>


<%--  ===== 스피너를 사용하기 위해  jquery-ui 사용하기 ===== --%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<script src="<%= request.getContextPath()%>/resources/datepicker/datepicker.js"></script>  
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" />
<link rel="stylesheet" href="<%= request.getContextPath()%>/resources/datepicker/datepicker.css">

<%--  ===== datepicker css 와 script ===== --%>
<link rel="stylesheet" href="<%= request.getContextPath()%>/resources/datepicker/datepicker.css">
<script src="<%= request.getContextPath()%>/resources/datepicker/datepicker.js"></script>
<script src="<%= request.getContextPath()%>/resources/datepicker/datepicker.js"></script>  
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" />
<link rel="stylesheet" href="<%= request.getContextPath()%>/resources/datepicker/datepicker.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<div id="mycontainer">
		<div id="myheader">
			<tiles:insertAttribute name="header" />
		</div>
		<div id="mysession">
			<div id="mysideinfo">
				<tiles:insertAttribute name="sideinfo" />
			</div>
			
			<div id="mycontent">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
	</div>
	
	<c:if test="${empty(sessionScope.messenger)}">
		<div id="mymessenger" class="messengerClose">
			<tiles:insertAttribute name="messenger" />
		</div>
	</c:if>
	<c:if test="${not empty(sessionScope.messenger)}">
		<div id="mymessenger" class="messengerOpen">
			<tiles:insertAttribute name="messenger" />
		</div>
	</c:if>
	
	<div style="clear:both;"></div>
</body>
</html>

