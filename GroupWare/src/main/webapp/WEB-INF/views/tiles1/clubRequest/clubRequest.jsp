<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
	#container {
		width: 1240px;
		margin: 0 auto;
	}
	
	#in {
		width: 1000px;
		margin: 0 auto;
	}
	
	.sidebar2 {
		border: 1px solid white;
		width: 100px;
		height: 52px;
		margin-left: 30px;
		cursor: pointer;
		padding-top: 15px;
		text-align: center;
		background-color: #3399ff;		
		color: white;
	}	
	
	.comunity {
		padding-top: 18px;
		width: 100px;
		height: 55px;
		margin-left: 30px;
		text-align: center;
		font-weight: bold;		
	}

	#post {
		margin-right: 30px;
		width: 750px;
		float: right;		
	}	

	#side {
		float: left;
	}
	
	.snip1537 {
	  background-color: #0099ff;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 22px;
	  line-height: 1em;
	  margin: 15px 40px;
	  outline: none;
	  padding: 12px 15px 10px;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.snip1537:before,
	.snip1537:after {
	  border-color: transparent;
	  -webkit-transition: all 0.25s;
	  transition: all 0.25s;
	  border-style: solid;
	  border-width: 0;
	  content: "";
	  height: 24px;
	  position: absolute;
	  width: 24px;
	}
	
	.snip1537:before {
	  border-color: #0099ff;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1537:after {
	  border-bottom-width: 2px;
	  border-color: #0099ff;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1537:hover {
	  background-color: #0099ff;
	}
	
	.snip1537:hover:before,
	.snip1537:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
	.bg2{ background-color:rgba(0, 0, 0, 0.5); /*살짝 투명한 검정으로 배경색*/ width: 200px; height: 250px; position: absolute; /*다른 요소들 위로 겹쳐질 수 있게함*/ top:155px; }

	.clubContent { opacity: 0; }
	
	.clubContent2 { position: relative; z-index:1000; opacity: 1;/*맨 앞으로 나오도록 함*/ }

	tbody, tr, td { margin-left: 15px; border: solid 1px gray; border-collapse: collapse;}
	
	td.ACel {
		background-color: #3399ff;		
		color: white;
	}
	
	.snip1538 {
	  background-color: #0099ff;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 22px;
	  line-height: 1em;
	  margin: 15px 40px;
	  outline: none;
	  padding: 12px 40px 10px;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.snip1538:before,
	.snip1538:after {
	  border-color: transparent;
	  -webkit-transition: all 0.25s;
	  transition: all 0.25s;
	  border-style: solid;
	  border-width: 0;
	  content: "";
	  height: 24px;
	  position: absolute;
	  width: 24px;
	}
	
	.snip1538:before {
	  border-color: #0099ff;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1538:after {
	  border-bottom-width: 2px;
	  border-color: #0099ff;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1538:hover {
	  background-color: #0099ff;
	}
	
	.snip1538:hover:before,
	.snip1538:hover:after {
	  height: 100%;
	  width: 100%;
	}
</style>
<script type="text/javascript">

	$(document).ready(function() {
		
		$(".detailSection").css("display","none");
		
		$(".clubTable").hover(function() {
			
			$(this).find(".clubContent").addClass("clubContent2");
			
			$(this).find(".bg").addClass("bg2");
		},
		function() {
			
			$(this).find(".clubContent").removeClass("clubContent2");
			
			$(this).find(".bg").removeClass("bg2");
			
		});
		
		$(".snip1537").click(function() {
			
			$(".detailSection").css("display","inline-block");
		});
		
		$(".snip1538").click(function() {
			
			var detailSection = $(this).parents(".detailSection");
			var type = "club";
			var subject = detailSection.find(".subject").val();
			var reason = detailSection.find(".reason").val();
			var receive = detailSection.find(".employee_seq").val();
			
			
			$.ajax({
				url:"<%=request.getContextPath()%>/mail/requestMail.top",
				data:{"type":type
					  ,"clubName":subject
					  ,"reason":reason
					  ,"receive":receive},
				type:"get",
				dataType:"JSON",
				success:function(json){
					console.log(json.result);
					if(json.result=="true"){
						alert("동호회 가입 신청 메일을 동호회 회장에게 보냈습니다.");
					}
					else{
						alert("동호회 가입 신청 메일을 동호회 회장에게 보내는데 실패했습니다.");
					}
				},
				error:function(e){
					alert("동호회 가입 신청 메일을 동호회 회장에게 보내는 도중 오류가 발생했습니다.");
				}
			});
			
		});
	});
	
</script>
	<div id="container">
		<div id="in">
			<div id="side">
				<div class="comunity">커뮤니티</div>			
				<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/list.top?seq=${board.seq}'">앨범</div>
				<div class="sidebar2" onclick="javascript:location.href=''">자유게시판</div>
				<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/clubRequest.top'">동호회신청</div>
			</div>	
							
			<div id="post">	
				<h3>동호회 신청</h3>

				<c:forEach var="clubMap" items="${clubList}">
					<div class="clubTable" style="display: inline-block; background-image: url('<%= request.getContextPath()%>/resources/files/${clubMap.representative_img}'); width: 200px; height: 250px;">
						<div class="bg"></div>
						<div class="clubContent" style="color: white;">
							동호회명 : ${clubMap.club_name}<br/>
							동호회 회장 : ${clubMap.employee_name}<br/>
							동호회 인원수 : ${clubMap.cnt}<br/>
							동호회 소개 : ${clubMap.club_info}<br/>
							<button type="button" class="snip1537">신청하기</button>
						</div>
					</div>
					
					<div class="detailSection" style="display: inline-block; width: 450px;">
						<table>
							<tbody>
								<tr>
									<td class="ACel" style="width: 100px; text-align: center;">
										<span style="font-weight: bold; font-size: 11pt;">동호회명</span>
									</td>
									<td class="BCel" colspan="3">
										<input type="text" class="subject" style="border: none; width: 350px; height: 30px;" value="${clubMap.club_name}" readonly/>
									</td>
								</tr>
								<tr>
									<td class="ACel" style="width: 100px; text-align: center;">
										<span style="font-weight: bold; font-size: 11pt;">신청자명</span>
									</td>
									<td class="BCel" colspan="3">
										<input type="text" style="border: none; width: 350px; height: 30px;" value="${sessionScope.loginEmployee.employee_name}" readonly/>
									</td>
								</tr>
								<tr>
									<td class="ACel" style="width: 100px; text-align: center;">
										<span style="font-weight: bold; font-size: 11pt;">신청사유</span>
									</td>
									<td class="BCel" colspan="3">
										<textarea rows="3" cols="45" class="reason" style="border: none;"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
						<input type="hidden" value="${clubMap.club_seq}" class="club_seq" />
						<input type="hidden" value="${clubMap.employee_seq}" class="employee_seq" />
						<button type="button" class="snip1538" id="btnRequestClub${clubMap.club_seq}">신청완료하기</button>
					</div>
				</c:forEach>

			</div>
			
		</div>
	</div>