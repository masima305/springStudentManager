<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>



<script>
$("#showList").empty();
	
	function ajaxSearchKeyword(formId) {
		
		$('#'+formId).ajaxForm({
			
			type: "post",
			url: "/searchKeywordStudent.do",
			datatype: "json",
			success: function(result){
				
				$("#showList").empty();
				var str = "";
				
				$.each(result,function(index,value){
						str+="<tr>"
						str+="<td>" + index + "</td>";
						str+="<td>" + this.STU_NUMBER + "</td>";
					 	str+="<td>"+ this.STU_NAME + "</td>";
						str+="<td>"+ this.STU_GENDER + "</td>";
						str+="<td>"+ this.STU_BIRTHDAY + "</td>";
						str+="<td>"+ this.STU_PHONE + "</td>";
						str+="<td>"+ this.STU_EMAIL + "</td>";
						str+="<td>"+ this.STU_ENTERANCE + "</td>";
						str+="<td>"+ this.STU_AUTHORITY + "</td>";
						str+="<td><button type='button' class='btn btn-small btn-info'>수정</button>"
						str+="<button type='button' class='btn btn-small btn-danger'>삭제</button></td>" 
						str+="</tr>"
				});
				$("#showList").append(str);
			},
			error: function(result){}
		}).submit();
	}
	
	function ajaxSearchScope(formId) {
			
			$('#'+formId).ajaxForm({
				
				type: "post",
				url: "/searchScopeStudent.do",
				datatype: "json",
				success: function(result){
					
					$("#showList").empty();
					var str = "";
					
					$.each(result,function(index,value){
							str+="<tr>"
							str+="<td>" + index + "</td>";
							str+="<td>" + this.STU_NUMBER + "</td>";
						 	str+="<td>"+ this.STU_NAME + "</td>";
							str+="<td>"+ this.STU_GENDER + "</td>";
							str+="<td>"+ this.STU_BIRTHDAY + "</td>";
							str+="<td>"+ this.STU_PHONE + "</td>";
							str+="<td>"+ this.STU_EMAIL + "</td>";
							str+="<td>"+ this.STU_ENTERANCE + "</td>";
							str+="<td>"+ this.STU_AUTHORITY + "</td>";
							str+="<td><button type='button' class='btn btn-small btn-info'>수정</button>"
							str+="<button type='button' class='btn btn-small btn-danger'>삭제</button></td>" 
							str+="</tr>"
					});
					$("#showList").append(str);
				},
				error: function(result){}
			}).submit();
		}

</script>



<div class="card">

	<div class="card-header">

		<label class="small">> 검색으로 찾기</label>
		<form id="seachKeywordForm">
			<select name="searchCategory">
				<option value="">선택없음</option>
				<option value="stuName">이름</option>
				<option value="stuNumber">학번</option>
				<option value="stuPhone">연락처</option>
				<option value="stuEmail">이메일</option>
			</select> <input type="text" name="searchContent" /> <input type="button"
				value="검색" onclick="javascript:ajaxSearchKeyword('seachKeywordForm')" />
		</form>
		<!-- seachKeywordForm -->
		<hr>

		<label class="small">> 범위로 찾기</label>
		<form id="searchScopeForm">
			<label>학번별로</label> 
			<select name="stuNumber" id="searchStuNumber" onclick="javascript:stuNumberOption()">
				<option value="null">선택없음</option>
			</select>&nbsp;
			
			<label>입학전형별로</label> 
			<select name="stuEnterance">
			<option value="null">선택없음</option>
			<c:forEach var="i" items="${listAllCommonMap.stuEnteranceList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>
			</select>&nbsp; 
			
			<label>접근권한별로</label> 
			<select name="stuAuthority">
			<option value="null">선택없음</option>
			<c:forEach var="i" items="${listAllCommonMap.stuAuthorityList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>	
			</select>&nbsp; 
			
			<label>성별로</label> 
			<select name="stuGender">
			<option value="null">선택없음</option>
			<c:forEach var="i" items="${listAllCommonMap.stuGenderList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>	
			</select> <input type="button" value="검색" onclick="javascript:ajaxSearchScope('searchScopeForm')" />
		</form>
		
		<!-- searchScopeForm -->
	</div>
	<!-- card-header -->



	<div class="card-body">

		<div id="stuListScroll">
			<table class="table table-striped table-sm">
				<thead>
					<tr>
						<th>번호</th>
						<th>학번</th>
						<th>이름</th>
						<th>성별</th>
						<th>생년월일</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>입학전형</th>
						<th>권한</th>
						<th>옵션</th>
					<tr>
				</thead>


				<tbody id="showList">
					<!-- <tr>
				            	<td>1</td>
				            	<td>2013049595</td>
				            	<td>윤인아</td>
				            	<td>여</td>
				            	<td>19940317</td>
				            	<td>01086166450</td>
				            	<td>ina-yun@hanmail.net</td>
				            	<td>수시</td>
				            	<td>예비역회장</td>
				                <td><button type="button" class="btn btn-small btn-info">수정</button><button type="button" class="btn btn-small btn-danger">삭제</button></td>
							</tr> -->
					<c:forEach var="i" items="${listAllStudent}" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>${i.STU_NUMBER}</td>
							<td>${i.STU_NAME}</td>
							<td>${i.STU_GENDER_VALUE}</td>
							<td>${i.STU_BIRTHDAY}</td>
							<td>${i.STU_PHONE}</td>
							<td>${i.STU_EMAIL}</td>
							<td>${i.STU_ENTERANCE_VALUE}</td>
							<td>${i.STU_AUTHORITY_VALUE}</td>
							<td>
							<button type="button" class="btn btn-small btn-info">수정</button>
							<button type="button" class="btn btn-small btn-danger">삭제</button></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
		<!-- stuListScroll -->
	</div>
	<!-- card-body -->

</div>
<!-- card -->

