<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<div id="ledgListSection">
	<br>
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
				<tr id="preMonthPay">
				
					<td class="preMonthPay">0</td>
					<td class="preMonthPay"></td>
					<td class="preMonthPay">전월 이월금</td>
					<td class="preMonthPay"></td>
					<td class="preMonthPay"></td>
					<td class="preMonthPay"></td>
					<td class="preMonthPay">${ledgerListData.ledgMonthBalance}</td>
					<td class="preMonthPay"></td>
					<td class="preMonthPay">${ledgerListData.ledgMonthBalance}</td>
					<td class="preMonthPay"></td>
				
				</tr>
				
				<c:forEach var="i" items="${ledgerListData.ledgerList}" varStatus="status" >
				<tr>
					<td>${status.count}</td>
					<td>${i.LEDG_TRADE_DATE}</td>
					<td>${i.LEDG_CONTENT}</td>
					<td>${i.LEDG_TRADE_PARTNER}</td>
					<td>${i.LEDG_CATEGORY_VALUE}</td>
					<td>${i.LEDG_METHOD_VALUE}</td>
					
					
					<c:choose>
						<c:when test="${i.LEDG_TRADE_TYPE eq '1'}">
    						<td>0</td>
							<td>${i.LEDG_AMOUNT}</td>
						</c:when>
						<c:otherwise>
							<td>${i.LEDG_AMOUNT}</td>
							<td>0</td>
						</c:otherwise>
					</c:choose>
					
					<td>${i.LEDG_BALANCE}</td>
					<td><button type="button" class="btn btn-outline-secondary btn-sm">보기</button></td>
				</tr>
				</c:forEach>
				
				
			</tbody>
		</table>
	</div> <!-- ledgListSection -->
	<br><br>
	<div id="ledgStatSection">
	<table class='table table-striped table-sm table-bordered'>
			<tr>
				<th>구분</th>
				<th>전월금</th>
				<th>수입총계</th>
				<th>지출총계</th>
				<th>합계잔액</th>
				<th>최고수입</th>
				<th>최고지출</th>
			</tr>
		
			<tr>
				<td style="text-align:center;" id="">합계</td>
				<td id="">${ledgerListData.ledgerStat.balance}</td>
				<td id="">${ledgerListData.ledgerStat.totalIncome}</td>
				<td id="">${ledgerListData.ledgerStat.totalOutcome}</td>
				<td id="">${ledgerListData.ledgerStat.finalBalance}</td>
				<td id="">${ledgerListData.ledgerStat.maxIncome}</td>
				<td id="">${ledgerListData.ledgerStat.maxOutcome}</td>
			</tr>
	</table>
</div><!-- ledgStatSection -->
						