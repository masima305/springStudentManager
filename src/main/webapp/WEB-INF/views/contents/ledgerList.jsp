<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<style>
	table th{
		text-align: center;
	}
	
	.bold{
		font-weight: bold;
	}
	
	#ledgerDateTitle{
		font-size : 30px;
		font-weight:bold;
		text-align: center;
	}
	
	#preMonthPay td{
		height : 50px;
		border-bottom: 5px double #dee2e6;
	}
	
	#ledgerDateTitleForm{
		border: none;
		font-weight: bold;
		height: 24.2px;
	}
</style>

<script type="text/javascript">
	function searchByMonthly(){
		if($("#isClosed").val() == "false"){
			var txt;
		    if (confirm("대기중인 월말 정산이 있습니다. 월말정산을 완료하지 않을 시, 다른 달의 입출금 현황 확인 및 입력이 불가능합니다. \n 월말 정산 페이지로 이동하시겠습니까?")){
		        openClosing();
		    } else {
		        
		    }
		
		
		}else{
			 
			var keyword = $("#ledgerDateTitleForm").val()
			var keywordChunk = keyword.split('-') 
			//keywordChunk[0] : YYYY
			//keywordChunk[1] : MM
			keyword = ""+keywordChunk[0]+keywordChunk[1];
				
			
			alert($("#isClosed").val());
			alert($("#ledgerDateTitleForm").val());
			
			var sendData = {};
			sendData.keyword = keyword;
			
			$.ajax({
				  url: "/listMonthlyLedger.do",
				  data: sendData,
				  success: function( result ) {
				    alert();
				    $( "#ledgerContentSection" ).empty;
				    $( "#ledgerContentSection" ).html(result);
				  },
				  error: function(err){
					  $( "#ledgerContentSection" ).empty;
					  $( "#ledgerContentSection" ).html(
							  '<br>'+
							  '<h1>'+keywordChunk[0]+'년'+keywordChunk[0]+'월의 자료는 없습니다.<h1>'
							  +'<br>'
					  );
				  }
				});
			}
	}
	function searchByCondition(){
		
		var searchLedgCategory 	= $("#searchLedgCategory option:selected").val();
		var searchLedgTradeType = $("#searchLedgTradeType option:selected").val();
		var ledgStartMonth 		= ($("#ledgStartMonth").val()).replace('-','');
		var ledgEndMonth 		= ($("#ledgEndMonth").val()).replace('-','');
		
		var sendData = {}
		
		sendData.searchLedgCategory 	= searchLedgCategory;
		sendData.searchLedgTradeType 	= searchLedgTradeType;
		sendData.ledgStartMonth 		= ledgStartMonth;
		sendData.ledgEndMonth 			= ledgEndMonth;
		
		$.ajax({
			  url: "/listSearchMonthlyLedger.do",
			  data: sendData,
			  success: function( result ) {
			
			    $( "#ledgerContentSection" ).empty;
			    $( "#ledgerContentSection" ).html(result);
			
			  },
			  error: function(err){
				  $( "#ledgerContentSection" ).empty;
				  $( "#ledgerContentSection" ).html(
						  '<br>'+
						  '<h1>'+keywordChunk[0]+'년'+keywordChunk[0]+'월의 자료는 없습니다.<h1>'
						  +'<br>'
				  );
			  }
			});
		
		
	}
	
	
</script>

<body>
	
<div class="card">

	<div class="card-header">
		<c:if test="${isClosed eq false}">
			<p id="closingWorning" style="color:red; font-size:1em;">미승인된 월말결산이 남아있으므로, 다른 날짜의 장부 조회가 제한됩니다.</p>
		</c:if>
	</div>
	
	<div class="card-body">
	<!-- 정산 완료 여부를 알기 위한 히든값 -->
	<input id="isClosed" type="hidden" value="${isClosed}">	
		<div class="container">
			<div class="row">
			
				<div class="col-lg-12 col-md-12 col-sm-12">
					<div id="ledgerlabel">
						<!-- 날짜 타이틀 -->
						<div id="ledgerDateTitle">
							<input id="ledgerDateTitleForm" type="month" onchange="searchByMonthly()" value="${ledgerDate}">
						</div>
						

						
				
						<br><br>
						
						<!-- 범위로 찾기 폼 -->
						<div>
							<label class="small"></label>
							
							<form id="ledgSearchScopeForm">
								<label>날짜별로</label> 
								<input type="month" id="ledgStartMonth" style="width:130px;" >&nbsp;~&nbsp;
								<input type="month" id="ledgEndMonth" style="width:130px;" >
								
								&nbsp;
									
								<label>입금/출금별로</label> 
								<select name="ledgTradeType" id="searchLedgTradeType">
									<option value="">선택없음</option>
									<c:forEach var="i" items="${listAllCommonMap.ledgTradeTypeList}">
										<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
									</c:forEach>
								</select>&nbsp; 
								
								<label>카테고리별로</label> 
								<select name="ledgCategory" id="searchLedgCategory">
									<option value="">선택없음</option>
									<c:forEach var="i" items="${ledgerCate}">
										<option value="${i.LEDG_CATE_CODE}">${i.LEDG_CATE_NAME}</option>
									</c:forEach>
								</select>&nbsp; 
								
								<input type="button" value="검색" onclick="searchByCondition()" />
							</form> <!-- searchScopeForm -->
						</div> <!-- 범위폼 -->
					</div>	
				</div>
			</div> <!-- row (사용내역 리스트) -->

			<div class ="row">
				<div class="col-lg-12 col-md-12 col-sm-12">
					
						<div id = ledgerContentSection>
							<c:import url='/listMonthlyLedger.do'></c:import> 
						</div>
					
					</div> 
			
			</div> <!-- 동적으로 통계내주는 섹션-->	
			<br><br>
		</div> <!-- container -->
	</div> <!-- card-body -->
</div>

