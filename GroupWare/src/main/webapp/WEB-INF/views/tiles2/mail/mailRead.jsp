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
	$(document).ready(function(){
		// === jQuery UI 의 datepicker === //
		$(".datepicker").datepicker({
                 dateFormat: 'yy-mm-dd'  //Input Display Format 변경
                ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true        //콤보박스에서 년 선택 가능
                ,changeMonth: true       //콤보박스에서 월 선택 가능                
                ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
              //,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
              //,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
            });                    
            
            //초기값을 오늘 날짜로 설정
           // $('.today').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
		/////////////////////////////////////////////////////
		
		// === 전체 datepicker 옵션 일괄 설정하기 ===  
		//     한번의 설정으로 $("#fromDate"), $('#toDate')의 옵션을 모두 설정할 수 있다.
		$(function() {
		          //모든 datepicker에 대한 공통 옵션 설정
		          $.datepicker.setDefaults({
		              dateFormat: 'yy-mm-dd' //Input Display Format 변경
		              ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		              ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		              ,changeYear: true //콤보박스에서 년 선택 가능
		              ,changeMonth: true //콤보박스에서 월 선택 가능                
		              ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
		              ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
		              ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		              ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
		              ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
		              ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		              ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		              ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		              ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		           // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		           // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
		          });
		
		          //input을 datepicker로 선언
		          $("#fromDate").datepicker();                    
		          $("#toDate").datepicker();
		          
		          //From의 초기값을 오늘 날짜로 설정
		          $('#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
		          //To의 초기값을 내일로 설정
		          $('#toDate').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
		      });
           
	        // 메일 검색 창 포커스 시 함수 실행
			$("#mailSearch").focus(function(){
				$("#searchTypetArea").css({"display":"block","border":"solid 1px yellowgreen"});
				var txtVal = $(this).val();
				func_searchTypeFind(txtVal);
			});
	        
	        $("#mailSearch").blur(function(){
	        	$("#searchTypetArea").css({"display":"none","border":"none"});
	        	
	        });
	        
	        $("#mailSearch").keyup(function(){
	        	var txtVal = $(this).val();
	        	func_searchTypeFind(txtVal);
	        });
           
	        
	        // 기간 선택
	        $("#mailDay").change(function(){
	        	if($(this).val()!="" && $(this).val()!="direct"){
	        		$(".today").datepicker('setDate', 'today');
		        	
	        		if($(this).val()=="week"){
	        			$(".prevday").datepicker('setDate', '-7D');
	        		}
	        		else if($(this).val()=="month"){
		        		$(".prevday").datepicker('setDate', '-1M');
		        	}
		        	else if($(this).val()=="threeMonth"){
		        		$(".prevday").datepicker('setDate', '-3M');
		        	}
		        	else if($(this).val()=="sixMonth"){
		        		$(".prevday").datepicker('setDate', '-6M');
		        	}
	        	}
	        	else{
	        		$(".datepicker").val("");
	        		// $(".datepicker").datepicker('setDate', '');
	        		console.log("초기화");
	        	}
	        	
	        });
	        
	        $(".datepicker").change(function(){
	        	$("#mailDay").val("direct");
	        });
	}); // end of $(document).ready(function())-----------------------------------------------------
	
	function func_searchTypeFind(val){
		var len = val.length;
		console.log(len);
		var html = "";
		if(len>0){
			html += "<ul id='searchTypeList'>";
			html+="<li onclick='goSearch("+val+", all)'><div>"+val+"-<span style='font-size:8pt; color:gray;'>전체검색</span></div></li>";
			html+="<li onclick='goSearch("+val+", sender)'><div>보낸사람: "+val+"-<span style='font-size:8pt; color:gray;'>보낸사람을 찾기</span></div></li>";
			html+="<li onclick='goSearch("+val+", receiver)'><div>받은사람: "+val+"-<span style='font-size:8pt; color:gray;'>받은사람을 찾기</span></div></li>";
			html+="<li onclick='goSearch("+val+", content)'><div>내용: "+val+"-<span style='font-size:8pt; color:gray;'>제목, 본문내용, 첨부파일을 찾기</span></div></li>";
		}
		else{
			
			html="검색어를 입력하세요";
		}
		
		$("#searchTypetArea").html(html);
	}
	
	function goSearch(val, type){
		console.log(val+"/"+type);
	}
</script>
<div style="margin-left:10px;">
	<div id="searchArea">
		<div style="position: relative; display: inline;">
			<div style="border:solid 1px gray; display: inline-block;"><input type="text" size="20" id="mailSearch" style="border: none;"/><span style="background-color: white">아이콘</span></div>
			<span onclick="javascript:$('#termSearch').toggleClass('hide')" style="cursor:pointer">기간</span>
			<div id="searchTypetArea"></div>
		</div>
		<div id="termSearch" class="hide">
			<select id="mailDay" name="mailDay">
				<option value="">전체</option>
				<option value="week">1주</option>
				<option value="month">1개월</option>
				<option value="threeMonth">3개월</option>
				<option value="sixMonth">6개월</option>
				<option value="direct">직접입력</option>
			</select>
			<input type="text" class="datepicker prevday"> - <input type="text" class="datepicker today">
			<button type="button">검색</button>
		</div>
		
		<div id="mailFunctionArea">
			<button type="button">삭제</button>
			<button type="button">전달</button>
			<button type="button">답장</button>
		</div>
		<div id="mailDetail">
			<div id="subject">
				<h3>제목</h3>
			</div>
			<div id="send">
				<h6>보낸사람</h6>
				<h6>받은사람</h6>
			</div>
			<div id="content">
				내용
			</div>
		</div>
		
		<div id="other">
			<ul>
				<li>이전글 | </li>
				<li>다음글 | </li>
			</ul>
		</div>
	</div>
	
</div>