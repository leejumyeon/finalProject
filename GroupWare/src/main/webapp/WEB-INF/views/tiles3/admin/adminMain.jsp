<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core"%>

	<link rel= "shortcut icon" href="./resources/admincalendar/images/favicon.ico">

    <link rel= "stylesheet" href="./resources/admincalendar/vendor/css/fullcalendar.min.css" />
    <link rel= "stylesheet" href="./resources/admincalendar/vendor/css/bootstrap.min.css">
    <link rel= "stylesheet" href='./resources/admincalendar/vendor/css/select2.min.css' />
    <link rel= "stylesheet" href='./resources/admincalendar/vendor/css/bootstrap-datetimepicker.min.css' />

    <link rel= "stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel= "stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel= "stylesheet" href="./resources/admincalendar/css/main.css">
    
    <script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/data.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	

   
<script type="text/javascript">

	$(document).ready(function() {
		
		func_salesChart();
		
	});
	
	function func_salesChart(){
		$.ajax({
			url:"<%=request.getContextPath()%>/manager/finance/salesChart.top",
			dataType:"JSON",
			success:function(json){

				var project_value = new Array;
				var maintain_value = new Array;
				var laborCost_value = new Array;
				var category_value = new Array;
				$.each(json.projectChartList, function(index, item) {
					var comma = (index > 0) ? "," : "";
					project_value.push(Number(item.project_value));
					maintain_value.push(Number(item.maintain_value));
					laborCost_value.push(Number(item.laborCost_value));
					category_value.push(item.category);
				});
				
				console.log(project_value);
				Highcharts.chart('saleContainer', {
	
					 chart: {
					        type: 'column'
					    },
					    title: {
					        text: 'Monthly Average Rainfall'
					    },
					    subtitle: {
					        text: 'Source: WorldClimate.com'
					    },
					    xAxis: {
					        categories:category_value,
					        crosshair: true
					    },
					    yAxis: {
					        min: 0,
					        title: {
					            text: 'Rainfall (mm)'
					        }
					    },
					    tooltip: {
					        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
					        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
					        footerFormat: '</table>',
					        shared: true,
					        useHTML: true
					    },
					    plotOptions: {
					        column: {
					            pointPadding: 0.2,
					            borderWidth: 0
					        }
					    },
					    series: [{
					        name: 'project_value',
					        data: project_value
	
					    }, {
					        name: 'laborCost_value',
					        data: laborCost_value
	
					    }, {
					        name: 'maintain_value',
					        data: maintain_value
					        
					    }]
	
				});
			},error:function(e){
				
			}
		});
	}
</script>
	 <div class="container" style="width: 700px; display: inline-block; float: left;">
				
	        <!-- 일자 클릭시 메뉴오픈 -->
	        <div id="contextMenu" class="dropdown clearfix">
	            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
	                style="display:block;position:static;margin-bottom:5px;">
	                <li><a tabindex="-1" href="#">경조사</a></li>
	                <li><a tabindex="-1" href="#">워크샵</a></li>
	                <li><a tabindex="-1" href="#">협력일정</a></li>
	                <li><a tabindex="-1" href="#">채용일정</a></li>
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
	                                    <option value="경조사">경조사</option>
	                                    <option value="워크샵">워크샵</option>
	                                    <option value="협력일정">협력일정</option>
	                                    <option value="채용일정">채용일정</option>
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
	                </div><!-- /.modal-content -->
	            </div><!-- /.modal-dialog -->
	        </div><!-- /.modal -->        
        

         <div class="panel panel-default">

            <div class="panel-heading">
                <h3 class="panel-title">필터</h3>
            </div>

            <div class="panel-body">

                <div class="col-lg-6">
                    <label for="calendar_view">구분별</label>
                    <div class="input-group">
                        <select class="filter" id="type_filter" multiple="multiple" style="width: 300px;">
                            <option value="경조사">경조사</option>
                            <option value="워크샵">워크샵</option>
                            <option value="협력일정">협력일정</option>
                            <option value="채용일정">채용일정</option>
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
    
    <div style="float: left; border: solid 0px green; width: 300px; height: 300px; padding-top: 22px;" >
    	<div style="width: 730px; height: 267px;">
	        <h3>매출통계</h3>
	        <div id="saleContainer">
			</div>
        </div>
        <br/>
        <div style="width: 730px; height: 267px; margin-top: 180px;">
        	<h3>인사고과</h3>
        	<table id="datatables" class="table">
				<thead>
					<tr>
						<th class="ta_seq">고과번호</th>
						<th class="employee_seq">사원번호</th>
						<th>부서</th>
						<th>사원</th>
						<th>직책</th>
						<th>근무태도</th>
						<th>출결</th>
						<th>업무성과</th>
						<th>총평</th>
						<th>부서장</th>
						<th>기록날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="tavo" items="${TAList}">
						<tr class="pick">
							<td class="ta_seq">${tavo.ta_seq}</td>
							<td class="employee_seq">${tavo.fk_employee_seq}</td>
							<td>${tavo.department_name}</td>
							<td>${tavo.employee_name}</td>
							<td>${tavo.position_name}</td>
							<td>
								<c:choose>
									<c:when test="${tavo.attitude > 90}">
										A
									</c:when>
									<c:when test="${tavo.attitude > 80}">
										B
									</c:when>
									<c:when test="${tavo.attitude > 70}">
										C
									</c:when>
									<c:when test="${tavo.attitude > 60}">
										D
									</c:when>
									<c:otherwise>
										F
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${tavo.attendance > 90}">
										A
									</c:when>
									<c:when test="${tavo.attendance > 80}">
										B
									</c:when>
									<c:when test="${tavo.attendance > 70}">
										C
									</c:when>
									<c:when test="${tavo.attendance > 60}">
										D
									</c:when>
									<c:otherwise>
										F
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${tavo.performance > 90}">
										A
									</c:when>
									<c:when test="${tavo.performance > 80}">
										B
									</c:when>
									<c:when test="${tavo.performance > 70}">
										C
									</c:when>
									<c:when test="${tavo.performance > 60}">
										D
									</c:when>
									<c:otherwise>
										F
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${tavo.attitude + tavo.attendance + tavo.performance > 270}">
										A
									</c:when>
									<c:when test="${tavo.attitude + tavo.attendance + tavo.performance > 240}">
										B
									</c:when>
									<c:when test="${tavo.attitude + tavo.attendance + tavo.performance > 210}">
										C
									</c:when>
									<c:when test="${tavo.attitude + tavo.attendance + tavo.performance > 180}">
										D
									</c:when>
									<c:otherwise>
										F
									</c:otherwise>
								</c:choose>
							</td>
							<td>${tavo.manager}</td>
							<td>${tavo.regDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
        </div> 	                     
    </div>
	<div style="clear: both;"></div> 
    <!-- /.container -->

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
    
