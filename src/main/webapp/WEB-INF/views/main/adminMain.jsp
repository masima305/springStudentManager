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
	var getUrlParameter = function getUrlParameter(sParam) {
	    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
	        sURLVariables = sPageURL.split('&'),
	        sParameterName,
	        i;
	 
	    for (i = 0; i < sURLVariables.length; i++) {
	        sParameterName = sURLVariables[i].split('=');
	 
	        if (sParameterName[0] === sParam) {
	            return sParameterName[1] === undefined ? true : sParameterName[1];
	        }
	    }
	};
	
	
	function openClosing(){
		window.open('/closeLedgerMonthly.do'
					,'popUpWindow'
					,'height=700'
					+',width=800'
					+',left=10,top=10'
					+',resizable=yes'
					+',scrollbars=yes'
					+',toolbar=yes'
					+',menubar=no'
					+',location=no'
					+',directories=no'
					+',status=yes')
		
	}

	function commaMaker(num){
		var len, point, str; 
	       
	    num 	= num + ""; 
	    point 	= num.length % 3 ;
	    len 	= num.length; 
	   
	    str = num.substring(0, point); 
	    while (point < len) { 
	        if (str != "") str += ","; 
	        str += num.substring(point, point + 3); 
	        point += 3; 
	    } 
	     
	    return str;
	}
	
	function commaDeleter(num){
		   
	    var commaNum = num + ""; 
		var pureNum  = "";
		
		for (var j= 0; j < commaNum.length ; j++){
			if(commaNum[j] != ','){
				pureNum += commaNum[j];
			}	
		}
	    return pureNum;
	}
	
	
	
	
	$().ready(function(){
		stuNumberOption("searchStuNumber1",undefined)
		
		
		//---------------특정 페이지로의 새로고침을 url로 명령 받으면, 그 페이지를 보여준다.
		
		if(getUrlParameter('loc') != undefined){
			showTitle(this,getUrlParameter('loc'));
		}
		
		//---------------장부에 날짜 오늘짜로 우선 맞춰주기
		var today = new Date();
		var dd 	  = today.getDate();
		var mm 	  = today.getMonth()+1; //January is 0!
		var yyyy  = today.getFullYear();

		if(dd<10) {
		    dd = '0'+dd
		} 
		if(mm<10) {
		    mm = '0'+mm
		} 
		$("#ledgerDateTitleForm").val(yyyy+"-"+mm)
		
		

		//구분(입금/출금)에 따라 금액 인풋 값 색 바꾸기
		$("#ledgTransTypeFunction").click(function(){
			var transType 	= $(':radio[name="ledgTransType"]:checked').val();
			var ledgAmount 	= ($("#ledgAmount").val()*1);
			var balance 	= ($("#originalBalance").val())*1;
			
			if(transType == "1"){ //출금일경우
				
				$("#ledgAmount"				).css("color","red"			);
				$("#ledgWithdrawalOutput"	).html(ledgAmount			);
				$("#ledgDepositOutput"		).html("0"					);
				$("#ledgBalance"			).val(balance - ledgAmount	);
				$("#ledgBalanceOutput"		).html(balance - ledgAmount	);
				
			} else if(transType == "2"){ //입금일경우
				
				$("#ledgAmount"				).css("color","blue"		);
				$("#ledgDepositOutput"		).html(ledgAmount			);
				$("#ledgWithdrawalOutput"	).html("0"					);
				$("#ledgBalance"			).val(balance + ledgAmount	);
				$("#ledgBalanceOutput"		).html(balance + ledgAmount	);
			
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
	
		
		//'결제수단' 입력시 입력내역에 실시간으로 출력하기
		$("#ledgMethod").change(function(){
			
			var ledgMethod 		= $("#ledgMethod option:selected").text();
			var ledgMethodCode 	= $("#ledgMethod option:selected").val();
			
			$("#ledgMethodOutput"		).html(ledgMethod);
			$("#ledgMethodCodeOutput"	).val(ledgMethodCode);
		
		});

		//'분류' 입력시 입력내역에 실시간으로 출력하기
		$("#ledgCategory").change(function(){
			
			var ledgCategory 		= $("#ledgCategory option:selected").text();
			var ledgCategoryCode 	= $("#ledgCategory option:selected").val();
			
			$("#ledgCategoryOutput"		).html(ledgCategory);
			$("#ledgCategoryCodeOutput"	).val(ledgCategoryCode);
		
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
				
				var ledgAmount 	= ($("#ledgAmount"		).val())*1;//숫자 자료형으로 만들어준다.
				var balance 	= ($("#originalBalance"	).val())*1;
				
				
				if(transType == "1") { //출금일경우
					$("#ledgWithdrawalOutput").html(commaMaker(ledgAmount));
					
					$("#ledgDepositOutput"	).html("0");
					$("#ledgBalance"		).val(commaMaker(balance - ledgAmount));
					$("#ledgBalanceOutput"	).html(commaMaker(balance - ledgAmount));
					
				} else { //입금일경우
					$("#ledgDepositOutput").html(commaMaker(ledgAmount));
					
					$("#ledgWithdrawalOutput").html("0");
					$("#ledgBalance"		 ).val(commaMaker(balance + ledgAmount));
					$("#ledgBalanceOutput"	 ).html(commaMaker(balance + ledgAmount));
					
				}
			}
		});
	
	
	});
	
	
</script>
<body>


	<!---파비콘 만들어 보기- https://www.favicon-generator.org/search/---/N -->
	<nav id="upperbar" class="navbar navbar-expand-lg navbar-light bg-light">
		<span style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776;&nbsp;</span>


		<span class="navbar-brand" id="sideNavTitle">학생관리</span>


	</nav>


	<!----------------------------메인 들어갈 자리.---------------------------->
	<div id="main">

 		<div id="listAll" style="display: block;">
			<c:import url="/listAllStudent.do"></c:import>
		</div>
		<div id="studentFee" style="display: none;">
		</div>
		<div id="else">
		
		</div>
		<div id="studentInsert" style="display: none;">
		</div>
		<div id="ledgerInsert" style="display: none;">
		</div>
		<div id="listLedger" style="display: none;">
		</div>
		
	</div>



	<!------------------------------------ 사이드 바 --------------------------->
	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<a href="#" onclick="showTitle(this,'listAll'		)">학생관리</a> 
		<a href="#" onclick="showTitle(this,'studentInsert'	)">학생등록</a> 
		<a href="#" onclick="showTitle(this,'studentFee'	)">학생회비관리</a> 
		<a href="#" onclick="showTitle(this,'ledgerInsert'	)">회비장부입력</a> 
		<a href="#" onclick="showTitle(this,'listLedger'	)">회비장부보기</a> 
		<a href="#" onclick="window.open('/listAllScheduler.do','popUpWindow','height=700,width=1200,left=10,top=10,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes')">학과 일정</a>
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
			var linkUrl;
			
			if(value == undefined){
				if (contentId == 'ledgerInsert'){
					value = '회비장부 입력';
					}
			}
			if(contentId == 'listAll'){
				linkUrl = '/listAllStudent.do';
			}else if(contentId == 'studentFee'){
				linkUrl = '/listAllFee.do';
			}else if(contentId == 'studentInsert'){
				linkUrl = '/getCommonCode.do';
			}else if(contentId == 'ledgerInsert'){
				linkUrl = '/ledgerForm.do';
			}else if(contentId == 'listLedger'){
				linkUrl = '/listLedger.do';
			}else if(contentId == ''){
				linkUrl = '';
			}else if(contentId == ''){
				linkUrl = '';
			}
			
			//이후 해당 디브에 호출. 근데 해당 디브가 비어있을 경우에만 호출하도록 한다.
			
			$.ajax({
			  url: linkUrl,
			  //data: sendData,
			  success: function( result ) {
			    
				$( "#"+contentId ).empty;
				$( "#"+contentId ).html(result);	    	
			    
				document.getElementById("sideNavTitle").innerHTML = value;
				$("#"+preContentId).css('display','none');
				preContentId = contentId;
				$("#"+contentId).css('display','block');
	      	  
			  },
			  error: function(err){
				  
			  }
			});

      
      }
      
      
    </script>
    
</body>
</html>