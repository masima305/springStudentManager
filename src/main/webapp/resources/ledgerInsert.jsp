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
	
</style>

<script type="text/javascript">
	
	
	$(document).ready(function(){
		
		//구분(입금/출금)에 따라 금액 인풋 값 색 바꾸기
		$("#ledgTransTypeFunction").click(function(){
			var transType = $(':radio[name="ledgTransType"]:checked').val();
			
			if(transType == "1"){ //출금일경우
				$("#ledgAmount").css("color","red");
			} else if(transType == "2"){ //입금일경우
				$("#ledgAmount").css("color","blue");
			}
		});
	
		
		$()
	
	});
		

</script>

<body>
	
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
								<tr>
									<td>3</td>
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
									<th>통계</th>
									<th colspan="9" style="text-align:right; ">잔액 350000원</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class= "col-lg-2">
				</div>
				
			</div> <!-- row (사용내역 리스트) -->
			
			<br><br>
			
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
									<option>카드</option>
									<option>현금</option>
									<option>계좌이체</option>
									<option>기타</option>
								</select>
							</div>
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">분류</span>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<select name="ledgCategory" id="ledgCategory" style="width:168px;height:30px;" >
									<option>학과행사비</option>
									<option>학회지원비</option>
									<option>--추가--</option>
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
								<input type="text" name="ledgBalance" id="ledgBalance" disabled="disabled" value="50000">
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">비고</span></div>
							<div class="col-lg-10 col-md-10 col-sm-10">
								<textarea rows="2" name="ledgRemark" id="ledgRemark"  style="width:85%;"></textarea>
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2"><span class="bold">파일첨부</span></div>
							<div class="col-lg-10 col-md-10 col-sm-4">
								<input type="file" name="ledgFile" id="ledgFile">
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12" style="text-align:right;">
								<button type="button" class="btn btn-outline-info">완료</button>
							</div>
						</div>
					</div>
					
					<div class= "col-lg-2">
					</div>
					
				</div > <!-- row (입력섹션) -->
				
			</div> <!-- ledgerInsertSection -->
			
			<br><br>
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
									<td id="ledgDateOutput">20180546</td>
									<td id="ledgContentOutput">야식사업</td>
									<td id="ledgTradePartnerOutput">도스마스</td>
									<td id="ledgCategoryOutput">학과행사진행</td>
									<td id="ledgMethodOutput">카드</td>
									<td id="ledgDepositOutput">0</td>
									<td id="ledgWithdrawalOutput">600000</td>
									<td id="ledgBalanceOutput">500000</td>
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


</body>
</html>