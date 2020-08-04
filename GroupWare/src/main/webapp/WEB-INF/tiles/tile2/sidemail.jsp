<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ======= #28. tile2 중 sideinfo 페이지 만들기  ======= --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	.mailBtn{
		display: inline-block;
		padding: 10px 10px;
		background-color: white;
		font-size: 11pt;
		cursor: pointer;
		margin-right: 5px;
	}
	
	.subMailBtn{
		display: inline-block;
		height: 100 px;
		border: solid 0px white;
	}
	
	#mailhamList{
		list-style: none; 
		padding:0 0 0 10px;
	}
	
	#mailhamList > li{
		line-height: 50px;
	}
</style>

<script type="text/javascript">
	
</script>
<div style="margin: 0 auto;" align="center">
	<div id="mailBtnArea">
		<span class="mailBtn">메일쓰기</span>
		<span class="mailBtn">내게쓰기</span>
		<br>
	</div>
	<div align="left" style="margin:10px 10px 0 12px; padding-bottom:5px; border-bottom: solid 1px white">
		<div class="subMailBtn">
			<div style="border:solid 1px black; width: 50px; height: 50px;">
				
			</div>
			<div style="border:solid 1px green">안읽음</div>
		</div>
		
		<div class="subMailBtn">
			<div style="border:solid 1px black; width: 50px; height: 50px;">
				<img src="" />
			</div>
			<div style="border:solid 1px green">첨부</div>
		</div>
	</div>
	<div id="mailhamArea" align="left">
		<ul id="mailhamList">
			<li>전체메일</li>
			<li>받은메일함</li>
			<li>보낸메일함</li>
			<li>내게쓴메일함</li>
			<li>휴지통<div style="display: inline-block; float:right; margin-right:30px;">비우기</div></li>
		</ul>
	</div>
</div>