<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="card">

	<div class="card-header">

		<label class="small">> 검색으로 찾기</label>
		<form id="stuSeachKeywordForm">
			<select name="searchCategory">
				<option value="">선택없음</option>
				<option value="stuName">이름</option>
				<option value="stuNumber">학번</option>
				<option value="stuPhone">연락처</option>
				<option value="stuEmail">이메일</option>
			</select> 
			<input type="text" name="searchContent"/> 
			<input type="button" value="검색" onclick="javascript:ajaxStuSearchKeyword('stuSeachKeywordForm')" />
		</form>
		<!-- seachKeywordForm -->
		<hr>

		<label class="small">> 범위로 찾기</label>
		<form id="stuSearchScopeForm">
		
			<label>학번별로</label> 
			<select name="stuNumber" id="searchStuNumber1">
				
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
			</select> 
			
			<input type="button" value="검색" onclick="javascript:ajaxStuSearchScope('stuSearchScopeForm')" />
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


				<tbody id="showStuList">
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
							<button type="button" class="btn btn-small btn-info" onclick="javascript:ajaxStuDetail(${i.STU_NUMBER})">보기</button>
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

<!-- Modal -->
  <div class="modal fade" id="stuDetailModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
      
        <div class="modal-header">
      	  <h4 class="modal-title">학생 상세 보기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
			        
		<!-- Nav tabs -->
	  	<ul class="nav nav-tabs nav-justified" role="tablist">
		    <li class="nav-item">
		      <a class="nav-link active" data-toggle="tab" href="#stuInfoDetail">기본정보</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" data-toggle="tab" href="#stuFeeDetail">학생회비</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" data-toggle="tab" href="#stuExpDetail">학생경력</a>
		    </li>
	  	</ul>
			  
	     <!-- Tab panes -->
	  	<div class="tab-content">
		    <div id="stuInfoDetail" class="container tab-pane active"><br>
		    </div>
		    <div id="stuFeeDetail" class="container tab-pane fade"><br>
		    </div>
		    <div id="stuExpDetail" class="container tab-pane fade"><br>
		    </div>
	 	</div>
        
    <!--     <div class="modal-footer" id="modalFooter">
        	
        </div> -->
        
      </div>
    </div>
  </div>


<script>

function ajaxStuDetail(stuNumber){
	
	$.ajax({
		url: "/getStudent.do",
		data: {stuNumber: stuNumber},
		method: "post",
		dataType: "json",
		success: function(result) {
			
			//학생 기본 정보
			$("#stuInfoDetail").empty();
			var str = "<br>";
			str+= "<img class='card-img-top' src='../../../resources/common/img/man.png' alt='Card image' style='width:30%'><br><br>";
			str+= "<form>"
			str+="<table class='table table-bordered'><tbody>";
			str+="<tr><th>학번</th><td>"+result[0].STU_NUMBER+"</td><th>이름</th><td>"+result[0].STU_NAME+"</td></tr>";
			str+="<tr><th>생년월일</th><td>"+result[0].STU_BIRTHDAY+"</td><th>성별</th><td>"+result[0].STU_GENDER_VALUE+"</td></tr>";
			str+="<tr><th>연락처</th><td>"+result[0].STU_PHONE+"</td><th>이메일</th><td>"+result[0].STU_EMAIL+"</td></tr>";
			str+="<tr><th>입학전형</th><td>"+result[0].STU_ENTERANCE_VALUE+"</td><th>접근권한</th><td>"+result[0].STU_AUTHORITY_VALUE+"</td></tr>";
			str+="</tbody></form>"
			$("#stuInfoDetail").append(str);
			$("#stuInfoDetail").append("<hr><button type='button' class='btn btn-small btn-info'>수정</button>");
			$("#stuInfoDetail").append("<button type='button' class='btn btn-small btn-danger'>삭제</button><br><br>");
      	    
			
			
			
			
			//학생 회비 정보
			$("#stuFeeDetail").empty();
			var str = "<br>";
			str+="<table class='table table-bordered'><thead><tr><th>회비금액</th><th>납부금액</th><th>입금날짜</th><th>입금방식</th><th>상태</th><th>비고</th></tr></thead><tbody>";
			str+="<tr>"
			str+= "<td>"+result[0].FEE_TOTAL_AMOUNT + "</td>";
			str+= "<td>"+result[0].FEE_PAID_AMOUNT + "</td>";
			str+= "<td>"+result[0].FEE_PAID_DATE + "</td>";
			str+= "<td>"+result[0].FEE_PAID_METHOD_VALUE + "</td>";
			str+= "<td>"+result[0].FEE_PAID_STATUS_VALUE + "</td>";
			str+= "<td>"+result[0].FEE_CONTENT_VALUE + "</td>";
			str+="</tr>"
			str+="</tbody>"
			$("#stuFeeDetail").append(str);
			$("#stuFeeDetail").append("<hr><button type='button' class='btn btn-small btn-info'>수정</button>");
			$("#stuFeeDetail").append("<button type='button' class='btn btn-small btn-danger'>삭제</button><br><br>");
      	    

			//학생 경력 정보
			$("#stuExpDetail").empty();
			var str = "<br>";
			str+="<table class='table table-bordered'><thead><tr><th>년도</th><th>학기</th><th>활동내용</th></tr></thead><tbody>";
			
			$.each(result,function(index,value){
				str+="<tr>"
				str+= "<td>"+translator(this.EXP_YEAR) + "</td>";
				str+= "<td>"+translator(this.EXP_SEMESTER) + "</td>";
				str+= "<td>"+translator(this.EXP_CONTENT) + "</td>";
				str+="</tr>"
			});
			str+="</tbody>"
			$("#stuExpDetail").append(str);
			$("#stuExpDetail").append("<hr><button type='button' class='btn btn-small btn-info'>수정</button>");
			$("#stuExpDetail").append("<button type='button' class='btn btn-small btn-danger'>삭제</button><br><br>");
      	    
			
			//모달 실행
			$("#stuDetailModal").modal();
		}
	});
	
}


</script>
