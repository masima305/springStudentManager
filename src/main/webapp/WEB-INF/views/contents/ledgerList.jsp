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
	
</script>

<body>
	
<div class="card">

	<div class="card-header">
	</div>
	
	<div class="card-body">
		<div class="container">
			<div class="row">
			
				<div class="col-lg-12 col-md-12 col-sm-12">
					<div id="ledgerlabel">
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

