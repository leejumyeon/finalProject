<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ======= #28. tile2 중 sideinfo 페이지 만들기  ======= --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	.sideNavi img{
		width: 40px;
		height: 40px;
		margin: 20px, 0;
		
	}
	
	.sideNavi{
		
	}
	
	.sideNavi > div{
		cursor: pointer;
	}
	
	
	.receiveCnt{
		border: solid 1px black;
		background-color: white;
		font-size: 10pt;
		font-weight: bold;
		border-radius: 50%;
		width:20px;
		height: 20px;
		text-align: center;
		z-index: 1;
		left: 40px;
		top: 20px;
		display: none;
	}
	
	.paymentCnt{
		border: solid 1px black;
		background-color: white;
		font-size: 10pt;
		font-weight: bold;
		border-radius: 50%;
		width:20px;
		height: 20px;
		text-align: center;
		z-index: 1;
		left: 40px;
		top: 20px;
		display: none;
	}
	
</style>
<script type="text/javascript">
$(document).ready(function(){
	newMailFind();
	//newPaymentFind();
}); // end of $(document).ready()-------------------------------------

function newMailFind(){
	$.ajax({
		url:"<%=request.getContextPath()%>/mail/newMailFind.top",
		data:{"loginSeq":"${sessionScope.loginEmployee.employee_seq}"},
		dataType:"JSON",
		success:function(json){
			console.log(json);
			if(json.result > "0"){
				var html="<span style='text-align:center;'>"+json.result+"</span>";
				$(".receiveCnt").show();
				$(".receiveCnt").html(html);
			}
		},
		error:function(e){
			
		}
	});
	setTimeout('newMailFind()',30000);
}

function newPaymentFind(){
	$.ajax({
		url:"<%=request.getContextPath()%>/document/newPaymentFind.top",
		data:{"loginSeq":'${sessionScope.loginEmployee.employee_seq}'},
		dataType:"JSON",
		success:function(json){
			
			if(json.result > "0") {
				
				var html = "<span style='text-align:center;'>"+json.result+"</span>";
				$(".paymentCnt").show();
				$(".paymentCnt").html(html);
			}
		},
		error:function(e){
			
		}
	});
	
	setTimeout('newPaymentFind()',30000);
}

function goMail(){
	location.href="<%=request.getContextPath()%>/mail/list.top?type=receive";
}

function goMailSend(){
	location.href="<%=request.getContextPath()%>/mail/write.top?type=normal";
}

function goReservation(){
	location.href="<%=request.getContextPath()%>/reservation/reserveRoom.top";
}

function goPayment() {
	location.href="<%=request.getContextPath()%>/documentPayment.top";
}
</script>
<div style="margin: 0 auto;" align="center" class="sideNavi">
	
			<div style="position: relative;" onclick="goMail();">
				<div style="position: absolute;" class="receiveCnt" align="center"></div>
				<img src="<%=request.getContextPath()%>/resources/sideImg/받은메일.png" />
				<span style="display: inline-block; font-size: 5px;">받은 메일함</span>
			</div>
			
			<div style="height: 20px;"></div>
			
			<div style="position: relative;" onclick="goMailSend()">
				<img src="<%=request.getContextPath()%>/resources/sideImg/메일보내기.png" />
				<div style="position: absolute;"></div>
				<span style="display: inline-block; font-size: 5px;">메일 보내기</span>
			</div>
			
			<div style="height: 20px;"></div>
			
			<div style="position: relative;" onclick="goReservation()">
				<img src="<%=request.getContextPath()%>/resources/sideImg/예약.png" />
				<div style="position: absolute;"></div>
				<span style="display: inline-block; font-size: 5px;">자원 예약</span>
			</div>
			
			<div style="height: 20px;"></div>
			
			<div style="position: relative;" onclick="goPayment()">
				<img src="<%=request.getContextPath()%>/resources/sideImg/결재.png" />
				<div style="position: absolute;" class="paymentCnt"></div>
				<span style="display: inline-block; font-size: 5px;">문서 결재</span>
			</div>
		
</div>
