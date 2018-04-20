<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>TILES</title>
<meta charset="utf-8">
<c:import url="../../resources/common/commonMeta.jsp"></c:import>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
  
  <script type="text/javascript">
  
  
  	function loginFunction(){
  		
  		$("#loginForm").submit();
  		
  	}
  </script>
</head>
  
<body>
    <div id="main" class="container-fluid">
    
    
             <div class="row">
             	 <div class="col-lg-4 col-md-4 col-sm-2">
             	 </div>
             	 
             	 <div class="col-lg-4 col-md-4 col-sm-8">
             	 	<div class="row">
	             	 	<div class="col-lg-12">
	             	 		<p style="font-size:60px;">T I L E S</p>
	             	 	</div>
             	 	</div>
             	 </div>
             	 
           	 	 <div class="col-lg-4 col-md-4 col-sm-2">
             	 </div>
             </div> <!-- row1 -->
             
             
             <div class="row">
             
             	 <div class="col-lg-4 col-md-4 col-sm-2">
             	 </div>
             	 
             	 <div class="col-lg-4 col-md-4 col-sm-8">
             	 
             	 	<div class="row">
             	 		<div class="col-lg-12">
             	 		
	             	 		<form id="loginForm" action="/loginCheck.go" method="post">
							    <div class="input-group">
							      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
							      <input id="stuNumber" type="text" class="form-control" name="stuNumber" placeholder="student ID">
							    </div>
							    <div class="input-group">
							      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							      <input id="stuPassword" type="password" class="form-control" name="stuPassword" placeholder="Password">
							    </div>
             	 			</form>
             	 		
             	 		</div>
             	 	</div>
             	 </div>
             	 
           	 	 <div class="col-lg-4 col-md-4 col-sm-2">
             	 </div>
             
             </div> <!-- row2 -->
             
              <div class="row">
             	 <div class="col-lg-4 col-md-4 col-sm-2">
             	 </div>
             	 
             	 <div class="col-lg-4 col-md-4 col-sm-8">
             		<div class="row">
             	 		<div class="col-lg-12">
             	 			<button type="button" onclick="javascript:loginFunction()">로그인</button>	
             	 		</div>
             	 	</div>
             	 
             	 	<div class="row">
	             	 	<div class="col-lg-12">
	             	 		 <a href = "/adminMain">관리자페이지로 이동</a>
             	 			 <a href = "/getUser.do">유저메인페이지로 이동</a>
	             	 	</div>
             	 	</div>
             	 	
             	 </div>
             	 
           	 	 <div class="col-lg-4 col-md-4 col-sm-2">
             	 </div>
             </div> <!-- row1 -->
                 
          </div> <!-- main -->
</body>
</html>