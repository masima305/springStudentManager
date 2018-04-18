<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>student Main</title>
<meta charset="utf-8">
<c:import url="../../../resources/common/commonMeta.jsp"></c:import>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>

</head>



<body>

	<!---파비콘 만들어 보기- https://www.favicon-generator.org/search/---/N -->
	<nav id="upperbar" class="navbar navbar-expand-lg navbar-light bg-light">
		<span style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776;</span>


		<span class="navbar-brand" id="sideNavTitle">기본정보1</span>


	</nav>


<div id="main">

	<div class="container-fluid"> 
			
		<div class = "card">
		
			<div class="card-header">
				<i class="fas fa-bullhorn"></i>&nbsp;사물함 신청기간입니다. 서둘러 신청해주세요. 공지사항 게시판 필독!
			</div>
			
			<div class="card-body">
				
				
				<div class="row">
					<!-- 여백 -->
					<div class="col-lg-2">
						<div class="row">
						</div>
					</div>
				
					<!-- 이미지 -->
					<div class="col-lg-4">
						<div class="row"><div class="col-lg-12">&nbsp;</div></div>
						<div class="row"><div class="col-lg-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-lg-12">
								<img class="card-img-circle card-img-no-padding card-img-responsive" src='../../../resources/common/img/man.png' alt='Card image' style='width:60%' />
							</div>
						</div>
					</div>
					
					<br><br>
					
					<!-- 기본정보 -->
					<div class="col-lg-4">
						<div class="row"><div class="col-lg-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-lg-12"><i class="fas fa-user"></i>&nbsp;<span class="font-weight-bold">기본정보</span></div>
						</div>
						<div class="row">
							<div class="col-lg-12"><hr></div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">학번</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">2013049595</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">이름</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">윤인아</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">성별</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">여</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">생년월일</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">19940317</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">연락처</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">01086166450</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">이메일</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">ina-yun@hanmail.net</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">입학전형</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">수시</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">권한</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">일반</div>
						</div>
					</div>
				
					<!-- 여백 -->
					<div class="col-lg-2">
					</div>
				</div> <!-- row1 -->
				
				
				<div class="row">
					<!-- 여백 -->
					<div class="col-lg-2">
					</div>
				
					<!-- 학생회비 정보-->
					<div class="col-lg-4">
						<div class="row"><div class="col-lg-12">&nbsp;</div></div>
						<div class="row"><div class="col-lg-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-lg-12"><i class="fas fa-credit-card"></i>&nbsp;<span class="font-weight-bold">학생회비 정보</span></div>
						</div>
						
						<div class="row">
						<div class="col-lg-12"><hr></div>
						</div>
						
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">회비금액</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">170000</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">납부금액</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">170000</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">입금날짜</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">20130516</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">입금방식</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">계좌이체</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">상태</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">납부완료</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-4"><span class="font-weight-bold">비고</span></div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-8">없음</div>
						</div>
					</div>
				
					
					<!-- 학생경력 정보-->
					<div class="col-lg-4">
						<div class="row"><div class="col-lg-12">&nbsp;</div></div>
						<div class="row"><div class="col-lg-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-lg-12"><i class="fab fa-readme"></i>&nbsp;<span class="font-weight-bold">학생경력 정보</span></div>
						</div>
						<div class="row"><div class="col-lg-12"><hr></div></div>
						
						<div class="row">
							<div class="col-lg-3 col-md-3 col-sm-3 col-3">2013</div>
							<div class="col-lg-3 col-md-3 col-sm-3 col-3">1학기</div>
							<div class="col-lg-6 col-md-6 col-sm-6 col-6">영문과 부회장</div>
						</div>
						
						<div class="row">
							<div class="col-lg-3 col-md-3 col-sm-3 col-3">2015</div>
							<div class="col-lg-3 col-md-3 col-sm-3 col-3">2학기</div>
							<div class="col-lg-6 col-md-6 col-sm-6 col-6">공간과 창조 부학회장 헤헤후후히히하하</div>
						</div>
			
					</div>
					<!-- 여백 -->
					<div class="col-lg-2">
					</div>
				</div> <!-- row2 -->
				
				<div class="row"><div class="col-lg-12">&nbsp;</div></div>
				
			</div>
		</div>
	
	</div>

</div>

<!------------------------------------ 사이드 바 ------------------------->
	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<a href="#" onclick="showTitle(this,'listAll')">기본정보1</a> 
		<a href="#" onclick="showTitle(this,'studentFee')">기본정보2</a> 
		<a href="#" onclick="showTitle(this)">기본정보3</a> 
		<a href="#" onclick="showTitle(this)">기본정보4</a>
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
      
    /*   
      var preContentId = "listAll";
      
      function showTitle(id,contentId,preContendId){
			var value = id.innerHTML;
			document.getElementById("sideNavTitle").innerHTML = value;
			$("#"+preContentId).css('display','none');
			preContentId = contentId;
			$("#"+contentId).css('display','block');
      }
       */
      
    </script>

    
  </body>
</html>