<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	
	table{
	
		width:100%;
		border: 1px solid #444444;
		border-collapse:collapse;
		background-color: #bbdefb;
	}
	
	th, td {
	
		border: 1px solid #444444;
		padding: 5px; 
		text-align: center;
	
	}
	
	thead tr {
	
      background-color: #0d47a1;
      color: #ffffff;
      
  	}
	tbody tr:nth-child(2n) {
	
	  background-color: #bbdefb;
	  
	}
	tbody tr:nth-child(2n+1) {
	
	  background-color: #e3f2fd;
	  
	}
		
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		func_viewInfo();
				
	});// end of $(document).ready(function(){
	
	function func_viewInfo(){
		
		$.ajax({
			
			url:"/groupware/popupList.top",
			data:{"club_seq":"${club_seq}"},
			dataType:"JSON",			
			success:function(json){
				var html = "";
				//html += "<div>"+${club_name}+"<div>";
				
				html += "<table>";
					html += "<thead>";
						html += "<tr>";							
							html += "<th>회원번호</th>"; 
							html += "<th>회원명</th>";
							html += "<th>동호회명</th>";
							html += "<th>동호회소개</th>";
							html += "<th>회원등급</th>";
							html += "<th>가입날짜</th>";					
						html += "</tr>";
					html += "</thead>";	
							
				$.each(json.resultList, function(index,item){
				
					html += "<tbody>";
						html += "<tr >";								
							html += "<td>"+item.member_seq+"</td>"; 
							html += "<td>"+item.employee_name+"</td>";
							html += "<td>"+item.club_name+"</td>";
							html += "<td>"+item.club_info+"</td>";
							html += "<td>"+item.status+"</td>";
							html += "<td>"+item.regDate+"</td>";													
						html += "</tr>";
					html += "</tbody>";
				
			});	
			
			html += "</table>";
			
			$("#show").html(html);
			
				
			},
			error : function(request, status, error){
				
				alert("code: "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		
			
		});
		
		
	}
		
</script>

<div id="show"></div>    