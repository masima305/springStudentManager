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
		stuNumberOption("searchStuNumber1",undefined)
		stuNumberOption("searchStuNumber2",undefined)
		
	

		//구분(입금/출금)에 따라 금액 인풋 값 색 바꾸기
		$("#ledgTransTypeFunction").click(function(){
			var transType = $(':radio[name="ledgTransType"]:checked').val();
			var ledgAmount = $("#ledgAmount").val(); 

			
			if(transType == "1"){ //출금일경우
				$("#ledgAmount").css("color","red");
				$("#ledgWithdrawalOutput").html(ledgAmount);
				$("#ledgDepositOutput").html("0");
			
			} else if(transType == "2"){ //입금일경우
				$("#ledgAmount").css("color","blue");
				$("#ledgDepositOutput").html(ledgAmount);
				$("#ledgWithdrawalOutput").html("0");
			
			}
		});
	
		//'상세내역' 입력시 입력내역에 실시간으로 출력하기
		$("#ledgContent").keyup(function(){
			var ledgContent = $("#ledgContent").val();
			$("#ledgContentOutput").html(ledgContent);
		});
	
		
		//'거래처' 입력시 입력내역에 실시간으로 출력하기
		$("#ledgTradePartner").keyup(function(){
			var ledgTradePartner = $("#ledgTradePartner").val();
			$("#ledgTradePartnerOutput").html(ledgTradePartner);
		});
	
		
		//'날짜' 입력시 입력내역에 실시간으로 출력하기
		$("#ledgDate").change(function(){
			var ledgDate = $("#ledgDate").val();
			ledgDate = ledgDate.substring(0,4) + ledgDate.substring(5,7) + ledgDate.substring(8,10);
			$("#ledgDateOutput").html(ledgDate);
		});

		//'금액' 입력시 '구분(입금/출금) 체크 확인한 후' 입력내역에 실시간으로 출력하기
		$("#ledgAmount").keyup(function(){
			
			var transType = $(':radio[name="ledgTransType"]:checked').val();

			if(transType == null){
				alert("구분(출금/입금)을 먼저 선택해주세요");
				$("#ledgAmount").val("");
				return false;
			} else {
				
				var ledgAmount = $("#ledgAmount").val();
				
				if(transType == "1") { //출금일경우
					$("#ledgWithdrawalOutput").html(ledgAmount);
					$("#ledgDepositOutput").html("0");
				} else { //입금일경우
					$("#ledgDepositOutput").html(ledgAmount);
					$("#ledgWithdrawalOutput").html("0");
				}
			}
		});
	
	
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
		<div id="studentInsert" style="display: none;">
			<c:import url='/getCommonCode.do'></c:import>
		</div>
		<div id="ledgerInsert" style="display: none;">
			<c:import url='/ledgerForm.do'></c:import>
		</div>
	</div>



	<!------------------------------------ 사이드 바 --------------------------->
	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<a href="#" onclick="showTitle(this,'listAll'	)">학생관리</a> 
		<a href="#" onclick="showTitle(this,'studentInsert'	)">학생등록</a> 
		<a href="#" onclick="showTitle(this,'studentFee')">학생회비관리</a> 
		<a href="#" onclick="showTitle(this,'ledgerInsert')">회비장부입력</a> 
		<a href="#" onclick="showTitle(this				)">학과일정관리</a> 
		<a href="#" onclick="showTitle(this				)">학생회의</a>
	</div>
	<!------------------------------------------------------------------------>


	<script>
      function openNav() {
          document.getElementById("mySidenav").style.width 		= "250px";
          document.getElementById("main"	 ).style.marginLeft = "250px";
          document.getElementById("upperbar" ).style.marginLeft = "250px";
          
      }

      function closeNav() {
          document.getElementById("mySidenav").style.width 		= "0";
          document.getElementById("main"	 ).style.marginLeft = "0";
          document.getElementById("upperbar" ).style.marginLeft = "0";
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