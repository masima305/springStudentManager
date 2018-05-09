<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css" integrity="sha384-+d0P83n9kaQMCwj8F4RJB66tzIwOKmrdb46+porD/OvrJ+37WqIM7UoBtwHO6Nlg" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>

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
	
</script>

<body>
	
<div class="card">

	<div class="card-header">
	</div>
	
	<div class="card-body">
		<div class="container">
			<div class="row">
			
				<div class="col-lg-12 col-md-12 col-sm-12">
				
					<!-- 날짜 타이틀 -->
					<div id="ledgerDateTitle">
						<input id="ledgerDateTitleForm" type="month" >
					</div>
			
					<br><br>
					
					<!-- 범위로 찾기 폼 -->
					<div>
						<label class="small"></label>
						
						<form id="ledgSearchScopeForm">
							<label>날짜별로</label> 
							<input type="month"  style="width:130px;" >&nbsp;~&nbsp;<input type="month"  style="width:130px;" >
							&nbsp;
								
							<label>입금/출금별로</label> 
							<select name="ledgTransType">
								<option value="null">선택없음</option>
								<%-- <c:forEach var="i" items="${}">
									<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
								</c:forEach> --%>
							</select>&nbsp; 
							
							<label>카테고리별로</label> 
							<select name="ledgCategory">
								<option value="null">선택없음</option>
								<%-- <c:forEach var="i" items="${}">
									<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
								</c:forEach>	 --%>
							</select>&nbsp; 
							
							<input type="button" value="검색" onclick="javascript:ajaxLedgSearchScope('ledgSearchScopeForm')" />
						</form> <!-- searchScopeForm -->
					</div> <!-- 범위폼 -->
					
					
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


</body>
</html>