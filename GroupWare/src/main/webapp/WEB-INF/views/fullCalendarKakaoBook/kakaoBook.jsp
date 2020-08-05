<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KakaoBook</title>

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
           		
           		html += "<span><img src='" + msg.documents[i].thumbnail + "'></span><br />";
           		html += "제목&nbsp;:&nbsp;<strong>" + msg.documents[i].title + "</strong><br />";
       			html +=	"저자&nbsp;:&nbsp;<strong>" + msg.documents[i].authors + "</strong><br />";
     			html += "판매가&nbsp;:&nbsp;<strong>" + msg.documents[i].price + "</strong><br />";
           		html += "판매현황&nbsp;:&nbsp;<strong>" + msg.documents[i].status + "</strong><br />";
           		html += "출간일자&nbsp;:&nbsp;<strong>" + msg.documents[i].datetime + "</strong><br />";
           		html += "바코드&nbsp;:&nbsp;<strong>" + msg.documents[i].isbn + "</strong><br />";
           							          		                         
           	}
           	
           	$("p").html(html);
           	
           });
      })
  });
  </script>  
  

</head>
<body>

 	<h1>책 제목을 검색해주세요</h1>
    <input id="bookName" type="text">
    <button id="search">검색</button>
    <p></p>

</body>
</html>