<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">
	#container {
		width: 1240px;
		margin: 0 auto;
	}
	#in {
		width: 1000px;
		margin: 0 auto;
	}
	#abl, #abl th, #abl td {
		border: 0.1px solid #d9d9d9;
		border-collapse: collapse;
	}
	#abl th {
		font-size: 11pt;
		background-color: #3399ff;
		color: white;
	}
	#abl th, #abl td {
		height: 27px;
	}
	#searchType {
		height: 28px;
		vertical-align: middle;
	}
	#searchWord {
		vertical-align: middle;
		height: 28px;
	}
	#btnS, #btnW  {
		height: 28px;
		vertical-align: middle;
		color: white;
		background-color: #3399ff;
		border: none;
	}
	.sidebar2 {
		border: 1px solid white;
		width: 100px;
		height: 52px;
		margin-left: 30px;
		cursor: pointer;
		padding-top: 15px;
		text-align: center;
		background-color: #3399ff;		
		color: white;
	}	
	.comunity {
		padding-top: 18px;
		width: 100px;
		height: 55px;
		margin-left: 30px;
		text-align: center;
		font-weight: bold;		
	}
	#post {
		margin-right: 30px;
		width: 750px;
		float: right;		
	}	
	#btnS {
		margin-left: -44px;
	}
	#btnW {
		float: right;
		width: 70px;
	}
	#side {
		float: left;
	}
	
	.labelAlbumList {
		color: #0099ff;
		border: solid 0.5px #0099ff;
		cursor: pointer;
	}
	
	.labelAlbumListActive {
		color: white;
		background-color: #0099ff;
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("input:radio[name=albumList]").hide();
		
		var statusValue = $("input:radio[name=albumList]:checked").val();
		var searchType = $("#searchType").val();
		var searchWord = $("#searchWord").val();
		
		getAlbumList(statusValue, searchType, searchWord, "");
		
		$("input:radio[name=albumList]").each(function() {
			
			var bchecked = $(this).prop("checked");
			
			if(bchecked) {
				
				$(this).next().addClass("labelAlbumListActive");
			}
		});
		
		$("input:radio[name=albumList]").click(function() {
			
			$(".labelAlbumList").removeClass("labelAlbumListActive");
			
			$(this).next().addClass("labelAlbumListActive");
			
			getAlbumList(statusValue, searchType, searchWord, "");
		});
		
	});
	
	function getAlbumList(statusValue, searchType, searchWord, currentShowPageNo) {
		
		statusValue = $("input:radio[name=albumList]:checked").val();
		searchType = $("#searchType").val();
		searchWord = $("#searchWord").val();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/albumList.top",
			type:"GET",
			data:{"statusValue":statusValue
				, "searchType":searchType
				, "searchWord":searchWord
				, "currentShowPageNo":currentShowPageNo},
			dataType:"JSON",
			success:function(json) {
				console.log(json);
				var html = "";

				if(json.AlbumList.length != 0) {
					
					$.each(json.AlbumList, function(index, item) {

						html += '<tr>'
							 +  '<td>' + (json.AlbumList.length - index) + '</td>'
							 +  '<td>' + item.category_name + '</td>'
							 +  '<td>' + item.employee_name + "(" + item.employee_id + ")" + '</td>'
							 +  '<td onclick="goDetailAlbum(' + item.album_seq + ')">' + item.subject + '</td>'
							 +  '<td>' + item.regDate + '</td>'
							 +  '</tr>';

					});
					
				}
				
				var html2 = json.pageBar;
				
				$("#albumList").html(html);
				$("#pagebar").html(html2);
			}
		});
	}

	function goDetailAlbum(seq) {
		
		location.href="<%= request.getContextPath()%>/detailAlbum.top?album_seq=" + seq;
		
	}
</script>
	<div id="container">
		<div id="in">
		<div id="side">
			<div class="comunity">커뮤니티</div>			
			<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/list.top'">앨범</div>
			<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/freeboard/list.top'">자유게시판</div>
			<div class="sidebar2" onclick="javascript:location.href='<%= request.getContextPath()%>/clubRequest.top'">동호회신청</div>
		</div>						
			<div id="post">	
				<h3>앨범게시판</h3>
					<select name="searchType" id="searchType">
						<option value="all">전체</option>
						<option value="subject">제목</option>
						<option value="employee_name">작성자</option>
					</select>
					<input type="text" name="searchWord" id="searchWord" size="30" autocomplete="off" />
					<button style="color: white;" id="btnS" type="button" onclick="getAlbumList('', '', '', '')">검색</button>
					<button style="color: white;" id="btnW" type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/write.top?seq=${board.seq}'">글쓰기</button>		
				<input type="radio" id="allAlbumtList" name="albumList" value="0" checked/><label for="allAlbumtList" class="labelAlbumList">전체 앨범</label>
				<input type="radio" id="comAlbumtList" name="albumList" value="1" /><label for="comAlbumtList" class="labelAlbumList">사내 앨범</label>
				<input type="radio" id="clubAlbumtList" name="albumList" value="2" /><label for="clubAlbumtList" class="labelAlbumList">동호회 앨범</label>
				<input type="radio" id="volAlbumtList" name="albumList" value="3" /><label for="volAlbumtList" class="labelAlbumList">봉사활동 앨범</label>
				<div style="margin-top: 15px;">
					<table id="abl">
						<thead>
							<tr>
								<th style="height: 40px; text-align: center;" align="center" width="80px">글번호</th>
								<th style="text-align: center;" width="80px">앨범종류</th>
								<th style="text-align: center;" width="200px">작성자</th>
								<th style="text-align: center;" width="360px">제목</th>
								<th style="text-align: center;" width="155px">작성날짜</th>
							</tr>
						 </thead>
						 <tbody id="albumList">
						 
						 </tbody>							
					</table>
					<div id="pagebar" align="center">
						<!-- 페이지바들어갈곳 -->
					</div>
					<div style="clear:both"></div>
				</div>
			</div>
		</div>
	</div>