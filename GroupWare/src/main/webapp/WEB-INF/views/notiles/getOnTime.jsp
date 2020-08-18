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

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#btnOnTime").click(function() {
			
			$.ajax({
				url:"<%= request.getContextPath()%>/insertAttendanceTable.top",
				type:"GET",
				dataType:"JSON",
				success: function(json) {
  					
  					if(json.result > 0) {
  						
  						window.close();
  						
  					}
  				},
  				error: function(e) {
  					
  				}
			})
		});
	});
</script>

<div id="mainContainer" style="text-align: center">
	<h4>출근하셨습니다. 확인을 눌러주십시오</h4>
	<button type="button" class="snip1537" id="btnOnTime">확인</button>
</div>