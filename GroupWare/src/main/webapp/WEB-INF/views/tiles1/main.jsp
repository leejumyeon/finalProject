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
      margin-top: 30px;
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

	<link rel= "shortcut icon" href="./resources/admincalendar/images/favicon.ico">

    <link rel= "stylesheet" href="./resources/admincalendar/vendor/css/fullcalendar.min.css" />
    <link rel= "stylesheet" href="./resources/admincalendar/vendor/css/bootstrap.min.css">
    <link rel= "stylesheet" href='./resources/admincalendar/vendor/css/select2.min.css' />
    <link rel= "stylesheet" href='./resources/admincalendar/vendor/css/bootstrap-datetimepicker.min.css' />

    <link rel= "stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel= "stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel= "stylesheet" href="./resources/admincalendar/css/main.css">

	

<body>
   <div id="container">
      <div style="float: left;">
         <div style="width: 300px; height: 300px; border: 1px solid red;">
         </div>
         <div class="mt" style="width: 300px; height: 300px; border: 1px solid red;">
         </div>
      </div>
      
      
<div style="clear: both; display: inline-block; margin-left: 25px;">
   <div style="width: 600px; height: 630px; border: 1px solid red;">
   
   		 <!-- <div class="container" style=" width: 600px; height: 1300px;" >				
	        일자 클릭시 메뉴오픈
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
	        </div> -->
	
	        <div id="wrapper">
	            <div id="loading"></div>
	            <div id="calendar"></div>	
	            
	               
	        </div>	        
	        <!-- 일정 추가 MODAL -->
	        <!-- <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
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
                    	<label class="checkbox-inline"><input class='filter' type="checkbox" value="회사"
                                checked>회사</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="개발팀"
                                checked>개발팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="디자인팀"
                                checked>디자인팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="영업팀"
                                checked>영업팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="인사팀"
                                checked>인사팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="경영지원팀"
                                checked>경영지원팀</label>
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
         <div style="width: 250px; height: 190px; border: 1px solid red;">
         </div>
         <div class="mt" style="width: 250px; height: 190px; border: 1px solid red;">
         </div>
         <div class="mt" style="width: 250px; height: 190px; border: 1px solid red;">
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


