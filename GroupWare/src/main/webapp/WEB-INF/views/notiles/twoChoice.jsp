<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>

	body {
		background-color: #ffffff;
	}

	#choiceContainer {
		margin: 0 auto;
		margin-top: 230px;
		text-align: center;
	}
	
	.snip1535 {
 		background-color: #ff4d4d;
		border: none;
		color: #ffffff;
		cursor: pointer;
		display: inline-block;
		font-family: 'BenchNine', Arial, sans-serif;
		font-size: 1em;
		font-size: 50pt;
		line-height: 1em;
		margin: 15px 40px;
		outline: none;
		padding: 12px 40px 10px;
		position: relative;
		text-transform: uppercase;
		font-weight: 700;
		width: 500px;
		height: 500px;
	}
	
	.snip1535:before,
	.snip1535:after {
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
	
	.snip1535:before {
 		border-color: #ff4d4d;
		border-right-width: 7px;
		border-top-width: 7px;
		right: -10px;
		top: -10px;
	}
	
	.snip1535:after {
		border-bottom-width: 7px;
		border-color: #ff4d4d;
		border-left-width: 7px;
		bottom: -10px;
		left: -10px;
	}
	
	.snip1535:hover {
 		background-color: #ff4d4d;
	}
	
	.snip1535:hover:before,
	.snip1535:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
	.snip1536 {
	  background-color: #0099ff;
	  border: none;
	  color: #ffffff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: 'BenchNine', Arial, sans-serif;
	  font-size: 1em;
	  font-size: 50pt;
	  line-height: 1em;
	  margin: 15px 40px;
	  outline: none;
	  padding: 12px 40px 10px;
	  position: relative;
	  text-transform: uppercase;
	  font-weight: 700;
	  width: 500px;
	  height: 500px;
	}
	
	.snip1536:before,
	.snip1536:after {
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
	
	.snip1536:before {
	  border-color: #0099ff;
	  border-right-width: 7px;
	  border-top-width: 7px;
	  right: -10px;
	  top: -10px;
	}
	
	.snip1536:after {
	  border-bottom-width: 7px;
	  border-color: #0099ff;
	  border-left-width: 7px;
	  bottom: -10px;
	  left: -10px;
	}
	
	.snip1536:hover {
	  background-color: #0099ff;
	}
	
	.snip1536:hover:before,
	.snip1536:hover:after {
	  height: 100%;
	  width: 100%;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#btnGoaAdminHome").click(function() {

			window.open('<%= request.getContextPath()%>/adminMain.top', '관리자', 'width = 1550, height = 780, location = yes, left = 200, top = 100');
		});
		
		$("#btnGoMainHome").click(function() {
			
			window.open('<%= request.getContextPath()%>/main.top', '그룹웨어', 'width = 1220, height = 850, location = yes, left = 200, top = 100');
		})
		
	});
</script>
<body>

	<div id="choiceContainer">
		<button type="button" id="btnGoaAdminHome" class="snip1535">관리자페이지</button>
		<button type="button" id="btnGoMainHome" class="snip1536">메인페이지</button>
	</div>

</body>