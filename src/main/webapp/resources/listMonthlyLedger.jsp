<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
<div class="card">

	<div class="card-header">
	</div>
	
	<div class="card-body">
		<div class="container">
			<div class="row">
			
				<div class="col-lg-12 col-md-12 col-sm-12">
				
					
					<!-- 사용 내역 리스트 섹션 -->
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
										<td class="preMonthPay">20180546</td>
										<td class="preMonthPay">전월금</td>
										<td class="preMonthPay"></td>
										<td class="preMonthPay"></td>
										<td class="preMonthPay"></td>
										<td class="preMonthPay">500000</td>
										<td class="preMonthPay"></td>
										<td class="preMonthPay">500000</td>
										<td class="preMonthPay"></td>
									</tr>
									
									
									<tr>
										<td>1</td>
										<td>20180546</td>
										<td>야식사업</td>
										<td>도스마스</td>
										<td>학과행사진행</td>
										<td>카드</td>
										<td>0</td>
										<td>600000</td>
										<td>500000</td>
										<td><button type="button" class="btn btn-outline-secondary btn-sm">보기</button></td>
									</tr>
									
									<tr>
										<td>2</td>
										<td>20180546</td>
										<td>야식사업</td>
										<td>도스마스</td>
										<td>학과행사진행</td>
										<td>카드</td>
										<td>0</td>
										<td>600000</td>
										<td>500000</td>
										<td><button type="button" class="btn btn-outline-secondary btn-sm">보기</button></td>
									</tr>
								</tbody>
							</table>
						</div> <!-- ledgListSection -->
				</div>
						
			</div> <!-- row (사용내역 리스트) -->

			<!-- 통계 섹션 -->
			<div class ="row">
				<div class="col-lg-12 col-md-12 col-sm-12">
					<br><br>
					<div>
						<table class='table table-striped table-sm table-bordered'>
								<tr>
									<th>구분</th>
									<th>전월금</th>
									<th>수입</th>
									<th>지출</th>
									<th>잔액</th>
									<th>최고수입</th>
									<th>최고지출</th>
								</tr>
							
								<tr>
									<td style="text-align:center;" id="">합계</td>
									<td id=""></td>
									<td id=""></td>
									<td id=""></td>
									<td id=""></td>
									<td id=""></td>
									<td id=""></td>
								</tr>
						</table>
					</div>
				</div> 
			</div> <!-- 동적으로 통계내주는 섹션-->
			
			<br><br>
		</div> <!-- container -->
	
	</div> <!-- card-body -->
</div>

