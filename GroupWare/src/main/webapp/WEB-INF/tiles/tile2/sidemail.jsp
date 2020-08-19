<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ======= #28. tile2 중 sideinfo 페이지 만들기  ======= --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String ctxPath = request.getContextPath(); %>

<style type="text/css">
	.mailBtn{
		display: inline-block;
		padding: 10px 10px;
		background-color: white;
		font-size: 11pt;
		cursor: pointer;
		margin-right: 5px;
	}
	
	.subMailBtn{
		display: inline-block;
		height: 100 px;
		border: solid 0px white;
		cursor: pointer;
	}
	
	#mailhamList{
		list-style: none; 
		padding:0;
	}
	
	#mailhamList > li{
		line-height: 50px;
		color:white;
	}
	
	#mailhamList > li > div{
		padding-left: 5px;
	}
	
	#mailhamList > li:hover{
		cursor: pointer;
		background-color: white;
		font-size: 12pt;
		font-weight: bold;
		color: black;
	}
	
	.delete:hover{
		background-color: gray;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			url:"<%=request.getContextPath()%>/mail/noRead.top",
			data:{"loginSeq":"${sessionScope.loginEmployee.employee_seq}"},
			type:"get",
			dataType:"JSON",
			success:function(json){
				var html = "<div style='color:green; text-align:center; font-size:28pt;' class='noRead'>"+json.noReadCount+"</div>";
				$(".cnt").html(html);
				if(json.delCount > 0){
					html = "<span>"+json.delCount+"</span>";
					$("#trushCount").append(html);
				}
				
			},
			error:function(e){
				
			}
		});
		
		$(".subMailBtn").click(function(event){
			var $target = $(event.target);
		
			if($target.hasClass("noRead")){
				
				location.href="<%=request.getContextPath()%>/mail/list.top?type=noRead";
			}
			else if($target.hasClass("attach")){
				
				location.href="<%=request.getContextPath()%>/mail/list.top?type=attach";
			} 
		});
		
		$(".trush").click(function(event){
			var $target = $(event.target);
			console.log($target);
			if($target.hasClass("delete")){ //비우기 클릭시
				$.ajax({
					url:"<%=request.getContextPath()%>/mail/drop.top",
					data:{"loginSeq":"${sessionScope.loginEmployee.employee_seq}"},
					type:"GET",
					dataType:"JSON",
					success:function(json){
						if(json.msg!= ""){
							alert(json.msg);
							history.go(0);
						}
						else{
							alert("휴지통을 비우는데 실패했습니다.");
						}
					},
					error:function(e){
						
					}
				});
			}
			else{ // 휴지통 클릭시
				location.href="<%=request.getContextPath()%>/mail/list.top?type=del";
			}
		});
	});
</script>
<div style="margin: 0 auto;" align="center">
	<div id="mailBtnArea">
		<span class="mailBtn" onclick="javascript:location.href='<%=ctxPath%>/mail/write.top?type=normal'">메일쓰기</span>
		<span class="mailBtn" onclick="javascript:location.href='<%=ctxPath%>/mail/write.top?type=mine'">내게쓰기</span>
		<br>
	</div>
	<div align="left" style="margin:10px 10px 0 12px; padding-bottom:5px; border-bottom: solid 1px white">
		<div class="subMailBtn">
			<div style="border:solid 0px black; width: 50px; height: 50px;" class="noRead cnt">
				
			</div>
			<div style="border:solid 0px green" class="noRead">안읽음</div>
		</div>
		
		<div class="subMailBtn">
			<div style="border:solid 0px black; width: 50px; height: 50px;" class="attach">
				<img src="<%=ctxPath%>/resources/sideImg/attach.jpg" width="100%;"/>
			</div>
			<div style="border:solid 0px green" class="attach">첨부</div>
		</div>
	</div>
	<div id="mailhamArea" align="left">
		<ul id="mailhamList">
			<li onclick="location.href='<%=request.getContextPath()%>/mail/list.top?type=all'"><div>전체메일</div></li>
			<li onclick="location.href='<%=request.getContextPath()%>/mail/list.top?type=receive'"><div>받은메일함</div></li>
			<li onclick="location.href='<%=request.getContextPath()%>/mail/list.top?type=send'"><div>보낸메일함</div></li>
			<li onclick="location.href='<%=request.getContextPath()%>/mail/list.top?type=mine'"><div>내게쓴메일함</div></li>
			<li class="trush"><div id="trushCount" style="display:inline-block;">휴지통</div><div style="display: inline-block; float:right; margin-right:30px; color:black;" class="delete">비우기</div></li>
		</ul>
	</div>
</div>