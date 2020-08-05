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
	                </div><!-- /.modal-content -->
	            </div><!-- /.modal-dialog -->
	        </div><!-- /.modal -->        
        

        <!-- <div class="panel panel-default">

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
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="정연"
                                checked>정연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="다현"
                                checked>다현</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나"
                                checked>사나</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="나연"
                                checked>나연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="지효"
                                checked>지효</label>
                    </div>
                </div>

            </div>
        </div> -->
        <!-- /.filter panel -->
                                   
    </div>
    
    <div style="float: left; border: solid 0px green; width: 300px; height: 300px; padding-top: 22px;" >
    	<div style="border: solid 1px blue; width: 730px; height: 267px;">
	        <h3>개인정보</h3>
        </div>
        <br/>
        <div style="border: solid 1px red; width: 730px; height: 267px;">
        	<h3>동호회</h3>
        </div> 	                     
    </div>
	<div style="clear: both;"></div>
	<br/>
    <div style="padding-left: 15px;">   
	    <div style="border: solid 1px red; width: 1415px; height: 148px; ">
	        <h3>도서추천</h3>
			<input id="bookName" type="text">
			<button id="search">검색</button>
			
			<div id="p" style="border: solid 1px red; display: inline-block;">피카츄라이츄파이리꼬북이</div>			
	    </div>    
    </div>
    <!-- /.container -->
    
     <script src="https://code.jquery.com/jquery-3.4.1.js"
      integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
  	</script>
  	
  	<script>
	  $(function () {
	      $("#search").click(function () {
	    	      	     	  
	          $.ajax({
	              method: "GET",
	              url: "https://dapi.kakao.com/v3/search/book?target=title", // 전송 주소
	              data: { query: $("#bookName").val() }, 
	              headers: { Authorization: "KakaoAK 6b9a374380958fdd321ffdf370b9e7d9" }
	          })
	             .done(function (msg) {   
	            	 
	            var html ="";
	            
	           	for(var i = 0; i<10 ; i++) {
	           		
	           		html += "<div style='display:inline-block; min-width:300px;'>";
		           		html += "<span><img src='" + msg.documents[i].thumbnail + "'></span><br />";
		           		html += "제목&nbsp;:&nbsp;<strong>" + msg.documents[i].title + "</strong><br />";
		       			html +=	"저자&nbsp;:&nbsp;<strong>" + msg.documents[i].authors + "</strong><br />";
		     			html += "판매가&nbsp;:&nbsp;<strong>" + msg.documents[i].price + "</strong><br />";
		           		html += "판매현황&nbsp;:&nbsp;<strong>" + msg.documents[i].status + "</strong><br />";
		           		html += "출간일자&nbsp;:&nbsp;<strong>" + msg.documents[i].datetime + "</strong><br />";
		           		html += "바코드&nbsp;:&nbsp;<strong>" + msg.documents[i].isbn + "</strong><br />";
	           		html += "</div>";
	           							          		                         
	           	}
	           	
	           	$("#p").html(html);
	           	
	           });
	      })
	  });
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
    