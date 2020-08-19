<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<style type="text/css">
   div#container {
      width: 1240px;
      margin: 0 auto;
   }
   div.mt {
      margin-top: 0px;
   }
   p {
      margin: 15px;
      display: inline-block;
   }
   #img {
      width: 25px;
      height: 25px;
      margin: 15px;
      float: right;
   }
   a {
      cursor: pointer;
   }
   
</style>

<link rel="icon" type="image/png" href="<%= request.getContextPath()%>/resources/table_css/images/icons/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/vendor/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/css/util.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/table_css/css/main.css">

<script type="text/javascript">
	
	$(document).ready(function(){
		func_infoView();
		func_viewInfo();
		func_info();
	});
	
</script>

<link rel= "shortcut icon" href="./resources/admincalendar/images/favicon.ico">

<link rel= "stylesheet" href="./resources/admincalendar/vendor/css/fullcalendar.min.css" />
<link rel= "stylesheet" href="./resources/admincalendar/vendor/css/bootstrap.min.css">
<link rel= "stylesheet" href='./resources/admincalendar/vendor/css/select2.min.css' />
<link rel= "stylesheet" href='./resources/admincalendar/vendor/css/bootstrap-datetimepicker.min.css' />

<link rel= "stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
<link rel= "stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<link rel= "stylesheet" href="./resources/admincalendar/css/main.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<body>

	<div id="container">
		<div style="float: left; margin-left: 30px;">
			<div style="width: 300px; height: 150px; border: 0px solid red;"> 
			<h3>공지사항</h3>
			
			<div id="indication"></div>
			
			</div>
			
			<div class="mt" style="width: 300px; height: 150px; border: 0px solid red;">
			<h3>자유게시판</h3>
			
			<div id="freedom"></div>
			
			</div>
			
			<div style="width: 300px; height: 150px; border: 0px solid red;">
				<h3>앨범게시판</h3>
				<div id="album"></div>
			</div>
			
		</div> 
      
      
		<div style="clear: both; display: inline-block; margin-left: 0px;">
			<div style="width: 600px; height: 630px; border: 0px solid red;">
	   
				<div class="container" style=" width: 600px;" >				
	
	<%--			<div id="contextMenu" class="dropdown clearfix">
						<ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
							style="display:block;position:static;margin-bottom:5px;">
							<li><a tabindex="-1" href="#">카테고리1</a></li>
							<li><a tabindex="-1" href="#">카테고리2</a></li>
							<li><a tabindex="-1" href="#">카테고리3</a></li>
							<li><a tabindex="-1" href="#">카테고리4</a></li>
							<li class="divider"></li>
							<li><a tabindex="-1" href="#" data-role="close">Close</a></li>
						</ul>
					</div> --%>
	
					<div id="wrapper">
						<div id="loading"></div>
						<div id="calendar"></div>	               
					</div>
					
		        <!-- 일정 추가 MODAL -->
	<!--			<div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><spanaria-hidden="true">&times;</span></button>
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
		                                    <option value="1">경조사</option>
		                                    <option value="2">워크샵</option>
		                                    <option value="3">협력일정</option>
		                                    <option value="4">채용일정</option>
		                                </select>
		                            </div>
		                        </div>
		                        <div class="row">
		                            <div class="col-xs-12">
		                                <label class="col-xs-4" for="edit-type">부서명</label>
		                                <select class="inputModal" type="text" name="edit-username" id="edit-username">
		                                    <option value="1">개발팀</option>
		                                    <option value="2">디자인팀</option>
		                                    <option value="3">영업팀</option>
		                                    <option value="4">인사팀</option>
		                                    <option value="5">경영지원팀</option>
		                                </select>
		                            </div>
		                        </div>
		                        <div class="row">
		                            <div class="col-xs-12">
		                                <label class="col-xs-4" for="edit-color">색상</label>
		                                <select class="inputModal" name="color" id="edit-color">
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
		                </div>
		            </div>
		        </div>      
	 -->        
	
						<div class="panel panel-default" id="hideAll">
			
						<div class="panel-heading" >
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
									<label class="checkbox-inline"><input class='filter' type="checkbox" value="회사" checked>회사</label>
									<label class="checkbox-inline"><input class='filter' type="checkbox" value="개발팀" checked>개발팀</label>
									<label class="checkbox-inline"><input class='filter' type="checkbox" value="디자인팀"checked>디자인팀</label>
									<label class="checkbox-inline"><input class='filter' type="checkbox" value="영업팀"checked>영업팀</label>
									<label class="checkbox-inline"><input class='filter' type="checkbox" value="인사팀"checked>인사팀</label>
									<label class="checkbox-inline"><input class='filter' type="checkbox" value="경영지원팀"checked>경영지원팀</label>
								</div>
							</div>
			
						</div>
					</div> 
	        <!-- /.filter panel -->
	                                   
				</div>
	
				<div style="clear: both;"></div> 
	      
			</div>
			
		</div>
      
      
		<div style="float: right;">
			
			
			<div class="mt" style=" width: 300px; height: 230px; border: 0px solid red; margin-top: 20px;">								
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
				  <!-- Indicators -->
				  <ol class="carousel-indicators">
				    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				    <li data-target="#myCarousel" data-slide-to="1"></li>
				    <li data-target="#myCarousel" data-slide-to="2"></li>
				  </ol>
				
				  <!-- Wrapper for slides -->
				  <div class="carousel-inner">
				    <div class="item active" style=" width: 300px; height: 230px;">
				      <img height="230px" src="/groupware/resources/images/rodong.jpg">
				    </div>
				
				    <div class="item" style=" width: 300px; height: 230px;">
				      <img height="230px" src="/groupware/resources/images/gim.jpg">
				    </div>
				
				    <div class="item" style=" width: 300px; height: 230px;">
				      <img height="230px" src="/groupware/resources/images/tan.jpg">
				    </div>
				  </div>
				
				  <!-- Left and right controls -->
				  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#myCarousel" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>				
			</div>
			
			<div class="mt" style=" margin-bottom:30px; width: 300px; height: 230px; border: 0px solid red; margin-top: 20px;">				
				<div id="myCarousel2" class="carousel slide" data-ride="carousel">
				  <!-- Indicators -->
				  <ol class="carousel-indicators">
				    <li data-target="#myCarousel2" data-slide-to="0" class="active"></li>
				    <li data-target="#myCarousel2" data-slide-to="1"></li>
				    <li data-target="#myCarousel2" data-slide-to="2"></li>
				  </ol>
				
				  <!-- Wrapper for slides -->
				  <div class="carousel-inner">
				    <div class="item active" style="width: 300px; height: 230px;">
				      <img height="190px" src="/groupware/resources/images/auto.jpg">
				    </div>
				
				    <div class="item" style="width: 300px; height: 230px;">
				      <img height="190px" src="/groupware/resources/images/ron.jpg">
				    </div>
				
				    <div class="item" style="width: 300px; height: 230px;">
				      <img src="/groupware/resources/images/si.jpg">
				    </div>
				  </div>
				
				  <!-- Left and right controls -->
				  <a class="left carousel-control" href="#myCarousel2" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#myCarousel2" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>								
			</div>
			
		</div>
	</div>      
</body>


	<script src="./resources/admincalendar/vendor/js/jquery.min.js"></script>
    <script src="./resources/admincalendar/vendor/js/bootstrap.min.js"></script>
    <script src="./resources/admincalendar/vendor/js/moment.min.js"></script>
    <script src="./resources/admincalendar/vendor/js/fullcalendar.min.js"></script>
    <script src="./resources/admincalendar/vendor/js/ko.js"></script>
    <script src="./resources/admincalendar/vendor/js/select2.min.js"></script>
    <script src="./resources/admincalendar/vendor/js/bootstrap-datetimepicker.min.js"></script>
    <script src="./resources/admincalendar/js/main.js"></script>
    <script src="./resources/admincalendar/js/addEvent.js"></script>
    <script src="./resources/admincalendar/js/editEvent.js"></script>
    <script src="./resources/admincalendar/js/etcSetting.js"></script>
	
	<script type="text/javascript">
		$("#hideAll").hide();
	</script>
	
	<script type="text/javascript">
		
	firstAttendance();
		
		function firstAttendance() {
			
			$.ajax({
				url:"<%= request.getContextPath()%>/getIsAttendance.top",
				type:"GET",
				dataType:"JSON",
				success: function(json) {
					
					if(json.employee_seq == null) {
						
						window.open("<%= request.getContextPath()%>/getOnTime.top", "출근하기", "width = 450, height= 200, top=350, left=500")
					}
				},
				error: function(e) {
					
				}
			});
		}
		
	</script>
	
	<script type="text/javascript">

  		// 공지사항
  		function func_infoView(){
  			
  			$.ajax({
  				
  				url:"/groupware/indication.top",
  				data:{"fk_category_num":"${fk_category_num}"}, 
  				dataType:"JSON",
  				success:function(json){
  					
  					var html = '<div class="table100 ver2 m-b-35">';
						html += '<div class="table100-head">';
						html += "<table class='tableClass'>";
						html += "<thead>";
					html += "<tr class='row100 head'>";					 
						html += "<th class='cell100 column2'>항목</th>"; 						
						html += "<th class='cell100 column3'>제목</th>";				  						  						
						html += "<th class='cell100 column5'>작성자</th>";				 						
					html += "</tr>";
					html += "</thead>";
					html += "</table>";
					html += "</div>";
					
					html += '<div class="table105-body js-pscroll">';
					html += '<table>';
					html += "<tbody>";
  					
  				$.each(json.resList, function(index,item){
  					  					
  					html += "<tr class='row100 tr_body'>";	 							
						html += "<td class='cell100 column2'>"+item.category_name+"</td>"; 							
						html += "<td class='cell100 column3'>"+item.subject+"</td>"; 
						html += "<td class='cell100 column5'>"+item.employee_name+"</td>";							  							  							
					html += "</tr>";
  														
  				});	
  				
  				html += "</tbody>";
  				html += "</table>";
  				html += "</div>"
  				html += "</div>"
  				
  				$("#indication").html(html);
  					
  				},
  				error : function(request, status, error){
  					
  					alert("code: "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  				}
  									
  			});
  			
  		}// end of function func_infoView(){
  			  		
  		// 자유게시판
  		function func_viewInfo(){
  			
  			$.ajax({
  				
  				url:"/groupware/freedom.top",
  				dataType:"JSON",
				success:function(json){
  					
  					var html = '<div class="table100 ver2 m-b-35">';
  						html += '<div class="table100-head">';
  						html += "<table class='tableClass'>";
  						html += "<thead>";
  					html += "<tr class='row100 head'>";					 
  						html += "<th class='cell100 column2'>항목</th>"; 						
  						html += "<th class='cell100 column3'>제목</th>";				  						  						
  						html += "<th class='cell100 column5'>작성자</th>";				 						
  					html += "</tr>";
  					html += "</thead>";
  					html += "</table>";
  					html += "</div>";
  					
  					html += '<div class="table105-body js-pscroll">';
  					html += '<table>';
  					html += "<tbody>";
  				$.each(json.resList, function(index,item){
  					  					
  						html += "<tr class='row100 tr_body'>";	 							
  							html += "<td class='cell100 column2'>"+item.category_name+"</td>"; 							
  							html += "<td class='cell100 column3'>"+item.subject+"</td>"; 
  							html += "<td class='cell100 column5'>"+item.employee_name+"</td>";						  							  							
  						html += "</tr>";
  														
  				});	
  				
  				html += "</tbody>";
  				html += "</table>";
  				html += "</div>";
  				html += "</div>";
  				
  				$("#freedom").html(html);
  					
  				},
  				error : function(request, status, error){
  					
  					alert("code: "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  				}
  									
  			});
  			
  		}// end of function func_infoView(){	 
  		
  			
  		// 앨범게시판
  		function func_info(){
  			
  			$.ajax({
  				
  				url:"/groupware/album.top",
  				dataType:"JSON",
  				success:function(json){
  					
  					var html = '<div class="table100 ver2 m-b-35">';
						html += '<div class="table100-head">';
						html += "<table class='tableClass'>";
						html += "<thead>";
					html += "<tr class='row100 head'>";					 
						html += "<th class='cell100 column2'>항목</th>"; 						
						html += "<th class='cell100 column3'>제목</th>";				  						  						
						html += "<th class='cell100 column5'>작성자</th>";				 						
					html += "</tr>";
					html += "</thead>";
					html += "</table>";
					html += "</div>";
					
					html += '<div class="table105-body js-pscroll">';
					html += '<table>';
					html += "<tbody>";
  					
  					$.each(json.albumvoList, function(index,item){
  					  					
  						html += "<tr class='row100 tr_body'>";	 							
  							 							
  							if(item.album_seq == '1'){
  								
  								html += "<td class='cell100 column2'>사내활동</td>";
  								
  							}else if(item.album_seq == '2'){
  								
  								html += "<td class='cell100 column2'>동호회</td>";
  								
  							}else{
  								
  								html += "<td class='cell100 column2'>봉사</td>";
  							
  							}
  							
  							html += "<td class='cell100 column3'>"+item.subject+"</td>";
  							html += "<td class='cell100 column5'>"+item.employee_name+"</td>";
							
  						html += "</tr>";
  						
  					});	
  					
  					html += "</tbody>";
  	  				html += "</table>";
  	  				html += "</div>";
  	  				html += "</div>";
  	  				
  	  				$("#album").html(html);
  				
  				},
				error : function(request, status, error){
  					
  					alert("code: "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  				}
  							
  			});
  				
  		}// end of function func_info(){}
  		
	</script>


