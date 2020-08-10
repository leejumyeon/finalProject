<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<link rel= "shortcut icon" href="./resources/calendar/images/favicon.ico">

<link rel= "stylesheet" href="./resources/calendar/vendor/css/fullcalendar.min.css" />
<link rel= "stylesheet" href="./resources/calendar/vendor/css/bootstrap.min.css">
<link rel= "stylesheet" href='./resources/calendar/vendor/css/select2.min.css' />
<link rel= "stylesheet" href='./resources/calendar/vendor/css/bootstrap-datetimepicker.min.css' />

<link rel= "stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
<link rel= "stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<link rel= "stylesheet" href="./resources/calendar/css/main.css">

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

<script type="text/javascript">

</script>

<body>
   <div id="container">
      <div style="float: left;">
         <div style="width: 320px; height: 300px; border: 1px solid red;">
         </div>
         <div class="mt" style="width: 320px; height: 300px; border: 1px solid red;">
         </div>
      </div>
      <div style="clear: both; display: inline-block; margin-left: 10px;">
         <div style="width: 650px; height: 630px; border: 1px solid red;">
         	<div class="container" style="width: 650px; display: inline-block; float: left;">
				
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
         </div>
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