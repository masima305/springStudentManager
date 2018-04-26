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
		
		//------------------input tag 입력----------------------------
		
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
		
		
		//---------------형식 조정/입력 여부/유효성 체크----------------------------

		
		//'이름' 입력여부 검사
		if(insertStuName == ""){
			alert("이름을 입력하지 않았습니다.");
			 $('#insertStuName').focus();
			 return false;
		}
		
		//'이름 형식' 유효성 검사 (2자 이상으로 구성)
		if(insertStuName.length < 2){
			alert("이름을 2자 이상 입력해주십시오.");
			 $('#insertStuName').empty();
			 $('#insertStuName').focus();
			 return false;
		}
		
		//'학번' 입력여부 검사
		if(insertStuNumber == ""){
			alert("학번을 입력하지 않았습니다.");
			 $('#insertStuNumber').focus();
			 return false;
		}

		//'학번'유효성 검사 (숫자 10개로만 구성)
		var regStuNumber =  /^\d{10}$/;
		if(regStuNumber.test(insertStuNumber) === false){
			alert("학번 형식(숫자 10개로 구성)이 올바르지 않습니다.");
			$('#insertStuNumber').empty();
			$('#insertStuNumber').focus();
			 return false;
		}
		
		//'생년월일' 입력여부 검사
		if(insertStuBirthday == ""){
			alert("생년월일을 입력하지 않았습니다.");
			 $('#insertStuBirthday').focus();
			 return false;
		}
		
		//'연락처' 입력여부 검사
		if(insertStuPhone == ""){
			alert("연락처를 입력하지 않았습니다.");
			 $('#insertStuPhone').focus();
			 return false;
		}
		
		//'연락처 형식' 유효성 검사 (숫자 11개로만 구성)
		var regPhone =  /^\d{11}$/;
		if(regPhone.test(insertStuPhone) === false){
			alert("연락처 형식(숫자 11개로 구성)이 올바르지 않습니다.");
			$('#insertStuPhone').empty();
			$('#insertStuPhone').focus();
			 return false;
		}
		
		//'이메일' 입력여부 검사
		if(insertStuEmail == ""){
			alert("이메일을 입력하지 않았습니다.");
			 $('#insertStuEmail').focus();
			 return false;
		}
		
		//'이메일 형식' 유효성 검사
		var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(regEmail.test(insertStuEmail) === false){
			 alert("잘못된 이메일 형식입니다.");
			 $('#insertStuEmail').empty();
			 $('#insertStuEmail').focus();
			 return false;
		}
		
		//'회비금액' 입력여부 검사
		if(insertFeeTotalAmount == ""){
			alert("회비금액을 입력하지 않았습니다.");
			 $('#insertFeeTotalAmount').focus();
			 return false;
		}
		
		//회비금액과 납부금액 비교 검사 (회비금액 >= 납부금액)
		if(insertFeeTotalAmount < insertFeePaidAmount ){ //납부금액이 회비금액보다 큰 경우
			alert("납부한 금액은 회비금액과 같거나 회비금액보다 작아야 합니다.");
			 $('#insertFeePaidAmount').empty();
			 $('#insertFeePaidAmount').focus();
			 return false;
		}

		//-----------------Insert 를 위한 데이터 json----------------------
		
		var insertData = {};
		insertData.stuName 			= insertStuName;
		insertData.stuNumber  		= insertStuNumber;
		insertData.stuBirthday 		= insertStuBirthday;
		insertData.stuGender 		= insertStuGender;
		insertData.stuPhone 		= insertStuPhone;
		insertData.stuEmail 		= insertStuEmail;
		insertData.stuEnterance 	= insertStuEnterance;
		insertData.stuAuthority 	= insertStuAuthority;
		
		insertData.feeTotalAmount 	= insertFeeTotalAmount;
		insertData.feePaidDate 		= insertFeePaidDate;
		insertData.feePaidAmount 	= insertFeePaidAmount;
		insertData.feePaidMethod 	= insertFeePaidMethod;
		insertData.feePaidStatus	= insertFeePaidStatus;
		insertData.feeContent		= insertFeeContent;
		
		
		
		if(true){ //추후 유효성 검사 메서드를 여기 넣는다. ( validator() )
			$('#'+formId).ajaxForm({
				type: "post",
				url: "/insertStudent.do",
				data: insertData,
				success: function(result){
					alert(result.result);
				}
				
				, error: function(result){}
			}).submit();
		} else {
			//유효성 검사에 실패하면 그에 해당하는 alert가 나오고, 전송은 하지 않는체로 종료.
			alert('입력이 올바르지 않습니다.');
			return;
		}
	}
	
	
	//학번 유효성(중복) 검사
	function ajaxStuNumberCheck(){
		
		var insertStuNumber = $('#insertStuNumber').val();
		
		$.ajax({
			type: "post",
			url: "/checkStuNumber.do",
			data: {'stuNumber':insertStuNumber},
			success: function(result){
				
				if(result.result == '1') { //학번이 중복되는 경우
					$("#stuNumberCheck").html("<i class='fas fa-exclamation-circle'></i>&nbsp;중복되는 학번입니다.");
				} else {
					$("#stuNumberCheck").empty();
				}
			},
			error: function(result){}
		});
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
							</div>
						</div>
					
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>학번 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="stuNumber" id="insertStuNumber" onkeyup='ajaxStuNumberCheck()' />
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuNumberCheck">
							</div>
						</div>
						
						
						<div class="row"> 
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>생년월일 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="date" name="stuBirthday" id="insertStuBirthday" placeholder="ex) YYYYMMDD"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuBirthdayCheck">
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
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>연락처 <span class="prime">*</span></label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="text" name="stuPhone" id="insertStuPhone"  placeholder=" ex) 01012345678"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="stuPhoneCheck">
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
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3 col-lg-3">
								<label>입금날짜</label>
							</div>
							<div class="col-sm-5 col-md-5 col-lg-5">
								<input type="date" name="feePaidDate" id="insertFeePaidDate" placeholder="YYYYMMDD"/>
							</div>
							<div class="col-sm-4 col-md-4 col-lg-4 check" id="feePaidDateCheck">
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

