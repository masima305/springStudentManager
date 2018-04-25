<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

.prime{
	color: red;
	font-weight: bold;
}

.check{
	color: red;
	font-weight: lighter;
	font-size: small;
}

</style>

<script>

	function ajaxStudentInsertForm(formId){
		
		
		
		var insertStuName  		= $('#insertStuName').val();
		var insertStuNumber 	= $('#insertStuNumber').val();
		var insertStuBirthday 	= $('#insertStuBirthday').val();
		var insertStuGender 	= $('#insertStuGender').val();
		var insertStuPhone 		= $('#insertStuPhone').val();
		var insertStuEmail  	= $('#insertStuEmail').val();
		var insertStuEnterance 	= $('#insertStuEnterance').val();
		var insertStuAuthority 	= $('#insertStuAuthority').val();
		
		
		var insertFeeTotalAmount 	= $('#insertFeeTotalAmount').val();
		var insertFeePaidDate		= $('#insertFeePaidDate').val();
		var insertFeePaidAmount 	= $('#insertFeePaidAmount').val();
		var insertFeePaidMethod 	= $('#insertFeePaidMethod').val();
		var insertFeePaidStatus 	= $('#insertFeePaidStatus').val();
		var insertFeeContent 		= $('#insertFeeContent').val();
		
		
		
		if(true){ //추후 유효성 검사 메서드를 여기 넣는다. ( validator() )
			$('#'+formId).ajaxForm({
				type: "post",
				url: "/insertStudent.do",
				data: 
				success: function(result){
					alert(result.result);
				},
				error: function(result){}
			}).submit();
		} else {
			//유효성 검사에 실패하면 그에 해당하는 alert가 나오고, 전송은 하지 않는체로 종료.
			alert('입력이 올바르지 않습니다.');
			return;
		}
	}
	
	
	function ajaxStuNumberCheck(formId){
		
		$("#"+formId).ajaxForm({
			type: "post",
			url: "/stuNumberCheck.do",
			datatype: "json",
			success: function(result){
				
			},
			error: function(result){}
		}).submit();
		
	}

</script>

<div class="card">

	<div class="card-header"><i class="fas fa-bullhorn"></i>&nbsp;공지사항입니다</div>
	
	<div class="card-body">
		<div class="container">
		
			<div class="row">
				<div class="col-lg-7">
					<form id="studentInsertForm">
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>이름 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="stuName" id="insertStuName"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuNameCheck">
							이름유효성 결과
							</div>
						</div>
					
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>학번 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="stuNumber" id="insertStuNumber" onkeydown="javascript:ajaxStuNumberCheck('stuNumber')" />
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuNumberCheck">
							중복되는 학번입니다
							</div>
						</div>
						
						
						<div class="row"> 
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>생년월일 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="stuBirthday" id="insertStuBirthday" placeholder="YYYYMMDD"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuBirthdayCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>성별 <span class="prime">*</span></label>
							</div>
							
							<div class="col-sm-5 col-md-5 col-lg-5">
								<select name="stuGender" id="insertStuGender">
									<c:forEach var="i" items="${listAllCommonMap.stuGenderList}">
										<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
									</c:forEach>	
								</select>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuGenderCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>연락처 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="stuPhone" id="insertStuPhone"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuPhoneCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>이메일 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="stuEmail" id="insertStuEmail"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuEmailCheck">
							이름유효성 결과
							</div>
						</div>
						
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>입학전형 <span class="prime">*</span></label>
							</div>
							
							<div class="col-sm-5 col-md-5 col-lg-5">
								<select name="stuEnterance" id="insertStuEnterance">
									<c:forEach var="i" items="${listAllCommonMap.stuEnteranceList}">
										<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuEnteranceCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>접근권한 <span class="prime">*</span></label>
							</div>
							
							<div class="col-sm-5 col-md-5 col-lg-5">
								<select name="stuAuthority" id="insertStuAuthority">
									<c:forEach var="i" items="${listAllCommonMap.stuAuthorityList}">
										<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
									</c:forEach>	
								</select>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuAuthorityCheck">
							이름유효성 결과
							</div>
						</div>
						
						<br><hr>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>회비금액 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="feeTotalAmount" id="insertFeeTotalAmount"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="feeTotalAmountCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>입금날짜</label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="feePaidDate" id="insertFeePaidDate" placeholder="YYYYMMDD"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="feePaidDateCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>납부금액</label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="feePaidAmount" id="insertFeePaidAmount"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="feePaidAmountCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>입금방식</label>
							</div>
							
							<div class="col-sm-5 col-md-5 col-lg-5">
								<select name="feePaidMethod" id="insertFeePaidMethod">
									<c:forEach var="i" items="${listAllCommonMap.feePaidMethodList}">
										<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
									</c:forEach>	
								</select>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="feePaidMethodCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>상태</label>
							</div>
							
							<div class="col-sm-5 col-md-5 col-lg-5">
								<select name="feePaidStatus" id="insertFeePaidStatus">
									<c:forEach var="i" items="${listAllCommonMap.feePaidStatusList}">
										<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="feePaidStatusCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>비고</label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="feeContent" id="insertFeeContent"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="feeContentCheck">
							이름유효성 결과
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-12 col-md-12 col-lg-12">
								<input type="reset" value="다시작성"/>
								<input type="button" value="저장" onclick="javascript:ajaxStudentInsertForm('studentInsertForm')"/>
							</div>
						</div>
					
					</form>
				</div>
				
				<div class="col-lg-5">
				</div>
			</div> <!-- row -->
		</div> <!-- container -->
	
	</div> <!-- card-body -->
</div>

