<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>월별 정산</title>
<!-- Required meta tags -->
<meta charset="utf-8">

<c:import url="../../../resources/common/commonMeta.jsp"></c:import>

</head>
<script>
	function closingConfirm(){
		var sendData = {};
		var date = ""+$("#ledgMonthDate"	).val(	);
		alert(date);
		sendData.ledgMonthDate 		= date;
		sendData.ledgMonthBalance 	= $("#ledgMonthBalance"	).text(	);
		
		
		$.ajax({
			  url: "/insertLedgerMonthly.do",
			  data: sendData,
			  success: function( result ) {
			    alert("정산 완료");
			    self.close();
			  },
			  error: function(err){
				  alert("오류 발생 :잠시 후 다시 시도해주세요");
			  }
			});
		
		
	}
</script>
<body>
<div class="card">

	<div class="card-header">
		<h2>${ledgerYear}년 ${ledgerMonth}월 정산</h2>
	</div>
	<input type="hidden" id="ledgMonthDate" value="${ledgerYear}${ledgerMonth}">
	<div class="card-body">
		<div class="container">
			
			<div class="row">
			
				<div class="col-lg-10 col-md-12 col-sm-12">
				
					<c:import url='/listMonthlyLedger.do'></c:import> 

				</div>
				
			</div> <!-- row (사용내역 리스트) -->
			
			<div id="ledgerInsertSection">
				
			<div class= "row">
				
			</div> <!-- ledgerInsertSection -->
			
			<div class ="row">
				<input type="button" class="btn btn-outline-success btn-lg" onclick="closingConfirm()" value = "승인">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" class="btn btn-outline-danger btn-lg" onclick="javascript:self.close();" value = "보류">
	
				
			</div> <!-- 내역 입력한 것을 동적으로 출력해주는 섹션-->
		
			</div>
			<br><br>
		</div> <!-- container -->
	
	</div> <!-- card-body -->
</div>
	
</body>