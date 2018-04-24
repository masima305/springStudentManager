<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script>


	function ajaxStudentInsertForm(formId){
		

		
		
		
		
		if(true){ //추후 유효성 검사 메서드를 여기 넣는다. ( validator() )
			
			$().ajax({
				url: "/insertStudent.do",
				data: updateData,
				success: function( result ) {
		
					},//success
				error: function(a,b,c){
					alert("오류 발생");
			
			});
							
		}else{
			//유효성 검사에 실패하면 그에 해당하는 alert가 나오고, 전송은 하지 않는체로 종료.
			alert('');
			return;
		}
		
	}


</script>

<div class="card">

	<div class="card-header">학생 등록</div>
	
	<div class="card-body">
		<div class="container">
			<form id="studentInsertForm" action="/insertStudent.do" method="post">
			
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>이름</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="stuName"/>
					</div>
				</div>
			
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>학번</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="stuNumber"/>
					</div>
				</div>
				
				<div class="row"> 
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>생년월일</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="stuBirthday" placeholder="YYYYMMDD"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>성별</label>
					</div>
					
					<div class="col-sm-9 col-md-6 col-lg-8">
						<select name="stuGender">
							<c:forEach var="i" items="${listAllCommonMap.stuGenderList}">
								<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
							</c:forEach>	
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>연락처</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="stuPhone"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>이메일</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="stuEmail"/>
					</div>
				</div>
				
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>입학전형</label>
					</div>
					
					<div class="col-sm-9 col-md-6 col-lg-8">
						<select name="stuEnterance">
							<c:forEach var="i" items="${listAllCommonMap.stuEnteranceList}">
								<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>접근권한</label>
					</div>
					
					<div class="col-sm-9 col-md-6 col-lg-8">
						<select name="stuAuthority">
							<c:forEach var="i" items="${listAllCommonMap.stuAuthorityList}">
								<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
							</c:forEach>	
						</select>
					</div>
				</div>
				
				<br><hr>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>회비금액*</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="feeTotalAmount"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>입금날짜</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="feePaidDate" placeholder="YYYYMMDD"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>납부금액</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="feePaidAmount"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>입금방식</label>
					</div>
					
					<div class="col-sm-9 col-md-6 col-lg-8">
						<select name="feePaidMethod">
							<c:forEach var="i" items="${listAllCommonMap.feePaidMethodList}">
								<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
							</c:forEach>	
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>상태</label>
					</div>
					
					<div class="col-sm-9 col-md-6 col-lg-8">
						<select name="feePaidStatus">
							<c:forEach var="i" items="${listAllCommonMap.feePaidStatusList}">
								<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-3 col-md-6 col-lg-4">
						<label>비고</label>
					</div>
					<div class="col-sm-9 col-md-6 col-lg-8">
						<input type="text" name="feeContent"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-12 col-md-12 col-lg-12">
						<input type="reset" value="다시작성"/>
						<input type="button" value="저장" onclick="javascript:ajaxStudentInsertForm('studentInsertForm')"/>
					</div>
				</div>
			
			</form>
		</div> <!-- container -->
	
	</div> <!-- card-body -->
</div>

