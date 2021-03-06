<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<meta charset="UTF-8">
<title>캘린더</title>

	<link rel= "shortcut icon" href="./resources/calendar/images/favicon.ico">

    <link rel= "stylesheet" href="./resources/calendar/vendor/css/fullcalendar.min.css" />
    <link rel= "stylesheet" href="./resources/calendar/vendor/css/bootstrap.min.css">
    <link rel= "stylesheet" href='./resources/calendar/vendor/css/select2.min.css' />
    <link rel= "stylesheet" href='./resources/calendar/vendor/css/bootstrap-datetimepicker.min.css' />

    <link rel= "stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel= "stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel= "stylesheet" href="./resources/calendar/css/main.css">
    
    <link rel="icon" type="image/png" href="<%= request.getContextPath()%>/resources/table_css/images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/perfect-scrollbar/perfect-scrollbar.css">
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/css/util.css">
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/css/main.css">
<style>

	.snip1536 {
		  background-color: #0099ff;
		  border: none;
		  color: #ffffff;
		  cursor: pointer;
		  display: inline-block;
		  font-family: 'BenchNine', Arial, sans-serif;
		  font-size: 1em;
		  font-size: 10pt;
		  line-height: 1em;
		  margin: 8px 12px;
		  outline: none;
		  position: relative;
		  text-transform: uppercase;
		  font-weight: 700;
		  width: 60px;
		  height: 20px;
		}
		
		.snip1536:before,
		.snip1536:after {
		  border-color: transparent;
		  -webkit-transition: all 0.25s;
		  transition: all 0.25s;
		  border-style: solid;
		  border-width: 0;
		  content: "";
		  height: 15px;
		  position: absolute;
		  width: 15px;
		}
		
		.snip1536:before {
		  border-color: #0099ff;
		  border-right-width: 3px;
		  border-top-width: 3px;
		  right: -5px;
		  top: -5px;
		}
		
		.snip1536:after {
		  border-bottom-width: 3px;
		  border-color: #0099ff;
		  border-left-width: 3px;
		  bottom: -5px;
		  left: -5px;
		}
		
		.snip1536:hover {
		  background-color: #0099ff;
		}
		
		.snip1536:hover:before,
		.snip1536:hover:after {
		  height: 100%;
		  width: 100%;
		}
		
		table.type09 {
		    border-collapse: collapse; 
		    text-align: left;
		    line-height: 1.5;
		
		}
		table.type09 thead th {
		    padding:10px;
		    font-weight: bold;
		    vertical-align: top; 
		    color: #369;
		    border-bottom: 1px solid #036; 
		}
		table.type09 tbody th {
		    width: 100px;
		    padding: 10px;
		    font-weight: bold;
		    vertical-align: top;
		    border-bottom: 1px solid #ccc;
		    background: #f3f6f7;
		}
		table.type09 td {  
		    width: 280px;  
		    padding: 10px;
		    font-weight: bold; 
		    vertical-align: top;
		    border-bottom: 1px solid #ccc;
		}			
		
			
</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		func_viewInfo();
		func_infoViews();
	});
	
</script>

	<div class="container" style="width: 700px; display: inline-block; float: left;"> 
				
	        <!-- 일자 클릭시 메뉴오픈 -->
	        <div id="contextMenu" class="dropdown clearfix">
	            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
	                style="display:block;position:static;margin-bottom:5px;">
	                <li><a tabindex="-1" href="#">카테고리1</a></li>
	                <li><a tabindex="-1" href="#">카테고리2</a></li>
	                <li><a tabindex="-1" href="#">카테고리3</a></li>
	                <li><a tabindex="-1" href="#">카테고리4</a></li>
	                <li class="divider"></li>
	                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
	            </ul>
	        </div>
	
	        <div id="wrapper">
	            <div id="loading"></div>
	            <div id="calendar"></div>	
	            
	               
	        </div>

	        <!-- 일정 추가 MODAL -->
	        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
	            <div class="modal-dialog" role="document">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
	                                aria-hidden="true">&times;</span></button>
	                        <h4 class="modal-title"></h4>
	                    </div>
	                    <div class="modal-body">
	
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-allDay">하루종일</label>
	                                <input class='allDayNewEvent' id="edit-allDay" type="checkbox"></label>
	                            </div>
	                        </div>
	
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-title">일정명</label>
	                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
	                                    required="required" />
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-start">시작</label>
	                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-end">끝</label>
	                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-type">구분</label>
	                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
	                                    <option value="카테고리1">카테고리1</option>
	                                    <option value="카테고리2">카테고리2</option>
	                                    <option value="카테고리3">카테고리3</option>
	                                    <option value="카테고리4">카테고리4</option>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-color">색상</label>
	                                <select class="inputModal" name="backgroundColor" id="edit-color">
	                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
	                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
	                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
	                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
	                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
	                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
	                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
	                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
	                                    <option value="#495057" style="color:#495057;">검정색</option>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-desc">설명</label>
	                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
	                                    id="edit-desc"></textarea>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="modal-footer modalBtnContainer-addEvent">
	                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
	                    </div>
	                    <div class="modal-footer modalBtnContainer-modifyEvent">
	                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
	                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
	                    </div>
	                </div><!-- /.modal-content -->
	            </div><!-- /.modal-dialog -->
	        </div><!-- /.modal -->        
        

         <div class="panel panel-default" id="hideAll">

            <div class="panel-heading">
                <h3 class="panel-title">필터</h3>
            </div>

            <div class="panel-body">

                <div class="col-lg-6">
                    <label for="calendar_view">구분별</label>
                    <div class="input-group">
                        <select class="filter" id="type_filter" multiple="multiple">
                            <option value="카테고리1">카테고리1</option>
                            <option value="카테고리2">카테고리2</option>
                            <option value="카테고리3">카테고리3</option>
                            <option value="카테고리4">카테고리4</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label for="calendar_view">등록자별</label>
                    <div class="input-group">
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="${sessionScope.loginEmployee.employee_name}"
                                checked>개발팀</label>
                    </div>
                </div>

            </div>
        </div> 
        <!-- /.filter panel -->
                                  
    </div>
    
    <div style="float: left; border: solid 0px green; width: 300px; height: 300px; padding-top: 22px;" >
    	<div style="border: solid 0px blue; width: 500px; height: 267px;">
    	
	        <br/><span><h3 style="font-weight: bolder;">개인정보</h3></span><br/>
	        
     		<table class="type09">
			    
			     <tr>
			        <th scope="row">사번</th>
			        <td>${sessionScope.loginEmployee.employee_id}</td>
			    </tr>
			    <tr>
			        <th scope="row">직급</th>
			        <td>${sessionScope.loginEmployee.position_name}</td>
			    </tr>
			    <tr>
			        <th scope="row">부서명</th>
			        <td>${sessionScope.loginEmployee.department_name}</td>
			    </tr>
			    <tr>
			        <th scope="row">이름</th>
			        <td>${sessionScope.loginEmployee.employee_name}</td>
			    </tr>
			    <tr>
			        <th scope="row">입사날짜</th>
			        <td>${sessionScope.loginEmployee.hire_date}</td>
			    </tr>
			    
 			 </table>      	
        </div>
        <br/>
        <div style="width: 500px; height: 267px;">
        	<h3 style="display: inline-block; width: 120px; font-weight: bolder;">도서 추천</h3>
        	<input id="bookName" type="text" style="border: solid 0.5px #0099ff;">
			<button id="search" class="snip1536">검색</button>
			
			<div id="p" style="width: 500px;"></div>
        </div> 	                     
    </div>
	<div style="clear: both;"></div>
	<br/>
    <div style="padding-left: 15px; float: left;">   
	    <div style="border: solid 0px red; width: 520px; height: 148px; ">
	        <h3 style="font-weight: bolder;">동호회</h3><br/>
	        <div id="view"></div>		        	        
	    </div>    
    </div>
    <div style="float: left; margin-left: 30px;">   
	    <div style="border: solid 0px red; width: 562px; height: 148px; margin-left: 15px;">
	        <h3 style="font-weight: bolder;">예약 현황</h3><br/>
	        <div id="views"></div>	
	    </div>    
    </div>
    <!-- /.container -->
    
     <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
  	
  	<script>

	  $(function () {
		  
		  $("#bookName").keydown(function(event) {
			 
			  var code = event.keyCode;
			  
			  if(code == '13') {
				  
				  $("#search").click();
			  }
		  });
		  
	      $("#search").click(function () {
	    	      	     	  
	          $.ajax({
	              method: "GET",
	              url: "https://dapi.kakao.com/v3/search/book?target=title", // 전송 주소
	              data: { query: $("#bookName").val() }, 
	              headers: { Authorization: "KakaoAK 6b9a374380958fdd321ffdf370b9e7d9" }
	          })
	             .done(function (msg) {   
	            	 
	            var html ="";
	            
           		html += '<div id="myCarousel" class="carousel slide" data-ride="carousel">';
           		html += '<ol class="carousel-indicators">';
           		html += '<li data-target="#myCarousel" data-slide-to="0" class="active"></li>';
           		html += '<li data-target="#myCarousel" data-slide-to="1"></li>';
           		html += '<li data-target="#myCarousel" data-slide-to="2"></li>';
           		html += '</ol>';
           		
           		html += '<div class="carousel-inner">';
           		
           		html += '<div class="item active">';
           		html += "<div style='display:inline-block; min-width:300px;'>";
	           	for(var i = 0; i<3 ; i++) {

	           		html += "<div style='display: inline-block; margin-right: 30px;'>";
	           		html += "<span><img src='" + msg.documents[i].thumbnail + "'></span><br />";
	           		html += "제목&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].title) + "</strong><br />";
	       			html +=	"저자&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].authors[0]) + "</strong><br />";
	     			html += "판매가&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].price) + "</strong><br />";
	           		html += "</div>";
				          		                         
	           	}
	           	
           		html += "</div>";
           		html += '</div>';
	           	
           		html += '<div class="item">';
           		html += "<div style='display:inline-block; min-width:300px;'>";
           		
	           	for(var i = 3; i<6 ; i++) {

	           		html += "<div style='display: inline-block; margin-right: 30px;'>";
	           		html += "<span><img src='" + msg.documents[i].thumbnail + "'></span><br />";
	           		html += "제목&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].title) + "</strong><br />";
	       			html +=	"저자&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].authors[0]) + "</strong><br />";
	     			html += "판매가&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].price) + "</strong><br />";
	           		html += "</div>";
	           							          		                         
	           	}
	           	
	           	html += "</div>";
           		html += '</div>';
	           	
           		html += '<div class="item">';
           		html += "<div style='display:inline-block; min-width:300px;'>";
           		
	           	for(var i = 6; i<9 ; i++) {

	           		html += "<div style='display: inline-block;  margin-right: 30px;'>";
	           		html += "<span><img src='" + msg.documents[i].thumbnail + "'></span><br />";
	           		html += "제목&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].title) + "</strong><br />";
	       			html +=	"저자&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].authors[0]) + "</strong><br />";
	     			html += "판매가&nbsp;:&nbsp;<strong>" + numberMaxLength(msg.documents[i].price) + "</strong><br />";
	           		html += "</div>";
	           							          		                         
	           	}
	           	
           		html += "</div>";
           		html += '</div>';
	           	
	           	html += ' <a class="left carousel-control" href="#myCarousel" data-slide="prev">';
	           	html += '<span class="glyphicon glyphicon-chevron-left"></span>';
	           	html += '<span class="sr-only">Previous</span>';
	           	html += '</a>';
	           	html += '<a class="right carousel-control" href="#myCarousel" data-slide="next">';
	           	html += '<span class="glyphicon glyphicon-chevron-right"></span>';
	           	html += '<span class="sr-only">Next</span>';
	           	html += '</a>';
	           	html += '</div>';
	           	html += '</div>';
	           	
	           	$("#p").html(html);
	           	
	           });
	      })
	  });
	  
	function numberMaxLength(e){
		
		if(e.length > 6){
			
			e = e.substring(0, 6) + "..";
		}
		
		return e;
	}
	
	// 동호회	
	function func_viewInfo(){
		
		$.ajax({			
			url:"/groupware/club.top",
			dataType:"JSON",
			success:function(json){

				var html = '<div class="table100 ver2 m-b-35">';
				html += '<div class="table100-head">';
				html += "<table class='tableClass'>";
				html += "<thead>";
			html += "<tr class='row100 head'>";
				html += "<th class='cell100 column2'>회원명</th>";
				html += "<th class='cell100 column2'>동호회명</th>";
				html += "<th class='cell100 column3'>동호회소개</th>";
				html += "<th class='cell100 column5'>가입날짜</th>";					
				html += "<th class='cell100 column5'>회원명단</th>";				 						
			html += "</tr>";
			html += "</thead>";
			html += "</table>";
			html += "</div>";
			
			html += '<div class="table105-body js-pscroll">';
			html += '<table>';
			html += "<tbody>";
				$.each(json, function(index,item){
					
					html += "<tr>";			

						html += "<td class='cell100 column2'>"+item.employee_name+"</td>";
						html += "<td class='cell100 column2'>"+item.club_name+"</td>";
						html += "<td class='cell100 column3'>"+item.club_info+"</td>";
						html += "<td class='cell100 column5'>"+item.regDate+"</td>";
						
					if(item.status == '1') {
						
						html += "<td class='cell100 column5'><button onclick='viewClubMember(" + item.club_seq + ")'>명단보기</button></td>";
					
					}
					
					html += "</tr>";
					
				});	
				
				html += "</tbody>";
  				html += "</table>";
  				html += "</div>"
  				html += "</div>"
				
				$("#view").html(html);
				
			},
			error : function(request, status, error){
				
				alert("code: "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		
		});
		
	}//end of function func_viewInfo(){}
	
	function viewClubMember(club_seq){
		
		window.open("/groupware/popup.top?club_seq="+club_seq+"","popup","width=600, height=400, top=300,left=300");
		
	}
	
	// ------------------------------------ 예약 ------------------------------------------
	
	function func_infoViews(){
		
		$.ajax({
			
			url:"/groupware/reservation.top",
			dataType:"JSON",
			success:function(json){
				
				var html = '<div class="table100 ver2 m-b-35">';
				html += '<div class="table100-head">';
				html += "<table class='tableClass'>";
				html += "<thead>";
			html += "<tr class='row100 head'>";	
				html += "<th class='cell100 column5'>예약방번호</th>";
				html += "<th class='cell100 column3'>시작시간</th>";
				html += "<th class='cell100 column3'>종료시간</th>";				
				html += "<th class='cell100 column4'>승인상태</th>";				 						
			html += "</tr>";
			html += "</thead>";
			html += "</table>";
			html += "</div>";
			
			html += '<div class="table105-body js-pscroll">';
			html += '<table>';
			html += "<tbody>";
				
			$.each(json.reList, function(index,item){
				
				if(item.employee_seq == '${sessionScope.loginEmployee.employee_seq}') {
				
					html += "<tr>";						 
						html += "<td class='cell100 column5'>"+item.roomName+"</td>";
						html += "<td class='cell100 column3'>"+item.startDate+"</td>";
						html += "<td class='cell100 column3'>"+item.endDate+"</td>";
						if(item.status == '0') {
							html += "<td class='cell100 column4'>미승인</td>";	
						}
						else {
							html += "<td class='cell100 column4'>승인</td>";
						}								
					html += "</tr>";
				}
								
			});	
			
			html += "</tbody>";
			html += "</table>";
			html += "</div>"
			html += "</div>"
			
			$("#views").html(html);
				
			},
			error : function(request, status, error){
				
				alert("code: "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
			
		});
		
	}// end of function func_infoviews{
	
	</script>  

	<script src="./resources/calendar/vendor/js/jquery.min.js"></script>
    <script src="./resources/calendar/vendor/js/bootstrap.min.js"></script>
    <script src="./resources/calendar/vendor/js/moment.min.js"></script>
    <script src="./resources/calendar/vendor/js/fullcalendar.min.js"></script>
    <script src="./resources/calendar/vendor/js/ko.js"></script>
    <script src="./resources/calendar/vendor/js/select2.min.js"></script>
    <script src="./resources/calendar/vendor/js/bootstrap-datetimepicker.min.js"></script>
    <script src="./resources/calendar/js/main.js"></script>
    <script src="./resources/calendar/js/addEvent.js"></script>
    <script src="./resources/calendar/js/editEvent.js"></script>
    <script src="./resources/calendar/js/etcSetting.js"></script>
  	<script type="text/javascript">
		
  		$("#hideAll").hide();
  		
	</script>
