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
         <div style="width: 300px; height: 300px; border: 1px solid red;">
         </div>
         <div class="mt" style="width: 300px; height: 300px; border: 1px solid red;">
         </div>
      </div>
      <div style="clear: both; display: inline-block; margin-left: 25px;">
         <div style="width: 600px; height: 630px; border: 1px solid red;">                
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