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

<script type="text/javascript">
</script>

<body>
   <div id="container">
      <div style="float: left;">
         <div style="width: 350px; height: 300px; border: 1px solid red;">
            <p>공지사항</p>
            <a><img id="img" alt="plus" src="images/512px-Plus_font_awesome.svg.png"></a>
         </div>
         <div class="mt" style="width: 350px; height: 300px; border: 1px solid red;">
            <p>자유게시판</p>
            <a><img id="img" alt="plus" src="images/512px-Plus_font_awesome.svg.png"></a>
         </div>
      </div>
      <div style="clear: both; display: inline-block; margin-left: 195px;">
         <div style="width: 600px; height: 630px; border: 1px solid red;">
            <p>사내일정</p>
            <a><img id="img" alt="plus" src="images/512px-Plus_font_awesome.svg.png"></a>                  
         </div>
      </div>
      <div style="float: right;">
         <div style="width: 350px; height: 190px; border: 1px solid red;">
            <p>사내앨범</p>
            <a><img id="img" alt="plus" src="images/512px-Plus_font_awesome.svg.png"></a>
         </div>
         <div class="mt" style="width: 350px; height: 190px; border: 1px solid red;">
            <p>동호회앨범</p>
            <a><img id="img" alt="plus" src="images/512px-Plus_font_awesome.svg.png"></a>
         </div>
         <div class="mt" style="width: 350px; height: 190px; border: 1px solid red;">
            <p>봉사활동앨범</p>
            <a><img id="img" alt="plus" src="images/512px-Plus_font_awesome.svg.png"></a>
         </div>
      </div>
   </div>      
</body>