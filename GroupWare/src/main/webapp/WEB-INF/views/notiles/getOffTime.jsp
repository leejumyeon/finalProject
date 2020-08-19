<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

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
	  padding: 12px 40px 10px;
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

	.snip1538 {
	  background-color: #ff4d4d;
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
	  border-color: #ff4d4d;
	  border-right-width: 2px;
	  border-top-width: 2px;
	  right: -5px;
	  top: -5px;
	}
	
	.snip1538:after {
	  border-bottom-width: 2px;
	  border-color: #ff4d4d;
	  border-left-width: 2px;
	  bottom: -5px;
	  left: -5px;
	}
	
	.snip1538:hover {
	  background-color: #ff4d4d;
	}
	
	.snip1538:hover:before,
	.snip1538:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#btnOffTime").click(function() {
			
			$.ajax({
				url:"<%= request.getContextPath()%>/updateAttendanceTable.top",
				type:"GET",
				dataType:"JSON",
				success: function(json) {
  					
  					if(json.result > 0) {
  						
  						window.close();
  						
  						setTimeout(function() {
  							top.window.opener = top;
  							top.window.open('','_parent','');
  							top.window.close();
  						}, 1000);
  						
  					}
  				},
  				error: function(e) {
  					
  				}
			})
		});
		
		setTimeout(function(){top.window.opener = top;top.window.open('','_parent','');top.window.close();});
		
		$("#btnExtendTime").click(function() {
			
			window.close();
		});
	});
</script>

<div id="mainContainer" style="text-align: center">
	<h4>퇴근하실 시간입니다. 연장을 원하시면 연장버튼을 눌러 주십시오</h4>
	<button type="button" class="snip1537" id="btnOffTime">퇴근하기</button>
	<button type="button" class="snip1538" id="btnExtendTime">연장하기</button>
</div>