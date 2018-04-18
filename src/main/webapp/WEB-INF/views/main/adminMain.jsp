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

</head>
<script>
	$().ready(function(){
		stuNumberOption("searchStuNumber1")
		stuNumberOption("searchStuNumber2")
		});
</script>
<body>


	<!---파비콘 만들어 보기- https://www.favicon-generator.org/search/---/N -->
	<nav id="upperbar" class="navbar navbar-expand-lg navbar-light bg-light">
		<span style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776;</span>


		<span class="navbar-brand" id="sideNavTitle">학생관리</span>


	</nav>


	<!----------------------------메인 들어갈 자리.---------------------------->
	<div id="main">

 		<div id="listAll" style="display: block;">
			<c:import url="/listAllStudent.do"></c:import>
		</div>

		<div id="studentFee" style="display: none;">
			<c:import url='/listAllFee.do'></c:import>
		</div>
		<div id="else">
		
		</div>
<%-- 	
		<c:import url='../contents/studentInsert.jsp'></c:import>
	    <c:import url='../contents/studentUpdate.jsp'></c:import>
--%>


	</div>



	<!------------------------------------ 사이드 바 ------------------------->
	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<a href="#" onclick="showTitle(this,'listAll')">학생관리</a> 
		<a href="#" onclick="showTitle(this,'studentFee')">학생회비관리</a> 
		<a href="#" onclick="showTitle(this)">학과일정관리</a> 
		<a href="#" onclick="showTitle(this)">학생회의</a>
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