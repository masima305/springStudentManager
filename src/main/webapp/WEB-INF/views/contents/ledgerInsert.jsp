<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<style>
	table th{
		text-align: center;
	}
	
	.bold{
		font-weight: bold;
	}
	
</style>
<script>
function submitLedgerInsert(){
		
	var ledgDate 			= $("#ledgDateOutput"			).text();
	var ledgContent 		= $("#ledgContentOutput"		).text();
	var ledgTradePartner 	= $("#ledgTradePartnerOutput"	).text();
	var ledgCategory 		= $("#ledgCategoryOutput"		).text();
	var ledgCategoryCode 	= $("#ledgCategoryCodeOutput"	).val();
	var ledgMethod 			= $("#ledgMethodOutput"			).text();
	var ledgMethodCode 		= $("#ledgMethodCodeOutput"		).val();
	var ledgDeposit 		= commaDeleter($("#ledgDepositOutput"	).text());
	var ledgWithdrawal 		= commaDeleter($("#ledgWithdrawalOutput").text());
	var ledgRemark			= $("#ledgRemark"				).val();
	
	if(true){ //추후 유효성 검사 메서드를 여기 넣는다. ( validator(paidContentUpdate) )
		
		//-----------------Update를 위한 데이터 json화	-------------------
		var insertData = {};
		
		insertData.ledgDate 		= ledgDate;
		insertData.ledgContent 		= ledgContent;
		insertData.ledgTradePartner	= ledgTradePartner;
		insertData.ledgCategory		= ledgCategoryCode;
		insertData.ledgMethod 		= ledgMethodCode;
		insertData.ledgDeposit 		= ledgDeposit;
		insertData.ledgWithdrawal 	= ledgWithdrawal;
		insertData.ledgRemark 		= ledgRemark;
		
		
		$.ajax({
			url: "insertLedger.do",
			data: insertData,
			success: function( result ) {
				alert("성공!!!");
			
			},
			error: function(a,b,c){
				alert("오류 발생");
			}	
		});
						
	}else{
		//유효성 검사에 실패하면 그에 해당하는 alert가 나오고, 전송은 하지 않는체로 종료.
		alert('오류발생. 입력값을 다시 확인해주세요.');
		return;
	}
	
	
	
}
	
	
</script>
	
<div class="card">

	<div class="card-header"><i class="fas fa-bullhorn"></i>&nbsp;학생회비 사용입력</div>
	
	<div class="card-body">
		<div class="container">
			<div class="row">
			
				<div class="col-lg-10 col-md-12 col-sm-12">
					<div>
					<span style="font-weight:bold;"><i class="fas fa-clipboard-list"></i>&nbsp;사용 내역</span>
					<br><br>
						<table class='table table-striped table-sm table-bordered'>
							<thead>
								<tr>
									<th>번호</th>
									<th>날짜</th>
									<th>상세내역</th>
									<th>거래처</th>
									<th>분류</th>
									<th>결제수단</th>
									<th>입금</th>
									<th>출금</th>
									<th>잔액</th>
									<th>비고</th>
								</tr>
							</thead>
							
							<tbody>
							<c:forEach var="i" items="${ledgerList}" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${i.LEDG_TRADE_DATE}</td>
									<td>${i.LEDG_CONTENT}</td>
									<td>${i.LEDG_TRADE_PARTNER}</td>
									<td>${i.LEDG_CATEGORY_VALUE}</td>
									<td>${i.LEDG_METHOD_VALUE}</td>									
									<c:choose>
										<c:when test="${i.LEDG_TRADE_TYPE eq '1'}">
											<td>${i.LEDG_AMOUNT}</td>
											<td>0</td>
										</c:when>
										<c:when test="${i.LEDG_TRADE_TYPE eq '2'}">
											<td>0</td>
											<td>${i.LEDG_AMOUNT}</td>
										</c:when>
									</c:choose>									
									<td>${i.LEDG_BALANCE}</td>
									<td><button type="button" class="btn btn-outline-secondary btn-sm">보기</button></td>
								</tr>
							</c:forEach>
								
								
							
								<tr>
									<th>통계</th>
									<th colspan="9" style="text-align:right; ">잔액 ${ledgerList[2].LEDG_BALANCE}원</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class= "col-lg-2">
				</div>
				
			</div> <!-- row (사용내역 리스트) -->
			
			<div id="ledgerInsertSection">
			<div class= "row">
				
					<div class= "col-lg-10 col-md-12 col-sm-12 jumbotron">
						<span style="font-weight:bold;"><i class="fas fa-pencil-alt"></i>&nbsp;내역 입력</span>
						<br><br>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">구분</span></div>
							<div class="col-lg-4 col-md-4 col-sm-4" id="ledgTransTypeFunction">
								<input type="radio" name="ledgTransType" value="1">&nbsp;출금 &nbsp;&nbsp;
								<input type="radio" name="ledgTransType" value="2">&nbsp;입금
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">날짜</span></div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<input type="date" name="ledgDate" id="ledgDate" style="width:168px;height:30px;">
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">상세내역</span></div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<input type="text" name="ledgContent" id="ledgContent">
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">거래처</span></div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<input type="text" name="ledgTradePartner" id="ledgTradePartner">
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">결제수단</span></div>
							<div class="col-lg-4 col-md-4 col-sm-4">
							
								<select name="ledgMethod" id="ledgMethod" style="width:168px;height:30px;" >
									<c:forEach var="i" items="${listAllCommonMap.ledgMethodList}" varStatus="status">
										<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>	
									</c:forEach>
								</select>
							
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">분류</span>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<select name="ledgCategory" id="ledgCategory" style="width:168px;height:30px;" >
									<c:forEach var="i" items="${ledgerCate}" varStatus="status">
										<option value="${i.LEDG_CATE_CODE}">${i.LEDG_CATE_NAME}</option>	
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">금액</span></div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<input type="text" name="ledgAmount" id="ledgAmount">
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">잔액</span></div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<input type="text" name="ledgBalance" id="ledgBalance" disabled="disabled" value=" ${ledgerList[2].LEDG_BALANCE}">
								<input type="hidden" name="originalBalance" id="originalBalance" value=" ${ledgerList[2].LEDG_BALANCE}">
							
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">비고</span></div>
							<div class="col-lg-10 col-md-10 col-sm-10">
								<textarea rows="2" name="ledgRemark" id="ledgRemark"  style="width:85%;"></textarea>
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">영수증첨부</span></div>
							<div class="col-lg-10 col-md-10 col-sm-4">
								<input type="file" name="ledgFile" id="ledgFile">
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12" style="text-align:right;">
								<button type="button" onclick="submitLedgerInsert()" class="btn btn-outline-info">완료</button>
							</div>
						</div>
					</div>
					
					<div class= "col-lg-2">
					</div>
					
				</div > <!-- row (입력섹션) -->
				
			</div> <!-- ledgerInsertSection -->
			
			<div class ="row">
				<div class="col-lg-10 col-md-12 col-sm-12">
					<span style="font-weight:bold;"><i class="fas fa-clipboard-check"></i>&nbsp;입력 내역</span>
					<br><br>
					<div>
						<table class='table table-striped table-sm table-bordered'>
								<tr>
									<th>날짜</th>
									<th>상세내역</th>
									<th>거래처</th>
									<th>분류</th>
									<th>결제수단</th>
									<th>입금</th>
									<th>출금</th>
									<th>잔액</th>
								</tr>
							
								<tr>
									<td id="ledgDateOutput"></td>
									<td id="ledgContentOutput"></td>
									<td id="ledgTradePartnerOutput"></td>
									<td id="ledgCategoryOutput"></td>
									<input type="hidden" id="ledgCategoryCodeOutput"/>
									<td id="ledgMethodOutput"></td>
									<input type="hidden" id="ledgMethodCodeOutput"/>
									<td id="ledgDepositOutput"></td>
									<td id="ledgWithdrawalOutput"></td>
									<td id="ledgBalanceOutput"></td>
								</tr>
						</table>
					</div>
				</div> 
				
				<div class= "col-lg-2">
				</div>
				
			</div> <!-- 내역 입력한 것을 동적으로 출력해주는 섹션-->
		
			
			<br><br>
		</div> <!-- container -->
	
	</div> <!-- card-body -->
</div>


