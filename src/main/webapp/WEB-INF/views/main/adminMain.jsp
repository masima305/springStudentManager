<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>admin Main</title>
<!-- Required meta tags -->
<meta charset="utf-8">

<c:import url="../../../resources/common/commonMeta.jsp"></c:import>

<%--     <c:set var ="listAll" scope = "session" value = "/listAllStudent.do"/>
  	<c:set var ="fee" scope = "session" value = "../contents/studentFeeList.jsp"/> --%>


<style type="text/css">
/*div {border: 1px solid black;}
      */
html, body {
	height: 100%;
	margin: 0;
	background-color: rgb(224, 224, 235);
}

#stuListScroll {
	overflow-y: scroll;
	height: 400px;
}
/*-----------------------------사이드바 용 css--------------------------*/
.navbar-brand {
	text-align: right;
}

.sidenav {
	height: 100%;
	width: 0;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	background-color: #111;
	overflow-x: hidden;
	transition: 0.5s;
	padding-top: 60px;
}

.sidenav a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 20px;
	color: #818181;
	display: block;
	transition: 0.3s;
}

.sidenav a:hover {
	color: #f1f1f1;
}

.sidenav .closebtn {
	position: absolute;
	top: 0;
	right: 25px;
	font-size: 36px;
	margin-left: 50px;
}

#upperbar {
	transition: margin-left .5s;
}

#main {
	transition: margin-left .5s;
	padding: 16px;
}

@media screen and (max-height: 450px) {
	.sidenav {
		padding-top: 15px;
	}
	.sidenav a {
		font-size: 18px;
	}
}
/*----------------------------------------------------------------------*/
.full {
	height: 100%;
}

.eight {
	height: 80%;
}

.five {
	height: 50%;
}

.seven {
	height: 70%;
}

.three {
	height: 30%;
}
</style>

</head>
<script>
/*   	$(document).ready(
  			
  			
  		function() {
  				
  		}
  		
  		); */

  	/*  
  	 * 학번별로 검색
  	 * option 동적 추가 기능
  	 */
    function stuNumberOption(){
        var date = new Date();
        var year = date.getFullYear();
        var selectValue = document.getElementById("searchStuNumber");
        for(var i=year-40; i<=year; i++){
           selectValue.add(new Option(i,i));
        }
     }
  	</script>

<body>


	<!---파비콘 만들어 보기- https://www.favicon-generator.org/search/---/N -->
	<nav id="upperbar"
		class="navbar navbar-expand-lg navbar-light bg-light">
		<span style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776;</span>&nbsp


		<span class="navbar-brand" id="sideNavTitle">학생관리</span>


	</nav>


	<!----------------------------메인 들어갈 자리.---------------------------->
	<div id="main">

		<div id="listAll" style="display: block;">
			<c:import url="/listAllStudent.do"></c:import>
		</div>

		<div id="studentFee" style="display: none;">
			<c:import url='../contents/studentFeeList.jsp'></c:import>
		</div>

		<%--   
	     <c:import url='../contents/studentInsert.jsp'></c:import>
	    <c:import url='../contents/studentUpdate.jsp'></c:import>
       --%>


	</div>



	<!------------------------------------ 사이드 바 ------------------------->
	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<a href="#" onclick="showTitle(this,'listAll')">학생관리</a> <a href="#"
			onclick="showTitle(this,'studentFee')">학생회비관리</a> <a href="#"
			onclick="showTitle(this)">학과일정관리</a> <a href="#"
			onclick="showTitle(this)">학생회의</a>
	</div>
	<!------------------------------------------------------------------------>


	<script>
      function openNav() {
          document.getElementById("mySidenav").style.width = "250px";
          document.getElementById("main").style.marginLeft = "250px";
          document.getElementById("upperbar").style.marginLeft="250px";
          
      }

      function closeNav() {
          document.getElementById("mySidenav").style.width = "0";
          document.getElementById("main").style.marginLeft= "0";
          document.getElementById("upperbar").style.marginLeft="0";
      }
      
      var preContentId = "listAll";
      
      function showTitle(id,contentId,preContendId){
			var value = id.innerHTML;
			document.getElementById("sideNavTitle").innerHTML = value;
			$("#"+preContentId).css('display','none');
			preContentId = contentId;
			$("#"+contentId).css('display','block');
      }
      
      
    </script>




</body>
</html>