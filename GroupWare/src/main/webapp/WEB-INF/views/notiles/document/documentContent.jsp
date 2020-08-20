<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/documentStyle.css" />

<script type="text/javascript">

	function showFile(filename) {
		
		window.open('<%= request.getContextPath()%>/resources/files/' + filename +'', '사진', 'width = 450, height= 450, top=200')
	}
</script>

<div id="divCustomWrapper" style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="titleSection">${documentContent.category_name} 기안서</div>
	
	<div class="partition">
		
		<div class="left">
			<table style="width:260px; height:130px;">
				<tbody>
					<tr><td class="ACel">문서번호</td><td class="BCel"><input name="groupno" value="${documentContent.groupno}" style="border: none;" readonly/></td></tr>
					<tr><td class="ACel">기안일</td><td class="BCel"><input name="regDate" value="${documentContent.regDate}" style="border: none;" readonly/></td></tr>
					<tr><td class="ACel">기안자부서</td><td class="BCel">${documentContent.department_name}</td></tr>
					<tr><td class="ACel">기안자</td><td class="BCel">${documentContent.employee_name}</td></tr>
				</tbody>
			</table>
		</div>
		
		<table width="540" style="border-collapse:collapse; margin-bottom: 15px;" class="form2" align="center">
			<tr>
				<td align="right">
					<table border="1" style="border-collapse: collapse; display: inline-block;">
						<tr>
							<td width="25" height="120" rowspan="3" align="center" bgcolor="#D9E2F3">결<br>
							<br>
							<br>
							재</td>
							<td width="100" height="25" style="text-align: center; font-size: 10pt; font-style: italic; font-weight: bold;">
								기안자
							</td>
						</tr>
						<tr>
							<td height="25" style="text-align: center; font-size: 8pt;">
								${documentContent.position_name}&nbsp;${documentContent.employee_name}
							</td>
						</tr>
						<tr>
							<td height="70" style="text-align: center;">
								<img src="<%= request.getContextPath()%>/resources/images/acceptedStamp.png" width="70px">
							</td>
						</tr>
					</table>
					<table border="1" id="approvalList" style="border-collapse: collapse; display: inline-block;">
						<tr>
							<c:forEach items="${approverList}" varStatus="status">
								<td width="100" height="25" style="text-align: center; font-size: 10pt; font-style: italic; font-weight: bold;">
									결제자 ${status.count}
								</td>
							</c:forEach>
						</tr>
						<tr>
							<c:forEach var="docuvo" items="${approverList}" varStatus="status">
								<td height="25" style="text-align: center; font-size: 8pt;">
									${docuvo.approver_position}&nbsp;${docuvo.approver_name}
								</td>
							</c:forEach>
						</tr>
						<tr>
							<c:forEach var="docuvo" items="${approverList}">
								<td height="70" style="text-align: center;">
									<c:if test="${docuvo.status == '1'}">
										<img src="<%= request.getContextPath()%>/resources/images/acceptedStamp.png" width="70px">
									</c:if>
									<c:if test="${docuvo.status == '-1'}">
										<img src="<%= request.getContextPath()%>/resources/images/rejectedStamp.png" width="70px">
									</c:if>
								</td>
							</c:forEach>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
	<br/>
	
	<div id="documentContents">
		<img src="<%= request.getContextPath()%>/resources/files/${documentContent.content}" width="800px;" />
	</div>
	
	<c:if test="${documentContent.fileName != null}">
		<table style="width:800px; height:30px;">
			<tbody>
				<tr><td class="ACel">첨부파일</td><td class="BCel" onclick="showFile('${documentContent.fileName}')" style="cursor: pointer;">${documentContent.orgFileName}</td></tr>
			</tbody>
		</table>
	</c:if>
</div>